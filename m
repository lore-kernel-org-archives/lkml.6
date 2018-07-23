Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF1BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAF020883
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zbiW9Mof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBAF020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388631AbeGWOaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387956AbeGWOaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:30:17 -0400
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com [209.85.216.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A1322089B;
        Mon, 23 Jul 2018 13:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532352541;
        bh=o6EdJoUXBklVzQPwKxazyPPenivnRs5UIkSwkvMGhC8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zbiW9MofzJpubNmDvcI3EhUQG84ddKtkZYgREfHuuHzZ1pGjjORVEq4HKa7XVbsd5
         W/zbzQfq67IPVqPBx5dqyStYXliuIf8j8iRuEzYZS6Q7XbhT4HYa+8aL40FWGRNDk2
         Zq/bKrK0+UVZA9mwqDr+OVxSwCp8F2MCxxqjnFaU=
Received: by mail-qt0-f179.google.com with SMTP id d4-v6so557904qtn.13;
        Mon, 23 Jul 2018 06:29:01 -0700 (PDT)
X-Gm-Message-State: AOUpUlEhtkEid6vVocg98ko1X+vRdK25sv6tDXa9l1Ywy1U/9RgWWxtA
        6F//hX52RokwkjcJhKp7BYg5j/eishEZXLJS9g==
X-Google-Smtp-Source: AAOMgpcSALdBnAJ1ktjfVnXTksJ15oP2Qm7r/ohlXqh50XuJbpp4t5gihu2wbzZksUtjzEY2ft4PsLhKZxYg/hJYwL4=
X-Received: by 2002:ac8:705a:: with SMTP id y26-v6mr12506920qtm.118.1532352540311;
 Mon, 23 Jul 2018 06:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180717084158.23532-1-masneyb@onstation.org> <20180717084158.23532-4-masneyb@onstation.org>
 <20180720173635.GA21241@rob-hp-laptop> <20180721183716.524632f1@archlinux>
 <20180722123720.GB20029@onstation.org> <20180722181748.24bc47d8@archlinux>
In-Reply-To: <20180722181748.24bc47d8@archlinux>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 23 Jul 2018 07:28:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLCQG_CNppd9f7xtwYkruvU4=3PziPOPCTt1P4phg5iLg@mail.gmail.com>
Message-ID: <CAL_JsqLCQG_CNppd9f7xtwYkruvU4=3PziPOPCTt1P4phg5iLg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] iio: tsl2772: add support for reading power
 settings from device tree
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Brian Masney <masneyb@onstation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Martin Kelly <mkelly@xevo.com>, fischerdouglasc@gmail.com,
        bshah@kde.org, Craig Tatlor <ctatlor97@gmail.com>,
        drew.paterson@ams.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 11:17 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun, 22 Jul 2018 12:37:20 +0000
> Brian Masney <masneyb@onstation.org> wrote:
>
> > On Sat, Jul 21, 2018 at 06:37:16PM +0100, Jonathan Cameron wrote:
> > > On Fri, 20 Jul 2018 11:36:35 -0600
> > > Rob Herring <robh@kernel.org> wrote:
> > >
> > > > On Tue, Jul 17, 2018 at 04:41:54AM -0400, Brian Masney wrote:
> > > > > This patch adds support for optionally reading the prox_diode and
> > > > > prox_power settings from device tree. This was tested using a LG
> > > > > Nexus 5 (hammerhead) which requires a different diode than the driver
> > > > > default for the IR LED.
> > > > >
> > > > > Signed-off-by: Brian Masney <masneyb@onstation.org>

> > > > > +  - amstaos,prox_diode - must be TSL2772_DIODE0, TSL2772_DIODE1, or
> > > > > +                         TSL2772_DIODE_BOTH.
> > > >
> > > > s/_/-/
> > > >
> > > > > +  - amstaos,prox_power - must be TSL2772_100_mA, TSL2772_50_mA, TSL2772_25_mA,
> > > > > +                         or TSL2772_13_mA.
> > > >
> > > > I wonder if this should be common. Perhaps we should use the existing
> > > > 'led-max-microamp' as this is setting the current for an IR LED.
> > >
> > > Seems reasonable, then perhaps have two controls to turn on the diodes
> > > above.
> > >
> > > >
> > > > And while called 'power' this setting is current.
> > >
> > > Also can we have real values?  I really don't like defines if they
> > > aren't absolutely necessary - particularly when there is a nice real
> > > unit to be used.
> >
> > How about these options then?
> >
> > amstaos,proximity-diode-0-enabled;
> > amstaos,proximity-diode-1-enabled;
> > led-max-microamp = <100000>;
>
> Works for me.  Rob?

I think we're bikeshedding, but I'd prefer a single property though
perhaps as a list (0, 1, or <0 1>) or mask. A list would be similar to
the "led-sources" property format.

Rob
