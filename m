Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4013AC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F26521526
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F26521526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeJHWjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:39:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728983AbeJHWjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:39:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE08311530;
        Mon,  8 Oct 2018 15:27:23 +0000 (UTC)
Received: from amt.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76E0D6AEB8;
        Mon,  8 Oct 2018 15:27:23 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id 9900F105135;
        Mon,  8 Oct 2018 12:27:08 -0300 (BRT)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id w98FQrAl010190;
        Mon, 8 Oct 2018 12:26:53 -0300
Date:   Mon, 8 Oct 2018 12:26:53 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI
 support
Message-ID: <20181008152650.GB27822@amt.cnet>
References: <87sh1ne64t.fsf@vitty.brq.redhat.com>
 <20181003190617.GC21381@amt.cnet>
 <87k1mycfju.fsf@vitty.brq.redhat.com>
 <20181004081100.GI19272@hirez.programming.kicks-ass.net>
 <B8C05946-43BB-40A4-A564-53904FAF8CC0@amacapital.net>
 <20181004193150.GQ19272@hirez.programming.kicks-ass.net>
 <499807AB-E779-40C3-AA3F-E8C77A7770EC@amacapital.net>
 <CALCETrXNKCNZzUXj=2sp1vBd_o7HHzfW6RwyY5v3-wMfbVaZnQ@mail.gmail.com>
 <20181006202731.GC7129@amt.cnet>
 <CALCETrWqze2mifOdFc0GJYHtHGKiKX2Zdi5Kz87OyUogbqD15w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWqze2mifOdFc0GJYHtHGKiKX2Zdi5Kz87OyUogbqD15w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 08 Oct 2018 15:27:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 03:28:05PM -0700, Andy Lutomirski wrote:
> On Sat, Oct 6, 2018 at 1:29 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> >
> > On Thu, Oct 04, 2018 at 03:15:32PM -0700, Andy Lutomirski wrote:
> > > For better or for worse, I'm trying to understand this code.  So far,
> > > I've come up with this patch:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/vdso-tglx&id=14fd71e12b1c4492a06f368f75041f263e6862bf
> > >
> > > Is it correct, or am I missing some subtlety?
> >
> > The master clock, when initialized, has a pair
> >
> > masterclockvalues=(TSC value, time-of-day data).
> >
> > When updating the guest clock, we only update relative to (TSC value)
> > that was read on masterclock initialization.
> 
> I don't see the problem.  The masterclock data is updated here:
> 
>     host_tsc_clocksource = kvm_get_time_and_clockread(
>                     &ka->master_kernel_ns,
>                     &ka->master_cycle_now);
> 
> kvm_get_time_and_clockread() gets those values from
> do_monotonic_boot(), which, barring bugs, should cause
> get_kvmclock_ns() to return exactly the same thing as
> ktime_get_boot_ns() + ka->kvmclock_offset, albeit in a rather
> roundabout manner.
> 
> So what am I missing?  Is there actually something wrong with my patch?

For the bug mentioned in the comment not to happen, you must only read
TSC and add it as offset to (TSC value, time-of-day data).

Its more than "a roundabout manner".

Read the comment again.

> 
> 
> >
> > See the following comment on x86.c:
> 
> I read that comment, and it's not obvious to me how it's related.


