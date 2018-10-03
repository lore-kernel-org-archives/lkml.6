Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D710C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B12120835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B12120835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeJCQKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:10:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbeJCQKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:10:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A3D6307D84D;
        Wed,  3 Oct 2018 09:23:05 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 263DA6714C;
        Wed,  3 Oct 2018 09:23:00 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI support
In-Reply-To: <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
References: <20180914125006.349747096@linutronix.de> <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
Date:   Wed, 03 Oct 2018 11:22:58 +0200
Message-ID: <87sh1ne64t.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 03 Oct 2018 09:23:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> Hi Vitaly, Paolo, Radim, etc.,
>
> On Fri, Sep 14, 2018 at 5:52 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Matt attempted to add CLOCK_TAI support to the VDSO clock_gettime()
>> implementation, which extended the clockid switch case and added yet
>> another slightly different copy of the same code.
>>
>> Especially the extended switch case is problematic as the compiler tends to
>> generate a jump table which then requires to use retpolines. If jump tables
>> are disabled it adds yet another conditional to the existing maze.
>>
>> This series takes a different approach by consolidating the almost
>> identical functions into one implementation for high resolution clocks and
>> one for the coarse grained clock ids by storing the base data for each
>> clock id in an array which is indexed by the clock id.
>>
>
> I was trying to understand more of the implications of this patch
> series, and I was again reminded that there is an entire extra copy of
> the vclock reading code in arch/x86/kvm/x86.c.  And the purpose of
> that code is very, very opaque.
>
> Can one of you explain what the code is even doing?  From a couple of
> attempts to read through it, it's a whole bunch of
> probably-extremely-buggy code that, drumroll please, tries to
> atomically read the TSC value and the time.  And decide whether the
> result is "based on the TSC".  And then synthesizes a TSC-to-ns
> multiplier and shift, based on *something other than the actual
> multiply and shift used*.
>
> IOW, unless I'm totally misunderstanding it, the code digs into the
> private arch clocksource data intended for the vDSO, uses a poorly
> maintained copy of the vDSO code to read the time (instead of doing
> the sane thing and using the kernel interfaces for this), and
> propagates a totally made up copy to the guest.  And gets it entirely
> wrong when doing nested virt, since, unless there's some secret in
> this maze, it doesn't acutlaly use the scaling factor from the host
> when it tells the guest what to do.
>
> I am really, seriously tempted to send a patch to simply delete all
> this code.  The correct way to do it is to hook

"I have discovered a truly marvelous proof of this, which this margin is
too narrow to contain" :-)

There is a very long history of different (hardware) issues Marcelo was
fighting with and the current code is the survived Frankenstein. E.g. it
is very, very unclear what "catchup", "always catchup" and
masterclock-less mode in general are and if we still need them.

That said I'm all for simplification. I'm not sure if we still need to
care about buggy hardware though.

>
> And I don't see how it's even possible to pass kvmclock correctly to
> the L2 guest when L0 is hyperv.  KVM could pass *hyperv's* clock, but
> L1 isn't notified when the data structure changes, so how the heck is
> it supposed to update the kvmclock structure?

Well, this kind of works in the the followin way:
L1's clocksource is 'tsc_page' which is, basically, a compliment to TSC:
two numbers provided by L0: offset and scale and KVM was tought to treat
this clocksource as a good one (see b0c39dc68e3b "x86/kvm: Pass stable
clocksource to guests when running nested on Hyper-V").

The notification you're talking about exists, it is called
Reenligntenment, see 0092e4346f49 "x86/kvm: Support Hyper-V
reenlightenment"). When TSC page changes (and this only happens when L1
is migrated to a different host with a different TSC frequency and TSC
scaling is not supported by the CPU) we receive an interrupt in L1 (at
this moment all TSC accesses are emulated which guarantees the
correctness of the readings), pause all L2 guests, update their kvmclock
structures with new data (we already know the new TSC frequency) and
then tell L0 that we're done and it can stop emulating TSC accesses.

(Nothing like this exists for KVM-on-KVM, by the way, when L1's
clocksource is 'kvmclock' L2s won't get a stable kvmclock clocksource.)

-- 
Vitaly
