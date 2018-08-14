Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F038C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3AE21742
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3AE21742
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732649AbeHNSWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:22:01 -0400
Received: from mail1.windriver.com ([147.11.146.13]:53086 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbeHNSWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:22:01 -0400
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w7EFXnvf017831
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 14 Aug 2018 08:33:49 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.399.0; Tue, 14 Aug 2018 08:33:48 -0700
From:   <zhe.he@windriver.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <pombredanne@nexb.com>,
        <gregkh@linuxfoundation.org>, <kstewart@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhe.he@windriver.com>
Subject: [PATCH v2 2/2] x86: corruption-check: Change printk to the right fashion
Date:   Tue, 14 Aug 2018 23:33:43 +0800
Message-ID: <1534260823-87917-2-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534260823-87917-1-git-send-email-zhe.he@windriver.com>
References: <1534260823-87917-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

pr_* is preferred according to scripts/checkpatch.pl.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
v2:
- Split printk cleanups into a single patch
- Add pr_fmt for mod name

 arch/x86/kernel/check.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/check.c b/arch/x86/kernel/check.c
index cc8258a..a3d9649 100644
--- a/arch/x86/kernel/check.c
+++ b/arch/x86/kernel/check.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/kthread.h>
@@ -128,7 +131,8 @@ void __init setup_bios_corruption_check(void)
 	}
 
 	if (num_scan_areas)
-		printk(KERN_INFO "Scanning %d areas for low memory corruption\n", num_scan_areas);
+		pr_info("Scanning %d areas for low memory corruption\n",
+			num_scan_areas);
 }
 
 
@@ -147,7 +151,7 @@ void check_for_bios_corruption(void)
 		for (; size; addr++, size -= sizeof(unsigned long)) {
 			if (!*addr)
 				continue;
-			printk(KERN_ERR "Corrupted low memory at %p (%lx phys) = %08lx\n",
+			pr_err("Corrupted low memory at %p (%lx phys) = %08lx\n",
 			       addr, __pa(addr), *addr);
 			corruption = 1;
 			*addr = 0;
@@ -172,7 +176,7 @@ static int start_periodic_check_for_corruption(void)
 	if (!num_scan_areas || !memory_corruption_check || corruption_check_period == 0)
 		return 0;
 
-	printk(KERN_INFO "Scanning for low memory corruption every %d seconds\n",
+	pr_info("Scanning for low memory corruption every %d seconds\n",
 	       corruption_check_period);
 
 	/* First time we run the checks right away */
-- 
2.7.4

