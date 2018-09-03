Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E973C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4777420658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4777420658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbeICVzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:55:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47836 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbeICVzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:55:53 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0BFB4D30;
        Mon,  3 Sep 2018 17:34:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dominique Leuenberger <dimstar@suse.de>,
        Adrian Schroeter <adrian@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 4.18 051/123] x86/speculation/l1tf: Fix overflow in l1tf_pfn_limit() on 32bit
Date:   Mon,  3 Sep 2018 18:56:35 +0200
Message-Id: <20180903165721.616170486@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180820095835.5298-1-vbabka@suse.cz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/processor.h |    4 ++--
 arch/x86/mm/init.c               |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -181,9 +181,9 @@ extern const struct seq_operations cpuin
 
 extern void cpu_detect(struct cpuinfo_x86 *c);
 
-static inline unsigned long l1tf_pfn_limit(void)
+static inline unsigned long long l1tf_pfn_limit(void)
 {
-	return BIT(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT) - 1;
+	return BIT_ULL(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT) - 1;
 }
 
 extern void early_cpu_init(void);
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -923,7 +923,7 @@ unsigned long max_swapfile_size(void)
 
 	if (boot_cpu_has_bug(X86_BUG_L1TF)) {
 		/* Limit the swap file size to MAX_PA/2 for L1TF workaround */
-		unsigned long l1tf_limit = l1tf_pfn_limit() + 1;
+		unsigned long long l1tf_limit = l1tf_pfn_limit() + 1;
 		/*
 		 * We encode swap offsets also with 3 bits below those for pfn
 		 * which makes the usable limit higher.
@@ -931,7 +931,7 @@ unsigned long max_swapfile_size(void)
 #if CONFIG_PGTABLE_LEVELS > 2
 		l1tf_limit <<= PAGE_SHIFT - SWP_OFFSET_FIRST_BIT;
 #endif
-		pages = min_t(unsigned long, l1tf_limit, pages);
+		pages = min_t(unsigned long long, l1tf_limit, pages);
 	}
 	return pages;
 }


