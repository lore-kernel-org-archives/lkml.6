Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92112C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E81206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E81206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbeI3E3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:29:24 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51657 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728045AbeI3ESY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:24 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N63-0000HB-D9; Sat, 29 Sep 2018 22:48:19 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5z-0006xs-7W; Sat, 29 Sep 2018 22:48:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Adrian Schroeter" <adrian@suse.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Michal Hocko" <mhocko@suse.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        "Dominique Leuenberger" <dimstar@suse.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.772399205@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 112/131] x86/speculation/l1tf: Fix overflow in
 l1tf_pfn_limit() on 32bit
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Vlastimil Babka <vbabka@suse.cz>

commit 9df9516940a61d29aedf4d91b483ca6597e7d480 upstream.

On 32bit PAE kernels on 64bit hardware with enough physical bits,
l1tf_pfn_limit() will overflow unsigned long. This in turn affects
max_swapfile_size() and can lead to swapon returning -EINVAL. This has been
observed in a 32bit guest with 42 bits physical address size, where
max_swapfile_size() overflows exactly to 1 << 32, thus zero, and produces
the following warning to dmesg:

[    6.396845] Truncating oversized swap area, only using 0k out of 2047996k

Fix this by using unsigned long long instead.

Fixes: 17dbca119312 ("x86/speculation/l1tf: Add sysfs reporting for l1tf")
Fixes: 377eeaa8e11f ("x86/speculation/l1tf: Limit swap file size to MAX_PA/2")
Reported-by: Dominique Leuenberger <dimstar@suse.de>
Reported-by: Adrian Schroeter <adrian@suse.de>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Link: https://lkml.kernel.org/r/20180820095835.5298-1-vbabka@suse.cz
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/processor.h | 4 ++--
 arch/x86/mm/init.c               | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -165,9 +165,9 @@ extern const struct seq_operations cpuin
 extern void cpu_detect(struct cpuinfo_x86 *c);
 extern void fpu_detect(struct cpuinfo_x86 *c);
 
-static inline unsigned long l1tf_pfn_limit(void)
+static inline unsigned long long l1tf_pfn_limit(void)
 {
-	return BIT(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT) - 1;
+	return BIT_ULL(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT) - 1;
 }
 
 extern void early_cpu_init(void);
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -710,7 +710,7 @@ unsigned long max_swapfile_size(void)
 
 	if (boot_cpu_has_bug(X86_BUG_L1TF)) {
 		/* Limit the swap file size to MAX_PA/2 for L1TF workaround */
-		unsigned long l1tf_limit = l1tf_pfn_limit() + 1;
+		unsigned long long l1tf_limit = l1tf_pfn_limit() + 1;
 		/*
 		 * We encode swap offsets also with 3 bits below those for pfn
 		 * which makes the usable limit higher.
@@ -718,7 +718,7 @@ unsigned long max_swapfile_size(void)
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
 		l1tf_limit <<= PAGE_SHIFT - SWP_OFFSET_FIRST_BIT;
 #endif
-		pages = min_t(unsigned long, l1tf_limit, pages);
+		pages = min_t(unsigned long long, l1tf_limit, pages);
 	}
 	return pages;
 }

