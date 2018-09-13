Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA466C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E11A20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E11A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbeIMTIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:08:21 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39559 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731286AbeIMTIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:08:21 -0400
Received: by mail-ot1-f68.google.com with SMTP id c12-v6so1304576otl.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 06:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyzbjWylZk4vNomlZFP0KUtwEYhxD/Np8KXad4/GNkY=;
        b=i89PGCGlbBPwpdfn5kaz2advnjgXS8DuEugCHyhmd+DcBgEbtyb2oL2q420f5eNiAi
         oyhyKTPysBoGbIAtMmWIXlf1+/humrDT5FwIMPjKr34oFQmnOgkTqqA43P0m0FZwZGFM
         1cIxHEInPcLyv4co3Ku1RoaEyAN7/acE9u6XwcenBk0Ji9dAQ4KSSqPvlcbvxFgtY8rw
         h/4KmNU9OpVW3WGhByqP9EOMNfM4vZ+FVI3iGw6tYDIYokfAvW9NZcWjwBwNfkKGvA4J
         tOwCUtd9Ig8ruxgH1t3Fm5dfLTZP0ZmTkQ5m36Y47kHa2cUxQFOBWDwbxsenmi2FFX4z
         kS+w==
X-Gm-Message-State: APzg51BJn7QIaUhkYcqAvYnEKHYtT3SxqOKr8TYYI99GscLRc8GwFa4A
        zFYrCEUA24TQKIhXch7/orOt2XXT74pNVDc+FQHPhQ==
X-Google-Smtp-Source: ANB0Vdbp9xnwAH1lyfTbTonnTrxN2h/9wYsptMIoTDrQKVDPLNVrP1UBEsLlF54f2263v+7PBu/y6OxHCJ27Lx/7m/k=
X-Received: by 2002:a9d:1cac:: with SMTP id l44-v6mr1229816ota.359.1536847123882;
 Thu, 13 Sep 2018 06:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180820123818.27547-1-omosnace@redhat.com> <20180821072114.GC23069@localhost>
 <CAHC9VhQCB5kB9Vy-TWwu-Z62p2XcPpKwsFLB647=usVM2EE=LA@mail.gmail.com> <2148764.ODNUjEgRWb@x2>
In-Reply-To: <2148764.ODNUjEgRWb@x2>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 13 Sep 2018 15:58:32 +0200
Message-ID: <CAFqZXNtsjAt3ks7L=e24UVhx23bihz1MLN7gKihs=LFJDShutg@mail.gmail.com>
Subject: Re: [RFC PATCH ghak10 v4 0/2] audit: Log modifying adjtimex(2) calls
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 4:56 PM Steve Grubb <sgrubb@redhat.com> wrote:
> On Wednesday, August 22, 2018 5:27:17 PM EDT Paul Moore wrote:
> > On Tue, Aug 21, 2018 at 3:21 AM Miroslav Lichvar <mlichvar@redhat.com>
> wrote:
> > > > On Mon, 20 Aug 2018, Ondrej Mosnacek wrote:
> > > > > @John or other timekeeping/NTP folks: We had a discussion on the
> > > > > audit
> > > > > ML on which of the internal timekeeping/NTP variables we should
> > > > > actually
> > > > > log changes for. We are only interested in variables that can
> > > > > (directly
> > > > > or indirectly) cause noticeable changes to the system clock, but
> > > > > since we
> > > > > have only limited understanding of the NTP code, we would like to ask
> > > > > you for advice on which variables are security relevant.
> > >
> > > I guess that mostly depends on whether you consider setting the clock
> > > to run faster or slower than real time to be an important event for
> > > the audit.
> > >
> > > > > - NTP value adjustments:
> > > > > - time_offset (probably important)
> > >
> > > This can adjust the clock by up to 0.5 seconds per call and also speed
> > > it up or slow down by up to about 0.05% (43 seconds per day).
> >
> > This seems worthwhile.
> >
> > > > > - time_freq (maybe not important?)
> > >
> > > This can speed up or slow down by up to about 0.05%.
> >
> > This too.
> >
> > > > > - time_status (likely important, can cause leap second injection)
> > >
> > > Yes, it can insert/delete leap seconds and it also enables/disables
> > > synchronization of the hardware real-time clock.
> >
> > This one as well.
> >
> > > > > - time_maxerror (maybe not important?)
> > > > > - time_esterror (maybe not important?)
> > >
> > > These two change the error estimates that are reported to applications
> > > using ntp_gettime()/adjtimex(). If an application was periodically
> > > checking that the clock is synchronized with some specified accuracy
> > > and setting the maxerror to a larger value would cause the application
> > > to abort, would it be an important event in the audit?
> >
> > Since these don't really affect the time, just the expected error, I'm
> > not sure this is important.
>
> I don't think so.

Sorry, just to make sure I understand it right - do you (also) not
think it is important or do you not think it is not important? :)

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
