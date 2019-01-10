Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E440C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F781214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfAJLVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:21:09 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:36620 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbfAJLVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:21:09 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 240F7C0F34802E181BE6;
        Thu, 10 Jan 2019 19:21:06 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x0ABKxh9084969;
        Thu, 10 Jan 2019 19:20:59 +0800 (GMT-8)
        (envelope-from tan.hu@zte.com.cn)
Received: from localhost.localdomain ([10.75.9.60])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019011019213058-21524191 ;
          Thu, 10 Jan 2019 19:21:30 +0800 
From:   Tan Hu <tan.hu@zte.com.cn>
To:     adobriyan@gmail.com
Cc:     zhong.weidong@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: only export statistics of softirqs for online cpus
Date:   Thu, 10 Jan 2019 19:24:01 +0800
Message-Id: <1547119441-28314-1-git-send-email-tan.hu@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-10 19:21:30,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-10 19:20:47,
        Serialize complete at 2019-01-10 19:20:47
X-MAIL: mse01.zte.com.cn x0ABKxh9084969
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only export statistics of softirqs for online cpus like
/proc/interrupts, it would be more clearly.

Signed-off-by: Tan Hu <tan.hu@zte.com.cn>
---
 fs/proc/softirqs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/softirqs.c b/fs/proc/softirqs.c
index 12901dc..b7e6a0f 100644
--- a/fs/proc/softirqs.c
+++ b/fs/proc/softirqs.c
@@ -12,13 +12,13 @@ static int show_softirqs(struct seq_file *p, void *v)
 	int i, j;
 
 	seq_puts(p, "                    ");
-	for_each_possible_cpu(i)
+	for_each_online_cpu(i)
 		seq_printf(p, "CPU%-8d", i);
 	seq_putc(p, '\n');
 
 	for (i = 0; i < NR_SOFTIRQS; i++) {
 		seq_printf(p, "%12s:", softirq_to_name[i]);
-		for_each_possible_cpu(j)
+		for_each_online_cpu(j)
 			seq_printf(p, " %10u", kstat_softirqs_cpu(i, j));
 		seq_putc(p, '\n');
 	}
-- 
1.8.3.1

