Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA18C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB082145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ta6Zvg8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB082145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJIAvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbeJIAvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:51:24 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17AD52150C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 17:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539020316;
        bh=nOELVkD6C4YjKrA6cd/+gg/f/hubfXGZFeulfNccSng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ta6Zvg8B00h64pCOctBZxMjn4zevQxr0kI4DXRnB48ZZ6dQDmHsvOaqQcee2FjTOP
         AitVuVpUBpiszpiUMzr+nMKOP1N6s5DlfEoP966OqRbuCbNE2AHxyWbid1d7WzXBJM
         S4dynawxFC+H5Op2lMjVLa69mmiEpWqJsxM7vSUc=
Received: by mail-wr1-f49.google.com with SMTP id 63-v6so21704139wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 10:38:36 -0700 (PDT)
X-Gm-Message-State: ABuFfog5oQgAbsFKlB5gHwZFs663LXTg3bnwWU+11OezG7sgnGxSkbq9
        ZPLaioDW8/uj0GWGgRd6L0NDOtDb/tA7oiIElZaIvA==
X-Google-Smtp-Source: ACcGV61PInSA77vEQX6i2U4HnCuP+HT6SrRpvFGzYK0pRFVEsOQKvENH5gJWv9c/VKweXrIpbAy27SzV960OhyiVFNk=
X-Received: by 2002:a5d:610a:: with SMTP id v10-v6mr11321245wrt.308.1539020314323;
 Mon, 08 Oct 2018 10:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <87sh1ne64t.fsf@vitty.brq.redhat.com> <20181003190617.GC21381@amt.cnet>
 <87k1mycfju.fsf@vitty.brq.redhat.com> <20181004081100.GI19272@hirez.programming.kicks-ass.net>
 <B8C05946-43BB-40A4-A564-53904FAF8CC0@amacapital.net> <20181004193150.GQ19272@hirez.programming.kicks-ass.net>
 <499807AB-E779-40C3-AA3F-E8C77A7770EC@amacapital.net> <CALCETrXNKCNZzUXj=2sp1vBd_o7HHzfW6RwyY5v3-wMfbVaZnQ@mail.gmail.com>
 <20181006202731.GC7129@amt.cnet> <CALCETrWqze2mifOdFc0GJYHtHGKiKX2Zdi5Kz87OyUogbqD15w@mail.gmail.com>
 <20181008152650.GB27822@amt.cnet>
In-Reply-To: <20181008152650.GB27822@amt.cnet>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 8 Oct 2018 10:38:22 -0700
X-Gmail-Original-Message-ID: <CALCETrVY6VHPLs0GXZM4+VYraTa1+xs=iRJoRa++OHX9Wq+ieg@mail.gmail.com>
Message-ID: <CALCETrVY6VHPLs0GXZM4+VYraTa1+xs=iRJoRa++OHX9Wq+ieg@mail.gmail.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI support
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 8:27 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
> On Sat, Oct 06, 2018 at 03:28:05PM -0700, Andy Lutomirski wrote:
> > On Sat, Oct 6, 2018 at 1:29 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > >
> > > On Thu, Oct 04, 2018 at 03:15:32PM -0700, Andy Lutomirski wrote:
> > > > For better or for worse, I'm trying to understand this code.  So far,
> > > > I've come up with this patch:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/vdso-tglx&id=14fd71e12b1c4492a06f368f75041f263e6862bf
> > > >
> > > > Is it correct, or am I missing some subtlety?
> > >
> > > The master clock, when initialized, has a pair
> > >
> > > masterclockvalues=(TSC value, time-of-day data).
> > >
> > > When updating the guest clock, we only update relative to (TSC value)
> > > that was read on masterclock initialization.
> >
> > I don't see the problem.  The masterclock data is updated here:
> >
> >     host_tsc_clocksource = kvm_get_time_and_clockread(
> >                     &ka->master_kernel_ns,
> >                     &ka->master_cycle_now);
> >
> > kvm_get_time_and_clockread() gets those values from
> > do_monotonic_boot(), which, barring bugs, should cause
> > get_kvmclock_ns() to return exactly the same thing as
> > ktime_get_boot_ns() + ka->kvmclock_offset, albeit in a rather
> > roundabout manner.
> >
> > So what am I missing?  Is there actually something wrong with my patch?
>
> For the bug mentioned in the comment not to happen, you must only read
> TSC and add it as offset to (TSC value, time-of-day data).
>
> Its more than "a roundabout manner".
>
> Read the comment again.
>

I read the comment three more times and even dug through the git
history.  It seems like what you're saying is that, under certain
conditions (which arguably would be bugs in the core Linux timing
code), actually calling ktime_get_boot_ns() could be non-monotonic
with respect to the kvmclock timing.  But get_kvmclock_ns() isn't used
for VM timing as such -- it's used for the IOCTL interfaces for
updating the time offset.  So can you explain how my patch is
incorrect?

--Andy
