Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8186FC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7AD2087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7AD2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeJEAW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:22:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbeJEAW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:22:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F48BA8BB;
        Thu,  4 Oct 2018 17:28:42 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB71616BE0;
        Thu,  4 Oct 2018 17:28:38 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
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
        devel@linuxdriverproject.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI support
In-Reply-To: <CALCETrWbWLM5Jjm7iJCE7S=BJ9OFw2QQGJ2Ao-qsuaN50z=y0A@mail.gmail.com>
References: <20180914125006.349747096@linutronix.de> <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com> <20181003190026.GB21381@amt.cnet> <CALCETrXwEDGNry=9KKvWyc7Eot3eEDifkJ234igDLrea2mVfuA@mail.gmail.com> <20181004163705.GA25129@amt.cnet> <CALCETrWbWLM5Jjm7iJCE7S=BJ9OFw2QQGJ2Ao-qsuaN50z=y0A@mail.gmail.com>
Date:   Thu, 04 Oct 2018 19:28:37 +0200
Message-ID: <87bm89d3ju.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 04 Oct 2018 17:28:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> On Thu, Oct 4, 2018 at 9:43 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>>
>> On Wed, Oct 03, 2018 at 03:32:08PM -0700, Andy Lutomirski wrote:
>> > On Wed, Oct 3, 2018 at 12:01 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
>> > >
>> > > On Tue, Oct 02, 2018 at 10:15:49PM -0700, Andy Lutomirski wrote:
>> > > > Hi Vitaly, Paolo, Radim, etc.,
>> > > >
>> > > > On Fri, Sep 14, 2018 at 5:52 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> > > > >
>> > > > > Matt attempted to add CLOCK_TAI support to the VDSO clock_gettime()
>> > > > > implementation, which extended the clockid switch case and added yet
>> > > > > another slightly different copy of the same code.
>> > > > >
>> > > > > Especially the extended switch case is problematic as the compiler tends to
>> > > > > generate a jump table which then requires to use retpolines. If jump tables
>> > > > > are disabled it adds yet another conditional to the existing maze.
>> > > > >
>> > > > > This series takes a different approach by consolidating the almost
>> > > > > identical functions into one implementation for high resolution clocks and
>> > > > > one for the coarse grained clock ids by storing the base data for each
>> > > > > clock id in an array which is indexed by the clock id.
>> > > > >
>> > > >
>> > > > I was trying to understand more of the implications of this patch
>> > > > series, and I was again reminded that there is an entire extra copy of
>> > > > the vclock reading code in arch/x86/kvm/x86.c.  And the purpose of
>> > > > that code is very, very opaque.
>> > > >
>> > > > Can one of you explain what the code is even doing?  From a couple of
>> > > > attempts to read through it, it's a whole bunch of
>> > > > probably-extremely-buggy code that,
>> > >
>> > > Yes, probably.
>> > >
>> > > > drumroll please, tries to atomically read the TSC value and the time.  And decide whether the
>> > > > result is "based on the TSC".
>> > >
>> > > I think "based on the TSC" refers to whether TSC clocksource is being
>> > > used.
>> > >
>> > > > And then synthesizes a TSC-to-ns
>> > > > multiplier and shift, based on *something other than the actual
>> > > > multiply and shift used*.
>> > > >
>> > > > IOW, unless I'm totally misunderstanding it, the code digs into the
>> > > > private arch clocksource data intended for the vDSO, uses a poorly
>> > > > maintained copy of the vDSO code to read the time (instead of doing
>> > > > the sane thing and using the kernel interfaces for this), and
>> > > > propagates a totally made up copy to the guest.
>> > >
>> > > I posted kernel interfaces for this, and it was suggested to
>> > > instead write a "in-kernel user of pvclock data".
>> > >
>> > > If you can get kernel interfaces to replace that, go for it. I prefer
>> > > kernel interfaces as well.
>> > >
>> > > >  And gets it entirely
>> > > > wrong when doing nested virt, since, unless there's some secret in
>> > > > this maze, it doesn't acutlaly use the scaling factor from the host
>> > > > when it tells the guest what to do.
>> > > >
>> > > > I am really, seriously tempted to send a patch to simply delete all
>> > > > this code.
>> > >
>> > > If your patch which deletes the code gets the necessary features right,
>> > > sure, go for it.
>> > >
>> > > > The correct way to do it is to hook
>> > >
>> > > Can you expand on the correct way to do it?
>> > >
>> > > > And I don't see how it's even possible to pass kvmclock correctly to
>> > > > the L2 guest when L0 is hyperv.  KVM could pass *hyperv's* clock, but
>> > > > L1 isn't notified when the data structure changes, so how the heck is
>> > > > it supposed to update the kvmclock structure?
>> > >
>> > > I don't parse your question.
>> >
>> > Let me ask it more intelligently: when the "reenlightenment" IRQ
>> > happens, what tells KVM to do its own update for its guests?
>>
>> Update of what, and why it needs to update anything from IRQ?
>>
>> The update i can think of is from host kernel clocksource,
>> which there is a notifier for.
>>
>>
>
> Unless I've missed some serious magic, L2 guests see kvmclock, not hv.
> So we have the following sequence of events:
>
>  - L0 migrates the whole VM.  Starting now, RDTSC is emulated to match
> the old host, which applies in L1 and L2.
>
>  - An IRQ is queued to L1.
>
>  - L1 acknowledges that it noticed the TSC change.

Before the acknowledgement we actually pause all guests so they don't
notice the change ....

>  RDTSC stops being emulated for L1 and L2.

.... and right after that we update all kvmclocks for all L2s and
unpause them so all their readings are still correct (see
kvm_hyperv_tsc_notifier()).

>
>  - L2 reads the TSC.  It has no idea that anything changed, and it
> gets the wrong answer.

I have to admit I forgot what happens if L2 uses raw TSC. I *think* that
we actually adjust TSC offset along with adjusting kvmclocks so the
reading is still correct. I'll have to check this.

All bets are off in case L2 was using TSC for time interval
measurements: frequency, of course, changes.

>
>  - At some point, kvm clock updates.
>
> What prevents this?  Vitaly, am I missing some subtlety of what
> actually happens?

-- 
Vitaly
