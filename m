Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579C0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C812073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C812073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeH3RHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:07:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50125 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbeH3RHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:07:38 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fvMdf-0003MV-FB; Thu, 30 Aug 2018 15:05:31 +0200
Date:   Thu, 30 Aug 2018 15:05:31 +0200 (CEST)
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
In-Reply-To: <20180830125909.uq3e76akcmep6j2u@shbuild888>
Message-ID: <alpine.DEB.2.21.1808301504300.1210@nanos.tec.linutronix.de>
References: <20180830090319.985-1-feng.tang@intel.com> <20180830104401.GZ24124@hirez.programming.kicks-ass.net> <20180830111207.GE2656@dhcp22.suse.cz> <alpine.DEB.2.21.1808301352410.1210@nanos.tec.linutronix.de> <20180830124915.GH2656@dhcp22.suse.cz>
 <20180830125909.uq3e76akcmep6j2u@shbuild888>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018, Feng Tang wrote:
> On Thu, Aug 30, 2018 at 02:49:15PM +0200, Michal Hocko wrote:
> > On Thu 30-08-18 13:54:19, Thomas Gleixner wrote:
> > > On Thu, 30 Aug 2018, Michal Hocko wrote:
> > > > On Thu 30-08-18 12:44:02, Peter Zijlstra wrote:
> > > > > On Thu, Aug 30, 2018 at 05:03:19PM +0800, Feng Tang wrote:
> > > > > > The root cause is that when CONFIG_NO_BOOTMEM=y,  before
> > > > > > e820__memblock_setup() is called there is no memory for bootmem
> > > > > > to allocate,
> > > > > 
> > > > > Which you bloody well asked for by using NO_BOOTMEM=y.
> > > > > 
> > > > > Going down this route; adding hacks for every little thing that does
> > > > > want bootmem, completely defeats the purpose.
> > > > > 
> > > > > If anything, make the earlycon thing depend on NO_BOOTMEM=n. That also
> > > > > solves your problem. No earlycon, no panic.
> > > > 
> > > > Well, there is endeavor to remove bootmem allocator altogether. So
> > > > making earlycon depend on NO_BOOTMEM=n doesn't sound like a good fit to
> > > 
> > > If we want to remove bootmem, then reintroducing it with a static bootmem
> > > section doesn't make any sense at all.
> > 
> > I have actually checked the code now and see what you mean. I thought it
> > would be a single allocation that is needed but that is not the case so
> > the static buffer is not going to fly.
> 
> Exactly! I tried several ways for the static allocation, like in data, in bss
> section, but they all failed, as in the very start of setup_arch():
> 
> 	memblock_reserve(__pa_symbol(_text),
> 		(unsigned long)__bss_stop - (unsigned long)_text);
> 
> Those [_text, __bss_stop] is not able to be used by alloc_bootmem(). And I
> only got this patch, and really appreciate any good suggestions.

And why do you want to use bootmem in the first place? If boot mem is going
away, why are you not fixing the early console crap to NOT use bootmem at
all?

Thanks,

	tglx
