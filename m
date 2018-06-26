Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB9FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2451126A48
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2451126A48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755002AbeFZXcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:32:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:37576 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754951AbeFZXcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:32:46 -0400
Received: from pasglop.au.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5QNQ6qf022979;
        Tue, 26 Jun 2018 18:27:01 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 08/14] fsi: master-gpio: Remove "GPIO" prefix on some definitions
Date:   Wed, 27 Jun 2018 09:25:59 +1000
Message-Id: <20180626232605.13420-9-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626232605.13420-1-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some definitions are generic to the FSI protocol or any
give master implementation. Rename them to remove the
"GPIO" prefix in preparation for moving them to a common
header.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-master-gpio.c | 70 ++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 2bc85514bb0c..91d89597784a 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -23,26 +23,28 @@
 #define	FSI_BREAK_CLOCKS	256	/* Number of clocks to issue break */
 #define	FSI_POST_BREAK_CLOCKS	16000	/* Number clocks to set up cfam */
 #define	FSI_INIT_CLOCKS		5000	/* Clock out any old data */
-#define	FSI_GPIO_DPOLL_CLOCKS	50      /* < 21 will cause slave to hang */
-#define	FSI_GPIO_EPOLL_CLOCKS	50      /* Number of clocks for E_POLL retry */
+#define	FSI_MASTER_DPOLL_CLOCKS	50      /* < 21 will cause slave to hang */
+#define	FSI_MASTER_EPOLL_CLOCKS	50      /* Number of clocks for E_POLL retry */
+
 #define FSI_CRC_ERR_RETRIES	10
 
-#define	FSI_GPIO_CMD_DPOLL      0x2
-#define	FSI_GPIO_CMD_EPOLL      0x3
-#define	FSI_GPIO_CMD_TERM	0x3f
-#define FSI_GPIO_CMD_ABS_AR	0x4
-#define FSI_GPIO_CMD_REL_AR	0x5
-#define FSI_GPIO_CMD_SAME_AR	0x3	/* but only a 2-bit opcode... */
+#define	FSI_CMD_DPOLL		0x2
+#define	FSI_CMD_EPOLL		0x3
+#define	FSI_CMD_TERM		0x3f
+#define FSI_CMD_ABS_AR		0x4
+#define FSI_CMD_REL_AR		0x5
+#define FSI_CMD_SAME_AR		0x3	/* but only a 2-bit opcode... */
 
 /* Slave responses */
-#define	FSI_GPIO_RESP_ACK	0	/* Success */
-#define	FSI_GPIO_RESP_BUSY	1	/* Slave busy */
-#define	FSI_GPIO_RESP_ERRA	2	/* Any (misc) Error */
-#define	FSI_GPIO_RESP_ERRC	3	/* Slave reports master CRC error */
+#define	FSI_RESP_ACK		0	/* Success */
+#define	FSI_RESP_BUSY		1	/* Slave busy */
+#define	FSI_RESP_ERRA		2	/* Any (misc) Error */
+#define	FSI_RESP_ERRC		3	/* Slave reports master CRC error */
+
+#define	FSI_MASTER_MAX_BUSY	200
 
-#define	FSI_GPIO_MAX_BUSY	200
-#define	FSI_GPIO_MTOE_COUNT	1000
-#define	FSI_GPIO_CRC_SIZE	4
+#define	FSI_MASTER_MTOE_COUNT	1000
+#define	FSI_CRC_SIZE		4
 
 #define LAST_ADDR_INVALID		0x1
 
@@ -279,19 +281,19 @@ static void build_ar_command(struct fsi_master_gpio *master,
 		/* we still address the byte offset within the word */
 		addr_bits = 2;
 		opcode_bits = 2;
-		opcode = FSI_GPIO_CMD_SAME_AR;
+		opcode = FSI_CMD_SAME_AR;
 		trace_fsi_master_gpio_cmd_same_addr(master);
 
 	} else if (check_relative_address(master, id, addr, &rel_addr)) {
 		/* 8 bits plus sign */
 		addr_bits = 9;
 		addr = rel_addr;
-		opcode = FSI_GPIO_CMD_REL_AR;
+		opcode = FSI_CMD_REL_AR;
 		trace_fsi_master_gpio_cmd_rel_addr(master, rel_addr);
 
 	} else {
 		addr_bits = 21;
-		opcode = FSI_GPIO_CMD_ABS_AR;
+		opcode = FSI_CMD_ABS_AR;
 		trace_fsi_master_gpio_cmd_abs_addr(master, addr);
 	}
 
@@ -327,7 +329,7 @@ static void build_dpoll_command(struct fsi_gpio_msg *cmd, uint8_t slave_id)
 	cmd->msg = 0;
 
 	msg_push_bits(cmd, slave_id, 2);
-	msg_push_bits(cmd, FSI_GPIO_CMD_DPOLL, 3);
+	msg_push_bits(cmd, FSI_CMD_DPOLL, 3);
 	msg_push_crc(cmd);
 }
 
@@ -337,7 +339,7 @@ static void build_epoll_command(struct fsi_gpio_msg *cmd, uint8_t slave_id)
 	cmd->msg = 0;
 
 	msg_push_bits(cmd, slave_id, 2);
-	msg_push_bits(cmd, FSI_GPIO_CMD_EPOLL, 3);
+	msg_push_bits(cmd, FSI_CMD_EPOLL, 3);
 	msg_push_crc(cmd);
 }
 
@@ -347,7 +349,7 @@ static void build_term_command(struct fsi_gpio_msg *cmd, uint8_t slave_id)
 	cmd->msg = 0;
 
 	msg_push_bits(cmd, slave_id, 2);
-	msg_push_bits(cmd, FSI_GPIO_CMD_TERM, 6);
+	msg_push_bits(cmd, FSI_CMD_TERM, 6);
 	msg_push_crc(cmd);
 }
 
@@ -369,14 +371,14 @@ static int read_one_response(struct fsi_master_gpio *master,
 	local_irq_save(flags);
 
 	/* wait for the start bit */
-	for (i = 0; i < FSI_GPIO_MTOE_COUNT; i++) {
+	for (i = 0; i < FSI_MASTER_MTOE_COUNT; i++) {
 		msg.bits = 0;
 		msg.msg = 0;
 		serial_in(master, &msg, 1);
 		if (msg.msg)
 			break;
 	}
-	if (i == FSI_GPIO_MTOE_COUNT) {
+	if (i == FSI_MASTER_MTOE_COUNT) {
 		dev_warn(master->dev,
 			"Master time out waiting for response\n");
 		local_irq_restore(flags);
@@ -392,11 +394,11 @@ static int read_one_response(struct fsi_master_gpio *master,
 	tag = msg.msg & 0x3;
 
 	/* If we have an ACK and we're expecting data, clock the data in too */
-	if (tag == FSI_GPIO_RESP_ACK && data_size)
+	if (tag == FSI_RESP_ACK && data_size)
 		serial_in(master, &msg, data_size * 8);
 
 	/* read CRC */
-	serial_in(master, &msg, FSI_GPIO_CRC_SIZE);
+	serial_in(master, &msg, FSI_CRC_SIZE);
 
 	local_irq_restore(flags);
 
@@ -439,7 +441,7 @@ static int issue_term(struct fsi_master_gpio *master, uint8_t slave)
 		dev_err(master->dev,
 				"TERM failed; lost communication with slave\n");
 		return -EIO;
-	} else if (tag != FSI_GPIO_RESP_ACK) {
+	} else if (tag != FSI_RESP_ACK) {
 		dev_err(master->dev, "TERM failed; response %d\n", tag);
 		return -EIO;
 	}
@@ -475,7 +477,7 @@ static int poll_for_response(struct fsi_master_gpio *master,
 		trace_fsi_master_gpio_crc_rsp_error(master);
 		build_epoll_command(&cmd, slave);
 		local_irq_save(flags);
-		clock_zeros(master, FSI_GPIO_EPOLL_CLOCKS);
+		clock_zeros(master, FSI_MASTER_EPOLL_CLOCKS);
 		serial_out(master, &cmd);
 		echo_delay(master);
 		local_irq_restore(flags);
@@ -484,7 +486,7 @@ static int poll_for_response(struct fsi_master_gpio *master,
 		goto fail;
 
 	switch (tag) {
-	case FSI_GPIO_RESP_ACK:
+	case FSI_RESP_ACK:
 		if (size && data) {
 			uint64_t val = response.msg;
 			/* clear crc & mask */
@@ -497,16 +499,16 @@ static int poll_for_response(struct fsi_master_gpio *master,
 			}
 		}
 		break;
-	case FSI_GPIO_RESP_BUSY:
+	case FSI_RESP_BUSY:
 		/*
 		 * Its necessary to clock slave before issuing
 		 * d-poll, not indicated in the hardware protocol
 		 * spec. < 20 clocks causes slave to hang, 21 ok.
 		 */
-		if (busy_count++ < FSI_GPIO_MAX_BUSY) {
+		if (busy_count++ < FSI_MASTER_MAX_BUSY) {
 			build_dpoll_command(&cmd, slave);
 			local_irq_save(flags);
-			clock_zeros(master, FSI_GPIO_DPOLL_CLOCKS);
+			clock_zeros(master, FSI_MASTER_DPOLL_CLOCKS);
 			serial_out(master, &cmd);
 			echo_delay(master);
 			local_irq_restore(flags);
@@ -515,17 +517,17 @@ static int poll_for_response(struct fsi_master_gpio *master,
 		dev_warn(master->dev,
 			"ERR slave is stuck in busy state, issuing TERM\n");
 		local_irq_save(flags);
-		clock_zeros(master, FSI_GPIO_DPOLL_CLOCKS);
+		clock_zeros(master, FSI_MASTER_DPOLL_CLOCKS);
 		local_irq_restore(flags);
 		issue_term(master, slave);
 		rc = -EIO;
 		break;
 
-	case FSI_GPIO_RESP_ERRA:
+	case FSI_RESP_ERRA:
 		dev_warn(master->dev, "ERRA received: 0x%x\n", (int)response.msg);
 		rc = -EIO;
 		break;
-	case FSI_GPIO_RESP_ERRC:
+	case FSI_RESP_ERRC:
 		dev_warn(master->dev, "ERRC received: 0x%x\n", (int)response.msg);
 		trace_fsi_master_gpio_crc_cmd_error(master);
 		rc = -EAGAIN;
-- 
2.17.1

