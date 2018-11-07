Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639EFC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224ED2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WqTOKQNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224ED2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbeKHEQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:16:24 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46306 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbeKHEQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:16:23 -0500
Received: by mail-vs1-f65.google.com with SMTP id r14so10019665vsc.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 10:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bZBtL8GlluFABM8CDN/PPTJ9bkuOUzL2FDyLXIArNec=;
        b=WqTOKQNFDu3MMYVKmHrHxzCuwhtkxTmx2UvAyV5YIKnRWGs0l609bcPE828l62Sxne
         Bvn5kghBF/GpQmqt/e9b4tXZq1dMPGeeTrdGpIJ/g97P+lJU8bY+2zgs/bbnpJhYy2Zo
         l8SgxXkDw16Bxl10RZBIFeIoePZNx7NCw2Uwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bZBtL8GlluFABM8CDN/PPTJ9bkuOUzL2FDyLXIArNec=;
        b=izKyDsmqppUsqhNMgQaDpx0jVA8IEXA+1OlTcF37Ms9c0qZIF5IX9bL6kaXzHeyu7t
         K6Nu6UadTFYtq87mdj3msr13j/KcXyzCAkJ2C18JJQPTlndXt/tTPvtqUkCyahG8o802
         gBVdTZjMJRC9Ff8peBLtjMyVcbtWTevtrHzBEYLdOBQKORLY5h75+eeUW4pWW1VavQ/V
         F2VjUpoHGurx8+eUwcrUaJmr4T3b7uIHmNLVMOSBvkaoZTVoMJ6LChAWOrp/vWzbWoJN
         l3pKTHVxR6Alc21hkHyjG2XY0rVL1f2ptLoxOCBftnh2ubqCr12NoRCWaR2HK2jmBOI+
         ROpQ==
X-Gm-Message-State: AGRZ1gKUiXse3mRMZiAhTXT0OqQGSYhaazRcTRoAxBahyVX5edrAfCu8
        a6ft4uTxkhY2EHR4CmmqoosL4dHIwUo=
X-Google-Smtp-Source: AJdET5d2K7+yyZVsAV23RfAJPXR5R/UcVYcHGHMgKDqih3yJT+pELpP3JTPlvkCGqnCcCZqImnBOTA==
X-Received: by 2002:a67:db06:: with SMTP id z6mr575302vsj.73.1541616284418;
        Wed, 07 Nov 2018 10:44:44 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a2sm337174uaa.15.2018.11.07.10.44.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 10:44:43 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id o17so6233004uad.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 10:44:43 -0800 (PST)
X-Received: by 2002:ab0:650e:: with SMTP id w14mr636398uam.83.1541616283078;
 Wed, 07 Nov 2018 10:44:43 -0800 (PST)
MIME-Version: 1.0
References: <20181107010028.184543-1-dianders@chromium.org>
 <20181107010028.184543-5-dianders@chromium.org> <20181107123032.ytwzfkkwajuo4tsj@holly.lan>
In-Reply-To: <20181107123032.ytwzfkkwajuo4tsj@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Nov 2018 10:44:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UzCRS9HYAs4WAL_Wqj52nrNO7eDpxNDtZevdG7i0nuEw@mail.gmail.com>
Message-ID: <CAD=FV=UzCRS9HYAs4WAL_Wqj52nrNO7eDpxNDtZevdG7i0nuEw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] kdb: Don't back trace on a cpu that didn't round up
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>, christophe.leroy@c-s.fr,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 7, 2018 at 4:30 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Nov 06, 2018 at 05:00:28PM -0800, Douglas Anderson wrote:
> > If you have a CPU that fails to round up and then run 'btc' you'll end
> > up crashing in kdb becaue we dereferenced NULL.  Let's add a check.
> > It's wise to also set the task to NULL when leaving the debugger so
> > that if we fail to round up on a later entry into the debugger we
> > won't backtrace a stale task.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v3:
> > - New for v3.
> >
> > Changes in v2: None
> >
> >  kernel/debug/debug_core.c |  1 +
> >  kernel/debug/kdb/kdb_bt.c | 11 ++++++++++-
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > index 324cba8917f1..08851077c20a 100644
> > --- a/kernel/debug/debug_core.c
> > +++ b/kernel/debug/debug_core.c
> > @@ -587,6 +587,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
> >                       kgdb_info[cpu].exception_state &=
> >                               ~(DCPU_WANT_MASTER | DCPU_IS_SLAVE);
> >                       kgdb_info[cpu].enter_kgdb--;
> > +                     kgdb_info[cpu].task = NULL;
>
> This code isn't quite right.
>
> In particular there are two exit paths from kgdb_cpu_enter() and this
> code path is for slave exit only (and master may change the next time we
> re-enter kgdb).

Ah, good point!  Right that the master could be the the one that later
fails to round up.


> It also looks very odd to have an unconditional clear
> next to a decrement that takes account of debugger re-entrancy.

Would it look less odd if I write it like this?

if (kgdb_info[cpu].enter_kgdb == 0)
  kgdb_info[cpu].task = NULL;

In general, though, "enter_kgdb" looks to be more of a boolean value
then a true counter.  The only place that modifies "enter_kgdb" is
kgdb_cpu_enter(). It increments it upon entry to the function and
decrements it upon exit.  All the callers to kgdb_cpu_enter() confirm
that "enter_kgdb" is 0 before calling it.  I'll further note that
kgdb_cpu_enter() unconditionally clobbers things like
"kgdb_info[cpu].debuggerinfo" upon entry.

I could add a patch that converts "enter_kgdb" to a true boolean if
that helps, though at this point I'm getting pretty far afield of my
original purpose of trying to fix the problem lockdep yelled about.
:-P  ...and I probably need to get back to my day job.

I'd also note that the other bits of code around here look pretty
unconditional to me, but my kdb/kgdb knowledge is not very strong (as
you've seen) so I could be wrong.  We are unconditionally clearing
bits from the "exception_state", unconditionally turning tracing on,
unconditionally calling correct_hw_break(), etc.  ...hmmmm, I suppose
it could look less odd if I moved my unconditional bit to be up a
little higher.  I could put it up above to the unconditional clearing
of "exception_state"  ;-P


> Note also that there is similar code in kdb_debugger.c (search for "zero
> out any offline cpu data") which should be tidied up if we decide to do
> the same clean up in a different way.
>
> I'll leave it to you whether to fix the existing code or add new code
> here but if you do add it in kgdb_cpu_enter() it must cover both return
> paths, include debuggerinfo as well, and kdb_debugger.c needs to be
> tidied up.

OK, so I _think_ the answer here is to just get rid of the code from
kdb_debugger.c and rely on my new code.

Specifically I'd rather CPUs clear their own "kgdb_info" so we don't
need to worry about races where a CPU rounds up really late at some
time when we're not expecting it.  ...and once CPUs always clear its
own "kgdb_info" when exiting we don't need any special case code to
have the master try to clear state of offline CPUs.  Thanks for
pointing me to this code to get rid of.

---

So the tl;dr:

1. Though I'm 99% certain that "enter_kgdb" is truly a bool that is
either 0 or 1, I won't write a patch to change this myself in the
hopes that I can wrap up this patch series.  I'll add a note in my CL
description indicating that I believe things are safe because
"enter_kgdb" is really a bool.

2. I will add clearing of "debuggerinfo".

3. I will add the same clearing of "task" and "debuggerinfo" to when
the master exits.  I won't try to unify the code in my patch and leave
that for a future person working on this code.

4. To make it look less odd, I'll move my clearing to above the
"kgdb_info[cpu].exception_state &=" line.  It doesn't really matter
and why not make it look less odd?

5. I will remove the clearing of "debuggerinfo" and "task" from
kdb_stub() since it will no longer be needed.


...and again, thank you for all your timely and awesome reviews and
advice here.  It is certainly appreciated.


-Doug
