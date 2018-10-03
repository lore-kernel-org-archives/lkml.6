Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A273C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6166E213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6166E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeJDB5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:57:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53247 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbeJDB5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:57:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A3A2287629;
        Wed,  3 Oct 2018 19:07:41 +0000 (UTC)
Received: from amt.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B04F2672C0;
        Wed,  3 Oct 2018 19:07:40 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id 44A9310514F;
        Wed,  3 Oct 2018 16:05:08 -0300 (BRT)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id w93J54gh023695;
        Wed, 3 Oct 2018 16:05:04 -0300
Date:   Wed, 3 Oct 2018 16:05:04 -0300
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
 support\
Message-ID: <20181003190500.GA23638@amt.cnet>
References: <20180914125006.349747096@linutronix.de>
 <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
 <20181003190026.GB21381@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003190026.GB21381@amt.cnet>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 03 Oct 2018 19:07:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 04:00:29PM -0300, Marcelo Tosatti wrote:
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

And cleanup patches, to make that code look nicer, are also very
welcome!

