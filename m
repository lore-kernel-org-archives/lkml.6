Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58864C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035ED2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fOw4ewkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035ED2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbeKHCPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:15:49 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43752 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbeKHCPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:15:49 -0500
Received: by mail-vs1-f66.google.com with SMTP id x1so3464045vsc.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 08:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZVfwt5B82ufv3POIcIW//zJjtqDZA4QQg9Bilo8F8Bw=;
        b=fOw4ewkdSoqO0vYhMo8g5quAmFWJacoP9y+9daoWk29Gc8hOOwjBp2QtfA8iwBPuxr
         Z93HayMMoPw7+jw89143qAjaFYG44bdry2LoHTlVxwqZWiaBCwOs1a7DfJZBIRFxgsHS
         2zeLfQ28qsmthZXTGvsGArh8I5LNnwRtmhWxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZVfwt5B82ufv3POIcIW//zJjtqDZA4QQg9Bilo8F8Bw=;
        b=c1oWaI+OsqnhvzCPdsKWzP4WINrpBta/DuplFFMxD8lIrgYEFZ/biJWkJY1gS4jynx
         Hh3PUOL2e3jLOLBEu8e+AMedytOWlXFuJSrtsTGC2htDZBpLyQd5Ij4vsYgQEBi2BGnB
         nyW4nRJUFxNlX/XT1MhzccZm/5ggreP/4gjDa19+YXbvLdoaph+UGnHnb4g9CWWmpEEO
         yNRk4hPZMdTaoCaRhNgQ+cdKG/JZ+Lt1ede/8geEqzpaqDNzvyfmWCiQhA61IlxMMd2t
         hQ2X67bb2zajwIXZ7XTX9UK/o9jAVCvsHiyhRZxcGkTq4w/0zPTjS8dFbN5MCQ425s7L
         18vQ==
X-Gm-Message-State: AGRZ1gLQcrvHbizQ5NMAQBmuhGIXa7cNr3tMjuFLiDt1EN+jpi43WqdX
        i9/yijKYyYG3h1NOWcdoTbzwt+CquUM=
X-Google-Smtp-Source: AJdET5fJTK4Eq5NTpns4zgSr/SBg3Xc9DpPfwoveGp9DhYS4ogapvI8OuqNHmtBhyDQ1WaUULFuiwA==
X-Received: by 2002:a67:32c6:: with SMTP id y189mr385359vsy.105.1541609078875;
        Wed, 07 Nov 2018 08:44:38 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id f126sm288883vsd.11.2018.11.07.08.44.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 08:44:38 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id z11so4176138uaa.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 08:44:37 -0800 (PST)
X-Received: by 2002:ab0:650e:: with SMTP id w14mr420101uam.83.1541609077408;
 Wed, 07 Nov 2018 08:44:37 -0800 (PST)
MIME-Version: 1.0
References: <20181107010028.184543-1-dianders@chromium.org>
 <20181107010028.184543-4-dianders@chromium.org> <20181107115953.cnar4u2axi4poaxe@holly.lan>
In-Reply-To: <20181107115953.cnar4u2axi4poaxe@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Nov 2018 08:44:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WcgYFkxJh=nvgXkBQsHsebGNzRkLnnTT1OWA9--n1nwQ@mail.gmail.com>
Message-ID: <CAD=FV=WcgYFkxJh=nvgXkBQsHsebGNzRkLnnTT1OWA9--n1nwQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] kgdb: Don't round up a CPU that failed rounding up before
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 7, 2018 at 3:59 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Nov 06, 2018 at 05:00:27PM -0800, Douglas Anderson wrote:
> > If we're using the default implementation of kgdb_roundup_cpus() that
> > uses smp_call_function_single_async() we can end up hanging
> > kgdb_roundup_cpus() if we try to round up a CPU that failed to round
> > up before.
> >
> > Specifically smp_call_function_single_async() will try to wait on the
> > csd lock for the CPU that we're trying to round up.  If the previous
> > round up never finished then that lock could still be held and we'll
> > just sit there hanging.
> >
> > There's not a lot of use trying to round up a CPU that failed to round
> > up before.  Let's keep a flag that indicates whether the CPU started
> > but didn't finish to round up before.  If we see that flag set then
> > we'll skip the next round up.
> >
> > In general we have a few goals here:
> > - We never want to end up calling smp_call_function_single_async()
> >   when the csd is still locked.  This is accomplished because
> >   flush_smp_call_function_queue() unlocks the csd _before_ invoking
> >   the callback.  That means that when kgdb_nmicallback() runs we know
> >   for sure the the csd is no longer locked.  Thus when we set
> >   "rounding_up = false" we know for sure that the csd is unlocked.
> > - If there are no timeouts rounding up we should never skip a round
> >   up.
> >
> > NOTE #1: In general trying to continue running after failing to round
> > up CPUs doesn't appear to be supported in the debugger.  When I
> > simulate this I find that kdb reports "Catastrophic error detected"
> > when I try to continue.  I can overrule and continue anyway, but it
> > should be noted that we may be entering the land of dragons here.
>
> It's been quite a while but AFAIR I decided to set the catastrophic
> error here *because* the stuck csd lock would make restarting fragile.
>
> So arguably we are now able to remove the code that sets this flag when
> a CPU fails to round up.

I will leave that to a future patch.  It's definitely not a
well-tested corner of the code (and also in general the debugger makes
the assumption that all the other CPUs are stopped) so I'd hesitate
making it seem supported, but it's up to you.


> > NOTE #3: setting 'kgdb_info[cpu].rounding_up = false' is in
> > kgdb_nmicallback() instead of kgdb_call_nmi_hook() because some
> > implementations override kgdb_call_nmi_hook().  It shouldn't hurt to
> > have it in kgdb_nmicallback() in any case.
>
> Slightly icky but I guess this is OK.

It was definitely a judgement call and I felt it was about 50/50
between putting it there vs. copying it to 'arch/arch'.  If you want
me to move it I can.

...or we can try to figure out why exactly arch/arc passes NULL
instead of get_irq_regs() to kgdb_nmicallback().  If it's OK for
arch/arc to pass get_irq_regs() then we can make everyone use the
default.


> > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > index 23f2b5613afa..324cba8917f1 100644
> > --- a/kernel/debug/debug_core.c
> > +++ b/kernel/debug/debug_core.c
> > @@ -246,6 +246,20 @@ void __weak kgdb_roundup_cpus(void)
> >                       continue;
> >
> >               csd = &per_cpu(kgdb_roundup_csd, cpu);
> > +
> > +             /*
> > +              * If it didn't round up last time, don't try again
> > +              * since smp_call_function_single_async() will block.
> > +              *
> > +              * If rounding_up is false then we know that the
> > +              * previous call must have at least started and that
> > +              * means smp_call_function_single_async() won't block.
> > +              */
> > +             smp_mb();
>
> Not commented and I suspect this may have no useful effect. What
> (harmful) orderings does this barrier render impossible?

As you have noticed, weakly ordered memory makes my brain hurt.  I'm
happy to just remove this.

...or I'm happy to not have to think about all this and just add a
small global spinlock that protects all accesses to all instances of
"rounding_up".  In general I follow the advice that, unless you're in
a performance critical section, weakly ordered memory is too hard for
humans to reason about (normal concurrency is hard enough) so you
should just protect everything touched by more than one CPU with a
lock.  I didn't do that in this case since it seemed like the pattern
was to use memory barriers in this file, but it would definitely be my
preference.

In general I was trying to make sure that we didn't miss rounding up a
CPU that may have arrived at just the wrong time to the party.  Said
another way, I think we're OK w/ no barriers in the "easy" cases.

Easy case #1: everyone rounds up in time all the time

- I believe that the "rounding_up = true" is guaranteed to be visible
to the target CPU by the time kgdb_call_nmi_hook() is called on the
target CPU.
- I believe that the "rounding_up = false" is guaranteed to be visible
to all CPUs by the time we leave the debugger.

Easy case #2: a CPU totally goes out to lunch and never comes back

- Super easy.  "rounding_up" will be true and never go false.


So the hard cases are when a CPU comes back at some sort of
inopportune time.  I'm trying to re-establish my reasoning for why I
thought these memory barriers were useful for this case but I'm not
sure it's worth it.  Even without the barriers I think the worst that
can happen is that a CPU might fail to round up in a 2nd debugger
entry if it failed to round up in a previous one.  ...in the very
least I can't think of any way where we'll accidentally try to round
up a CPU while the csd is locked, can you?


> > +             if (kgdb_info[cpu].rounding_up)
> > +                     continue;
> > +             kgdb_info[cpu].rounding_up = true;
> > +
> >               csd->func = kgdb_call_nmi_hook;
> >               smp_call_function_single_async(cpu, csd);
> >       }
> > @@ -782,6 +796,9 @@ int kgdb_nmicallback(int cpu, void *regs)
> >       struct kgdb_state kgdb_var;
> >       struct kgdb_state *ks = &kgdb_var;
> >
> > +     kgdb_info[cpu].rounding_up = false;
> > +     smp_mb();
>
> Also not commented. Here I think the barrier may have a purpose (to
> ensure rounding_up gets cleared before we peek at dbg_master_lock) but
> if that is the case we need to comment it.

As per above, I'll plan to remove this and the other memory barrier
unless you tell me otherwise.


Thanks so much for your very timely reviews on all this and your
invaluable advice.

-Doug
