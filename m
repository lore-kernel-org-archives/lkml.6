Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0EBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113A32157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113A32157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeHXL2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:28:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37539 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeHXL2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:28:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7O7t1Ao3564674
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 24 Aug 2018 00:55:01 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7O7t0Ar3564671;
        Fri, 24 Aug 2018 00:55:00 -0700
Date:   Fri, 24 Aug 2018 00:55:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vlastimil Babka <tipbot@zytor.com>
Message-ID: <tip-b0a182f875689647b014bc01d36b340217792852@git.kernel.org>
Cc:     mhocko@kernel.org, torvalds@linux-foundation.org,
        xxxxxx@xxxxxx.xxx, ak@linux.intel.com, dave.hansen@intel.com,
        kode54@gmail.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        vbabka@suse.cz, mingo@kernel.org, tglx@linutronix.de
Reply-To: kode54@gmail.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          vbabka@suse.cz, mingo@kernel.org, tglx@linutronix.de,
          mhocko@kernel.org, torvalds@linux-foundation.org,
          xxxxxx@xxxxxx.xxx, ak@linux.intel.com, dave.hansen@intel.com
In-Reply-To: <20180823134418.17008-1-vbabka@suse.cz>
References: <20180823134418.17008-1-vbabka@suse.cz>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/speculation/l1tf: Fix off-by-one error when
 warning that system has too much RAM
Git-Commit-ID: b0a182f875689647b014bc01d36b340217792852
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b0a182f875689647b014bc01d36b340217792852
Gitweb:     https://git.kernel.org/tip/b0a182f875689647b014bc01d36b340217792852
Author:     Vlastimil Babka <vbabka@suse.cz>
AuthorDate: Thu, 23 Aug 2018 15:44:18 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 24 Aug 2018 09:51:14 +0200

x86/speculation/l1tf: Fix off-by-one error when warning that system has too much RAM

Two users have reported [1] that they have an "extremely unlikely" system
with more than MAX_PA/2 memory and L1TF mitigation is not effective. In
fact it's a CPU with 36bits phys limit (64GB) and 32GB memory, but due to
holes in the e820 map, the main region is almost 500MB over the 32GB limit:

[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000081effffff] usable

Suggestions to use 'mem=32G' to enable the L1TF mitigation while losing the
500MB revealed, that there's an off-by-one error in the check in
l1tf_select_mitigation().

l1tf_pfn_limit() returns the last usable pfn (inclusive) and the range
check in the mitigation path does not take this into account.

Instead of amending the range check, make l1tf_pfn_limit() return the first
PFN which is over the limit which is less error prone. Adjust the other
users accordingly.

[1] https://bugzilla.suse.com/show_bug.cgi?id=1105536

Fixes: 17dbca119312 ("x86/speculation/l1tf: Add sysfs reporting for l1tf")
Reported-by: xxxxxx xxxxxx <xxxxxx@xxxxxx.xxx>
Reported-by: Christopher Snowhill <kode54@gmail.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180823134418.17008-1-vbabka@suse.cz

---
 arch/x86/include/asm/processor.h | 2 +-
 arch/x86/mm/init.c               | 2 +-
 arch/x86/mm/mmap.c               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a0a52274cb4a..c24297268ebc 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -183,7 +183,7 @@ extern void cpu_detect(struct cpuinfo_x86 *c);
 
 static inline unsigned long long l1tf_pfn_limit(void)
 {
-	return BIT_ULL(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT) - 1;
+	return BIT_ULL(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT);
 }
 
 extern void early_cpu_init(void);
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 02de3d6065c4..63a6f9fcaf20 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -923,7 +923,7 @@ unsigned long max_swapfile_size(void)
 
 	if (boot_cpu_has_bug(X86_BUG_L1TF)) {
 		/* Limit the swap file size to MAX_PA/2 for L1TF workaround */
-		unsigned long long l1tf_limit = l1tf_pfn_limit() + 1;
+		unsigned long long l1tf_limit = l1tf_pfn_limit();
 		/*
 		 * We encode swap offsets also with 3 bits below those for pfn
 		 * which makes the usable limit higher.
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index f40ab8185d94..1e95d57760cf 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -257,7 +257,7 @@ bool pfn_modify_allowed(unsigned long pfn, pgprot_t prot)
 	/* If it's real memory always allow */
 	if (pfn_valid(pfn))
 		return true;
-	if (pfn > l1tf_pfn_limit() && !capable(CAP_SYS_ADMIN))
+	if (pfn >= l1tf_pfn_limit() && !capable(CAP_SYS_ADMIN))
 		return false;
 	return true;
 }
