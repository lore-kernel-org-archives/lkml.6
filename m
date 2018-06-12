Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 45CA2C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019DA208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019DA208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933580AbeFLLDn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:03:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42368 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932476AbeFLLDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:03:41 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 691A320726; Tue, 12 Jun 2018 13:03:40 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0D83120719;
        Tue, 12 Jun 2018 13:03:30 +0200 (CEST)
Date:   Tue, 12 Jun 2018 13:03:29 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philipp Rosenberger <p.rosenberger@linutronix.de>,
        Richard Weinberger <richard@sigma-star.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 2/2] mtd: rawnand: denali: add more clocks
Message-ID: <20180612130329.1c17311f@bbrezillon>
In-Reply-To: <CAK7LNASM53scdd-OZOj_7404Eru3a98uNLagip_GdkrSSaG3-Q@mail.gmail.com>
References: <1528799515-1356-1-git-send-email-yamada.masahiro@socionext.com>
        <1528799515-1356-2-git-send-email-yamada.masahiro@socionext.com>
        <CAK7LNASM53scdd-OZOj_7404Eru3a98uNLagip_GdkrSSaG3-Q@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018 19:36:06 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Maybe, the commit title should be:
> 
> mtd: rawnand: denali: add more clocks and improve setup_data_interface

Or you split that in 2 commits, one retrieving the new clks, and the
other one fixing/improving ->setup_data_interface().

> 
> 
> 
> 2018-06-12 19:31 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> > According to the Denali User's Guide, this IP needs three clock inputs:
> >
> >  - clk: controller core clock
> >
> >  - clk_x: bus interface clock
> >
> >  - ecc_clk: clock at which ECC circuitry is run
> >
> > Currently, denali_dt.c requires a single anonymous clock and its
> > frequency.  However, the driver needs to get the frequency of "clk_x"
> > not "clk".  This is confusing because people tend to assume the
> > anonymous clock means the core clock.
> >
> > Instead of the cheesy implementation, the clocks in the real hardware
> > should be represented in the driver code and the DT-binding.
> >
> > I improved the ->setup_data_interface() hook as well.
> >
> > The denali_setup_data_interface() needs the frequency of clk_x
> > and the ratio of clk_x / clk.
> >
> > The latter is currently hardcoded in the driver, like this:
> >
> >   #define DENALI_CLK_X_MULT       6
> >
> > The IP datasheet specifies that clk_x / clk should be 4, 5, or 6.
> > I just chose 6 because it is the most defensive value, but it is not
> > very nice.  By getting the clock rate of both "clk" and "clk_x", the
> > driver can compute the timing values more precisely.
> >
> > Adding new clocks would break the existing platforms.  For the backward
> > compatibility, the driver still accepts the single clock just as before.
> > Also, ->clk_rate and ->clk_x_rate are set to hardcoded values if clk_x
> > is missing.
> >
> > It should work for all upstreamed platforms because Intel Moorestown,
> > Altera (Intel) SOCFPGA, Socionext UniPhier use the following clock
> > frequency:
> >
> >   clk = 50 MHz
> >   clk_x = ecc_clk = 200 MHz
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---  
> 
> 

