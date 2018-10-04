Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77932C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329152083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329152083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeJDXh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:37:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbeJDXh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:37:57 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1588723D9;
        Thu,  4 Oct 2018 16:43:52 +0000 (UTC)
Received: from amt.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77B2D9E8C9;
        Thu,  4 Oct 2018 16:43:51 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id DEDEB105143;
        Thu,  4 Oct 2018 13:37:17 -0300 (BRT)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id w94Gb6hF028089;
        Thu, 4 Oct 2018 13:37:06 -0300
Date:   Thu, 4 Oct 2018 13:37:05 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI
 support
Message-ID: <20181004163705.GA25129@amt.cnet>
References: <20180914125006.349747096@linutronix.de>
 <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
 <20181003190026.GB21381@amt.cnet>
 <CALCETrXwEDGNry=9KKvWyc7Eot3eEDifkJ234igDLrea2mVfuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXwEDGNry=9KKvWyc7Eot3eEDifkJ234igDLrea2mVfuA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 04 Oct 2018 16:43:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 03:32:08PM -0700, Andy Lutomirski wrote:
> On Wed, Oct 3, 2018 at 12:01 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> >
> > On Tue, Oct 02, 2018 at 10:15:49PM -0700, Andy Lutomirski wrote:
> > > Hi Vitaly, Paolo, Radim, etc.,
> > >
> > > On Fri, Sep 14, 2018 at 5:52 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >
> > > > Matt attempted to add CLOCK_TAI support to the VDSO clock_gettime()
> > > > implementation, which extended the clockid switch case and added yet
> > > > another slightly different copy of the same code.
> > > >
> > > > Especially the extended switch case is problematic as the compiler tends to
> > > > generate a jump table which then requires to use retpolines. If jump tables
> > > > are disabled it adds yet another conditional to the existing maze.
> > > >
> > > > This series takes a different approach by consolidating the almost
> > > > identical functions into one implementation for high resolution clocks and
> > > > one for the coarse grained clock ids by storing the base data for each
> > > > clock id in an array which is indexed by the clock id.
> > > >
> > >
> > > I was trying to understand more of the implications of this patch
> > > series, and I was again reminded that there is an entire extra copy of
> > > the vclock reading code in arch/x86/kvm/x86.c.  And the purpose of
> > > that code is very, very opaque.
> > >
> > > Can one of you explain what the code is even doing?  From a couple of
> > > attempts to read through it, it's a whole bunch of
> > > probably-extremely-buggy code that,
> >
> > Yes, probably.
> >
> > > drumroll please, tries to atomically read the TSC value and the time.  And decide whether the
> > > result is "based on the TSC".
> >
> > I think "based on the TSC" refers to whether TSC clocksource is being
> > used.
> >
> > > And then synthesizes a TSC-to-ns
> > > multiplier and shift, based on *something other than the actual
> > > multiply and shift used*.
> > >
> > > IOW, unless I'm totally misunderstanding it, the code digs into the
> > > private arch clocksource data intended for the vDSO, uses a poorly
> > > maintained copy of the vDSO code to read the time (instead of doing
> > > the sane thing and using the kernel interfaces for this), and
> > > propagates a totally made up copy to the guest.
> >
> > I posted kernel interfaces for this, and it was suggested to
> > instead write a "in-kernel user of pvclock data".
> >
> > If you can get kernel interfaces to replace that, go for it. I prefer
> > kernel interfaces as well.
> >
> > >  And gets it entirely
> > > wrong when doing nested virt, since, unless there's some secret in
> > > this maze, it doesn't acutlaly use the scaling factor from the host
> > > when it tells the guest what to do.
> > >
> > > I am really, seriously tempted to send a patch to simply delete all
> > > this code.
> >
> > If your patch which deletes the code gets the necessary features right,
> > sure, go for it.
> >
> > > The correct way to do it is to hook
> >
> > Can you expand on the correct way to do it?
> >
> > > And I don't see how it's even possible to pass kvmclock correctly to
> > > the L2 guest when L0 is hyperv.  KVM could pass *hyperv's* clock, but
> > > L1 isn't notified when the data structure changes, so how the heck is
> > > it supposed to update the kvmclock structure?
> >
> > I don't parse your question.
> 
> Let me ask it more intelligently: when the "reenlightenment" IRQ
> happens, what tells KVM to do its own update for its guests?

Update of what, and why it needs to update anything from IRQ? 

The update i can think of is from host kernel clocksource, 
which there is a notifier for.


