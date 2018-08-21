Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40BFC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0F4214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0F4214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeHUKkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:40:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbeHUKkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:40:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D0FFC7D84D;
        Tue, 21 Aug 2018 07:21:20 +0000 (UTC)
Received: from localhost (unknown [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0BDA10075DF;
        Tue, 21 Aug 2018 07:21:15 +0000 (UTC)
Date:   Tue, 21 Aug 2018 09:21:14 +0200
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-audit@redhat.com,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH ghak10 v4 0/2] audit: Log modifying adjtimex(2) calls
Message-ID: <20180821072114.GC23069@localhost>
References: <20180820123818.27547-1-omosnace@redhat.com>
 <alpine.DEB.2.21.1808201721350.1551@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808201721350.1551@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 21 Aug 2018 07:21:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 21 Aug 2018 07:21:20 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mlichvar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 20 Aug 2018, Ondrej Mosnacek wrote:
> > @John or other timekeeping/NTP folks: We had a discussion on the audit
> > ML on which of the internal timekeeping/NTP variables we should actually
> > log changes for. We are only interested in variables that can (directly
> > or indirectly) cause noticeable changes to the system clock, but since we
> > have only limited understanding of the NTP code, we would like to ask
> > you for advice on which variables are security relevant.

I guess that mostly depends on whether you consider setting the clock
to run faster or slower than real time to be an important event for
the audit.

> >   - NTP value adjustments:
> >     - time_offset (probably important)

This can adjust the clock by up to 0.5 seconds per call and also speed
it up or slow down by up to about 0.05% (43 seconds per day).

> >     - time_freq (maybe not important?)

This can speed up or slow down by up to about 0.05%.

> >     - time_status (likely important, can cause leap second injection)

Yes, it can insert/delete leap seconds and it also enables/disables
synchronization of the hardware real-time clock.

> >     - time_maxerror (maybe not important?)
> >     - time_esterror (maybe not important?)

These two change the error estimates that are reported to applications
using ntp_gettime()/adjtimex(). If an application was periodically
checking that the clock is synchronized with some specified accuracy
and setting the maxerror to a larger value would cause the application
to abort, would it be an important event in the audit?

> >     - time_constant (???)

This controls the speed of the clock adjustments that are made when
time_offset is set. Probably not important for the audit.

> >     - time_adjust (sounds important)

This is similar to time_freq. It can temporarily speed up or slow down
the clock by up to 0.05%.

> >     - tick_usec (???)

This is a more extreme version of time_freq. It can speed up or slow
down the clock by up to 10%.

-- 
Miroslav Lichvar
