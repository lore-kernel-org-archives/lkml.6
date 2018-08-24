Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138C5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3045208B7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3045208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeHXSbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:31:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726387AbeHXSbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:31:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2789F40216EC;
        Fri, 24 Aug 2018 14:56:23 +0000 (UTC)
Received: from x2.localnet (ovpn-121-58.rdu2.redhat.com [10.10.121.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 386F91007278;
        Fri, 24 Aug 2018 14:56:19 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     mlichvar@redhat.com, omosnace@redhat.com, tglx@linutronix.de,
        linux-audit@redhat.com, rgb@redhat.com, john.stultz@linaro.org,
        sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH ghak10 v4 0/2] audit: Log modifying adjtimex(2) calls
Date:   Fri, 24 Aug 2018 10:56:19 -0400
Message-ID: <2148764.ODNUjEgRWb@x2>
Organization: Red Hat
In-Reply-To: <CAHC9VhQCB5kB9Vy-TWwu-Z62p2XcPpKwsFLB647=usVM2EE=LA@mail.gmail.com>
References: <20180820123818.27547-1-omosnace@redhat.com> <20180821072114.GC23069@localhost> <CAHC9VhQCB5kB9Vy-TWwu-Z62p2XcPpKwsFLB647=usVM2EE=LA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 24 Aug 2018 14:56:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 24 Aug 2018 14:56:23 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'sgrubb@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 22, 2018 5:27:17 PM EDT Paul Moore wrote:
> On Tue, Aug 21, 2018 at 3:21 AM Miroslav Lichvar <mlichvar@redhat.com> 
wrote:
> > > On Mon, 20 Aug 2018, Ondrej Mosnacek wrote:
> > > > @John or other timekeeping/NTP folks: We had a discussion on the
> > > > audit
> > > > ML on which of the internal timekeeping/NTP variables we should
> > > > actually
> > > > log changes for. We are only interested in variables that can
> > > > (directly
> > > > or indirectly) cause noticeable changes to the system clock, but
> > > > since we
> > > > have only limited understanding of the NTP code, we would like to ask
> > > > you for advice on which variables are security relevant.
> > 
> > I guess that mostly depends on whether you consider setting the clock
> > to run faster or slower than real time to be an important event for
> > the audit.
> > 
> > > > - NTP value adjustments:
> > > > - time_offset (probably important)
> > 
> > This can adjust the clock by up to 0.5 seconds per call and also speed
> > it up or slow down by up to about 0.05% (43 seconds per day).
> 
> This seems worthwhile.
> 
> > > > - time_freq (maybe not important?)
> > 
> > This can speed up or slow down by up to about 0.05%.
> 
> This too.
> 
> > > > - time_status (likely important, can cause leap second injection)
> > 
> > Yes, it can insert/delete leap seconds and it also enables/disables
> > synchronization of the hardware real-time clock.
> 
> This one as well.
> 
> > > > - time_maxerror (maybe not important?)
> > > > - time_esterror (maybe not important?)
> > 
> > These two change the error estimates that are reported to applications
> > using ntp_gettime()/adjtimex(). If an application was periodically
> > checking that the clock is synchronized with some specified accuracy
> > and setting the maxerror to a larger value would cause the application
> > to abort, would it be an important event in the audit?
> 
> Since these don't really affect the time, just the expected error, I'm
> not sure this is important.

I don't think so.

-Steve



