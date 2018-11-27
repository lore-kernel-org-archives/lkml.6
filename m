Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D437C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6952086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6952086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeK1JTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:19:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:55672 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726277AbeK1JTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:19:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 503E1AD66;
        Tue, 27 Nov 2018 22:20:13 +0000 (UTC)
Date:   Tue, 27 Nov 2018 23:20:11 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 20/24] x86/speculation: Split out TIF update
In-Reply-To: <nycvar.YFH.7.76.1811272302070.21108@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1811272316420.21108@cbobk.fhfr.pm>
References: <20181121201430.559770965@linutronix.de> <20181121201724.227260385@linutronix.de> <f976eb35-5dcd-387e-eb29-f7c6636fd17b@linux.intel.com> <alpine.DEB.2.21.1811222352340.1665@nanos.tec.linutronix.de> <20181123073735.GA12959@gmail.com>
 <c51dd20a-2cea-1bd1-bee7-48ca25f9bdb9@linux.intel.com> <alpine.DEB.2.21.1811262244510.1682@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1811270800090.21108@cbobk.fhfr.pm> <alpine.DEB.2.21.1811270809450.1682@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1811270820050.21108@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1811271350590.21108@cbobk.fhfr.pm> <alpine.DEB.2.21.1811272247140.1875@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1811272302070.21108@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018, Jiri Kosina wrote:

> > >  static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
> > > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > > index 3f5e351bdd37..6c4fcef52b19 100644
> > > --- a/arch/x86/kernel/process.c
> > > +++ b/arch/x86/kernel/process.c
> > > @@ -474,6 +474,21 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
> > >  
> > >  	tifn = READ_ONCE(task_thread_info(next_p)->flags);
> > >  	tifp = READ_ONCE(task_thread_info(prev_p)->flags);
> > > +
> > > +	/*
> > > +	 * SECCOMP tasks might have had their spec_ctrl flags updated during
> > > +	 * runtime from a different CPU.
> > > +	 *
> > > +	 * When switching to such a task, populate thread flags with the ones
> > > +	 * that have been temporarily saved in spec_flags by task_update_spec_tif()
> > > +	 * in order to make sure MSR value is always kept up to date.
> > > +	 *
> > > +	 * SECCOMP tasks never disable the mitigation for other threads, only enable.
> > > +	 */
> > > +	if (IS_ENABLED(CONFIG_SECCOMP) &&
> > > +			test_and_clear_tsk_thread_flag(next_p, TIF_SPEC_UPDATE))
> > > +		tifp |= READ_ONCE(task_thread_info(next_p)->spec_flags);
> > 
> > And how does that get folded into task_thread_info(next_p)->flags for the
> > next context switch? 
> 
> Does it really have to? 

I guess I misunderstood the question, and the answer is that it actually 
should be 'tifn' there, as I wrote in a followup mail.

But in any case, I agree we need to handle both directions for full 
consistency, so your patch is a correct one.

Thanks,

-- 
Jiri Kosina
SUSE Labs

