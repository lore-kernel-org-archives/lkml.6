Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511D8C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5A520882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5A520882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeGYN7C convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:59:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34034 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbeGYN7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:59:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A5D9C20765; Wed, 25 Jul 2018 14:47:27 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0DA26206A6;
        Wed, 25 Jul 2018 14:47:17 +0200 (CEST)
Date:   Wed, 25 Jul 2018 14:47:17 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mans Rullgard <mans@mansr.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Stefan Agner <stefan@agner.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Marek Vasut <marek.vasut@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Broadcom Kernel Feedback List 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Han Xu <han.xu@nxp.com>, Xiaolei Li <xiaolei.li@mediatek.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v4 04/35] mtd: rawnand: denali: convert to nand_scan()
Message-ID: <20180725144717.604d3197@xps13>
In-Reply-To: <20180725115116.1fb38fe3@bbrezillon>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
        <20180720151527.16038-5-miquel.raynal@bootlin.com>
        <CAK7LNASmJRWM7Gj9qqqZqwenPkoRFeA8tupx+3PKPXC6OxD_eA@mail.gmail.com>
        <20180725115116.1fb38fe3@bbrezillon>
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

Boris Brezillon <boris.brezillon@bootlin.com> wrote on Wed, 25 Jul 2018
11:51:16 +0200:

> On Wed, 25 Jul 2018 18:42:44 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> 
> > 
> > You need to remove kfree(denali->buf)
> > from denali_remove(), right?  
> 
> Absolutely.
> 
> > 
> > void denali_remove(struct denali_nand_info *denali)
> > {
> >         struct mtd_info *mtd = nand_to_mtd(&denali->nand);
> > 
> >         nand_release(mtd);
> >         kfree(denali->buf);       <---- REMOVE !!
> >         denali_disable_irq(denali);
> > }
> > 
> > 
> > Otherwise, denali_remove() will free denali->buf twice
> > because kfree(denali->buf) is called from denali_detach_chip().  
> 

Absolutely, thanks for reviewing!

I'll apply with this changed.

Miquèl
