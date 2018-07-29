Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4113FC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD8120870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD8120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbeG2WsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:48:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42690 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbeG2WsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:48:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D2892207AC; Sun, 29 Jul 2018 23:16:19 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5EC77206EE;
        Sun, 29 Jul 2018 23:16:19 +0200 (CEST)
Date:   Sun, 29 Jul 2018 23:16:19 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>,
        ext Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [RFC PATCH 7/8] mtd: rawnand: ams-delta: Check sanity of data
 GPIO resource
Message-ID: <20180729231422.0264f971@bbrezillon>
In-Reply-To: <CACRpkdZfiCN3U57s-7hGnbO9W-=pOjt0mL0w=Jv_+5WBdkEuig@mail.gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
        <20180718235710.18242-8-jmkrzyszt@gmail.com>
        <20180719084447.239a1b92@bbrezillon>
        <CACRpkdZfiCN3U57s-7hGnbO9W-=pOjt0mL0w=Jv_+5WBdkEuig@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jul 2018 22:36:49 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Thu, Jul 19, 2018 at 8:44 AM Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> 
> > I guess you'd prefer to have the pin values in a bitmap instead of an
> > array of integers. That's probably something you can discuss with
> > Linus, see if he would accept to change the prototype of
> > gpiod_get_raw_array_value().  
> 
> I am not so smart as to see the overall effects but if what
> you're saying is that we shouldn't have designed these functions
> and callbacks using arrays of integers (or longs) and instead
> pass bitmaps, you may be just right. It intuitively sounds better.

Maybe, maybe not. Only an real evaluation of where the overhead is can
tell us. So I'd suggest trying to use the existing interface and doing
the int_array -> u8 conversion in the NAND driver first, and see how
much moving to a bitmap imprsoves things.

> But I'm not good with bitmaps.
> 
> We would have to refactor the world though.

I checked and, AFAICT, there are no external users of this API (only
core code is using those funcs, for ioctls I guess). Anyway, I think
we should wait for real numbers before we consider doing this change
(It's not unusual to get this sort of things wrong).
