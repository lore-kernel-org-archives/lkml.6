Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA93ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95E52150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95E52150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJQTMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:12:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60037 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeJQTMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:12:36 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gCjpG-0006Iq-Pt; Wed, 17 Oct 2018 13:17:18 +0200
Date:   Wed, 17 Oct 2018 13:17:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     David Laight <David.Laight@ACULAB.COM>,
        'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] x86/mm/pat: Disable preemption around
 __flush_tlb_all()
In-Reply-To: <20181017111145.GJ3121@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1810171315250.6000@nanos.tec.linutronix.de>
References: <20181016202525.29437-1-bigeasy@linutronix.de> <20181016202525.29437-2-bigeasy@linutronix.de> <acaca255a70b411488b889db9d1c31e4@AcuMS.aculab.com> <20181017111145.GJ3121@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018, Peter Zijlstra wrote:
> On Wed, Oct 17, 2018 at 09:54:38AM +0000, David Laight wrote:
> > >  	 * We should perform an IPI and flush all tlbs,
> > >  	 * but that can deadlock->flush only current cpu:
> > >  	 */
> > > +	preempt_disable();
> > >  	__flush_tlb_all();
> > > +	preempt_enable();
> > 
> > Can it make any sense to flush the tlb with preemption enabled?
> > Surely preemption must be disabled over something else as well?
> 
> This code is fishy anyway, for only doing that local invalidate.
> 
> Ideally we'd never ever merge anything that only does local invalidates,
> on a global address space, that's just broken.

A little bit late to lament about that.

So should we just replace it with cpa_flush_all() ?

Thanks,

	tglx
