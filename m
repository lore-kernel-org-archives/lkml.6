Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B42C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1946206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEvw3Jos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1946206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbeJCMCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbeJCMCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:02:48 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA1F921470
        for <linux-kernel@vger.kernel.org>; Wed,  3 Oct 2018 05:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538543762;
        bh=mD1CO+IjZXv0CDDY/wEkUp89zH7oIbyw2Bo8Z/BiOTw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YEvw3JosT3LdZOBWn57qhG09yCz9gZFSvZ8sMAnzy8o71JrV7atlFkPbAoQGfUGgP
         eb2V5qO8yVxPZJNtc2PJB9TwCj7qCJDkH+/QHRupTYk/scUQhT/6k9KPmZsW9iY42g
         0AZ3gZf6e/J98ZMuywLrT1AUc+EhoSmNKEnMPvMY=
Received: by mail-wm1-f52.google.com with SMTP id 185-v6so4239773wmt.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 22:16:01 -0700 (PDT)
X-Gm-Message-State: ABuFfoh1YAVUtVc0atx2M7UUH+Dt3hug9qAmDHVZJCo0F+5rwd67l2kl
        TU0K0r/GnH0e4o4oqQEdpQhDrJAwtOiok5WWpO1bGg==
X-Google-Smtp-Source: ACcGV62IubmpW81dweInj7BM+6vkNkUWJK9yPDoXHRcDoT1EupWsFlaoYBIsnMNa/FkiHTms4g0awGWEa66ennaboT0=
X-Received: by 2002:a1c:f312:: with SMTP id q18-v6mr168502wmq.14.1538543760007;
 Tue, 02 Oct 2018 22:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180914125006.349747096@linutronix.de>
In-Reply-To: <20180914125006.349747096@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 2 Oct 2018 22:15:49 -0700
X-Gmail-Original-Message-ID: <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
Message-ID: <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI support
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
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

Hi Vitaly, Paolo, Radim, etc.,

On Fri, Sep 14, 2018 at 5:52 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Matt attempted to add CLOCK_TAI support to the VDSO clock_gettime()
> implementation, which extended the clockid switch case and added yet
> another slightly different copy of the same code.
>
> Especially the extended switch case is problematic as the compiler tends to
> generate a jump table which then requires to use retpolines. If jump tables
> are disabled it adds yet another conditional to the existing maze.
>
> This series takes a different approach by consolidating the almost
> identical functions into one implementation for high resolution clocks and
> one for the coarse grained clock ids by storing the base data for each
> clock id in an array which is indexed by the clock id.
>

I was trying to understand more of the implications of this patch
series, and I was again reminded that there is an entire extra copy of
the vclock reading code in arch/x86/kvm/x86.c.  And the purpose of
that code is very, very opaque.

Can one of you explain what the code is even doing?  From a couple of
attempts to read through it, it's a whole bunch of
probably-extremely-buggy code that, drumroll please, tries to
atomically read the TSC value and the time.  And decide whether the
result is "based on the TSC".  And then synthesizes a TSC-to-ns
multiplier and shift, based on *something other than the actual
multiply and shift used*.

IOW, unless I'm totally misunderstanding it, the code digs into the
private arch clocksource data intended for the vDSO, uses a poorly
maintained copy of the vDSO code to read the time (instead of doing
the sane thing and using the kernel interfaces for this), and
propagates a totally made up copy to the guest.  And gets it entirely
wrong when doing nested virt, since, unless there's some secret in
this maze, it doesn't acutlaly use the scaling factor from the host
when it tells the guest what to do.

I am really, seriously tempted to send a patch to simply delete all
this code.  The correct way to do it is to hook

And I don't see how it's even possible to pass kvmclock correctly to
the L2 guest when L0 is hyperv.  KVM could pass *hyperv's* clock, but
L1 isn't notified when the data structure changes, so how the heck is
it supposed to update the kvmclock structure?

--Andy
