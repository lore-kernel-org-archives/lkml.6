Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937368AbeE2Bh2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:37:28 -0400
Received: from gate.crashing.org ([63.228.1.57]:53036 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937311AbeE2Bh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:37:26 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 12/15] fsi/fsi-master-gpio: More error handling cleanup
Date: Tue, 29 May 2018 11:30:41 +1000
Message-Id: <20180529013044.23815-13-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529013044.23815-1-benh@kernel.crashing.org>
References: <20180529013044.23815-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove calls to the empty and useless fsi_master_gpio_error()
function, and report CRC errors as "FSI_ERR_NO_SLAVE" when
reading an all 1's response.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-master-gpio.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 351c12f2ac55..da556da62846 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -41,13 +41,6 @@
 #define	FSI_GPIO_RESP_BUSY	1	/* Slave busy */
 #define	FSI_GPIO_RESP_ERRA	2	/* Any (misc) Error */
 #define	FSI_GPIO_RESP_ERRC	3	/* Slave reports master CRC error */
-#define	FSI_GPIO_MTOE		4	/* Master time out error */
-#define	FSI_GPIO_CRC_INVAL	5	/* Master reports slave CRC error */
-
-/* Normal slave responses */
-#define	FSI_GPIO_RESP_BUSY	1
-#define	FSI_GPIO_RESP_ACK	0
-#define	FSI_GPIO_RESP_ACKD	4
 
 #define	FSI_GPIO_MAX_BUSY	200
 #define	FSI_GPIO_MTOE_COUNT	1000
@@ -359,15 +352,6 @@ static void build_term_command(struct fsi_gpio_msg *cmd, uint8_t slave_id)
 	msg_push_crc(cmd);
 }
 
-/*
- * Store information on master errors so handler can detect and clean
- * up the bus
- */
-static void fsi_master_gpio_error(struct fsi_master_gpio *master, int error)
-{
-
-}
-
 /*
  * Note: callers rely specifically on this returning -EAGAIN for
  * a CRC error detected in the response. Use other error code
@@ -396,7 +380,6 @@ static int read_one_response(struct fsi_master_gpio *master,
 	if (i == FSI_GPIO_MTOE_COUNT) {
 		dev_dbg(master->dev,
 			"Master time out waiting for response\n");
-		fsi_master_gpio_error(master, FSI_GPIO_MTOE);
 		spin_unlock_irqrestore(&master->bit_lock, flags);
 		return -ETIMEDOUT;
 	}
@@ -422,8 +405,11 @@ static int read_one_response(struct fsi_master_gpio *master,
 	crc = crc4(0, 1, 1);
 	crc = crc4(crc, msg.msg, msg.bits);
 	if (crc) {
-		dev_dbg(master->dev, "ERR response CRC\n");
-		fsi_master_gpio_error(master, FSI_GPIO_CRC_INVAL);
+		/* Check if it's all 1's, that probably means the host is off */
+		if (((~msg.msg) & ((1ull << msg.bits) - 1)) == 0)
+			return -ENODEV;
+		dev_dbg(master->dev, "ERR response CRC msg: 0x%016llx (%d bits)\n",
+			msg.msg, msg.bits);
 		return -EAGAIN;
 	}
 
@@ -538,12 +524,10 @@ static int poll_for_response(struct fsi_master_gpio *master,
 
 	case FSI_GPIO_RESP_ERRA:
 		dev_dbg(master->dev, "ERRA received: 0x%x\n", (int)response.msg);
-		fsi_master_gpio_error(master, response.msg);
 		rc = -EIO;
 		break;
 	case FSI_GPIO_RESP_ERRC:
 		dev_dbg(master->dev, "ERRC received: 0x%x\n", (int)response.msg);
-		fsi_master_gpio_error(master, response.msg);
 		trace_fsi_master_gpio_crc_cmd_error(master);
 		rc = -EAGAIN;
 		break;
-- 
2.17.0
