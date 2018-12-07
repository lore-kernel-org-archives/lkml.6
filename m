Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BB7C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9F121479
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D9F121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeLGJnI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:43:08 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48635 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbeLGJnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:43:07 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1DE1D20731; Fri,  7 Dec 2018 10:43:05 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 922EA20711;
        Fri,  7 Dec 2018 10:42:54 +0100 (CET)
Date:   Fri, 7 Dec 2018 10:42:54 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        <linux-mtd@lists.infradead.org>,
        Liang Yang <liang.yang@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
Message-ID: <20181207104254.0ecfc1e5@xps13>
In-Reply-To: <20181207102456.1dc67e07@xps13>
References: <1542386439-30166-1-git-send-email-jianxin.pan@amlogic.com>
        <1542386439-30166-3-git-send-email-jianxin.pan@amlogic.com>
        <20181207102456.1dc67e07@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianxin,

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Fri, 7 Dec 2018
10:24:56 +0100:

> Hi Jianxin,
> 
> Looks good to me overall, a few comments inline.
> 
> Jianxin Pan <jianxin.pan@amlogic.com> wrote on Sat, 17 Nov 2018
> 00:40:38 +0800:
> 
> > From: Liang Yang <liang.yang@amlogic.com>
> > 
> > Add initial support for the Amlogic NAND flash controller which found
> > in the Meson-GXBB/GXL/AXG SoCs.
> > 
> > Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> > Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> > Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> > ---
> >  drivers/mtd/nand/raw/Kconfig      |   10 +
> >  drivers/mtd/nand/raw/Makefile     |    1 +
> >  drivers/mtd/nand/raw/meson_nand.c | 1417 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1428 insertions(+)
> >  create mode 100644 drivers/mtd/nand/raw/meson_nand.c
> > 

I forgot to mention, Boris has done more cleanup which breaks your
patches, please have a look at the following commits in the nand/next
branch, they will force you to do some light rework to get the driver
building (especially, you should not export the ->select_chip hook anymore):

7a08dbaedd36 mtd: rawnand: Move ->setup_data_interface() to nand_controller_ops
f2abfeb2078b mtd: rawnand: Move the ->exec_op() method to nand_controller_ops
7d6c37e90cf9 mtd: rawnand: Deprecate the ->select_chip() hook
1770022ffa85 mtd: rawnand: ams-delta: Stop implementing ->select_chip()
653c57c7da08 mtd: rawnand: vf610: Stop implementing ->select_chip()
2ace451cae22 mtd: rawnand: tegra: Stop implementing ->select_chip()
b25251414f6e mtd: rawnand: marvell: Stop implementing ->select_chip()
550b9fc4e3af mtd: rawnand: fsmc: Stop implementing ->select_chip()
02b4a52604a4 mtd: rawnand: Make ->select_chip() optional when ->exec_op() is implemented
ae2294b10b0f mtd: rawnand: Pass the CS line to be selected in struct nand_operation
1d0178593d14 mtd: rawnand: Add nand_[de]select_target() helpers

Thanks,
Miquèl
