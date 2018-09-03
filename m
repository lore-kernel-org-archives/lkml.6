Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD9DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C732086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C732086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbeICVqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:46:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45626 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbeICVqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:46:05 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 962C2D24;
        Mon,  3 Sep 2018 17:24:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, xxxxxx xxxxxx <xxxxxx@xxxxxx.xxx>,
        Christopher Snowhill <kode54@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 4.14 112/165] x86/speculation/l1tf: Fix off-by-one error when warning that system has too much RAM
Date:   Mon,  3 Sep 2018 18:56:38 +0200
Message-Id: <20180903165701.131805367@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180823134418.17008-1-vbabka@suse.cz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/processor.h |    2 +-
 arch/x86/mm/init.c               |    2 +-
 arch/x86/mm/mmap.c               |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -182,7 +182,7 @@ extern void cpu_detect(struct cpuinfo_x8
 
 static inline unsigned long long l1tf_pfn_limit(void)
 {
-	return BIT_ULL(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT) - 1;
+	return BIT_ULL(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT);
 }
 
 extern void early_cpu_init(void);
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -892,7 +892,7 @@ unsigned long max_swapfile_size(void)
 
 	if (boot_cpu_has_bug(X86_BUG_L1TF)) {
 		/* Limit the swap file size to MAX_PA/2 for L1TF workaround */
-		unsigned long long l1tf_limit = l1tf_pfn_limit() + 1;
+		unsigned long long l1tf_limit = l1tf_pfn_limit();
 		/*
 		 * We encode swap offsets also with 3 bits below those for pfn
 		 * which makes the usable limit higher.
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -191,7 +191,7 @@ bool pfn_modify_allowed(unsigned long pf
 	/* If it's real memory always allow */
 	if (pfn_valid(pfn))
 		return true;
-	if (pfn > l1tf_pfn_limit() && !capable(CAP_SYS_ADMIN))
+	if (pfn >= l1tf_pfn_limit() && !capable(CAP_SYS_ADMIN))
 		return false;
 	return true;
 }


