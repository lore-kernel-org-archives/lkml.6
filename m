Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9436C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1D9214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1D9214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeHOXih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:38:37 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37965 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeHOXih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:38:37 -0400
Received: by mail-qt0-f194.google.com with SMTP id w26-v6so2755445qto.5;
        Wed, 15 Aug 2018 13:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=upVKeWjxTPP+YWqaaOKHJLrXw9Nol93xfoio7or9HT8=;
        b=cOursw88VMdHA2iI+LbRy6ZrIo/VFhVF0UF2rUvag5czQazRQjpebKLr3lC2LLUvZr
         xsVNe57rgm9xZ7KnTGVpC2EiaPIPZ6W4PsdeBGJA2+OM8qmsP7YJQgXOo58Pk+AbCu+m
         7FbbH2D+p30RSDo9EJxXN/YJo42XDQo24aJKlQy7Xl3ISKW2twbKZZ44Mf6BAGN1yoq7
         4weAJpnYWlLgme+2maExE6K4WTuqQTCGCKlylA3+xwhzkw9AzsxD6QlCTgzb4e4Nojyq
         m/nazmSDRTmIPMxK0CZedKXgCzM79aPSrsNAc53NNlav+pcz7CewO+LnsX+EsKOU4JEH
         cjgg==
X-Gm-Message-State: AOUpUlEgkz3+AT2aOEEErPaO+tk3RKOpfrJgM8V/DbLj6KkYwrooGvHO
        UWEs7rxCiWS5C5v+eldyvjNpHCFcDiXSu/qTTJ1GrALu
X-Google-Smtp-Source: AA+uWPyuLSAdWqnfj4WvUSlnfGhFmLOnVC+JLgFPqnmWFo9UD640JOO/cLZnpYcBJkpXVDME7TefugmjGP4ykDN2lrI=
X-Received: by 2002:aed:241d:: with SMTP id r29-v6mr26120642qtc.389.1534365890428;
 Wed, 15 Aug 2018 13:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180815175040.3736548-1-arnd@arndb.de> <90A7E81AE28BAE4CBDDB3B35F187D2644073E9C4@CHN-SV-EXMX02.mchp-main.com>
 <CAK8P3a0f38ev5E4Zvg_3BS+1UN2NzYSw+dyRHXDwLCWgREXJ6g@mail.gmail.com> <90A7E81AE28BAE4CBDDB3B35F187D2644073EA26@CHN-SV-EXMX02.mchp-main.com>
In-Reply-To: <90A7E81AE28BAE4CBDDB3B35F187D2644073EA26@CHN-SV-EXMX02.mchp-main.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Aug 2018 22:44:34 +0200
Message-ID: <CAK8P3a3guebtDLNhbQwNmA2nq=raKiP8ztGRpb03r0XD8h+ZNA@mail.gmail.com>
Subject: Re: [PATCH] net: lan743x_ptp: convert to ktime_get_clocktai_ts64
To:     Bryan.Whitehead@microchip.com
Cc:     UNGLinuxDriver@microchiptechnology.mail.onmicrosoft.com,
        David Miller <davem@davemloft.net>,
        YueHaibing <yuehaibing@huawei.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 10:41 PM <Bryan.Whitehead@microchip.com> wrote:
>
> > > > Question: this is the only ptp driver that sets the hardware time to
> > > > the current system time in TAI. Why does it do that?
> > >
> > > This is done when the driver starts up after reset. Otherwise the clock is off
> > by 48 years.
> > > It seemed to me that the system time was the most appropriate clock to
> > sync to.
> > > If my reasoning is incorrect, please enlighten me.
> >
> > I've never worked with PTP, but my understanding from looking at the other
> > drivers is that the time normally gets set either from another host through
> > the PTP protocol, or using clock_settime() from user space with the current
> > time.
>
> Those methods will still work. But if it's not set by those methods, I thought the
> clock should at least be set once on driver startup to align with the system clock.
> After that, other methods are free to reset it again.

(adding Richard Cochran to Cc for more insight here)

I would argue that it's more important that the driver behaves like all other
PTP implementations. If we want the behavior to be that the initial PTP time is
set to the ktime_get_clocktai_ts64() value, then this should be done by the
PTP core rather than the device driver. If there is a good reason that the
other drivers don't do it like this, then I would assume the same reason applies
to lan743x.

        Arnd
