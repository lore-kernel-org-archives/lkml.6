Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936882AbeE2BcY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:32:24 -0400
Received: from gate.crashing.org ([63.228.1.57]:38871 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936805AbeE2BcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:32:23 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 11/15] fsi/fsi-master-gpio: Implement CRC error recovery
Date: Tue, 29 May 2018 11:30:40 +1000
Message-Id: <20180529013044.23815-12-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529013044.23815-1-benh@kernel.crashing.org>
References: <20180529013044.23815-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FSI protocol defines two modes of recovery from CRC errors,
this implements both:

 - If the device returns an ECRC (it detected a CRC error in the
   command), then we simply issue the command again.

 - If the master detects a CRC error in the response, we send
   an E_POLL command which requests a resend of the response
   without actually re-executing the command (which could otherwise
   have unwanted side effects such as dequeuing a FIFO twice).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---

Note: This was actually tested by removing some of my fixes, thus
causing us to hit occasional CRC errors during high LPC activity.
---
 drivers/fsi/fsi-master-gpio.c          | 90 ++++++++++++++++++++------
 include/trace/events/fsi_master_gpio.h | 27 ++++++++
 2 files changed, 99 insertions(+), 18 deletions(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 0a6799bda294..351c12f2ac55 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -22,20 +22,23 @@
 #define	FSI_BREAK_CLOCKS	256	/* Number of clocks to issue break */
 #define	FSI_POST_BREAK_CLOCKS	16000	/* Number clocks to set up cfam */
 #define	FSI_INIT_CLOCKS		5000	/* Clock out any old data */
+#define	FSI_GPIO_DPOLL_CLOCKS	50      /* < 21 will cause slave to hang */
+#define	FSI_GPIO_EPOLL_CLOCKS	50      /* Number of clocks for E_POLL retry */
 #define	FSI_GPIO_STD_DELAY	10	/* Standard GPIO delay in nS */
 					/* todo: adjust down as low as */
 					/* possible or eliminate */
+#define FSI_CRC_ERR_RETRIES	10
+
 #define	FSI_GPIO_CMD_DPOLL      0x2
+#define	FSI_GPIO_CMD_EPOLL      0x3
 #define	FSI_GPIO_CMD_TERM	0x3f
 #define FSI_GPIO_CMD_ABS_AR	0x4
 #define FSI_GPIO_CMD_REL_AR	0x5
 #define FSI_GPIO_CMD_SAME_AR	0x3	/* but only a 2-bit opcode... */
 
-
-#define	FSI_GPIO_DPOLL_CLOCKS	50      /* < 21 will cause slave to hang */
-
-/* Bus errors */
-#define	FSI_GPIO_ERR_BUSY	1	/* Slave stuck in busy state */
+/* Slave responses */
+#define	FSI_GPIO_RESP_ACK	0	/* Success */
+#define	FSI_GPIO_RESP_BUSY	1	/* Slave busy */
 #define	FSI_GPIO_RESP_ERRA	2	/* Any (misc) Error */
 #define	FSI_GPIO_RESP_ERRC	3	/* Slave reports master CRC error */
 #define	FSI_GPIO_MTOE		4	/* Master time out error */
@@ -330,6 +333,16 @@ static void build_dpoll_command(struct fsi_gpio_msg *cmd, uint8_t slave_id)
 	msg_push_crc(cmd);
 }
 
+static void build_epoll_command(struct fsi_gpio_msg *cmd, uint8_t slave_id)
+{
+	cmd->bits = 0;
+	cmd->msg = 0;
+
+	msg_push_bits(cmd, slave_id, 2);
+	msg_push_bits(cmd, FSI_GPIO_CMD_EPOLL, 3);
+	msg_push_crc(cmd);
+}
+
 static void echo_delay(struct fsi_master_gpio *master)
 {
 	set_sda_output(master, 1);
@@ -355,6 +368,12 @@ static void fsi_master_gpio_error(struct fsi_master_gpio *master, int error)
 
 }
 
+/*
+ * Note: callers rely specifically on this returning -EAGAIN for
+ * a CRC error detected in the response. Use other error code
+ * for other situations. It will be converted to something else
+ * higher up the stack before it reaches userspace.
+ */
 static int read_one_response(struct fsi_master_gpio *master,
 		uint8_t data_size, struct fsi_gpio_msg *msgp, uint8_t *tagp)
 {
@@ -379,7 +398,7 @@ static int read_one_response(struct fsi_master_gpio *master,
 			"Master time out waiting for response\n");
 		fsi_master_gpio_error(master, FSI_GPIO_MTOE);
 		spin_unlock_irqrestore(&master->bit_lock, flags);
-		return -EIO;
+		return -ETIMEDOUT;
 	}
 
 	msg.bits = 0;
@@ -405,7 +424,7 @@ static int read_one_response(struct fsi_master_gpio *master,
 	if (crc) {
 		dev_dbg(master->dev, "ERR response CRC\n");
 		fsi_master_gpio_error(master, FSI_GPIO_CRC_INVAL);
-		return -EIO;
+		return -EAGAIN;
 	}
 
 	if (msgp)
@@ -451,11 +470,33 @@ static int poll_for_response(struct fsi_master_gpio *master,
 	unsigned long flags;
 	uint8_t tag;
 	uint8_t *data_byte = data;
-
+	int crc_err_retries = 0;
 retry:
 	rc = read_one_response(master, size, &response, &tag);
-	if (rc)
-		return rc;
+
+	/* Handle retries on CRC errors */
+	if (rc == -EAGAIN) {
+		/* Too many retries ? */
+		if (crc_err_retries++ > FSI_CRC_ERR_RETRIES) {
+			/*
+			 * Pass it up as a -EIO otherwise upper level will retry
+			 * the whole command which isn't what we want here.
+			 */
+			rc = -EIO;
+			goto fail;
+		}
+		dev_dbg(master->dev,
+			 "CRC error retry %d\n", crc_err_retries);
+		trace_fsi_master_gpio_crc_rsp_error(master);
+		build_epoll_command(&cmd, slave);
+		spin_lock_irqsave(&master->bit_lock, flags);
+		clock_zeros(master, FSI_GPIO_EPOLL_CLOCKS);
+		serial_out(master, &cmd);
+		echo_delay(master);
+		spin_unlock_irqrestore(&master->bit_lock, flags);
+		goto retry;
+	} else if (rc)
+		goto fail;
 
 	switch (tag) {
 	case FSI_GPIO_RESP_ACK:
@@ -496,18 +537,21 @@ static int poll_for_response(struct fsi_master_gpio *master,
 		break;
 
 	case FSI_GPIO_RESP_ERRA:
-	case FSI_GPIO_RESP_ERRC:
-		dev_dbg(master->dev, "ERR%c received: 0x%x\n",
-			tag == FSI_GPIO_RESP_ERRA ? 'A' : 'C',
-			(int)response.msg);
+		dev_dbg(master->dev, "ERRA received: 0x%x\n", (int)response.msg);
 		fsi_master_gpio_error(master, response.msg);
 		rc = -EIO;
 		break;
+	case FSI_GPIO_RESP_ERRC:
+		dev_dbg(master->dev, "ERRC received: 0x%x\n", (int)response.msg);
+		fsi_master_gpio_error(master, response.msg);
+		trace_fsi_master_gpio_crc_cmd_error(master);
+		rc = -EAGAIN;
+		break;
 	}
 
 	if (busy_count > 0)
 		trace_fsi_master_gpio_poll_response_busy(master, busy_count);
-
+ fail:
 	/* Clock the slave enough to be ready for next operation */
 	spin_lock_irqsave(&master->bit_lock, flags);
 	clock_zeros(master, FSI_GPIO_PRIME_SLAVE_CLOCKS);
@@ -536,11 +580,21 @@ static int send_request(struct fsi_master_gpio *master,
 static int fsi_master_gpio_xfer(struct fsi_master_gpio *master, uint8_t slave,
 		struct fsi_gpio_msg *cmd, size_t resp_len, void *resp)
 {
-	int rc;
+	int rc = -EAGAIN, retries = 0;
 
-	rc = send_request(master, cmd);
-	if (!rc)
+	while ((retries++) < FSI_CRC_ERR_RETRIES) {
+		rc = send_request(master, cmd);
+		if (rc)
+			break;
 		rc = poll_for_response(master, slave, resp_len, resp);
+		if (rc != -EAGAIN)
+			break;
+		rc = -EIO;
+		dev_warn(master->dev, "ECRC retry %d\n", retries);
+
+		/* Pace it a bit before retry */
+		msleep(1);
+	}
 
 	return rc;
 }
diff --git a/include/trace/events/fsi_master_gpio.h b/include/trace/events/fsi_master_gpio.h
index 33e928c5acf3..389082132433 100644
--- a/include/trace/events/fsi_master_gpio.h
+++ b/include/trace/events/fsi_master_gpio.h
@@ -64,6 +64,33 @@ TRACE_EVENT(fsi_master_gpio_break,
 	)
 );
 
+TRACE_EVENT(fsi_master_gpio_crc_cmd_error,
+	TP_PROTO(const struct fsi_master_gpio *master),
+	TP_ARGS(master),
+	TP_STRUCT__entry(
+		__field(int,	master_idx)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master->master.idx;
+	),
+	TP_printk("fsi-gpio%d ----CRC command retry---",
+		__entry->master_idx
+	)
+);
+
+TRACE_EVENT(fsi_master_gpio_crc_rsp_error,
+	TP_PROTO(const struct fsi_master_gpio *master),
+	TP_ARGS(master),
+	TP_STRUCT__entry(
+		__field(int,	master_idx)
+	),
+	TP_fast_assign(
+		__entry->master_idx = master->master.idx;
+	),
+	TP_printk("fsi-gpio%d ----CRC response---",
+		__entry->master_idx
+	)
+);
 
 TRACE_EVENT(fsi_master_gpio_poll_response_busy,
 	TP_PROTO(const struct fsi_master_gpio *master, int busy),
-- 
2.17.0
