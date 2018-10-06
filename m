Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09837ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 22:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45DA2147D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 22:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPId6INq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45DA2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeJGFdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 01:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbeJGFdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 01:33:19 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B6EB214FF
        for <linux-kernel@vger.kernel.org>; Sat,  6 Oct 2018 22:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538864899;
        bh=Pm4HyIK0Lnie+pFEWmr9H5YcN4c27rPEanb+Nmc75fI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DPId6INqcQj+KYzwi9TdJSv4rQX1V+el09roRnbKpeLAEYOxjDaD6Ad9rQ5LfPBZY
         6k5k3leig2G8/IFYmkv3H5C8dYDxA46MHIy9QSYFsbm7CHFw1dhm7TVspl6ArXE40A
         IhtK0nvfMfxfAg5WZMuXUtxsDEhYXafeyDhP/yUM=
Received: by mail-wr1-f42.google.com with SMTP id 61-v6so16183450wrb.6
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 15:28:19 -0700 (PDT)
X-Gm-Message-State: ABuFfojL8QTI2oME7N7vJhnivrrXhnf/zFYFnRGS0BFjR1MIyjTKcWoa
        dPxabTCz3cItGfpw7DHkOpn55+WhzGomkCAG/jE2XQ==
X-Google-Smtp-Source: ACcGV61EHF8yjziYTE4gr78ermpmK54EQCYkOD/Wp3WaHsurcAi8Iq6HLCe/9WoxcarNFmMMTFOR5yVPNqa59Xrs0Ac=
X-Received: by 2002:adf:e387:: with SMTP id e7-v6mr12207669wrm.94.1538864897441;
 Sat, 06 Oct 2018 15:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180914125006.349747096@linutronix.de> <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
 <87sh1ne64t.fsf@vitty.brq.redhat.com> <20181003190617.GC21381@amt.cnet>
 <87k1mycfju.fsf@vitty.brq.redhat.com> <20181004081100.GI19272@hirez.programming.kicks-ass.net>
 <B8C05946-43BB-40A4-A564-53904FAF8CC0@amacapital.net> <20181004193150.GQ19272@hirez.programming.kicks-ass.net>
 <499807AB-E779-40C3-AA3F-E8C77A7770EC@amacapital.net> <CALCETrXNKCNZzUXj=2sp1vBd_o7HHzfW6RwyY5v3-wMfbVaZnQ@mail.gmail.com>
 <20181006202731.GC7129@amt.cnet>
In-Reply-To: <20181006202731.GC7129@amt.cnet>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 6 Oct 2018 15:28:05 -0700
X-Gmail-Original-Message-ID: <CALCETrWqze2mifOdFc0GJYHtHGKiKX2Zdi5Kz87OyUogbqD15w@mail.gmail.com>
Message-ID: <CALCETrWqze2mifOdFc0GJYHtHGKiKX2Zdi5Kz87OyUogbqD15w@mail.gmail.com>
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

On Sat, Oct 6, 2018 at 1:29 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>
> On Thu, Oct 04, 2018 at 03:15:32PM -0700, Andy Lutomirski wrote:
> > For better or for worse, I'm trying to understand this code.  So far,
> > I've come up with this patch:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/vdso-tglx&id=14fd71e12b1c4492a06f368f75041f263e6862bf
> >
> > Is it correct, or am I missing some subtlety?
>
> The master clock, when initialized, has a pair
>
> masterclockvalues=(TSC value, time-of-day data).
>
> When updating the guest clock, we only update relative to (TSC value)
> that was read on masterclock initialization.

I don't see the problem.  The masterclock data is updated here:

    host_tsc_clocksource = kvm_get_time_and_clockread(
                    &ka->master_kernel_ns,
                    &ka->master_cycle_now);

kvm_get_time_and_clockread() gets those values from
do_monotonic_boot(), which, barring bugs, should cause
get_kvmclock_ns() to return exactly the same thing as
ktime_get_boot_ns() + ka->kvmclock_offset, albeit in a rather
roundabout manner.

So what am I missing?  Is there actually something wrong with my patch?


>
> See the following comment on x86.c:

I read that comment, and it's not obvious to me how it's related.
