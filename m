Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E03C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D12F20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D12F20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeKIVep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:34:45 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57711 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbeKIVeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:34:44 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gL5Mn-0000Cn-Ek; Fri, 09 Nov 2018 12:54:25 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gL5Mm-0003MA-K5; Fri, 09 Nov 2018 12:54:24 +0100
Date:   Fri, 9 Nov 2018 12:54:24 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] gpio: mockup: fix indicated direction
Message-ID: <20181109115424.pe4w26nmt6xplzto@pengutronix.de>
References: <20181108165255.9940-1-brgl@bgdev.pl>
 <20181108165255.9940-2-brgl@bgdev.pl>
 <20181108203546.54rncnydgamud5z3@pengutronix.de>
 <CAMRc=Mev6RMvVox2Sx6s80+obLg4QWAL=_hwcf34m2iMXwEbOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mev6RMvVox2Sx6s80+obLg4QWAL=_hwcf34m2iMXwEbOg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bartosz,

On Fri, Nov 09, 2018 at 12:13:44PM +0100, Bartosz Golaszewski wrote:
> czw., 8 lis 2018 o 21:35 Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> napisał(a):
> > On Thu, Nov 08, 2018 at 05:52:53PM +0100, Bartosz Golaszewski wrote:
> > > Commit 3edfb7bd76bd ("gpiolib: Show correct direction from the
> > > beginning") fixed an existing issue but broke libgpiod tests by
> > > changing the default direction of dummy lines to output.
> >
> > The indicated commit only changed what was shown in debugfs, but didn't
> > touch the actual direction of a GPIO, doesn't it? If someone called
> > gpiod_get_direction before it would have returned "output", too, unless
> > I miss something.
> >
> 
> This commit (3edfb7bd76bd) sets the correct direction of the line by
> actually calling get_direction() instead of assuming input if
> direction_input is not NULL. It just so happened that previously the
> default direction of gpio-mockup lines was output but it would be
> displayed as input due to this inconsistency.

Does the test that fails since 3edfb7bd76bd use debugfs/gpio to find out
the direction of a gpio? I'd say it's a bad idea to depend on this as
(AFAICT) debugfs is only a debug aid and you shouldn't depend on stuff
contained in it.

I'd weaken the commit log a bit to not claim that the commit broke
libgpiod but that it only made the inconsistency visible. After all this
commit didn't "change the default direction of dummy lines to output",
they were an output already before.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
