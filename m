Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D73CC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D30208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D30208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934375AbeFRMSR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:18:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34896 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933501AbeFRMSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:18:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2212B207C2; Mon, 18 Jun 2018 14:18:13 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 722A620650;
        Mon, 18 Jun 2018 14:18:00 +0200 (CEST)
Date:   Mon, 18 Jun 2018 14:18:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        linux-kbuild@vger.kernel.org,
        "linux-stable #4 . 14+" <stable@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 1/3] mtd: rawnand: denali_dt: add more clocks based
 on IP datasheet
Message-ID: <20180618141800.2b8b9721@xps13>
In-Reply-To: <20180618094636.0e40c518@bbrezillon>
References: <1529025532-22087-1-git-send-email-yamada.masahiro@socionext.com>
        <1529025532-22087-2-git-send-email-yamada.masahiro@socionext.com>
        <5816516.AqyscFuYxX@blindfold>
        <20180618094636.0e40c518@bbrezillon>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Mon, 18 Jun 2018 09:46:36 +0200, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:

> On Mon, 18 Jun 2018 09:09:02 +0200
> Richard Weinberger <richard@nod.at> wrote:
> 
> > Am Freitag, 15. Juni 2018, 03:18:50 CEST schrieb Masahiro Yamada:  
> > > According to the Denali User's Guide, this IP needs three clocks:
> > > 
> > >  - clk: controller core clock
> > > 
> > >  - clk_x: bus interface clock
> > > 
> > >  - ecc_clk: clock at which ECC circuitry is run
> > > 
> > > Currently, denali_dt.c requires a single anonymous clock and its
> > > frequency.  However, the driver needs to get the frequency of "clk_x"
> > > not "clk".  This is confusing because people tend to assume the
> > > anonymous clock means the core clock.  In fact, I got a report of
> > > SOCFPGA breakage because the timing parameters are calculated based
> > > on a wrong frequency.
> > > 
> > > Instead of the cheesy implementation, the clocks in the real hardware
> > > should be represented in the driver and the DT-binding.
> > > 
> > > However, adding new clocks would break the existing platforms.  For the
> > > backward compatibility, the driver still accepts a single clock just as
> > > before.  If clk_x is missing, clk_x_rate is set to a hardcoded value.
> > > This is fine for existing DT of Socionext UniPhier, and also fixes the
> > > issue of Altera (Intel) SOCFPGA because both platforms use 200 MHz for
> > > the bus interface clock.
> > > 
> > > Fixes: 1bb88666775e ("mtd: nand: denali: handle timing parameters by setup_data_interface()")
> > > Cc: linux-stable <stable@vger.kernel.org> #4.14+
> > > Reported-by: Richard Weinberger <richard@nod.at>
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>    
> > 
> > Reviewed-by: Richard Weinberger <richard@nod.at>  
> 
> Maybe a
> 
> Tested-by: Richard Weinberger <richard@nod.at>
> 
> ?
> 
> > Reported-by: Philipp Rosenberger <p.rosenberger@linutronix.de>  
> 
> Should I replace your Reported-by by this one or simply add it?
> 
> Miquel, I'll take this patch in mtd/fixes, and let you take the 2
> others in nand/next. That means you'll have to back merge v4.18-rc2
> into the nand/next tree, or base your tree on v4.18-rc2 instead of
> v4.18-rc1.

Sure.

Miquèl
