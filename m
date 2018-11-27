Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57C9C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7290D208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 03:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QcPHoePk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7290D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeK0O4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 09:56:09 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43340 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbeK0O4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 09:56:09 -0500
Received: by mail-ua1-f68.google.com with SMTP id z11so7131767uaa.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 19:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjUd6rh9Oz+kjGbUZS5mymEL2IOV7D6CriXwQhdsMjU=;
        b=QcPHoePkZX1rXMUYdsVjgFNEGwWi1t+kNzgHHl7f02t25QRLbxRsn38LV2ypdJ1Bet
         e0+PckNHOH/jab6l82SPjcFUnqnD3WPfuEI6R4N3zDp97pjS+o0tFeOUkhgdRhgDOJYl
         Tkr5tUn3ZIRFk36wyPZPqRF9qxyxgtvKyaE9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjUd6rh9Oz+kjGbUZS5mymEL2IOV7D6CriXwQhdsMjU=;
        b=alrdPXIVgQUhWCOnzc+C3bsPBi5j9DBIGpV8ZaQ4jwVKkXQYgbJIO+mhbrm+WmVG1j
         XbJkW7c6K0hZWEhxwVJHC1ZC3TEnWTfwHaQhhpcoz2Pd9jWyB9jyPjcEghc4xQDfHV8t
         LUq8ENRaMkrx42A6y4M0lezSIPqe0Dyd+89z9AyCaEqmGFUGpXhZ41ym6HxIev8IGpIs
         Lc2gayY6sfvMlD0lCiS2B3KujOIKQXPFV7IVUO32KCjP69ysTc6750SF4PA5E/KNFHY6
         SPpuCsYutrHuZfDeSpLz4mDso8y2aU8o4EjzZQL05PGJs+ymJWFKY4eGBx1W2kh6xEN+
         k76g==
X-Gm-Message-State: AA+aEWa1VGe6/dH6Cy5nanpbSa29yGe3+9hHWBlCJqQ5XtK+Y2+0HVix
        Y6ceQNXqgTqnHoJizY+NaAdBSnuEHeQ=
X-Google-Smtp-Source: AFSGD/VJIDTVzTyhcQoVbmvdMm9uinswGVqODCjiuy3N/EgbaV2wsVvYrHnUtCXGo3xF5uqcimG80g==
X-Received: by 2002:ab0:2385:: with SMTP id b5mr12681459uan.73.1543291178602;
        Mon, 26 Nov 2018 19:59:38 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id c24sm676798uao.17.2018.11.26.19.59.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 19:59:38 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id t17so12882900vsc.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 19:59:38 -0800 (PST)
X-Received: by 2002:a67:6cc1:: with SMTP id h184mr13126300vsc.149.1543290760514;
 Mon, 26 Nov 2018 19:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20181112182659.245726-1-dianders@chromium.org>
 <20181112182659.245726-3-dianders@chromium.org> <20181114220744.GB4044@brain-police>
In-Reply-To: <20181114220744.GB4044@brain-police>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 26 Nov 2018 19:52:27 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WYa8Hfo0hN8eqTBsjGY7A0nnQBoG1nSrvQ92we+v5kuA@mail.gmail.com>
Message-ID: <CAD=FV=WYa8Hfo0hN8eqTBsjGY7A0nnQBoG1nSrvQ92we+v5kuA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
To:     Will Deacon <will.deacon@arm.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, jhogan@kernel.org,
        linux-hexagon@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        dalias@libc.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        paulus@samba.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        christophe.leroy@c-s.fr, mpe@ellerman.id.au, paul.burton@mips.com,
        rkuo@codeaurora.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 14, 2018 at 2:07 PM Will Deacon <will.deacon@arm.com> wrote:
>
> > +void __weak kgdb_call_nmi_hook(void *ignored)
> > +{
> > +     kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> > +}
>
> I suppose you could pass the cpu as an argument, but it doesn't really
> matter.

I probably won't change it for now if it doesn't matter...


> Also, I think there are cases where the CSD callback can run without
> having received an IPI, so we could potentially up passing NULL for the regs
> here which probably goes boom.

Hrm, good point.  This is not a new issue so I'd tend to add it to the
TODO list rather than block the series.  I'll also add a comment in
the code since I'm touching it anyway.

Interestingly enough quite a bit of things continue to work just fine
even if this is NULL.  I simulated setting this to NULL for all CPUs
and I could drop into the debugger, type "btc" to backtrace all CPUs,
attach to kgdb, etc.  ...but when I typed "cpu 1" it went boom.  So it
seems like parts of kdb use this but definitely not everything.

Also interesting is that on MIPS this is always NULL.  I have no idea
why but my patch series preserves this oddity.  Presumably if someone
was on a SMP MIPS machine and did "cpu 1" from kdb they'd go boom too.

In general kdb has a lot of crufty stuff like this in it.  We need to
work to get rid of the cruft but one step at a time I think.

I've started a kgdb-wishlist:

https://bugs.chromium.org/p/chromium/issues/list?q=label%3Akgdb-wishlist

...and this is crbug.com/908723


> > +void __weak kgdb_roundup_cpus(void)
> > +{
> > +     call_single_data_t *csd;
> > +     int this_cpu = get_cpu();
>
> Do you actually need to disable preemption here? afaict, irqs are already
> disabled by the kgdb core.

Ah, right.  I can just use raw_smp_processor_id().  Done.  I didn't
try to see if I could use smp_processor_id() since
kgdb_call_nmi_hook() already used raw_smp_processor_id(), but I can
dig if you wish.


> > +     int cpu;
> > +
> > +     for_each_cpu(cpu, cpu_online_mask) {
>
> for_each_online_cpu(cpu) ?

Done.


> I'm assuming this is serialised wrt CPU hotplug somehow?

I doubt it.  I can add it to my wishlist (crbug.com/908722) , but I
don't think it's something I'm going to try to solve right now and
it's definitely not new.  I think we need to make some sort of attempt
in kgdb_cpu_enter() to stop hotplugging, though we'd have to take into
account that we may be entering kgdb in an IRQ context so it might be
hard to grab a mutex.  We need to account for it there since that
function has code like:

> while (kgdb_do_roundup && --time_left &&
>        (atomic_read(&masters_in_kgdb) + atomic_read(&slaves_in_kgdb)) !=
>    online_cpus)
> udelay(1000);

...and that would also be broken if cpus were plugging / unplugging.

In general, at least, the worst case would be that we'd either have an
extra 1 second delay entering the debugger (because we were waiting
for a CPU to respond that's been hotplugged) or we'd enter kgdb
without stopping one of the CPUs.  Neither of those is ideal but I
don't think we'd end up in too bad shape.

Oh, but actually, I guess I should probably check the error return of
smp_call_function_single_async() and if it returns an error I should
unset rounding_up...  That would make things behave slightly better
and is probably right anyway.


Overall: thank you very much for the review and the feedback.  Sorry
I'm not really fixing everything here.  My hope is to move things to a
slightly better state but I don't have time to fix everything.
Hopefully I can find some more time soon to fix more, or perhaps
someone else will.


-Doug
