Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB259C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B82920837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 06:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B82920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeHaKRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 06:17:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:4541 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbeHaKRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 06:17:03 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 23:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,309,1531810800"; 
   d="scan'208";a="66544050"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by fmsmga007.fm.intel.com with ESMTP; 30 Aug 2018 23:10:51 -0700
Date:   Fri, 31 Aug 2018 14:15:19 +0800
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
Message-ID: <20180831061519.3zbxsjs4rd6mmsuo@shbuild888>
References: <20180830090319.985-1-feng.tang@intel.com>
 <20180830104401.GZ24124@hirez.programming.kicks-ass.net>
 <20180830111207.GE2656@dhcp22.suse.cz>
 <alpine.DEB.2.21.1808301352410.1210@nanos.tec.linutronix.de>
 <20180830124915.GH2656@dhcp22.suse.cz>
 <20180830125909.uq3e76akcmep6j2u@shbuild888>
 <alpine.DEB.2.21.1808301504300.1210@nanos.tec.linutronix.de>
 <20180830131920.w2jqjvlkpfb4ejb2@shbuild888>
 <alpine.DEB.2.21.1808301523510.1210@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808301523510.1210@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 03:25:42PM +0200, Thomas Gleixner wrote:
 
> And where is the problem? We know that we need the fixmap during early boot
> anyway, so allocating the PTE page statically and setting it up early
> enough is not really rocket science. No allocator required.

Further check shows the page table for fixmap is already setup in [-12M, -10M],
but fixmap's address space breaks the expection under certain kernel config.
So here is another fix, please review, thanks!

----------------------------------------------------------------

From f63e4e5c6166a2f8d13ad3142b7a49b2fd1f8edf Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang@intel.com>
Date: Fri, 31 Aug 2018 13:48:21 +0800
Subject: [PATCH] x86, mm: Make the real fixmap address consistent

We hit a kernel panic when enabling earlycon for a platform, the
call trace is:

	  panic+0xd2/0x220
	  __alloc_bootmem+0x31/0x34
	  spp_getpage+0x60/0x8a
	  fill_pte+0x71/0x130
	  __set_pte_vaddr+0x1d/0x50
	  set_pte_vaddr+0x3c/0x60
	  __native_set_fixmap+0x23/0x30
	  native_set_fixmap+0x30/0x40
	  setup_earlycon+0x1e0/0x32f
	  param_setup_earlycon+0x13/0x22
	  do_early_param+0x5b/0x90
	  parse_args+0x1f7/0x300
	  parse_early_options+0x24/0x28
	  parse_early_param+0x65/0x73
	  setup_arch+0x31e/0x9f1
	  start_kernel+0x58/0x44e

This panic happens as the earlycon's fixmap address has no
pmd/pte ready, and __set_fixmap will try to allocate memory to
setup the page table, and trigger panic due to no memory.

x86 kernel actually prepares the page table for fixmap in head_64.S:

	NEXT_PAGE(level2_fixmap_pgt)
		.fill	506,8,0
		.quad	level1_fixmap_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
		/* 8MB reserved for vsyscalls + a 2MB hole = 4 + 1 entries */
		.fill	5,8,0

and it expects the fixmap address is in [-12M, -10M] range, but
current code in fixmap.h will break the expectation when
X86_VSYSCALL_EMULATION=n

	#ifdef CONFIG_X86_VSYSCALL_EMULATION
		VSYSCALL_PAGE = (FIXADDR_TOP - VSYSCALL_ADDR) >> PAGE_SHIFT,
	#endif

So removing the "#ifdef" will make the fixmap address space stable in
[-12M, -10M] and fix the issue.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 arch/x86/include/asm/fixmap.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index e203169931c7..fcf27171f493 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -67,9 +67,7 @@ enum fixed_addresses {
 #ifdef CONFIG_X86_32
 	FIX_HOLE,
 #else
-#ifdef CONFIG_X86_VSYSCALL_EMULATION
 	VSYSCALL_PAGE = (FIXADDR_TOP - VSYSCALL_ADDR) >> PAGE_SHIFT,
-#endif
 #endif
 	FIX_DBGP_BASE,
 	FIX_EARLYCON_MEM_BASE,
-- 
2.14.1

