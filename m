Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DB5C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F58208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F58208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeJFET6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 00:19:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbeJFET6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 00:19:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5DC7308ED66;
        Fri,  5 Oct 2018 21:19:26 +0000 (UTC)
Received: from amt.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 299155C22B;
        Fri,  5 Oct 2018 21:19:26 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id E788E105148;
        Fri,  5 Oct 2018 18:18:57 -0300 (BRT)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id w95LIfkI012495;
        Fri, 5 Oct 2018 18:18:41 -0300
Date:   Fri, 5 Oct 2018 18:18:41 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
Subject: Re: [patch 00/11] x86/vdso: Cleanups, simmplifications and CLOCK_TAI
 support
Message-ID: <20181005211838.GB7129@amt.cnet>
References: <20180914125006.349747096@linutronix.de>
 <CALCETrU+jP2hPLoJWTYJKTvr7-=YLwtk1=cZ_uizHYQZ1z4P-w@mail.gmail.com>
 <87sh1ne64t.fsf@vitty.brq.redhat.com>
 <20181003190617.GC21381@amt.cnet>
 <87k1mycfju.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1mycfju.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 05 Oct 2018 21:19:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 09:54:45AM +0200, Vitaly Kuznetsov wrote:
> Marcelo Tosatti <mtosatti@redhat.com> writes:
> 
> > On Wed, Oct 03, 2018 at 11:22:58AM +0200, Vitaly Kuznetsov wrote:
> >> 
> >> There is a very long history of different (hardware) issues Marcelo was
> >> fighting with and the current code is the survived Frankenstein.
> >
> > Right, the code has to handle different TSC modes.
> >
> >>  E.g. it
> >> is very, very unclear what "catchup", "always catchup" and
> >> masterclock-less mode in general are and if we still need them.
> >
> > Catchup means handling exposed (to guest) TSC frequency smaller than
> > HW TSC frequency.
> >
> > That is "frankenstein" code, could be removed.
> >
> >> That said I'm all for simplification. I'm not sure if we still need to
> >> care about buggy hardware though.
> >
> > What simplification is that again? 
> >
> 
> I was hoping to hear this from you :-) If I am to suggest how we can
> move forward I'd propose:
> - Check if pure TSC can be used on SkyLake+ systems (where TSC scaling
> is supported).

In that case just use TSC clocksource on the guest directly: i am
writing code for that now (its faster than pvclock syscall).

> - Check if non-masterclock mode is still needed. E.g. HyperV's TSC page
> clocksource is a single page for the whole VM, not a per-cpu thing. Can
> we think that all the buggy hardware is already gone?

As Peter mentioned, non sync TSC hardware might exist in the future. 
And older hardware must be supported.


