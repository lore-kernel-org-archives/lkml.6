Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17499C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BF5204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BF5204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbeIMTJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:09:08 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44535 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbeIMTJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:09:08 -0400
Received: by mail-ot1-f68.google.com with SMTP id 36-v6so1304301oth.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 06:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9viuzLyKw1+0ihqQI7BMG0rDHglykTatGiROFnvy3Ms=;
        b=pxso0uxi7bVV7bkF2efo+woxhpsj0fPmWSR9TU0Ts4CkxwXGs4igGMH0YEV7AIbVko
         x1ZM0iVWnYwgtDaSty1uFkufPKBlV4BJS+QmYmumOSQbmxd922Wrp7tTxj+LJtk6lfuh
         RxoCPkhUrZJjCddcIEhm/4UdkcfZaXX8nCxbRqjSFJv1k0T4lXtwtwmjubyZqkwnjhWS
         ysCexak4B2/Okn2CxymvwIr4NMGV2xnLuqnaQDIExuqNdu5YKabjMYQlU7J+S5T79+fk
         2WBoRAs0neW0Vz1OgHY1yAz5eZSl35FbFoitW90ZnL44IUAytPHxqKLWynQUrwg440Gu
         Y1OQ==
X-Gm-Message-State: APzg51C4+uGf4VvfPN2100U4bw+t+sNPDqq7qpVODrSvS2fxmbOvUSHC
        OHJfkO12AAOOugYANy2oGMiAOtcgmobrgTcfM83H8w==
X-Google-Smtp-Source: ANB0VdbPOWXGkqDnhVdgm9E14thfgTGJIK1+kyyAAwo/QS6QdHDNLAYGicytMbOUkL2GcUBvTB8DdmHiKp5opFGhS3Y=
X-Received: by 2002:a9d:5745:: with SMTP id x5-v6mr1342461oti.226.1536847170562;
 Thu, 13 Sep 2018 06:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180824120001.20771-1-omosnace@redhat.com> <20180827075020.GL27091@localhost>
 <CAFqZXNvADB-E_fjEaQpUymSVvfP-vXQXtk3K+nJ9DqrScHL8bQ@mail.gmail.com> <4819575.TSNxuEWROA@x2>
In-Reply-To: <4819575.TSNxuEWROA@x2>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 13 Sep 2018 15:59:19 +0200
Message-ID: <CAFqZXNtzSU0KjFwYzqJCQybEvJz1GhQZHxRfJ2hj=6o_RGGLLA@mail.gmail.com>
Subject: Re: [PATCH ghak10 v5 1/2] audit: Add functions to log time adjustments
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 6:38 PM Steve Grubb <sgrubb@redhat.com> wrote:
> On Monday, August 27, 2018 5:13:17 AM EDT Ondrej Mosnacek wrote:
> > On Mon, Aug 27, 2018 at 9:50 AM Miroslav Lichvar <mlichvar@redhat.com>
> wrote:
> > > On Fri, Aug 24, 2018 at 02:00:00PM +0200, Ondrej Mosnacek wrote:
> > > > This patch adds two auxiliary record types that will be used to
> > > > annotate
> > > > the adjtimex SYSCALL records with the NTP/timekeeping values that have
> > > > been changed.
> > >
> > > It seems the "adjust" function intentionally logs also calls/modes
> > > that don't actually change anything. Can you please explain it a bit
> > > in the message?
> > >
> > > NTP/PTP daemons typically don't read the adjtimex values in a normal
> > > operation and overwrite them on each update, even if they don't
> > > change. If the audit function checked that oldval != newval, the
> > > number of messages would be reduced and it might be easier to follow.
> >
> > We actually want to log any attempt to change a value, as even an
> > intention to set/change something could be a hint that the process is
> > trying to do something bad (see discussion at [1]).
>
> One of the problems is that these applications can flood the logs very
> quickly. An attempt to change is not needed unless it fails for permissions
> reasons. So, limiting to actual changes is probably a good thing.

Well, Richard seemed to "violently" agree with the opposite, so now I
don't know which way to go... Paul, you are the official tie-breaker
here, which do you prefer?

>
> -Steve
>
> > There are valid
> > arguments both for and against this choice, but we have to pick one in
> > the end... Anyway, I should explain the reasoning in the commit
> > message better, right now it just states the fact without explanation
> > (in the second patch), thank you for pointing my attention to it.
> >
> > [1] https://www.redhat.com/archives/linux-audit/2018-July/msg00061.html
> >
> > --
> > Ondrej Mosnacek <omosnace at redhat dot com>
> > Associate Software Engineer, Security Technologies
> > Red Hat, Inc.
>
>
>
>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
