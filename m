Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93714C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E1F20851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E1F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeLJOvB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:51:01 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37630 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbeLJOvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:51:00 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5EF5820CEB; Mon, 10 Dec 2018 15:50:58 +0100 (CET)
Received: from xps13 (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id E516320CE8;
        Mon, 10 Dec 2018 15:50:57 +0100 (CET)
Date:   Mon, 10 Dec 2018 15:50:57 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-mtd@lists.infradead.org>, Yixun Lan <yixun.lan@amlogic.com>,
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
Message-ID: <20181210155057.38788656@xps13>
In-Reply-To: <79a797c2-f37f-7f7c-e907-2d3c2283ec2d@amlogic.com>
References: <1542386439-30166-1-git-send-email-jianxin.pan@amlogic.com>
        <1542386439-30166-3-git-send-email-jianxin.pan@amlogic.com>
        <20181207102456.1dc67e07@xps13>
        <823825a3-86fb-9a20-ae29-85cc52d44093@amlogic.com>
        <20181210123809.5ade45c4@bbrezillon>
        <79a797c2-f37f-7f7c-e907-2d3c2283ec2d@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

Liang Yang <liang.yang@amlogic.com> wrote on Mon, 10 Dec 2018 20:12:39
+0800:

> On 2018/12/10 19:38, Boris Brezillon wrote:
> > On Mon, 10 Dec 2018 19:23:46 +0800
> > Liang Yang <liang.yang@amlogic.com> wrote:
> >   
> >>>> +			mtd->ecc_stats.failed++;
> >>>> +			continue;
> >>>> +		}
> >>>> +		mtd->ecc_stats.corrected += ECC_ERR_CNT(*info);
> >>>> +		bitflips = max_t(u32, bitflips, ECC_ERR_CNT(*info));
> >>>> +	}  
> >>>
> >>> Are you sure you handle correctly empty pages with bf?  
> >>>    >> if scramble is enable, i would say yes here.  
> >> when scramble is disabled, i am considering how to use the helper
> >> nand_check_erased_ecc_chunk, but it seems that i can't get the ecc
> >> bytes which is caculated by ecc engine.by the way, nfc dma doesn't send
> >> out the ecc parity bytes.  
> > 
> > Even if the ECC engine is disabled?
> >   
> No.
> When ECC engine is disabled, it can read the ecc parity bytes ; but there is another problem that i need to consider how code struct looks better when reading error with ecc opened and then try to raw read.
> Is there a good idea?

When reading with ECC enabled, in case of uncorrectable error you
must re-read without ECC, then check if the page is empty or not with
the core helpers (nand_check_erased_*()).

Is this what you meant?

Thanks,
Miquèl
