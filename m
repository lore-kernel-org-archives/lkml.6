Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F441C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED7026A26
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED7026A26
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934032AbeFZX2I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:28:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:43377 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933944AbeFZX2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:28:07 -0400
Received: from pasglop.au.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5QNQ6qh022979;
        Tue, 26 Jun 2018 18:27:16 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 10/14] fsi: Move various master definitions to a common header
Date:   Wed, 27 Jun 2018 09:26:01 +1000
Message-Id: <20180626232605.13420-11-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626232605.13420-1-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the definitions for various protocol details
(message & response codes, delays etc...) out of
fsi-master-gpio.c to fsi-master.h in order to share them
with other master implementations.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-master-gpio.c | 29 -----------------------------
 drivers/fsi/fsi-master.h      | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index bad7951a2677..edc257e40102 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -17,35 +17,6 @@
 #include "fsi-master.h"
 
 #define	FSI_GPIO_STD_DLY	1	/* Standard pin delay in nS */
-#define	FSI_ECHO_DELAY_CLOCKS	16	/* Number clocks for echo delay */
-#define	FSI_SEND_DELAY_CLOCKS	16	/* Number clocks for send delay */
-#define	FSI_PRE_BREAK_CLOCKS	50	/* Number clocks to prep for break */
-#define	FSI_BREAK_CLOCKS	256	/* Number of clocks to issue break */
-#define	FSI_POST_BREAK_CLOCKS	16000	/* Number clocks to set up cfam */
-#define	FSI_INIT_CLOCKS		5000	/* Clock out any old data */
-#define	FSI_MASTER_DPOLL_CLOCKS	50      /* < 21 will cause slave to hang */
-#define	FSI_MASTER_EPOLL_CLOCKS	50      /* Number of clocks for E_POLL retry */
-
-#define FSI_CRC_ERR_RETRIES	10
-
-#define	FSI_CMD_DPOLL		0x2
-#define	FSI_CMD_EPOLL		0x3
-#define	FSI_CMD_TERM		0x3f
-#define FSI_CMD_ABS_AR		0x4
-#define FSI_CMD_REL_AR		0x5
-#define FSI_CMD_SAME_AR		0x3	/* but only a 2-bit opcode... */
-
-/* Slave responses */
-#define	FSI_RESP_ACK		0	/* Success */
-#define	FSI_RESP_BUSY		1	/* Slave busy */
-#define	FSI_RESP_ERRA		2	/* Any (misc) Error */
-#define	FSI_RESP_ERRC		3	/* Slave reports master CRC error */
-
-#define	FSI_MASTER_MAX_BUSY	200
-
-#define	FSI_MASTER_MTOE_COUNT	1000
-#define	FSI_CRC_SIZE		4
-
 #define LAST_ADDR_INVALID		0x1
 
 struct fsi_master_gpio {
diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index 7d619c68ab9b..f653f75da7be 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -19,6 +19,39 @@
 
 #include <linux/device.h>
 
+/* Various protocol delays */
+#define	FSI_ECHO_DELAY_CLOCKS	16	/* Number clocks for echo delay */
+#define	FSI_SEND_DELAY_CLOCKS	16	/* Number clocks for send delay */
+#define	FSI_PRE_BREAK_CLOCKS	50	/* Number clocks to prep for break */
+#define	FSI_BREAK_CLOCKS	256	/* Number of clocks to issue break */
+#define	FSI_POST_BREAK_CLOCKS	16000	/* Number clocks to set up cfam */
+#define	FSI_INIT_CLOCKS		5000	/* Clock out any old data */
+#define	FSI_MASTER_DPOLL_CLOCKS	50      /* < 21 will cause slave to hang */
+#define	FSI_MASTER_EPOLL_CLOCKS	50      /* Number of clocks for E_POLL retry */
+
+/* Various retry maximums */
+#define FSI_CRC_ERR_RETRIES	10
+#define	FSI_MASTER_MAX_BUSY	200
+#define	FSI_MASTER_MTOE_COUNT	1000
+
+/* Command encodings */
+#define	FSI_CMD_DPOLL		0x2
+#define	FSI_CMD_EPOLL		0x3
+#define	FSI_CMD_TERM		0x3f
+#define FSI_CMD_ABS_AR		0x4
+#define FSI_CMD_REL_AR		0x5
+#define FSI_CMD_SAME_AR		0x3	/* but only a 2-bit opcode... */
+
+/* Slave responses */
+#define	FSI_RESP_ACK		0	/* Success */
+#define	FSI_RESP_BUSY		1	/* Slave busy */
+#define	FSI_RESP_ERRA		2	/* Any (misc) Error */
+#define	FSI_RESP_ERRC		3	/* Slave reports master CRC error */
+
+/* Misc */
+#define	FSI_CRC_SIZE		4
+
+/* fsi-master definition and flags */
 #define FSI_MASTER_FLAG_SWCLOCK		0x1
 
 struct fsi_master {
-- 
2.17.1

