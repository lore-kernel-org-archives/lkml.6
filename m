Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53621C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF0C2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF0C2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeIJOq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:46:58 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38838 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIJOq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:46:58 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fzIt2-0004LP-1i; Mon, 10 Sep 2018 11:53:40 +0200
Date:   Mon, 10 Sep 2018 11:53:39 +0200 (CEST)
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
In-Reply-To: <20180910093938.ka732apzy3d3a5ip@shbuild888>
Message-ID: <alpine.DEB.2.21.1809101147500.1402@nanos.tec.linutronix.de>
References: <20180830124915.GH2656@dhcp22.suse.cz> <20180830125909.uq3e76akcmep6j2u@shbuild888> <alpine.DEB.2.21.1808301504300.1210@nanos.tec.linutronix.de> <20180830131920.w2jqjvlkpfb4ejb2@shbuild888> <alpine.DEB.2.21.1808301523510.1210@nanos.tec.linutronix.de>
 <20180831061519.3zbxsjs4rd6mmsuo@shbuild888> <alpine.DEB.2.21.1808311328260.2208@nanos.tec.linutronix.de> <20180831133659.pkmscqpudjnkujbg@shbuild888> <20180907081716.bxw3hmcl6w7gqvax@shbuild888> <alpine.DEB.2.21.1809071250240.1402@nanos.tec.linutronix.de>
 <20180910093938.ka732apzy3d3a5ip@shbuild888>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018, Feng Tang wrote:
> On Fri, Sep 07, 2018 at 12:52:17PM +0200, Thomas Gleixner wrote:
> > You really want to add a proper sanity check for this. The static stuff has
> > to cover the fixmap. Just making it work for this particular case is sloppy
> > at best as the next larger change of the fixmap will just bring the problem
> > back.
> Yes, agree.
> 
> Since the issue happens very early before any serial console, I can only think
> of a build time check.

Of course. That's obvious. The size _IS_ known at build time.

> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index e848a4811785..fc172551048a 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -637,6 +637,19 @@ void __native_set_fixmap(enum fixed_addresses idx, pte_t pte)
>  {
>  	unsigned long address = __fix_to_virt(idx);
>  
> +#ifdef CONFIG_X86_64
> +	/*
> +	 * In arch/x86/kernel/head_64.S, the static page table
> +	 * has been setup for 4M space [-12M, -8M]
> +	 *	0xFFFFFFFFFF400000 ~ 0xFFFFFFFFFF7FFFFF
> +	 * Add a sanity check whether fixed_address crosses
> +	 * the boundary.
> +	 */
> +	#define FIXMAP_STATIC_PGTABLE_START	0xFFFFFFFFFF400000

Errm what? This is beyond hillarious, really. What helps that if I remove
that second FIXMAP entry in head_64.S?

The size of the fixmap is known at compile time and it is known when
building head_64.S. So the obvious check is to check right there where the
static pagetable is set up and where you know how many entries you set up
whether it's covering the full size or not and err out there.

Thanks,

	tglx
