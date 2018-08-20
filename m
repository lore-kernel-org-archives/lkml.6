Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23F5C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72F820C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72F820C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbeHTNNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:13:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:58122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeHTNNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:13:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AB05AAE3A;
        Mon, 20 Aug 2018 09:58:49 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org,
        Adrian Schroeter <adrian@suse.de>,
        Dominique Leuenberger <dimstar@suse.de>
Subject: [PATCH] x86/speculation/l1tf: fix overflow on l1tf_pfn_limit() on 32bit
Date:   Mon, 20 Aug 2018 11:58:35 +0200
Message-Id: <20180820095835.5298-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32bit PAE kernels on 64bit hardware with enough physical bits,
l1tf_pfn_limit() will overflow unsigned long. This in turn affects
max_swapfile_size() and can lead to swapon returning -EINVAL. This has been
observed in a 32bit guest with 42 bits physical address size, where
max_swapfile_size() overflows exactly to 1 << 32, thus zero, and produces the
following warning to dmesg:

[    6.396845] Truncating oversized swap area, only using 0k out of 2047996k

Fix this by using unsigned long long instead.

Reported-by: Dominique Leuenberger <dimstar@suse.de>
Reported-by: Adrian Schroeter <adrian@suse.de>
Fixes: 17dbca119312 ("x86/speculation/l1tf: Add sysfs reporting for l1tf")
Fixes: 377eeaa8e11f ("x86/speculation/l1tf: Limit swap file size to MAX_PA/2")
Cc: stable@vger.kernel.org
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
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
-- 
2.18.0

