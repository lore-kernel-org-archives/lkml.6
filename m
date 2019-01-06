Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEE4C43612
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 07:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39BA218FC
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 07:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfAFHYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 02:24:42 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:55089 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726250AbfAFHYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 02:24:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0THdglfm_1546759399;
Received: from localhost(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0THdglfm_1546759399)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 06 Jan 2019 15:23:20 +0800
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
To:     jarkko.sakkinen@linux.intel.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        tweek@google.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhang.jia@linux.alibaba.com
Subject: [PATCH 1/2] tpm/eventlog/tpm1: Simplify walking over *pos measurements
Date:   Sun,  6 Jan 2019 15:23:18 +0800
Message-Id: <1546759399-45360-1-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sanity check would be easier, especially for the first read
of binary_bios_measurements from the beginning.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
---
 drivers/char/tpm/eventlog/tpm1.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
index 58c8478..4cf8303 100644
--- a/drivers/char/tpm/eventlog/tpm1.c
+++ b/drivers/char/tpm/eventlog/tpm1.c
@@ -74,7 +74,7 @@
 /* returns pointer to start of pos. entry of tcg log */
 static void *tpm1_bios_measurements_start(struct seq_file *m, loff_t *pos)
 {
-	loff_t i;
+	loff_t i = 0;
 	struct tpm_chip *chip = m->private;
 	struct tpm_bios_log *log = &chip->log;
 	void *addr = log->bios_event_log;
@@ -83,38 +83,29 @@ static void *tpm1_bios_measurements_start(struct seq_file *m, loff_t *pos)
 	u32 converted_event_size;
 	u32 converted_event_type;
 
-
 	/* read over *pos measurements */
-	for (i = 0; i < *pos; i++) {
+	do {
 		event = addr;
 
+		/* check if current entry is valid */
+		if (addr + sizeof(struct tcpa_event) >= limit)
+			return NULL;
+
 		converted_event_size =
 		    do_endian_conversion(event->event_size);
 		converted_event_type =
 		    do_endian_conversion(event->event_type);
 
-		if ((addr + sizeof(struct tcpa_event)) < limit) {
-			if ((converted_event_type == 0) &&
-			    (converted_event_size == 0))
-				return NULL;
-			addr += (sizeof(struct tcpa_event) +
-				 converted_event_size);
-		}
-	}
-
-	/* now check if current entry is valid */
-	if ((addr + sizeof(struct tcpa_event)) >= limit)
-		return NULL;
-
-	event = addr;
+		if (((converted_event_type == 0) && (converted_event_size == 0))
+		    || ((addr + sizeof(struct tcpa_event) + converted_event_size)
+			>= limit))
+			return NULL;
 
-	converted_event_size = do_endian_conversion(event->event_size);
-	converted_event_type = do_endian_conversion(event->event_type);
+		if (i++ == *pos)
+			break;
 
-	if (((converted_event_type == 0) && (converted_event_size == 0))
-	    || ((addr + sizeof(struct tcpa_event) + converted_event_size)
-		>= limit))
-		return NULL;
+		addr += (sizeof(struct tcpa_event) + converted_event_size);
+	} while (1);
 
 	return addr;
 }
-- 
1.8.3.1

