Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAACC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC42206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866241;
	bh=ZhtEGOb110+2NFXg//zTxyZ+Xq+QNxzs5esaxnUnDCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lNpbUtuZoYQv4W+aEAJmN7Kl9oXzx6v0B996XsToATCAt9oQ3IOqb9vFW2l9DgrPL
	 DLVJN//bo3bCLf9h+/dSWQWkJIKUG/XkQ5l1045dL2uBxngrwB6mXn2QM0dEyH9ABR
	 Z4RXhbFeEEvJhjC4RiYAH2q5pPEkPbMDEYprrspw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbfAGNEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:04:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731100AbfAGND6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:03:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91C282089F;
        Mon,  7 Jan 2019 13:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866237;
        bh=ZhtEGOb110+2NFXg//zTxyZ+Xq+QNxzs5esaxnUnDCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xSedNs4jM7tT42bjoJ7XrlU1MPaCmuS+1jutzuDv4zv1bNSVgtj2HSvT8ZfCOaDyn
         frCVvNGZsD8CjK2oNEvzYztvTOCKXD7xS2dFwRqrkicuDrLvMLrhUd76o6qHY1Wpzl
         eOJYheWQFw6mjbOwSDe7/tYw8ELvu1DelvQyh6Ps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        Yu Huabing <yhb@ruijie.com.cn>, linux-mips@vger.kernel.org
Subject: [PATCH 4.14 093/101] MIPS: Expand MIPS32 ASIDs to 64 bits
Date:   Mon,  7 Jan 2019 13:33:21 +0100
Message-Id: <20190107105337.927508368@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit ff4dd232ec45a0e45ea69f28f069f2ab22b4908a upstream.

ASIDs have always been stored as unsigned longs, ie. 32 bits on MIPS32
kernels. This is problematic because it is feasible for the ASID version
to overflow & wrap around to zero.

We currently attempt to handle this overflow by simply setting the ASID
version to 1, using asid_first_version(), but we make no attempt to
account for the fact that there may be mm_structs with stale ASIDs that
have versions which we now reuse due to the overflow & wrap around.

Encountering this requires that:

  1) A struct mm_struct X is active on CPU A using ASID (V,n).

  2) That mm is not used on CPU A for the length of time that it takes
     for CPU A's asid_cache to overflow & wrap around to the same
     version V that the mm had in step 1. During this time tasks using
     the mm could either be sleeping or only scheduled on other CPUs.

  3) Some other mm Y becomes active on CPU A and is allocated the same
     ASID (V,n).

  4) mm X now becomes active on CPU A again, and now incorrectly has the
     same ASID as mm Y.

Where struct mm_struct ASIDs are represented above in the format
(version, EntryHi.ASID), and on a typical MIPS32 system version will be
24 bits wide & EntryHi.ASID will be 8 bits wide.

The length of time required in step 2 is highly dependent upon the CPU &
workload, but for a hypothetical 2GHz CPU running a workload which
generates a new ASID every 10000 cycles this period is around 248 days.
Due to this long period of time & the fact that tasks need to be
scheduled in just the right (or wrong, depending upon your inclination)
way, this is obviously a difficult bug to encounter but it's entirely
possible as evidenced by reports.

In order to fix this, simply extend ASIDs to 64 bits even on MIPS32
builds. This will extend the period of time required for the
hypothetical system above to encounter the problem from 28 days to
around 3 trillion years, which feels safely outside of the realms of
possibility.

The cost of this is slightly more generated code in some commonly
executed paths, but this is pretty minimal:

                         | Code Size Gain | Percentage
  -----------------------|----------------|-------------
    decstation_defconfig |           +270 | +0.00%
        32r2el_defconfig |           +652 | +0.01%
        32r6el_defconfig |          +1000 | +0.01%

I have been unable to measure any change in performance of the LMbench
lat_ctx or lat_proc tests resulting from the 64b ASIDs on either
32r2el_defconfig+interAptiv or 32r6el_defconfig+I6500 systems.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Suggested-by: James Hogan <jhogan@kernel.org>
References: https://lore.kernel.org/linux-mips/80B78A8B8FEE6145A87579E8435D78C30205D5F3@fzex.ruijie.com.cn/
References: https://lore.kernel.org/linux-mips/1488684260-18867-1-git-send-email-jiwei.sun@windriver.com/
Cc: Jiwei Sun <jiwei.sun@windriver.com>
Cc: Yu Huabing <yhb@ruijie.com.cn>
Cc: stable@vger.kernel.org # 2.6.12+
Cc: linux-mips@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/cpu-info.h    |    2 +-
 arch/mips/include/asm/mmu.h         |    2 +-
 arch/mips/include/asm/mmu_context.h |   10 ++++------
 arch/mips/mm/c-r3k.c                |    2 +-
 4 files changed, 7 insertions(+), 9 deletions(-)

--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -50,7 +50,7 @@ struct guest_info {
 #define MIPS_CACHE_PINDEX	0x00000020	/* Physically indexed cache */
 
 struct cpuinfo_mips {
-	unsigned long		asid_cache;
+	u64			asid_cache;
 #ifdef CONFIG_MIPS_ASID_BITS_VARIABLE
 	unsigned long		asid_mask;
 #endif
--- a/arch/mips/include/asm/mmu.h
+++ b/arch/mips/include/asm/mmu.h
@@ -7,7 +7,7 @@
 #include <linux/wait.h>
 
 typedef struct {
-	unsigned long asid[NR_CPUS];
+	u64 asid[NR_CPUS];
 	void *vdso;
 	atomic_t fp_mode_switching;
 
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -75,14 +75,14 @@ extern unsigned long pgd_current[];
  *  All unused by hardware upper bits will be considered
  *  as a software asid extension.
  */
-static unsigned long asid_version_mask(unsigned int cpu)
+static inline u64 asid_version_mask(unsigned int cpu)
 {
 	unsigned long asid_mask = cpu_asid_mask(&cpu_data[cpu]);
 
-	return ~(asid_mask | (asid_mask - 1));
+	return ~(u64)(asid_mask | (asid_mask - 1));
 }
 
-static unsigned long asid_first_version(unsigned int cpu)
+static inline u64 asid_first_version(unsigned int cpu)
 {
 	return ~asid_version_mask(cpu) + 1;
 }
@@ -101,14 +101,12 @@ static inline void enter_lazy_tlb(struct
 static inline void
 get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
 {
-	unsigned long asid = asid_cache(cpu);
+	u64 asid = asid_cache(cpu);
 
 	if (!((asid += cpu_asid_inc()) & cpu_asid_mask(&cpu_data[cpu]))) {
 		if (cpu_has_vtag_icache)
 			flush_icache_all();
 		local_flush_tlb_all();	/* start new asid cycle */
-		if (!asid)		/* fix version if needed */
-			asid = asid_first_version(cpu);
 	}
 
 	cpu_context(cpu, mm) = asid_cache(cpu) = asid;
--- a/arch/mips/mm/c-r3k.c
+++ b/arch/mips/mm/c-r3k.c
@@ -245,7 +245,7 @@ static void r3k_flush_cache_page(struct
 	pmd_t *pmdp;
 	pte_t *ptep;
 
-	pr_debug("cpage[%08lx,%08lx]\n",
+	pr_debug("cpage[%08llx,%08lx]\n",
 		 cpu_context(smp_processor_id(), mm), addr);
 
 	/* No ASID => no such page in the cache.  */


