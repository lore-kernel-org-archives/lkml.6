Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EDCECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B492150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B492150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeJQX5R convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:57:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60670 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbeJQX5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:57:17 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gCoFf-0002TR-9p; Wed, 17 Oct 2018 18:00:51 +0200
Date:   Wed, 17 Oct 2018 18:00:51 +0200
From:   'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Laight <David.Laight@ACULAB.COM>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] x86/mm/pat: Disable preemption around
 __flush_tlb_all()
Message-ID: <20181017160050.rw6tl2dzqiozbq3m@linutronix.de>
References: <20181016202525.29437-1-bigeasy@linutronix.de>
 <20181016202525.29437-2-bigeasy@linutronix.de>
 <acaca255a70b411488b889db9d1c31e4@AcuMS.aculab.com>
 <20181017111145.GJ3121@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1810171315250.6000@nanos.tec.linutronix.de>
 <20181017154707.GL3121@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181017154707.GL3121@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-17 17:47:07 [+0200], Peter Zijlstra wrote:
> > > Ideally we'd never ever merge anything that only does local invalidates,
> > > on a global address space, that's just broken.
> > 
> > A little bit late to lament about that.
> 
> For this, yes :/ But for future stuff we should really not allow such
> things anymore.

so we stay as is?

> > So should we just replace it with cpa_flush_all() ?
> 
> The comment there suggests that will deadlock, supposedly because the
> kernel_map_page() call can happen with IRQs disabled or such.
> 
> I've not deeply looked at this.

free_pages() / __free_pages() for instance ends may end up in
kernel_map_pages() (via free_pages_prepare()). And if this is invoked
with disabled interrupts…

Sebastian
