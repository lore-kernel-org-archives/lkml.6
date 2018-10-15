Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37DAC71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AB92083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AB92083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeJOW2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:28:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50363 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbeJOW2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:28:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0AE16307D943;
        Mon, 15 Oct 2018 14:42:47 +0000 (UTC)
Received: from amt.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06E4C7A26E;
        Mon, 15 Oct 2018 14:42:44 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id 619A01050ED;
        Mon, 15 Oct 2018 10:40:12 -0300 (BRT)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id w9FDdvDr003285;
        Mon, 15 Oct 2018 10:39:57 -0300
Date:   Mon, 15 Oct 2018 10:39:56 -0300
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
Message-ID: <20181015133952.GA2932@amt.cnet>
References: <499807AB-E779-40C3-AA3F-E8C77A7770EC@amacapital.net>
 <CALCETrXNKCNZzUXj=2sp1vBd_o7HHzfW6RwyY5v3-wMfbVaZnQ@mail.gmail.com>
 <20181006202731.GC7129@amt.cnet>
 <CALCETrWqze2mifOdFc0GJYHtHGKiKX2Zdi5Kz87OyUogbqD15w@mail.gmail.com>
 <20181008152650.GB27822@amt.cnet>
 <CALCETrVY6VHPLs0GXZM4+VYraTa1+xs=iRJoRa++OHX9Wq+ieg@mail.gmail.com>
 <20181008193632.GA31729@amt.cnet>
 <CALCETrW6b8=dU6vkXNS-rW1GPzJTbVxuVNsU4aoD_NwwobVQcg@mail.gmail.com>
 <20181011222744.GA17955@amt.cnet>
 <CALCETrXMEqHOa-8s51gGE_gxWVzTWY5eLiZrGLhMUkWKZkfmDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXMEqHOa-8s51gGE_gxWVzTWY5eLiZrGLhMUkWKZkfmDw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 15 Oct 2018 14:42:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 04:00:29PM -0700, Andy Lutomirski wrote:
> On Thu, Oct 11, 2018 at 3:28 PM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> >
> > On Tue, Oct 09, 2018 at 01:09:42PM -0700, Andy Lutomirski wrote:
> > > On Tue, Oct 9, 2018 at 8:28 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > > >
> > > > On Mon, Oct 08, 2018 at 10:38:22AM -0700, Andy Lutomirski wrote:
> > > > > On Mon, Oct 8, 2018 at 8:27 AM Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > >
> > > > > I read the comment three more times and even dug through the git
> > > > > history.  It seems like what you're saying is that, under certain
> > > > > conditions (which arguably would be bugs in the core Linux timing
> > > > > code),
> > > >
> > > > I don't see that as a bug. Its just a side effect of reading two
> > > > different clocks (one is CLOCK_MONOTONIC and the other is TSC),
> > > > and using those two clocks to as a "base + offset".
> > > >
> > > > As the comment explains, if you do that, can't guarantee monotonicity.
> > > >
> > > > > actually calling ktime_get_boot_ns() could be non-monotonic
> > > > > with respect to the kvmclock timing.  But get_kvmclock_ns() isn't used
> > > > > for VM timing as such -- it's used for the IOCTL interfaces for
> > > > > updating the time offset.  So can you explain how my patch is
> > > > > incorrect?
> > > >
> > > > ktime_get_boot_ns() has frequency correction applied, while
> > > > reading masterclock + TSC offset does not.
> > > >
> > > > So the clock reads differ.
> > > >
> > >
> > > Ah, okay, I finally think I see what's going on.  In the kvmclock data
> > > exposed to the guest, tsc_shift and tsc_to_system_mul come from
> > > tgt_tsc_khz, whereas master_kernel_ns and master_cycle_now come from
> > > CLOCK_BOOTTIME.  So the kvmclock and kernel clock drift apart at a
> > > rate given by the frequency shift and then suddenly agree again every
> > > time the pvclock data is updated.
> >
> > Yes.
> >
> > > Is there a reason to do it this way?
> >
> > Since pvclock updates which update system_timestamp are expensive (must stop all vcpus),
> > they should be avoided.
> >
> 
> Fair enough.
> 
> > So only HW TSC counts
> 
> makes sense.
> 
> >, and used as offset against vcpu's tsc_timestamp.
> >
> 
> Why don't you just expose CLOCK_MONTONIC_RAW or CLOCK_MONOTONIC_RAW
> plus suspend time, though?  Then you would actually be tracking a real
> kernel timekeeping mode, and you wouldn't need all this complicated
> offsetting work to avoid accidentally going backwards.

Can you outline how that would work ? 

