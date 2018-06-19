Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C172C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307532083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307532083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966208AbeFSKqQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:46:16 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:38096 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965360AbeFSKqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:46:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F17F460A356A;
        Tue, 19 Jun 2018 12:46:11 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id T_exIFqvl_YR; Tue, 19 Jun 2018 12:46:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 81BAF60A356B;
        Tue, 19 Jun 2018 12:46:11 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c1ZF_ZBwvMS3; Tue, 19 Jun 2018 12:46:11 +0200 (CEST)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 5F33B60A356A;
        Tue, 19 Jun 2018 12:46:11 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-stable #4 . 14+" <stable@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 1/3] mtd: rawnand: denali_dt: add more clocks based on IP datasheet
Date:   Tue, 19 Jun 2018 12:46:04 +0200
Message-ID: <2133216.znqypcnggC@blindfold>
In-Reply-To: <CAK7LNASCKhxtoOc3QdECF6p8BaBjab7Ed2y9Og+8LhvX4O83-Q@mail.gmail.com>
References: <1529025532-22087-1-git-send-email-yamada.masahiro@socionext.com> <20180618094636.0e40c518@bbrezillon> <CAK7LNASCKhxtoOc3QdECF6p8BaBjab7Ed2y9Og+8LhvX4O83-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 19. Juni 2018, 10:07:26 CEST schrieb Masahiro Yamada:
> Hi Boris,
> 
> 
> 2018-06-18 16:46 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> > On Mon, 18 Jun 2018 09:09:02 +0200
> > Richard Weinberger <richard@nod.at> wrote:
> >
> >> Am Freitag, 15. Juni 2018, 03:18:50 CEST schrieb Masahiro Yamada:
> >> > According to the Denali User's Guide, this IP needs three clocks:
> >> >
> >> >  - clk: controller core clock
> >> >
> >> >  - clk_x: bus interface clock
> >> >
> >> >  - ecc_clk: clock at which ECC circuitry is run
> >> >
> >> > Currently, denali_dt.c requires a single anonymous clock and its
> >> > frequency.  However, the driver needs to get the frequency of "clk_x"
> >> > not "clk".  This is confusing because people tend to assume the
> >> > anonymous clock means the core clock.  In fact, I got a report of
> >> > SOCFPGA breakage because the timing parameters are calculated based
> >> > on a wrong frequency.
> >> >
> >> > Instead of the cheesy implementation, the clocks in the real hardware
> >> > should be represented in the driver and the DT-binding.
> >> >
> >> > However, adding new clocks would break the existing platforms.  For the
> >> > backward compatibility, the driver still accepts a single clock just as
> >> > before.  If clk_x is missing, clk_x_rate is set to a hardcoded value.
> >> > This is fine for existing DT of Socionext UniPhier, and also fixes the
> >> > issue of Altera (Intel) SOCFPGA because both platforms use 200 MHz for
> >> > the bus interface clock.
> >> >
> >> > Fixes: 1bb88666775e ("mtd: nand: denali: handle timing parameters by setup_data_interface()")
> >> > Cc: linux-stable <stable@vger.kernel.org> #4.14+
> >> > Reported-by: Richard Weinberger <richard@nod.at>
> >> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >>
> >> Reviewed-by: Richard Weinberger <richard@nod.at>
> >
> > Maybe a
> >
> > Tested-by: Richard Weinberger <richard@nod.at>
> >
> > ?
> >
> >> Reported-by: Philipp Rosenberger <p.rosenberger@linutronix.de>
> >
> > Should I replace your Reported-by by this one or simply add it?

Philipp deserves the Reported-by. :)

> 
> I think it is good to have Reported-by
> both from Philipp and Richard.

Patch 1/3 unbreaks v4.14.x on my board.

Tested-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
