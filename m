Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BABC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BAF26A15
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BAF26A15
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934197AbeFZXor (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:44:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:37076 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933933AbeFZXoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:44:46 -0400
Received: from pasglop.au.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5QNNMmr022709;
        Tue, 26 Jun 2018 18:23:54 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 04/14] fsi: master-gpio: Rename and adjust send delay
Date:   Wed, 27 Jun 2018 09:23:11 +1000
Message-Id: <20180626232321.12372-5-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626232321.12372-1-benh@kernel.crashing.org>
References: <20180626232321.12372-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What the driver called "FSI_GPIO_PRIME_SLAVE_CLOCKS" is what
the FSI spec calls tSendDelay and should be 16 clocks by
default.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-master-gpio.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 1fd8b417939d..836587701ceb 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -18,6 +18,7 @@
 
 #define	FSI_GPIO_STD_DLY	1	/* Standard pin delay in nS */
 #define	FSI_ECHO_DELAY_CLOCKS	16	/* Number clocks for echo delay */
+#define	FSI_SEND_DELAY_CLOCKS	16	/* Number clocks for send delay */
 #define	FSI_PRE_BREAK_CLOCKS	50	/* Number clocks to prep for break */
 #define	FSI_BREAK_CLOCKS	256	/* Number of clocks to issue break */
 #define	FSI_POST_BREAK_CLOCKS	16000	/* Number clocks to set up cfam */
@@ -48,7 +49,6 @@
 #define	FSI_GPIO_CRC_SIZE	4
 #define	FSI_GPIO_MSG_ID_SIZE		2
 #define	FSI_GPIO_MSG_RESPID_SIZE	2
-#define	FSI_GPIO_PRIME_SLAVE_CLOCKS	20
 
 #define LAST_ADDR_INVALID		0x1
 
@@ -535,9 +535,12 @@ static int poll_for_response(struct fsi_master_gpio *master,
 	if (busy_count > 0)
 		trace_fsi_master_gpio_poll_response_busy(master, busy_count);
  fail:
-	/* Clock the slave enough to be ready for next operation */
+	/*
+	 * tSendDelay clocks, avoids signal reflections when switching
+	 * from receive of response back to send of data.
+	 */
 	local_irq_save(flags);
-	clock_zeros(master, FSI_GPIO_PRIME_SLAVE_CLOCKS);
+	clock_zeros(master, FSI_SEND_DELAY_CLOCKS);
 	local_irq_restore(flags);
 
 	return rc;
-- 
2.17.1

