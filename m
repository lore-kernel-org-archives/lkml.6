Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33F7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 07:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54E520870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 07:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbfALHQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 02:16:55 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:37208 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfALHQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 02:16:55 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 9253B3380D5A35EA13E4;
        Sat, 12 Jan 2019 15:16:51 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x0C7Gl1o001961;
        Sat, 12 Jan 2019 15:16:47 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019011215173273-21857418 ;
          Sat, 12 Jan 2019 15:17:32 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        mhocko@suse.com, pavel.tatashin@microsoft.com, joe@perches.com,
        jschoenh@amazon.de, m.mizuma@jp.fujitsu.com,
        n-horiguchi@ah.jp.nec.com, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        "Huang Zijiang" <huang.zijiang@zte.com.cn>
Subject: [PATCH v2] x86/boot/e820: Use kmemdup instead of duplicating its function
Date:   Sat, 12 Jan 2019 15:16:24 +0800
Message-Id: <1547277384-22156-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-12 15:17:32,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-12 15:16:28,
        Serialize complete at 2019-01-12 15:16:28
X-MAIL: mse01.zte.com.cn x0C7Gl1o001961
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Huang Zijiang" <huang.zijiang@zte.com.cn>

changes since v1:
	redo the patch based on suggestions from Boris.
v1 link:https://lkml.org/lkml/2019/1/8/30

kmemdup is the same function as kmalloc() + memcpy().

Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
---
 arch/x86/kernel/e820.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 50895c2..a687d10 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -671,21 +671,18 @@ __init void e820__reallocate_tables(void)
 	int size;
 
 	size = offsetof(struct e820_table, entries) + sizeof(struct e820_entry)*e820_table->nr_entries;
-	n = kmalloc(size, GFP_KERNEL);
+	n = kmemdup(e820_table, size, GFP_KERNEL);
 	BUG_ON(!n);
-	memcpy(n, e820_table, size);
 	e820_table = n;
 
 	size = offsetof(struct e820_table, entries) + sizeof(struct e820_entry)*e820_table_kexec->nr_entries;
-	n = kmalloc(size, GFP_KERNEL);
+	n = kmemdup(e820_table_kexec, size, GFP_KERNEL);
 	BUG_ON(!n);
-	memcpy(n, e820_table_kexec, size);
 	e820_table_kexec = n;
 
 	size = offsetof(struct e820_table, entries) + sizeof(struct e820_entry)*e820_table_firmware->nr_entries;
-	n = kmalloc(size, GFP_KERNEL);
+	n = kmemdup(e820_table_firmware, size, GFP_KERNEL);
 	BUG_ON(!n);
-	memcpy(n, e820_table_firmware, size);
 	e820_table_firmware = n;
 }
 
-- 
1.8.3.1

