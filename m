Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3110DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62DA1205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DA1205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbeH3RRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:17:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:13225 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbeH3RRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:17:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 06:14:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,306,1531810800"; 
   d="scan'208";a="84675121"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2018 06:14:53 -0700
Date:   Thu, 30 Aug 2018 21:19:20 +0800
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
Message-ID: <20180830131920.w2jqjvlkpfb4ejb2@shbuild888>
References: <20180830090319.985-1-feng.tang@intel.com>
 <20180830104401.GZ24124@hirez.programming.kicks-ass.net>
 <20180830111207.GE2656@dhcp22.suse.cz>
 <alpine.DEB.2.21.1808301352410.1210@nanos.tec.linutronix.de>
 <20180830124915.GH2656@dhcp22.suse.cz>
 <20180830125909.uq3e76akcmep6j2u@shbuild888>
 <alpine.DEB.2.21.1808301504300.1210@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808301504300.1210@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Aug 30, 2018 at 03:05:31PM +0200, Thomas Gleixner wrote:
> On Thu, 30 Aug 2018, Feng Tang wrote:
> > On Thu, Aug 30, 2018 at 02:49:15PM +0200, Michal Hocko wrote:
> > > On Thu 30-08-18 13:54:19, Thomas Gleixner wrote:
> > > > On Thu, 30 Aug 2018, Michal Hocko wrote:
> > > > > On Thu 30-08-18 12:44:02, Peter Zijlstra wrote:
> > > > > > On Thu, Aug 30, 2018 at 05:03:19PM +0800, Feng Tang wrote:
> > > > > > > The root cause is that when CONFIG_NO_BOOTMEM=y,  before
> > > > > > > e820__memblock_setup() is called there is no memory for bootmem
> > > > > > > to allocate,
> > > > > > 
> > > > > > Which you bloody well asked for by using NO_BOOTMEM=y.
> > > > > > 
> > > > > > Going down this route; adding hacks for every little thing that does
> > > > > > want bootmem, completely defeats the purpose.
> > > > > > 
> > > > > > If anything, make the earlycon thing depend on NO_BOOTMEM=n. That also
> > > > > > solves your problem. No earlycon, no panic.
> > > > > 
> > > > > Well, there is endeavor to remove bootmem allocator altogether. So
> > > > > making earlycon depend on NO_BOOTMEM=n doesn't sound like a good fit to
> > > > 
> > > > If we want to remove bootmem, then reintroducing it with a static bootmem
> > > > section doesn't make any sense at all.
> > > 
> > > I have actually checked the code now and see what you mean. I thought it
> > > would be a single allocation that is needed but that is not the case so
> > > the static buffer is not going to fly.
> > 
> > Exactly! I tried several ways for the static allocation, like in data, in bss
> > section, but they all failed, as in the very start of setup_arch():
> > 
> > 	memblock_reserve(__pa_symbol(_text),
> > 		(unsigned long)__bss_stop - (unsigned long)_text);
> > 
> > Those [_text, __bss_stop] is not able to be used by alloc_bootmem(). And I
> > only got this patch, and really appreciate any good suggestions.
> 
> And why do you want to use bootmem in the first place? If boot mem is going
> away, why are you not fixing the early console crap to NOT use bootmem at
> all?

The earlycon need use fixmap to map the mmio register, while fixmap will
need a new page for page table if the pmd/pte is not already their, as shown
in the commit log: 

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

inside the spp_getpage():
	
	if (after_bootmem)
		ptr = (void *) get_zeroed_page(GFP_ATOMIC);
	else
		ptr = alloc_bootmem_pages(PAGE_SIZE);

Thanks,
Feng

