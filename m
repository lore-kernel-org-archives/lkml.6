Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7649FC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A94520854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A94520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbeIMTRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:17:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbeIMTRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:17:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7DD10317C40E;
        Thu, 13 Sep 2018 14:08:00 +0000 (UTC)
Received: from x2.localnet (ovpn-122-199.rdu2.redhat.com [10.10.122.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F5735D6B5;
        Thu, 13 Sep 2018 14:07:55 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH ghak10 v4 0/2] audit: Log modifying adjtimex(2) calls
Date:   Thu, 13 Sep 2018 10:07:54 -0400
Message-ID: <192111258.UpI01XQOzn@x2>
Organization: Red Hat
In-Reply-To: <CAFqZXNtsjAt3ks7L=e24UVhx23bihz1MLN7gKihs=LFJDShutg@mail.gmail.com>
References: <20180820123818.27547-1-omosnace@redhat.com> <2148764.ODNUjEgRWb@x2> <CAFqZXNtsjAt3ks7L=e24UVhx23bihz1MLN7gKihs=LFJDShutg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 13 Sep 2018 14:08:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 13, 2018 9:58:32 AM EDT Ondrej Mosnacek wrote:
> On Fri, Aug 24, 2018 at 4:56 PM Steve Grubb <sgrubb@redhat.com> wrote:
> > On Wednesday, August 22, 2018 5:27:17 PM EDT Paul Moore wrote:
> > > On Tue, Aug 21, 2018 at 3:21 AM Miroslav Lichvar <mlichvar@redhat.com>
> > 
> > wrote:
> > > > > On Mon, 20 Aug 2018, Ondrej Mosnacek wrote:
> > > > > > @John or other timekeeping/NTP folks: We had a discussion on the
> > > > > > audit
> > > > > > ML on which of the internal timekeeping/NTP variables we should
> > > > > > actually
> > > > > > log changes for. We are only interested in variables that can
> > > > > > (directly
> > > > > > or indirectly) cause noticeable changes to the system clock, but
> > > > > > since we
> > > > > > have only limited understanding of the NTP code, we would like to
> > > > > > ask
> > > > > > you for advice on which variables are security relevant.
> > > > 
> > > > I guess that mostly depends on whether you consider setting the clock
> > > > to run faster or slower than real time to be an important event for
> > > > the audit.
> > > > 
> > > > > > - NTP value adjustments:
> > > > > > - time_offset (probably important)
> > > > 
> > > > This can adjust the clock by up to 0.5 seconds per call and also
> > > > speed
> > > > it up or slow down by up to about 0.05% (43 seconds per day).
> > > 
> > > This seems worthwhile.
> > > 
> > > > > > - time_freq (maybe not important?)
> > > > 
> > > > This can speed up or slow down by up to about 0.05%.
> > > 
> > > This too.
> > > 
> > > > > > - time_status (likely important, can cause leap second injection)
> > > > 
> > > > Yes, it can insert/delete leap seconds and it also enables/disables
> > > > synchronization of the hardware real-time clock.
> > > 
> > > This one as well.
> > > 
> > > > > > - time_maxerror (maybe not important?)
> > > > > > - time_esterror (maybe not important?)
> > > > 
> > > > These two change the error estimates that are reported to
> > > > applications
> > > > using ntp_gettime()/adjtimex(). If an application was periodically
> > > > checking that the clock is synchronized with some specified accuracy
> > > > and setting the maxerror to a larger value would cause the
> > > > application to abort, would it be an important event in the audit?
> > > 
> > > Since these don't really affect the time, just the expected error, I'm
> > > not sure this is important.
> > 
> > I don't think so.
> 
> Sorry, just to make sure I understand it right - do you (also) not
> think it is important or do you not think it is not important? :)

I do not think its important to record the errors since the exit code tells 
us there's a problem. IOW, I'm agreeing with Paul.

-Steve



