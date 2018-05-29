Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936937AbeE2Bcc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:32:32 -0400
Received: from gate.crashing.org ([63.228.1.57]:38875 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936805AbeE2Bc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:32:28 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 13/15] fsi/master-gpio: Replace bit_bit lock with IRQ disable/enable
Date: Tue, 29 May 2018 11:30:42 +1000
Message-Id: <20180529013044.23815-14-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529013044.23815-1-benh@kernel.crashing.org>
References: <20180529013044.23815-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Kerr <jk@ozlabs.org>

We currently use a spinlock (bit_lock) around operations that clock bits
out of the FSI bus, and a mutex to protect against simultaneous access
to the master.

This means that bit_lock isn't needed for mutual exlusion, only to
prevent timing issues when clocking bits out.

To reflect this, this change converts bit_lock to just the
local_irq_save/restore operation.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-master-gpio.c | 48 +++++++++++++++++------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index da556da62846..084e9da8d151 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -8,11 +8,11 @@
 #include <linux/fsi.h>
 #include <linux/gpio/consumer.h>
 #include <linux/io.h>
+#include <linux/irqflags.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/spinlock.h>
 
 #include "fsi-master.h"
 
@@ -56,7 +56,6 @@ struct fsi_master_gpio {
 	struct fsi_master	master;
 	struct device		*dev;
 	struct mutex		cmd_lock;	/* mutex for command ordering */
-	spinlock_t		bit_lock;	/* lock for clocking bits out */
 	struct gpio_desc	*gpio_clk;
 	struct gpio_desc	*gpio_data;
 	struct gpio_desc	*gpio_trans;	/* Voltage translator */
@@ -367,7 +366,7 @@ static int read_one_response(struct fsi_master_gpio *master,
 	uint8_t tag;
 	int i;
 
-	spin_lock_irqsave(&master->bit_lock, flags);
+	local_irq_save(flags);
 
 	/* wait for the start bit */
 	for (i = 0; i < FSI_GPIO_MTOE_COUNT; i++) {
@@ -380,7 +379,7 @@ static int read_one_response(struct fsi_master_gpio *master,
 	if (i == FSI_GPIO_MTOE_COUNT) {
 		dev_dbg(master->dev,
 			"Master time out waiting for response\n");
-		spin_unlock_irqrestore(&master->bit_lock, flags);
+		local_irq_restore(flags);
 		return -ETIMEDOUT;
 	}
 
@@ -399,7 +398,7 @@ static int read_one_response(struct fsi_master_gpio *master,
 	/* read CRC */
 	serial_in(master, &msg, FSI_GPIO_CRC_SIZE);
 
-	spin_unlock_irqrestore(&master->bit_lock, flags);
+	local_irq_restore(flags);
 
 	/* we have a whole message now; check CRC */
 	crc = crc4(0, 1, 1);
@@ -430,10 +429,10 @@ static int issue_term(struct fsi_master_gpio *master, uint8_t slave)
 
 	build_term_command(&cmd, slave);
 
-	spin_lock_irqsave(&master->bit_lock, flags);
+	local_irq_save(flags);
 	serial_out(master, &cmd);
 	echo_delay(master);
-	spin_unlock_irqrestore(&master->bit_lock, flags);
+	local_irq_restore(flags);
 
 	rc = read_one_response(master, 0, NULL, &tag);
 	if (rc < 0) {
@@ -475,11 +474,11 @@ static int poll_for_response(struct fsi_master_gpio *master,
 			 "CRC error retry %d\n", crc_err_retries);
 		trace_fsi_master_gpio_crc_rsp_error(master);
 		build_epoll_command(&cmd, slave);
-		spin_lock_irqsave(&master->bit_lock, flags);
+		local_irq_save(flags);
 		clock_zeros(master, FSI_GPIO_EPOLL_CLOCKS);
 		serial_out(master, &cmd);
 		echo_delay(master);
-		spin_unlock_irqrestore(&master->bit_lock, flags);
+		local_irq_restore(flags);
 		goto retry;
 	} else if (rc)
 		goto fail;
@@ -506,18 +505,18 @@ static int poll_for_response(struct fsi_master_gpio *master,
 		 */
 		if (busy_count++ < FSI_GPIO_MAX_BUSY) {
 			build_dpoll_command(&cmd, slave);
-			spin_lock_irqsave(&master->bit_lock, flags);
+			local_irq_save(flags);
 			clock_zeros(master, FSI_GPIO_DPOLL_CLOCKS);
 			serial_out(master, &cmd);
 			echo_delay(master);
-			spin_unlock_irqrestore(&master->bit_lock, flags);
+			local_irq_restore(flags);
 			goto retry;
 		}
 		dev_warn(master->dev,
 			"ERR slave is stuck in busy state, issuing TERM\n");
-		spin_lock_irqsave(&master->bit_lock, flags);
+		local_irq_save(flags);
 		clock_zeros(master, FSI_GPIO_DPOLL_CLOCKS);
-		spin_unlock_irqrestore(&master->bit_lock, flags);
+		local_irq_restore(flags);
 		issue_term(master, slave);
 		rc = -EIO;
 		break;
@@ -537,9 +536,10 @@ static int poll_for_response(struct fsi_master_gpio *master,
 		trace_fsi_master_gpio_poll_response_busy(master, busy_count);
  fail:
 	/* Clock the slave enough to be ready for next operation */
-	spin_lock_irqsave(&master->bit_lock, flags);
+	local_irq_save(flags);
 	clock_zeros(master, FSI_GPIO_PRIME_SLAVE_CLOCKS);
-	spin_unlock_irqrestore(&master->bit_lock, flags);
+	local_irq_restore(flags);
+
 	return rc;
 }
 
@@ -548,15 +548,13 @@ static int send_request(struct fsi_master_gpio *master,
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&master->bit_lock, flags);
-	if (master->external_mode) {
-		spin_unlock_irqrestore(&master->bit_lock, flags);
+	if (master->external_mode)
 		return -EBUSY;
-	}
 
+	local_irq_save(flags);
 	serial_out(master, cmd);
 	echo_delay(master);
-	spin_unlock_irqrestore(&master->bit_lock, flags);
+	local_irq_restore(flags);
 
 	return 0;
 }
@@ -656,7 +654,7 @@ static int fsi_master_gpio_break(struct fsi_master *_master, int link)
 		return -EBUSY;
 	}
 
-	spin_lock_irqsave(&master->bit_lock, flags);
+	local_irq_save(flags);
 
 	set_sda_output(master, 1);
 	sda_out(master, 1);
@@ -667,7 +665,8 @@ static int fsi_master_gpio_break(struct fsi_master *_master, int link)
 	sda_out(master, 1);
 	clock_toggle(master, FSI_POST_BREAK_CLOCKS);
 
-	spin_unlock_irqrestore(&master->bit_lock, flags);
+	local_irq_restore(flags);
+
 	last_address_update(master, 0, false, 0);
 	mutex_unlock(&master->cmd_lock);
 
@@ -688,9 +687,9 @@ static void fsi_master_gpio_init(struct fsi_master_gpio *master)
 	gpiod_direction_output(master->gpio_data, 1);
 
 	/* todo: evaluate if clocks can be reduced */
-	spin_lock_irqsave(&master->bit_lock, flags);
+	local_irq_save(flags);
 	clock_zeros(master, FSI_INIT_CLOCKS);
-	spin_unlock_irqrestore(&master->bit_lock, flags);
+	local_irq_restore(flags);
 }
 
 static void fsi_master_gpio_init_external(struct fsi_master_gpio *master)
@@ -832,7 +831,6 @@ static int fsi_master_gpio_probe(struct platform_device *pdev)
 	master->master.send_break = fsi_master_gpio_break;
 	master->master.link_enable = fsi_master_gpio_link_enable;
 	platform_set_drvdata(pdev, master);
-	spin_lock_init(&master->bit_lock);
 	mutex_init(&master->cmd_lock);
 
 	fsi_master_gpio_init(master);
-- 
2.17.0
