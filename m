Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E06C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55052054F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="imbLSuUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55052054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeLEDlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:41:49 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34904 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLEDlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 22:41:46 -0500
Received: by mail-ua1-f66.google.com with SMTP id d2so6618204ual.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 19:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=claPucn+XJmQuNDr9GzOxYNtVSSdZHOjhhV3KuIo0kc=;
        b=imbLSuUdrAQA+3eZTMnGhlCCedBfnUq0nH8VeWgXogzdRJPxVpsi6rdlN+L037ryt/
         c3Bg09Qimd0+OuB8LKUrOzPW/Bgv8lKmtZzpVicVGuWesxKatrE6XgbZD2GlbsrjCd4/
         yd0IeRC1t/Tzha8cYdMtMxxdHI5JaICl3xbAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=claPucn+XJmQuNDr9GzOxYNtVSSdZHOjhhV3KuIo0kc=;
        b=fNb8FTkBXwmufJ1viA7/09ce/y5/zjXTV2rAv4ZyFqFYP+cOUzaJ2G2A1DB9lBXYdK
         jfWSCzM4gXc8ABT/puXyfDyhxr6bf0gzhelFTiyyV8ST0g1vHtuycqdTzUe8BnhkGQi+
         +SDmjqTS9wldJDLxeFVoV3OQLlwEyKb3nHO5V969p+INpw0DeubMRFE0Zd3ee2mLasck
         6/gQkFAGbwxtTRLeIHbGzzpMUvcih1gUxqsnhtw9dSg/7ZQejJ4fpbgukRHJP+VadYVh
         oWTkpIB2Eul9JB6xBKxVi5M8HXTlF2O8jGwfo5ISdGvNfiKqY8A2F4xmnw/+U47vnSUu
         A5XA==
X-Gm-Message-State: AA+aEWbG8RGjOwGizNBm8psmorSb3xxCYemA4z5VLmfm8JYjTr29cG7U
        zOZhn9qwsMBlLONQXl8jqSqVy0MgMxw=
X-Google-Smtp-Source: AFSGD/UZIghToGY9WkM3txadBHBnqweTtQrObQ5kCp7z5pOOfBk00D3W4NF1qTKjG3lwsBv13VLoaQ==
X-Received: by 2002:ab0:44e7:: with SMTP id n94mr10555762uan.76.1543981304554;
        Tue, 04 Dec 2018 19:41:44 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id a75sm6629033vsi.4.2018.12.04.19.41.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 19:41:43 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id z3so11231733vsf.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 19:41:43 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr8920678vsv.20.1543981302613;
 Tue, 04 Dec 2018 19:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20181127173839.34328-1-dianders@chromium.org> <20181127173839.34328-3-dianders@chromium.org>
 <20181203155724.7g37vp43e4fd4xqk@holly.lan>
In-Reply-To: <20181203155724.7g37vp43e4fd4xqk@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Dec 2018 19:41:28 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WS+9d6xeCx4xDqSQkPKPuRx6yATh=j_c1=uJpTdMVUqA@mail.gmail.com>
Message-ID: <CAD=FV=WS+9d6xeCx4xDqSQkPKPuRx6yATh=j_c1=uJpTdMVUqA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Will Deacon <will.deacon@arm.com>,
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

On Mon, Dec 3, 2018 at 7:57 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Nov 27, 2018 at 09:38:37AM -0800, Douglas Anderson wrote:
> > When I had lockdep turned on and dropped into kgdb I got a nice splat
> > on my system.  Specifically it hit:
> >   DEBUG_LOCKS_WARN_ON(current->hardirq_context)
> >
> > Specifically it looked like this:
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
> > Looking closely at it, it seems like a really bad idea to be calling
> > local_irq_enable() in kgdb_roundup_cpus().  If nothing else that seems
> > like it could violate spinlock semantics and cause a deadlock.
> >
> > Instead, let's use a private csd alongside
> > smp_call_function_single_async() to round up the other CPUs.  Using
> > smp_call_function_single_async() doesn't require interrupts to be
> > enabled so we can remove the offending bit of code.
> >
> > In order to avoid duplicating this across all the architectures that
> > use the default kgdb_roundup_cpus(), we'll add a "weak" implementation
> > to debug_core.c.
> >
> > Looking at all the people who previously had copies of this code,
> > there were a few variants.  I've attempted to keep the variants
> > working like they used to.  Specifically:
> > * For arch/arc we passed NULL to kgdb_nmicallback() instead of
> >   get_irq_regs().
> > * For arch/mips there was a bit of extra code around
> >   kgdb_nmicallback()
> >
> > NOTE: In this patch we will still get into trouble if we try to round
> > up a CPU that failed to round up before.  We'll try to round it up
> > again and potentially hang when we try to grab the csd lock.  That's
> > not new behavior but we'll still try to do better in a future patch.
> >
> > Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v6:
> > - Moved smp_call_function_single_async() error check to patch 3.
> >
> > Changes in v5:
> > - Add a comment about get_irq_regs().
> > - get_cpu() => raw_smp_processor_id() in kgdb_roundup_cpus().
> > - for_each_cpu() => for_each_online_cpu()
> > - Error check smp_call_function_single_async()
> >
> > Changes in v4: None
> > Changes in v3:
> > - No separate init call.
> > - Don't round up the CPU that is doing the rounding up.
> > - Add "#ifdef CONFIG_SMP" to match the rest of the file.
> > - Updated desc saying we don't solve the "failed to roundup" case.
> > - Document the ignored parameter.
> >
> > Changes in v2:
> > - Removing irq flags separated from fixing lockdep splat.
> > - Don't use smp_call_function (Daniel).
> >
> >  arch/arc/kernel/kgdb.c     | 10 ++--------
> >  arch/arm/kernel/kgdb.c     | 12 -----------
> >  arch/arm64/kernel/kgdb.c   | 12 -----------
> >  arch/hexagon/kernel/kgdb.c | 27 -------------------------
> >  arch/mips/kernel/kgdb.c    |  9 +--------
> >  arch/powerpc/kernel/kgdb.c |  4 ++--
> >  arch/sh/kernel/kgdb.c      | 12 -----------
>
> Please could you re-send with the arch maintainers for these platforms
> included in the Cc: of the patch description rather than just in the
> e-mail header.
>
> I'd like to make sure arch maintainers have a chance to opt out if they
> want to (it's a weak symbol so an arch could chose not to use it).
>
> Otherwise I shall start testing shortly!

OK, I did a repost of v6 with the Cc's and also the Acks I've received
so far.  There are no code changes in the repost.  Please let me know
if you have additional comments and thanks for your help.

-Doug
