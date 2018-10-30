Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A53FC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C4B20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XyUm3UDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C4B20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbeJaHRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:17:03 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37941 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeJaHRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:17:03 -0400
Received: by mail-vs1-f65.google.com with SMTP id x64so2060091vsa.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 15:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wA1rTDsTXMl16yQ5A/Q7u3m9syhvXP+vgKrx+kVLhhM=;
        b=XyUm3UDblUwDfzhrHUB+GFOrtiFy2nwEZ/VX9E9gX9X0NUKTyY2otgPaloBJ9jsQ2m
         dUhTvg/OOH/gfA7J5HVIqQsEilgJseVCLNk0SKpmF4vvHNGar1Xu1lVgKMAZvcpZSha/
         /dtGN3uF6cf+b1S6nL1uPSb9pxYJBMbCGV4YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wA1rTDsTXMl16yQ5A/Q7u3m9syhvXP+vgKrx+kVLhhM=;
        b=DZEB25/kvClVgkKe7KzM7U0DGkn6cCjkuAvzBmqJ+gUOxx9+24600K5/vN+aM0U10A
         INKowg2FPG6s9dfbgs/g3smdT0QZYp2ShjY4bOp4KZFLQNt6qZuXam0NPwbeUohNXHU6
         /Vjq9Adq7uIxPFqVIyAh8RXb018ZUoYtE+CMD6fJ/4bxEzCutNgXb3jDDV83C/BabgEm
         nBg6bvBqVOExF3tsP3hfLT+FSyp/vO360Y/Gpm0LvDIxzVogcw0IbNd4KNFcyiRFZphr
         JfjB0oSs6oZX5R68jh01FdK4L/pw03ExAkjb0wGv2blamaOY2AkHof6Dyx3+GC/lFVXd
         k4RA==
X-Gm-Message-State: AGRZ1gLpssIcYyAg6UCk1A7U4qJWeebPO60GglUC0N9LY2IOj66VNbJQ
        bVNe47qq/NEn2tIeZkQGfO4/ERPwqYM=
X-Google-Smtp-Source: AJdET5enVywmxjbT/AyPxXcqDUGfKm+bK8s59zIkVIlSOIRuqeIPcRZqrIgLJzhEW1wIhUt2hx0FIQ==
X-Received: by 2002:a67:ca0e:: with SMTP id z14mr266526vsk.83.1540938104167;
        Tue, 30 Oct 2018 15:21:44 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 1sm2717266vke.0.2018.10.30.15.21.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 15:21:42 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id t17so5649252vsc.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 15:21:42 -0700 (PDT)
X-Received: by 2002:a67:1144:: with SMTP id 65mr245574vsr.213.1540938101864;
 Tue, 30 Oct 2018 15:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181029180707.207546-1-dianders@chromium.org>
 <20181029180707.207546-7-dianders@chromium.org> <20181030094159.zt6akmyxwrbzoe2x@holly.lan>
In-Reply-To: <20181030094159.zt6akmyxwrbzoe2x@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Oct 2018 15:21:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wno+QbhUp+0+Pmk72Ds4C9d25ynSH=0JDdttJ2WBU4NA@mail.gmail.com>
Message-ID: <CAD=FV=Wno+QbhUp+0+Pmk72Ds4C9d25ynSH=0JDdttJ2WBU4NA@mail.gmail.com>
Subject: Re: [PATCH 6/7] smp: Don't yell about IRQs disabled in kgdb_roundup_cpus()
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        linux-hexagon@vger.kernel.org, frederic@kernel.org,
        riel@surriel.com, LKML <linux-kernel@vger.kernel.org>,
        luto@kernel.org, sparclinux@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

On Tue, Oct 30, 2018 at 2:42 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Oct 29, 2018 at 11:07:06AM -0700, Douglas Anderson wrote:
> > In kgdb_roundup_cpus() we've got code that looks like:
> >   local_irq_enable();
> >   smp_call_function(kgdb_call_nmi_hook, NULL, 0);
> >   local_irq_disable();
> >
> > In certain cases when we drop into kgdb (like with sysrq-g on a serial
> > console) we'll get a big yell that looks like:
> >
> >   sysrq: SysRq : DEBUG
> >   ------------[ cut here ]------------
> >   DEBUG_LOCKS_WARN_ON(current->hardirq_context)
> >   WARNING: CPU: 0 PID: 0 at .../kernel/locking/lockdep.c:2875 lockdep_hardirqs_on+0xf0/0x160
> >   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0 #27
> >   pstate: 604003c9 (nZCv DAIF +PAN -UAO)
> >   pc : lockdep_hardirqs_on+0xf0/0x160
> >   ...
> >   Call trace:
> >    lockdep_hardirqs_on+0xf0/0x160
> >    trace_hardirqs_on+0x188/0x1ac
> >    kgdb_roundup_cpus+0x14/0x3c
> >    kgdb_cpu_enter+0x53c/0x5cc
> >    kgdb_handle_exception+0x180/0x1d4
> >    kgdb_compiled_brk_fn+0x30/0x3c
> >    brk_handler+0x134/0x178
> >    do_debug_exception+0xfc/0x178
> >    el1_dbg+0x18/0x78
> >    kgdb_breakpoint+0x34/0x58
> >    sysrq_handle_dbg+0x54/0x5c
> >    __handle_sysrq+0x114/0x21c
> >    handle_sysrq+0x30/0x3c
> >    qcom_geni_serial_isr+0x2dc/0x30c
> >   ...
> >   ...
> >   irq event stamp: ...45
> >   hardirqs last  enabled at (...44): [...] __do_softirq+0xd8/0x4e4
> >   hardirqs last disabled at (...45): [...] el1_irq+0x74/0x130
> >   softirqs last  enabled at (...42): [...] _local_bh_enable+0x2c/0x34
> >   softirqs last disabled at (...43): [...] irq_exit+0xa8/0x100
> >   ---[ end trace adf21f830c46e638 ]---
> >
> > Let's add kgdb to the list of reasons not to warn in
> > smp_call_function_many().  That will allow us (in a future patch) to
> > stop calling local_irq_enable() which will get rid of the original
> > splat.
> >
> > NOTE: with this change comes the obvious question: will we start
> > deadlocking more often now when we drop into the debugger.  I can't
> > say that for sure one way or the other, but the fact that we do the
> > same logic for "oops_in_progress" makes me feel like it shouldn't
> > happen too often.  Also note that the old logic of turning on
> > interrupts temporarily wasn't exactly safe since (I presume) that
> > could have violated spin_lock_irqsave() semantics and ended up with a
> > deadlock of its own.
>
> This is part of the code to bring all the cores to a halt and since
> the other cores are still running kgdb isn't yet able to use the fact
> all the CPUs are halted to bend the rules. It is better for this code
> to play by the rules if it can.
>
> Is is possible to get the roundup functions to use a private csd
> alongside smp_call_function_single_async()? We could add a helper
> function to the debug core to avoid having to add cpu_online loops into
> every kgdb_roundup_cpus() implementaton.

Exactly the kind of helpful suggestion I was looking for.  Thank you
very much!  See v2 and hopefully it matches what you were thinking of.

-Doug
