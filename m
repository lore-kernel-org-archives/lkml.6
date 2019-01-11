Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A3DC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BD820657
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbfAKJAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:00:21 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:55295 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725779AbfAKJAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:00:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TI.JvuE_1547197175;
Received: from localhost(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TI.JvuE_1547197175)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Jan 2019 16:59:35 +0800
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
To:     jarkko.sakkinen@linux.intel.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        tweek@google.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhang.jia@linux.alibaba.com
Subject: [PATCH 1/2] tpm/eventlog/tpm1: Simplify walking over *pos measurements
Date:   Fri, 11 Jan 2019 16:59:32 +0800
Message-Id: <1547197173-52826-2-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547197173-52826-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1547197173-52826-1-git-send-email-zhang.jia@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The responsibility of tpm1_bios_measurements_start() is to walk
over the first *pos measurements, ensuring the skipped and
to-be-read measurements are not out-of-boundary.

Current logic is complicated a bit. Just employ a do-while loop
with necessary sanity check, and then get the goal.

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

