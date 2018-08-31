Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A1BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3832E2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3832E2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbeHaRkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:40:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:28177 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbeHaRkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:40:03 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 06:32:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,311,1531810800"; 
   d="scan'208";a="70596713"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by orsmga006.jf.intel.com with ESMTP; 31 Aug 2018 06:32:29 -0700
Date:   Fri, 31 Aug 2018 21:36:59 +0800
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
Message-ID: <20180831133659.pkmscqpudjnkujbg@shbuild888>
References: <20180830104401.GZ24124@hirez.programming.kicks-ass.net>
 <20180830111207.GE2656@dhcp22.suse.cz>
 <alpine.DEB.2.21.1808301352410.1210@nanos.tec.linutronix.de>
 <20180830124915.GH2656@dhcp22.suse.cz>
 <20180830125909.uq3e76akcmep6j2u@shbuild888>
 <alpine.DEB.2.21.1808301504300.1210@nanos.tec.linutronix.de>
 <20180830131920.w2jqjvlkpfb4ejb2@shbuild888>
 <alpine.DEB.2.21.1808301523510.1210@nanos.tec.linutronix.de>
 <20180831061519.3zbxsjs4rd6mmsuo@shbuild888>
 <alpine.DEB.2.21.1808311328260.2208@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808311328260.2208@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 01:33:05PM +0200, Thomas Gleixner wrote:
> On Fri, 31 Aug 2018, Feng Tang wrote:
> > On Thu, Aug 30, 2018 at 03:25:42PM +0200, Thomas Gleixner wrote:
> > This panic happens as the earlycon's fixmap address has no
> > pmd/pte ready, and __set_fixmap will try to allocate memory to
> > setup the page table, and trigger panic due to no memory.
> > 
> > x86 kernel actually prepares the page table for fixmap in head_64.S:
> > 
> > 	NEXT_PAGE(level2_fixmap_pgt)
> > 		.fill	506,8,0
> > 		.quad	level1_fixmap_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
> > 		/* 8MB reserved for vsyscalls + a 2MB hole = 4 + 1 entries */
> > 		.fill	5,8,0
> > 
> > and it expects the fixmap address is in [-12M, -10M] range, but
> > current code in fixmap.h will break the expectation when
> > X86_VSYSCALL_EMULATION=n
> > 
> > 	#ifdef CONFIG_X86_VSYSCALL_EMULATION
> > 		VSYSCALL_PAGE = (FIXADDR_TOP - VSYSCALL_ADDR) >> PAGE_SHIFT,
> > 	#endif
> > 
> > So removing the "#ifdef" will make the fixmap address space stable in
> > [-12M, -10M] and fix the issue.
> 
> Why on earth are you not fixing the damned PTE setup which is the obvious
> and correct thing to do?

Any sugestion? I can only have patch like this:

---
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 15ebc2fc166e..8cdb27ccc3a3 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -446,11 +446,15 @@ NEXT_PAGE(level2_kernel_pgt)
 
 NEXT_PAGE(level2_fixmap_pgt)
 	.fill	506,8,0
-	.quad	level1_fixmap_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
+	.quad	level1_fixmap_pgt0 - __START_KERNEL_map + _PAGE_TABLE_NOENC
+	.quad	level1_fixmap_pgt1 - __START_KERNEL_map + _PAGE_TABLE_NOENC
 	/* 8MB reserved for vsyscalls + a 2MB hole = 4 + 1 entries */
-	.fill	5,8,0
+	.fill	4,8,0
 
-NEXT_PAGE(level1_fixmap_pgt)
+NEXT_PAGE(level1_fixmap_pgt0)
+	.fill	512,8,0
+
+NEXT_PAGE(level1_fixmap_pgt1)
 	.fill	512,8,0
 
 #undef PMDS


Thanks,
Feng

