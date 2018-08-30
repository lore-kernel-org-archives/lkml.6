Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F89DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB322082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB322082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbeH3R1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:27:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50169 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbeH3R1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:27:53 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fvMxD-00045u-1k; Thu, 30 Aug 2018 15:25:43 +0200
Date:   Thu, 30 Aug 2018 15:25:42 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Feng Tang <feng.tang@intel.com>
cc:     Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@elte.hu>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86, mm: Reserver some memory for bootmem allocator for
 NO_BOOTMEM
In-Reply-To: <20180830131920.w2jqjvlkpfb4ejb2@shbuild888>
Message-ID: <alpine.DEB.2.21.1808301523510.1210@nanos.tec.linutronix.de>
References: <20180830090319.985-1-feng.tang@intel.com> <20180830104401.GZ24124@hirez.programming.kicks-ass.net> <20180830111207.GE2656@dhcp22.suse.cz> <alpine.DEB.2.21.1808301352410.1210@nanos.tec.linutronix.de> <20180830124915.GH2656@dhcp22.suse.cz>
 <20180830125909.uq3e76akcmep6j2u@shbuild888> <alpine.DEB.2.21.1808301504300.1210@nanos.tec.linutronix.de> <20180830131920.w2jqjvlkpfb4ejb2@shbuild888>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018, Feng Tang wrote:
> On Thu, Aug 30, 2018 at 03:05:31PM +0200, Thomas Gleixner wrote:
> > > Those [_text, __bss_stop] is not able to be used by alloc_bootmem(). And I
> > > only got this patch, and really appreciate any good suggestions.
> > 
> > And why do you want to use bootmem in the first place? If boot mem is going
> > away, why are you not fixing the early console crap to NOT use bootmem at
> > all?
> 
> The earlycon need use fixmap to map the mmio register, while fixmap will
> need a new page for page table if the pmd/pte is not already their, as shown
> in the commit log: 
> 
> 	  panic+0xd2/0x220
> 	  __alloc_bootmem+0x31/0x34
> 	  spp_getpage+0x60/0x8a
> 	  fill_pte+0x71/0x130
> 	  __set_pte_vaddr+0x1d/0x50
> 	  set_pte_vaddr+0x3c/0x60
> 	  __native_set_fixmap+0x23/0x30
> 	  native_set_fixmap+0x30/0x40
> 	  setup_earlycon+0x1e0/0x32f
> 	  param_setup_earlycon+0x13/0x22
> 	  do_early_param+0x5b/0x90
> 	  parse_args+0x1f7/0x300
> 	  parse_early_options+0x24/0x28
> 	  parse_early_param+0x65/0x73
> 	  setup_arch+0x31e/0x9f1
> 	  start_kernel+0x58/0x44e
> 
> inside the spp_getpage():
> 	
> 	if (after_bootmem)
> 		ptr = (void *) get_zeroed_page(GFP_ATOMIC);
> 	else
> 		ptr = alloc_bootmem_pages(PAGE_SIZE);

And where is the problem? We know that we need the fixmap during early boot
anyway, so allocating the PTE page statically and setting it up early
enough is not really rocket science. No allocator required.

Thanks,

	tglx
