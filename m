Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48126ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F4B2064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F4B2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbeGTUTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:19:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34826 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388180AbeGTUTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:19:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C326720717; Fri, 20 Jul 2018 21:29:23 +0200 (CEST)
Received: from bbrezillon (unknown [37.173.220.171])
        by mail.bootlin.com (Postfix) with ESMTPSA id DB43F2069C;
        Fri, 20 Jul 2018 21:29:11 +0200 (CEST)
Date:   Fri, 20 Jul 2018 21:29:10 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [RFC PATCH 3/8] mtd: rawnand: ams-delta: Set port direction
 once per transfer
Message-ID: <20180720212910.49bb2a88@bbrezillon>
In-Reply-To: <90128326.sKM4evrj8F@z50>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
        <20180718235710.18242-4-jmkrzyszt@gmail.com>
        <20180719082318.290abee1@bbrezillon>
        <90128326.sKM4evrj8F@z50>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 20:12:05 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> On Thursday, July 19, 2018 8:23:18 AM CEST Boris Brezillon wrote:
> > On Thu, 19 Jul 2018 01:57:05 +0200
> > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> >   
> > > In its current shape, the driver sets data port direction before each
> > > byte read/write operation, even during multi-byte transfers.  Optimize
> > > that by setting the port direction only on first byte of each transfer.  
> > 
> > Sounds like premature optimization for something you'll rework when
> > fully switching to the GPIO consumer API to control the DATA bus.  
> 
> Indeed, this optimization was crucial for getting acceptable performance of 
> data transfers over GPIO.  I'm only not sure if there is any action in 
> response to your comment expected on my side, e.g., did you want to say I 
> should modify the patch description, or change the order of patches?

I'm just saying that, since you switch to a solution that goes through
the GPIO framework to control the data bus, making sure the the pin
direction change is done only once when reading/writing several bytes is
something you can do after/when transitioning to the new approach.

So yes, I suggest to re-order patches, except that this patch won't
look the same at all if you move it after the "use the GPIO consumer
API to control data bus" patch.
