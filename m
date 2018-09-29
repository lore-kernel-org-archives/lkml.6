Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72655C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C2B20880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C2B20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeI3E3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:29:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51665 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728078AbeI3ESY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:24 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N63-0000H7-Bj; Sat, 29 Sep 2018 22:48:19 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5z-0006xx-8t; Sat, 29 Sep 2018 22:48:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Michal Hocko" <mhocko@kernel.org>,
        "Christopher Snowhill" <kode54@gmail.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "xxxxxx xxxxxx" <xxxxxx@xxxxxx.xxx>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.201932437@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 113/131] x86/speculation/l1tf: Fix off-by-one error
 when warning that system has too much RAM
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

commit b0a182f875689647b014bc01d36b340217792852 upstream.

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
Link: https://lkml.kernel.org/r/20180823134418.17008-1-vbabka@suse.cz
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/processor.h | 2 +-
 arch/x86/mm/init.c               | 2 +-
 arch/x86/mm/mmap.c               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -167,7 +167,7 @@ extern void fpu_detect(struct cpuinfo_x8
 
 static inline unsigned long long l1tf_pfn_limit(void)
 {
-	return BIT_ULL(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT) - 1;
+	return BIT_ULL(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT);
 }
 
 extern void early_cpu_init(void);
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -710,7 +710,7 @@ unsigned long max_swapfile_size(void)
 
 	if (boot_cpu_has_bug(X86_BUG_L1TF)) {
 		/* Limit the swap file size to MAX_PA/2 for L1TF workaround */
-		unsigned long long l1tf_limit = l1tf_pfn_limit() + 1;
+		unsigned long long l1tf_limit = l1tf_pfn_limit();
 		/*
 		 * We encode swap offsets also with 3 bits below those for pfn
 		 * which makes the usable limit higher.
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -131,7 +131,7 @@ bool pfn_modify_allowed(unsigned long pf
 	/* If it's real memory always allow */
 	if (pfn_valid(pfn))
 		return true;
-	if (pfn > l1tf_pfn_limit() && !capable(CAP_SYS_ADMIN))
+	if (pfn >= l1tf_pfn_limit() && !capable(CAP_SYS_ADMIN))
 		return false;
 	return true;
 }

