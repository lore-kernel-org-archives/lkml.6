Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DB7C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D492146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544122167;
	bh=3a8g4JTwC6Fm94IZGZfdeBfzU9xF6ZTkghVNdOcZlHY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vvKGmRaaBCAyKIneklALHiqcF8/9QM1zDZ2BubVcQFlEnnYuX+E432XpK4M4sihSZ
	 9kG6qPIA8VrB/X87kDJQ2I61kq2Tl5gdWlatPw6mc2TQK3x6hkq5EQJTzat4QIskcP
	 uROGEdy0wM6PQbXSKXL60DjNo8dacr7Qd/krOjq8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D492146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeLFStZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:49:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbeLFStZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:49:25 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60B14214DB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Dec 2018 18:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544122164;
        bh=3a8g4JTwC6Fm94IZGZfdeBfzU9xF6ZTkghVNdOcZlHY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yqzuANenn7315T3per8xxmcwmC+FGL7W1BviCTojOTrL2LpvKbHgdWJuf87d31qPV
         iLpACJQvdpQEGXoNc+gWUMdpel8EAXSNexYtvFBiiBL1FOCswB8jo1OC/mwWxQC99o
         b+NGcQzsx1DPjamotSy3X9hhKvUaQUHR6XLN57eA=
Received: by mail-wr1-f43.google.com with SMTP id v13so1526092wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 10:49:24 -0800 (PST)
X-Gm-Message-State: AA+aEWbrCIjL90PqIM6iSyqlkG/l/tKNBIeU/3WLp75RSWnMladKM6fs
        IKhnBJ8z0CnKFMRxhD8x2cfQevWt6e7Xqn5Ht2NL2g==
X-Google-Smtp-Source: AFSGD/V0AY1ghRT/iFOR6OaGwNESonEfVSgxX14XB0OPf1loXondQG47IaR8n5TcD8k0Hfpk37f/TWSo59kYz4XvHFA=
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr25183890wro.77.1544122162824;
 Thu, 06 Dec 2018 10:49:22 -0800 (PST)
MIME-Version: 1.0
References: <20181205232012.28920-1-sean.j.christopherson@intel.com>
 <20181205232012.28920-4-sean.j.christopherson@intel.com> <22a86224-4d25-a679-5449-e88ea889d499@intel.com>
In-Reply-To: <22a86224-4d25-a679-5449-e88ea889d499@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Dec 2018 10:49:10 -0800
X-Gmail-Original-Message-ID: <CALCETrXo=KNDWgJqjxBUCpTnPMg9dkPam0FSMC1vwgxhta40SA@mail.gmail.com>
Message-ID: <CALCETrXo=KNDWgJqjxBUCpTnPMg9dkPam0FSMC1vwgxhta40SA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] x86/traps: Attempt to fixup exceptions in vDSO
 before signaling
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 10:22 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 12/5/18 3:20 PM, Sean Christopherson wrote:
> > @@ -223,6 +224,10 @@ do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
> >       tsk->thread.error_code = error_code;
> >       tsk->thread.trap_nr = trapnr;
> >
> > +     if (user_mode(regs) &&
> > +         fixup_vdso_exception(regs, trapnr, error_code, 0))
> > +             return 0;
> > +
> >       return -1;
> >  }
> >
> > @@ -563,6 +568,9 @@ do_general_protection(struct pt_regs *regs, long error_code)
> >       tsk->thread.error_code = error_code;
> >       tsk->thread.trap_nr = X86_TRAP_GP;
> >
> > +     if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
> > +             return;
> > +
> >       show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
> >
> >       force_sig(SIGSEGV, tsk);
> > @@ -854,6 +862,9 @@ static void math_error(struct pt_regs *regs, int error_code, int trapnr)
> >       if (!si_code)
> >               return;
> >
> > +     if (fixup_vdso_exception(regs, trapnr, error_code, 0))
> > +             return;
> > +
> >       force_sig_fault(SIGFPE, si_code,
> >                       (void __user *)uprobe_get_trap_addr(regs), task);
> >  }
> > --
>
> Needs commenting, please.
>
> But, also, this seems really ad-hoc.  Probably, that's a result of our
> signal generation being really ad-hoc itself.  But, if this claims
> "Attempt to fixup exceptions in vDSO before signaling", how do we assure
> ourselves that we hit all the ad-hoc signal generation cases?  How do we
> know we didn't miss one or ten?
>
> I want to hear more of the story of how you picked these sites and also
> decided that this is a comprehensive-enough set of sites to patch.

With my maintainer hat on, it would be awesome if we could inspire
Sean to do a nice cleanup and unify the code such that there is a
single "send a signal to user code to report an exception that wasn't
fixed up" path.  But that's also quite a big request for an otherwise
not-terribly-huge patch...

But, in the absence of a cleanup like that, we should at least
enumerate all the signals that are indented to get fixed up somewhere
in the comments or the changelog.  I'm a big suspicious that the
correct answer is "all of them", with the possible exception of MCE.
