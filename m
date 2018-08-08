Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10938C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF13121A38
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF13121A38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbeHHTH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:07:59 -0400
Received: from mail5.windriver.com ([192.103.53.11]:54196 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbeHHTH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:07:59 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w78GjIS1016111
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 8 Aug 2018 09:45:34 -0700
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.399.0; Wed, 8 Aug 2018 09:45:19 -0700
From:   <zhe.he@windriver.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <pombredanne@nexb.com>,
        <gregkh@linuxfoundation.org>, <kstewart@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhe.he@windriver.com>
Subject: [PATCH] x86: corruption-check: Passing memory_corruption_check to command line causes panic
Date:   Thu, 9 Aug 2018 00:45:16 +0800
Message-ID: <1533746716-442364-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

memory_corruption_check[{_period|_size}]'s handlers do not check input
argument before passing it to kstrtoul or simple_strtoull. The argument
would be a NULL pointer if each of the kernel parameters, without its
value, is set in command line and thus cause the following panic.

PANIC: early exception 0xe3 IP 10:ffffffff73587c22 error 0 cr2 0x0
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.18-rc8+ #2
[    0.000000] RIP: 0010:kstrtoull+0x2/0x10
...
[    0.000000] Call Trace
[    0.000000]  ? set_corruption_check+0x21/0x49
[    0.000000]  ? do_early_param+0x4d/0x82
[    0.000000]  ? parse_args+0x212/0x330
[    0.000000]  ? rdinit_setup+0x26/0x26
[    0.000000]  ? parse_early_options+0x20/0x23
[    0.000000]  ? rdinit_setup+0x26/0x26
[    0.000000]  ? parse_early_param+0x2d/0x39
[    0.000000]  ? setup_arch+0x2f7/0xbf4
[    0.000000]  ? start_kernel+0x5e/0x4c2
[    0.000000]  ? load_ucode_bsp+0x113/0x12f
[    0.000000]  ? secondary_startup_64+0xa5/0xb0

This patch adds checks to prevent the panic and changes some printk
to right fashion.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 arch/x86/kernel/check.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/check.c b/arch/x86/kernel/check.c
index 3339942..d3d65d7 100644
--- a/arch/x86/kernel/check.c
+++ b/arch/x86/kernel/check.c
@@ -31,6 +31,11 @@ static __init int set_corruption_check(char *arg)
 	ssize_t ret;
 	unsigned long val;
 
+	if (!arg) {
+		pr_err("memory_corruption_check: null option\n");
+		return -EINVAL;
+	}
+
 	ret = kstrtoul(arg, 10, &val);
 	if (ret)
 		return ret;
@@ -45,6 +50,11 @@ static __init int set_corruption_check_period(char *arg)
 	ssize_t ret;
 	unsigned long val;
 
+	if (!arg) {
+		pr_err("memory_corruption_check_period: null option\n");
+		return -EINVAL;
+	}
+
 	ret = kstrtoul(arg, 10, &val);
 	if (ret)
 		return ret;
@@ -59,6 +69,11 @@ static __init int set_corruption_check_size(char *arg)
 	char *end;
 	unsigned size;
 
+	if (!arg) {
+		pr_err("memory_corruption_check_size: null option\n");
+		return -EINVAL;
+	}
+
 	size = memparse(arg, &end);
 
 	if (*end == '\0')
@@ -113,7 +128,8 @@ void __init setup_bios_corruption_check(void)
 	}
 
 	if (num_scan_areas)
-		printk(KERN_INFO "Scanning %d areas for low memory corruption\n", num_scan_areas);
+		pr_info("Scanning %d areas for low memory corruption\n",
+			num_scan_areas);
 }
 
 
@@ -132,7 +148,7 @@ void check_for_bios_corruption(void)
 		for (; size; addr++, size -= sizeof(unsigned long)) {
 			if (!*addr)
 				continue;
-			printk(KERN_ERR "Corrupted low memory at %p (%lx phys) = %08lx\n",
+			pr_err("Corrupted low memory at %p (%lx phys) = %08lx\n",
 			       addr, __pa(addr), *addr);
 			corruption = 1;
 			*addr = 0;
@@ -157,7 +173,7 @@ static int start_periodic_check_for_corruption(void)
 	if (!num_scan_areas || !memory_corruption_check || corruption_check_period == 0)
 		return 0;
 
-	printk(KERN_INFO "Scanning for low memory corruption every %d seconds\n",
+	pr_info("Scanning for low memory corruption every %d seconds\n",
 	       corruption_check_period);
 
 	/* First time we run the checks right away */
-- 
2.7.4

