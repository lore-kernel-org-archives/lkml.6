Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F23C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AB22170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AB22170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeHTTaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:30:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35861 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeHTTaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:30:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7KGBtJt2126120
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 20 Aug 2018 09:11:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7KGBteO2126117;
        Mon, 20 Aug 2018 09:11:55 -0700
Date:   Mon, 20 Aug 2018 09:11:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vlastimil Babka <tipbot@zytor.com>
Message-ID: <tip-9df9516940a61d29aedf4d91b483ca6597e7d480@git.kernel.org>
Cc:     torvalds@linux-foundation.org, dave.hansen@intel.com,
        mingo@kernel.org, ak@linux.intel.com, dimstar@suse.de,
        hpa@zytor.com, vbabka@suse.cz, mhocko@suse.com, mhocko@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, adrian@suse.de
Reply-To: linux-kernel@vger.kernel.org, adrian@suse.de, mhocko@kernel.org,
          tglx@linutronix.de, vbabka@suse.cz, mhocko@suse.com,
          torvalds@linux-foundation.org, ak@linux.intel.com,
          mingo@kernel.org, dave.hansen@intel.com, dimstar@suse.de,
          hpa@zytor.com
In-Reply-To: <20180820095835.5298-1-vbabka@suse.cz>
References: <20180820095835.5298-1-vbabka@suse.cz>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/speculation/l1tf: Fix overflow in
 l1tf_pfn_limit() on 32bit
Git-Commit-ID: 9df9516940a61d29aedf4d91b483ca6597e7d480
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9df9516940a61d29aedf4d91b483ca6597e7d480
Gitweb:     https://git.kernel.org/tip/9df9516940a61d29aedf4d91b483ca6597e7d480
Author:     Vlastimil Babka <vbabka@suse.cz>
AuthorDate: Mon, 20 Aug 2018 11:58:35 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 20 Aug 2018 18:04:42 +0200

x86/speculation/l1tf: Fix overflow in l1tf_pfn_limit() on 32bit

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

---
 arch/x86/include/asm/processor.h | 4 ++--
 arch/x86/mm/init.c               | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 682286aca881..a0a52274cb4a 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -181,9 +181,9 @@ extern const struct seq_operations cpuinfo_op;
 
 extern void cpu_detect(struct cpuinfo_x86 *c);
 
-static inline unsigned long l1tf_pfn_limit(void)
+static inline unsigned long long l1tf_pfn_limit(void)
 {
-	return BIT(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT) - 1;
+	return BIT_ULL(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT) - 1;
 }
 
 extern void early_cpu_init(void);
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index acfab322fbe0..02de3d6065c4 100644
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
