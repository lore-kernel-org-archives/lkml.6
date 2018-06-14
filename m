Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 11847C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FA3208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5FA3208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754626AbeFNIDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:03:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42392 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752759AbeFNIDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:03:52 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 70D7B20734; Thu, 14 Jun 2018 10:03:50 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0DC6A20650;
        Thu, 14 Jun 2018 10:03:40 +0200 (CEST)
Date:   Thu, 14 Jun 2018 10:03:39 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Richard Weinberger <richard@sigma-star.at>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Philipp Rosenberger <p.rosenberger@linutronix.de>,
        Rob Herring <robh@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 0/3] mtd: rawnand: denali: add new clocks and improve
 setup_data_interface
Message-ID: <20180614100339.02f1ee04@bbrezillon>
In-Reply-To: <2214183.rYP2OkZajM@blindfold>
References: <1528953067-24324-1-git-send-email-yamada.masahiro@socionext.com>
        <CAK7LNASoV9nHTFax1nD_8pvkEjTzXkFpDFRf_xuoOnPPf9K23A@mail.gmail.com>
        <20180614093835.5c3bf426@bbrezillon>
        <2214183.rYP2OkZajM@blindfold>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018 10:02:12 +0200
Richard Weinberger <richard@sigma-star.at> wrote:

> Am Donnerstag, 14. Juni 2018, 09:38:35 CEST schrieb Boris Brezillon:
> > On Thu, 14 Jun 2018 16:29:59 +0900
> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >   
> > > Hi Richard,
> > > 
> > > 2018-06-14 16:25 GMT+09:00 Richard Weinberger <richard@sigma-star.at>:  
> > > > Masahiro,
> > > >
> > > > Am Donnerstag, 14. Juni 2018, 07:11:04 CEST schrieb Masahiro Yamada:    
> > > >>
> > > >> The ->setup_data_interface() hook needs to know the clock frequency.
> > > >> In fact, this IP needs three clocks, bus "which clock?" is really
> > > >> confusing.  (It is not described in the DT-binding at all.)
> > > >>
> > > >> This series adds more clocks.  In the new binding, three clocks
> > > >> are required: core clock, bus interface clock, ECC engine clock.
> > > >>
> > > >> This series also takes care of the backward compatibility by
> > > >> providing hardcoded values in case the new clocks are missing.
> > > >> So, existing DT should work.
> > > >>
> > > >>
> > > >> Changes in v2:
> > > >>   - Split patches into sensible chunks
> > > >>
> > > >> Masahiro Yamada (3):
> > > >>   mtd: rawnand: denali_dt: use dev as a shorthand of &pdev->dev
> > > >>   mtd: rawnand: denali_dt: add more clocks based on IP datasheet
> > > >>   mtd: rawnand: denali: optimize timing parameters for data interface    
> > > >
> > > > This still means that we need to feed at least 2/3 and 3/3 into -stable to
> > > > unbreak the driver.    
> > > 
> > > 
> > > 3/3 is not mandatory.
> > > 
> > > You can only back-port 1/3 and 2/3.  
> > 
> > Well, patch 1 is not a fix, can we move it after patch 2 so that only
> > patch 2 is flagged with the Fixes+Cc-stable tags?  
> 
> Another question, shall we fix arch/arm/boot/dts/socfpga.dtsi too?

Yep.
