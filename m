Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F59EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC37921473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO/tU0Yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC37921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeJDFWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbeJDFWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:22:43 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B03BF214C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Oct 2018 22:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538605942;
        bh=44K1dXoUqnnLNzkcFJ9rnt23TL/ivNkgJS3eEc4dMCs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DO/tU0YzoQrkY8tMszsAloZeTUrFvFPT91fTqbFo33ulMPxRTRKI2IvoGpgB4iLdX
         zFXmcd7lf9Gbp4KsRLtWXAKG5jNAsOI2gsFSIYBTqpip68VYEsVn3HJ/Ai/mLulOqr
         0C2TnSK12TDAUFScP4oGLU7u1mbF1yOh2RA16Ijs=
Received: by mail-wr1-f47.google.com with SMTP id 63-v6so7791164wra.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 15:32:21 -0700 (PDT)
X-Gm-Message-State: ABuFfog+/u0XFtiuIKD3P3rGN+lEtRckSZ6dTX1Dwwdm82kkuaLNnaeW
        85wfHbiT/16QNg65fJJkIp9BV4L4ZGK7wdokve/qLA==
X-Google-Smtp-Source: ACcGV62TWnDywNWeEiNesSHkod7MW47qvCSuZh0yorxEnXvQR5lv8Bacs3UyrN1+OvL7Cod+XdqVqMX+8Ckaw4OZiXg=
X-Received: by 2002:adf:9792:: with SMTP id s18-v6mr2824733wrb.283.1538605940010;
 Wed, 03 Oct 2018 15:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180914125006.349747096@linutronix.de> <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
 <20181003190026.GB21381@amt.cnet>
In-Reply-To: <20181003190026.GB21381@amt.cnet>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 3 Oct 2018 15:32:08 -0700
X-Gmail-Original-Message-ID: <CALCETrXwEDGNry=9KKvWyc7Eot3eEDifkJ234igDLrea2mVfuA@mail.gmail.com>
Message-ID: <CALCETrXwEDGNry=9KKvWyc7Eot3eEDifkJ234igDLrea2mVfuA@mail.gmail.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI support
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 12:01 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
> On Tue, Oct 02, 2018 at 10:15:49PM -0700, Andy Lutomirski wrote:
> > Hi Vitaly, Paolo, Radim, etc.,
> >
> > On Fri, Sep 14, 2018 at 5:52 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > Matt attempted to add CLOCK_TAI support to the VDSO clock_gettime()
> > > implementation, which extended the clockid switch case and added yet
> > > another slightly different copy of the same code.
> > >
> > > Especially the extended switch case is problematic as the compiler tends to
> > > generate a jump table which then requires to use retpolines. If jump tables
> > > are disabled it adds yet another conditional to the existing maze.
> > >
> > > This series takes a different approach by consolidating the almost
> > > identical functions into one implementation for high resolution clocks and
> > > one for the coarse grained clock ids by storing the base data for each
> > > clock id in an array which is indexed by the clock id.
> > >
> >
> > I was trying to understand more of the implications of this patch
> > series, and I was again reminded that there is an entire extra copy of
> > the vclock reading code in arch/x86/kvm/x86.c.  And the purpose of
> > that code is very, very opaque.
> >
> > Can one of you explain what the code is even doing?  From a couple of
> > attempts to read through it, it's a whole bunch of
> > probably-extremely-buggy code that,
>
> Yes, probably.
>
> > drumroll please, tries to atomically read the TSC value and the time.  And decide whether the
> > result is "based on the TSC".
>
> I think "based on the TSC" refers to whether TSC clocksource is being
> used.
>
> > And then synthesizes a TSC-to-ns
> > multiplier and shift, based on *something other than the actual
> > multiply and shift used*.
> >
> > IOW, unless I'm totally misunderstanding it, the code digs into the
> > private arch clocksource data intended for the vDSO, uses a poorly
> > maintained copy of the vDSO code to read the time (instead of doing
> > the sane thing and using the kernel interfaces for this), and
> > propagates a totally made up copy to the guest.
>
> I posted kernel interfaces for this, and it was suggested to
> instead write a "in-kernel user of pvclock data".
>
> If you can get kernel interfaces to replace that, go for it. I prefer
> kernel interfaces as well.
>
> >  And gets it entirely
> > wrong when doing nested virt, since, unless there's some secret in
> > this maze, it doesn't acutlaly use the scaling factor from the host
> > when it tells the guest what to do.
> >
> > I am really, seriously tempted to send a patch to simply delete all
> > this code.
>
> If your patch which deletes the code gets the necessary features right,
> sure, go for it.
>
> > The correct way to do it is to hook
>
> Can you expand on the correct way to do it?
>
> > And I don't see how it's even possible to pass kvmclock correctly to
> > the L2 guest when L0 is hyperv.  KVM could pass *hyperv's* clock, but
> > L1 isn't notified when the data structure changes, so how the heck is
> > it supposed to update the kvmclock structure?
>
> I don't parse your question.

Let me ask it more intelligently: when the "reenlightenment" IRQ
happens, what tells KVM to do its own update for its guests?
