Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E4AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE8A2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544521922;
	bh=Fkt48mBqjiEt8f3sScInV+n7lqn9TPfmTNf7vyKkkfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=D+zGoqf/8LK7ki+SHLFEtrlHm3ZJNM0ngDQoTrb0hPKzYT71HKiG2S0rZMMxoCNQQ
	 hyC/zctLVuOZVtU8oDlTrUmuvCfCWlmH0LoIr7O8jPTuJDD2gdCc6Zd+Ri/nidvS2u
	 cOB5DrhoXcXxu/+isWJK0481Z9U8xZ8QUB7+W1X8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE8A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbeLKJwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:52:01 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44545 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeLKJwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:52:00 -0500
Received: by mail-oi1-f193.google.com with SMTP id m6so11478271oig.11;
        Tue, 11 Dec 2018 01:51:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Pv3HYPbfn3JZ86CcHU13/v0nT8CZD4sjAt8lCr9FRk=;
        b=cb924vBaZfwDlpgm+W53HIOppVi+D8jsphutApszNLV/awuqZGGWKCBLwsUo51J6f/
         bRNuJR2F4XUBICR9H6KHPLRJIUCqjTWOIs2U0LSLDZ4anILhaRQ8i2mJpFUti/Zc/YpT
         JrUdtr2Cq8bc0ucAC9grB4HiBTcYU011LQ4SHPf4sgRaUXAr8nmJWXDFlBbwkt0rhBXV
         +ZRl1E6et8c5aqCtBXUyeou9oIddQVjyODyXidajkkYr6JFg61L7awvji0fSScUWrztc
         +RLgxEdkkSVWV4IXf8OVrWZAOcCku1xwb9KZZAUbQP5FQgC9UY3APxVrJCDnz2evHqkO
         k97Q==
X-Gm-Message-State: AA+aEWZftvuP0/c3miGggdaheaJDXL4lup8uVOyYrj9qSdKmespUYfxN
        r3Oyk3CJmblIq8xkXDdLW3GTU3cJ25BvZU4zQWs=
X-Google-Smtp-Source: AFSGD/WlXpsySE/Ckis0tZsJOQsT04lFNv+KKbo6jMQ+gGZht1gXh/q7eoCpFkgtJJ8QYThl6LM1/nwaWrcdaNM1pko=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr851757oix.246.1544521919383;
 Tue, 11 Dec 2018 01:51:59 -0800 (PST)
MIME-Version: 1.0
References: <3514439.dzOWKx1Cjx@aspire.rjw.lan> <20181210122104.GL5289@hirez.programming.kicks-ass.net>
 <CAJZ5v0j-a6cHayRtcsUPbUTBT0iBSUvmcUy6pfSSvUVcTMBxbw@mail.gmail.com> <20181210225134.GB24811@worktop.programming.kicks-ass.net>
In-Reply-To: <20181210225134.GB24811@worktop.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Dec 2018 10:51:48 +0100
Message-ID: <CAJZ5v0jvbDCCgy=nUfb-yZCYGOxe4-XexbvnmeBm8ZPDPBaK4w@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: Add 'above' and 'below' idle state metrics
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 11:51 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Dec 10, 2018 at 10:36:40PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Dec 10, 2018 at 1:21 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > One question on this; why is this tracked unconditionally?
> >
> > Because I didn't quite see how to make that conditional in a sensible way.
>
> Something like:
>
>         if (static_branch_unlikely(__tracepoint_idle_above) ||
>             static_branch_unlikely(__tracepoint_idle_below)) {
>
>                 // do stuff that calls trace_idle_above() /
>                 // trace_idle_below().
>
>         }
>
> > These things are counters and counting with the help of tracepoints
> > isn't particularly convenient (and one needs debugfs to be there to
> > use tracepoints and they require root access etc).
>
> Root only should not be a problem for a developer; and aren't these
> numbers only really interesting if you're prodding at the idle governor?

What about regression testing?

> > > Would not a tracepoint be better?; then there is no overhead in the
> > > normal case where nobody gives a crap about these here numbers.
> >
> > There is an existing tracepoint that in principle could be used to
> > produce this information, but it is such a major PITA in practice that
> > nobody does that.  Guess why. :-)
>
> Sounds like you need to ship a convenient script or something :-)

That would be a very ugly script.  Also I'd need to expose
drv->states[i].disabled somehow (that's not accessible from user space
now).

> > Also, the "usage" and "time" counters are there in sysfs, so why not these two?
> >
> > And is the overhead really that horrible?
>
> Dunno; it could be cold cachelines, at which point it can be fairly
> expensive. Also, being stuck with API is fairly horrible if you want to
> 'fix' it.

All of the cache lines involved should've been touched earlier in this
code path by the governor.  At least menu and the new one both touch
them.

The API part I'm not too worried about.  I know it is useful and two
other people have told that to me already. :-)
