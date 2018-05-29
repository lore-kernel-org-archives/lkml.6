Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937264AbeE2BhI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:37:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:53018 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932404AbeE2BhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:37:05 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 03/15] fsi: gpio: Use a mutex to protect transfers
Date: Tue, 29 May 2018 11:30:32 +1000
Message-Id: <20180529013044.23815-4-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529013044.23815-1-benh@kernel.crashing.org>
References: <20180529013044.23815-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Kerr <jk@ozlabs.org>

Reduce time spent with interrupts disabled by limiting the critical
sections to bitbanging FSI symbols. We only need to ensure exclusive use
of the bus for an entire transfer, not that the transfer be performed in
atomic context.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-master-gpio.c | 86 ++++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 22 deletions(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 20b334f1827d..4295a46780cb 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -54,7 +54,8 @@
 struct fsi_master_gpio {
 	struct fsi_master	master;
 	struct device		*dev;
-	spinlock_t		cmd_lock;	/* Lock for commands */
+	struct mutex		cmd_lock;	/* mutex for command ordering */
+	spinlock_t		bit_lock;	/* lock for clocking bits out */
 	struct gpio_desc	*gpio_clk;
 	struct gpio_desc	*gpio_data;
 	struct gpio_desc	*gpio_trans;	/* Voltage translator */
@@ -270,10 +271,13 @@ static int read_one_response(struct fsi_master_gpio *master,
 		uint8_t data_size, struct fsi_gpio_msg *msgp, uint8_t *tagp)
 {
 	struct fsi_gpio_msg msg;
-	uint8_t tag;
+	unsigned long flags;
 	uint32_t crc;
+	uint8_t tag;
 	int i;
 
+	spin_lock_irqsave(&master->bit_lock, flags);
+
 	/* wait for the start bit */
 	for (i = 0; i < FSI_GPIO_MTOE_COUNT; i++) {
 		msg.bits = 0;
@@ -286,6 +290,7 @@ static int read_one_response(struct fsi_master_gpio *master,
 		dev_dbg(master->dev,
 			"Master time out waiting for response\n");
 		fsi_master_gpio_error(master, FSI_GPIO_MTOE);
+		spin_unlock_irqrestore(&master->bit_lock, flags);
 		return -EIO;
 	}
 
@@ -304,6 +309,8 @@ static int read_one_response(struct fsi_master_gpio *master,
 	/* read CRC */
 	serial_in(master, &msg, FSI_GPIO_CRC_SIZE);
 
+	spin_unlock_irqrestore(&master->bit_lock, flags);
+
 	/* we have a whole message now; check CRC */
 	crc = crc4(0, 1, 1);
 	crc = crc4(crc, msg.msg, msg.bits);
@@ -324,12 +331,16 @@ static int read_one_response(struct fsi_master_gpio *master,
 static int issue_term(struct fsi_master_gpio *master, uint8_t slave)
 {
 	struct fsi_gpio_msg cmd;
+	unsigned long flags;
 	uint8_t tag;
 	int rc;
 
 	build_term_command(&cmd, slave);
+
+	spin_lock_irqsave(&master->bit_lock, flags);
 	serial_out(master, &cmd);
 	echo_delay(master);
+	spin_unlock_irqrestore(&master->bit_lock, flags);
 
 	rc = read_one_response(master, 0, NULL, &tag);
 	if (rc < 0) {
@@ -349,6 +360,7 @@ static int poll_for_response(struct fsi_master_gpio *master,
 {
 	struct fsi_gpio_msg response, cmd;
 	int busy_count = 0, rc, i;
+	unsigned long flags;
 	uint8_t tag;
 	uint8_t *data_byte = data;
 
@@ -377,15 +389,20 @@ static int poll_for_response(struct fsi_master_gpio *master,
 		 * d-poll, not indicated in the hardware protocol
 		 * spec. < 20 clocks causes slave to hang, 21 ok.
 		 */
-		clock_zeros(master, FSI_GPIO_DPOLL_CLOCKS);
 		if (busy_count++ < FSI_GPIO_MAX_BUSY) {
 			build_dpoll_command(&cmd, slave);
+			spin_lock_irqsave(&master->bit_lock, flags);
+			clock_zeros(master, FSI_GPIO_DPOLL_CLOCKS);
 			serial_out(master, &cmd);
 			echo_delay(master);
+			spin_unlock_irqrestore(&master->bit_lock, flags);
 			goto retry;
 		}
 		dev_warn(master->dev,
 			"ERR slave is stuck in busy state, issuing TERM\n");
+		spin_lock_irqsave(&master->bit_lock, flags);
+		clock_zeros(master, FSI_GPIO_DPOLL_CLOCKS);
+		spin_unlock_irqrestore(&master->bit_lock, flags);
 		issue_term(master, slave);
 		rc = -EIO;
 		break;
@@ -404,27 +421,42 @@ static int poll_for_response(struct fsi_master_gpio *master,
 		trace_fsi_master_gpio_poll_response_busy(master, busy_count);
 
 	/* Clock the slave enough to be ready for next operation */
+	spin_lock_irqsave(&master->bit_lock, flags);
 	clock_zeros(master, FSI_GPIO_PRIME_SLAVE_CLOCKS);
+	spin_unlock_irqrestore(&master->bit_lock, flags);
 	return rc;
 }
 
-static int fsi_master_gpio_xfer(struct fsi_master_gpio *master, uint8_t slave,
-		struct fsi_gpio_msg *cmd, size_t resp_len, void *resp)
+static int send_request(struct fsi_master_gpio *master,
+		struct fsi_gpio_msg *cmd)
 {
 	unsigned long flags;
-	int rc;
-
-	spin_lock_irqsave(&master->cmd_lock, flags);
 
+	spin_lock_irqsave(&master->bit_lock, flags);
 	if (master->external_mode) {
-		spin_unlock_irqrestore(&master->cmd_lock, flags);
+		spin_unlock_irqrestore(&master->bit_lock, flags);
 		return -EBUSY;
 	}
 
 	serial_out(master, cmd);
 	echo_delay(master);
-	rc = poll_for_response(master, slave, resp_len, resp);
-	spin_unlock_irqrestore(&master->cmd_lock, flags);
+	spin_unlock_irqrestore(&master->bit_lock, flags);
+
+	return 0;
+}
+
+static int fsi_master_gpio_xfer(struct fsi_master_gpio *master, uint8_t slave,
+		struct fsi_gpio_msg *cmd, size_t resp_len, void *resp)
+{
+	int rc;
+
+	mutex_lock(&master->cmd_lock);
+
+	rc = send_request(master, cmd);
+	if (!rc)
+		rc = poll_for_response(master, slave, resp_len, resp);
+
+	mutex_unlock(&master->cmd_lock);
 
 	return rc;
 }
@@ -478,11 +510,14 @@ static int fsi_master_gpio_break(struct fsi_master *_master, int link)
 
 	trace_fsi_master_gpio_break(master);
 
-	spin_lock_irqsave(&master->cmd_lock, flags);
+	mutex_lock(&master->cmd_lock);
 	if (master->external_mode) {
-		spin_unlock_irqrestore(&master->cmd_lock, flags);
+		mutex_unlock(&master->cmd_lock);
 		return -EBUSY;
 	}
+
+	spin_lock_irqsave(&master->bit_lock, flags);
+
 	set_sda_output(master, 1);
 	sda_out(master, 1);
 	clock_toggle(master, FSI_PRE_BREAK_CLOCKS);
@@ -491,7 +526,9 @@ static int fsi_master_gpio_break(struct fsi_master *_master, int link)
 	echo_delay(master);
 	sda_out(master, 1);
 	clock_toggle(master, FSI_POST_BREAK_CLOCKS);
-	spin_unlock_irqrestore(&master->cmd_lock, flags);
+
+	spin_unlock_irqrestore(&master->bit_lock, flags);
+	mutex_unlock(&master->cmd_lock);
 
 	/* Wait for logic reset to take effect */
 	udelay(200);
@@ -501,6 +538,8 @@ static int fsi_master_gpio_break(struct fsi_master *_master, int link)
 
 static void fsi_master_gpio_init(struct fsi_master_gpio *master)
 {
+	unsigned long flags;
+
 	gpiod_direction_output(master->gpio_mux, 1);
 	gpiod_direction_output(master->gpio_trans, 1);
 	gpiod_direction_output(master->gpio_enable, 1);
@@ -508,7 +547,9 @@ static void fsi_master_gpio_init(struct fsi_master_gpio *master)
 	gpiod_direction_output(master->gpio_data, 1);
 
 	/* todo: evaluate if clocks can be reduced */
+	spin_lock_irqsave(&master->bit_lock, flags);
 	clock_zeros(master, FSI_INIT_CLOCKS);
+	spin_unlock_irqrestore(&master->bit_lock, flags);
 }
 
 static void fsi_master_gpio_init_external(struct fsi_master_gpio *master)
@@ -523,18 +564,17 @@ static void fsi_master_gpio_init_external(struct fsi_master_gpio *master)
 static int fsi_master_gpio_link_enable(struct fsi_master *_master, int link)
 {
 	struct fsi_master_gpio *master = to_fsi_master_gpio(_master);
-	unsigned long flags;
 	int rc = -EBUSY;
 
 	if (link != 0)
 		return -ENODEV;
 
-	spin_lock_irqsave(&master->cmd_lock, flags);
+	mutex_lock(&master->cmd_lock);
 	if (!master->external_mode) {
 		gpiod_set_value(master->gpio_enable, 1);
 		rc = 0;
 	}
-	spin_unlock_irqrestore(&master->cmd_lock, flags);
+	mutex_unlock(&master->cmd_lock);
 
 	return rc;
 }
@@ -552,7 +592,7 @@ static ssize_t external_mode_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct fsi_master_gpio *master = dev_get_drvdata(dev);
-	unsigned long flags, val;
+	unsigned long val;
 	bool external_mode;
 	int err;
 
@@ -562,10 +602,10 @@ static ssize_t external_mode_store(struct device *dev,
 
 	external_mode = !!val;
 
-	spin_lock_irqsave(&master->cmd_lock, flags);
+	mutex_lock(&master->cmd_lock);
 
 	if (external_mode == master->external_mode) {
-		spin_unlock_irqrestore(&master->cmd_lock, flags);
+		mutex_unlock(&master->cmd_lock);
 		return count;
 	}
 
@@ -574,7 +614,8 @@ static ssize_t external_mode_store(struct device *dev,
 		fsi_master_gpio_init_external(master);
 	else
 		fsi_master_gpio_init(master);
-	spin_unlock_irqrestore(&master->cmd_lock, flags);
+
+	mutex_unlock(&master->cmd_lock);
 
 	fsi_master_rescan(&master->master);
 
@@ -642,7 +683,8 @@ static int fsi_master_gpio_probe(struct platform_device *pdev)
 	master->master.send_break = fsi_master_gpio_break;
 	master->master.link_enable = fsi_master_gpio_link_enable;
 	platform_set_drvdata(pdev, master);
-	spin_lock_init(&master->cmd_lock);
+	spin_lock_init(&master->bit_lock);
+	mutex_init(&master->cmd_lock);
 
 	fsi_master_gpio_init(master);
 
-- 
2.17.0
