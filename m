Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231A3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E379E214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbfAKJA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:00:26 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:48029 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731298AbfAKJAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:00:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TI.JvuG_1547197175;
Received: from localhost(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TI.JvuG_1547197175)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Jan 2019 16:59:35 +0800
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
To:     jarkko.sakkinen@linux.intel.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        tweek@google.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhang.jia@linux.alibaba.com
Subject: [PATCH 2/2] tpm/eventlog/tpm1: Fix off-by-1 when reading binary_bios_measurements
Date:   Fri, 11 Jan 2019 16:59:33 +0800
Message-Id: <1547197173-52826-3-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547197173-52826-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1547197173-52826-1-git-send-email-zhang.jia@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is unable to read the entry when it is the only one in
binary_bios_measurements:

00000000  00 00 00 00 08 00 00 00  c4 2f ed ad 26 82 00 cb
00000010  1d 15 f9 78 41 c3 44 e7  9d ae 33 20 00 00 00 00
00000020

This is obviously a firmware problem on my linux machine:

	Manufacturer: Inspur
	Product Name: SA5212M4
	Version: 01

However, binary_bios_measurements should return it any way,
rather than nothing, after all its content is completely
valid.

Fixes: 55a82ab("tpm: add bios measurement log")
Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
---
 drivers/char/tpm/eventlog/tpm1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
index 4cf8303..bfdff92 100644
--- a/drivers/char/tpm/eventlog/tpm1.c
+++ b/drivers/char/tpm/eventlog/tpm1.c
@@ -88,7 +88,7 @@ static void *tpm1_bios_measurements_start(struct seq_file *m, loff_t *pos)
 		event = addr;
 
 		/* check if current entry is valid */
-		if (addr + sizeof(struct tcpa_event) >= limit)
+		if (addr + sizeof(struct tcpa_event) > limit)
 			return NULL;
 
 		converted_event_size =
@@ -98,7 +98,7 @@ static void *tpm1_bios_measurements_start(struct seq_file *m, loff_t *pos)
 
 		if (((converted_event_type == 0) && (converted_event_size == 0))
 		    || ((addr + sizeof(struct tcpa_event) + converted_event_size)
-			>= limit))
+			> limit))
 			return NULL;
 
 		if (i++ == *pos)
@@ -125,7 +125,7 @@ static void *tpm1_bios_measurements_next(struct seq_file *m, void *v,
 	v += sizeof(struct tcpa_event) + converted_event_size;
 
 	/* now check if current entry is valid */
-	if ((v + sizeof(struct tcpa_event)) >= limit)
+	if ((v + sizeof(struct tcpa_event)) > limit)
 		return NULL;
 
 	event = v;
@@ -134,7 +134,7 @@ static void *tpm1_bios_measurements_next(struct seq_file *m, void *v,
 	converted_event_type = do_endian_conversion(event->event_type);
 
 	if (((converted_event_type == 0) && (converted_event_size == 0)) ||
-	    ((v + sizeof(struct tcpa_event) + converted_event_size) >= limit))
+	    ((v + sizeof(struct tcpa_event) + converted_event_size) > limit))
 		return NULL;
 
 	(*pos)++;
-- 
1.8.3.1

