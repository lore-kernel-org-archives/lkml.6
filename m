Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2438C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5623320865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5623320865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeIKLHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:07:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:43960 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbeIKLHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:07:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 23:09:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,359,1531810800"; 
   d="scan'208";a="69920205"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by fmsmga008.fm.intel.com with ESMTP; 10 Sep 2018 23:09:24 -0700
Date:   Tue, 11 Sep 2018 14:14:13 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@elte.hu>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86, mm: Reserver some memory for bootmem allocator for
 NO_BOOTMEM
Message-ID: <20180911061413.redy4oxia3hqifkh@shbuild888>
References: <alpine.DEB.2.21.1808301504300.1210@nanos.tec.linutronix.de>
 <20180830131920.w2jqjvlkpfb4ejb2@shbuild888>
 <alpine.DEB.2.21.1808301523510.1210@nanos.tec.linutronix.de>
 <20180831061519.3zbxsjs4rd6mmsuo@shbuild888>
 <alpine.DEB.2.21.1808311328260.2208@nanos.tec.linutronix.de>
 <20180831133659.pkmscqpudjnkujbg@shbuild888>
 <20180907081716.bxw3hmcl6w7gqvax@shbuild888>
 <alpine.DEB.2.21.1809071250240.1402@nanos.tec.linutronix.de>
 <20180910093938.ka732apzy3d3a5ip@shbuild888>
 <alpine.DEB.2.21.1809101147500.1402@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809101147500.1402@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Sep 10, 2018 at 11:53:39AM +0200, Thomas Gleixner wrote:
> On Mon, 10 Sep 2018, Feng Tang wrote:
> > diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> > index e848a4811785..fc172551048a 100644
> > --- a/arch/x86/mm/pgtable.c
> > +++ b/arch/x86/mm/pgtable.c
> > @@ -637,6 +637,19 @@ void __native_set_fixmap(enum fixed_addresses idx, pte_t pte)
> >  {
> >  	unsigned long address = __fix_to_virt(idx);
> >  
> > +#ifdef CONFIG_X86_64
> > +	/*
> > +	 * In arch/x86/kernel/head_64.S, the static page table
> > +	 * has been setup for 4M space [-12M, -8M]
> > +	 *	0xFFFFFFFFFF400000 ~ 0xFFFFFFFFFF7FFFFF
> > +	 * Add a sanity check whether fixed_address crosses
> > +	 * the boundary.
> > +	 */
> > +	#define FIXMAP_STATIC_PGTABLE_START	0xFFFFFFFFFF400000
> 
> Errm what? This is beyond hillarious, really. What helps that if I remove
> that second FIXMAP entry in head_64.S?
> 
> The size of the fixmap is known at compile time and it is known when
> building head_64.S. So the obvious check is to check right there where the
> static pagetable is set up and where you know how many entries you set up
> whether it's covering the full size or not and err out there.

Thanks for the suggestion, and I have 2 patches: one adds a build warning,   
the other prepares fixmap page table on demand and doesn't need warning.

But I met a problem, that the "__end_of_permanent_fixed_addresses" is
defined in fixmap.h, which is protected by #ifndef __ASSEMBLY__, also
fixmap.h reference many other header file, which makes it harder to
extract the definition out. Any suggestion on this? thanks!

- Feng

patch1:
---
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 3a1d33b43c29..5863623890af 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -451,12 +451,20 @@ NEXT_PAGE(level2_fixmap_pgt)
 	.quad	level1_fixmap_pgt1 - __START_KERNEL_map + _PAGE_TABLE_NOENC
 	.fill	4,8,0
 
+/*
+ * Next are static page table for 4M fixmap space:
+ *	[-12M, -10M], [-10M, -8M]
+ */
 NEXT_PAGE(level1_fixmap_pgt)
 	.fill	512,8,0
 
 NEXT_PAGE(level1_fixmap_pgt1)
 	.fill	512,8,0
 
+#if __end_of_permanent_fixed_addresses > 1024
+.error "Total fixmap space exceeds the static page table capacity, please expand the page table!"
+#endif
+
 #undef PMDS
 
 	.data


Patch2:
---
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 15ebc2fc166e..2b98ce234686 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -24,6 +24,7 @@
 #include "../entry/calling.h"
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
+#include <asm/fixmap.h>
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/asm-offsets.h>
@@ -444,14 +445,21 @@ NEXT_PAGE(level2_kernel_pgt)
 	PMDS(0, __PAGE_KERNEL_LARGE_EXEC,
 		KERNEL_IMAGE_SIZE/PMD_SIZE)
 
+#define FIXMAP_PMD_NUM	((__end_of_permanent_fixed_addresses + 511) / 512)
 NEXT_PAGE(level2_fixmap_pgt)
-	.fill	506,8,0
-	.quad	level1_fixmap_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
+	.fill	(512 - 4 - FIXMAP_PMD_NUM),8,0
+	pgtno = 0
+	.rept (FIXMAP_PMD_NUM)
+	.quad level1_fixmap_pgt + (pgtno << PAGE_SHIFT) - __START_KERNEL_map  + _PAGE_TABLE_NOENC
+	pgtno = pgtno + 1
+	.endr
 	/* 8MB reserved for vsyscalls + a 2MB hole = 4 + 1 entries */
-	.fill	5,8,0
+	.fill	4,8,0
 
 NEXT_PAGE(level1_fixmap_pgt)
+	.rept (FIXMAP_PMD_NUM)
 	.fill	512,8,0
+	.endr
 
 #undef PMDS
