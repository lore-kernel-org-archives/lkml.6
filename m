Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB64CC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952AF20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952AF20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeLJLiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:38:12 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58213 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbeLJLiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:38:12 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C1E1D2079D; Mon, 10 Dec 2018 12:38:09 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 420D02037D;
        Mon, 10 Dec 2018 12:38:09 +0100 (CET)
Date:   Mon, 10 Dec 2018 12:38:09 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
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
Message-ID: <20181210123809.5ade45c4@bbrezillon>
In-Reply-To: <823825a3-86fb-9a20-ae29-85cc52d44093@amlogic.com>
References: <1542386439-30166-1-git-send-email-jianxin.pan@amlogic.com>
        <1542386439-30166-3-git-send-email-jianxin.pan@amlogic.com>
        <20181207102456.1dc67e07@xps13>
        <823825a3-86fb-9a20-ae29-85cc52d44093@amlogic.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 19:23:46 +0800
Liang Yang <liang.yang@amlogic.com> wrote:

> >> +			mtd->ecc_stats.failed++;
> >> +			continue;
> >> +		}
> >> +		mtd->ecc_stats.corrected += ECC_ERR_CNT(*info);
> >> +		bitflips = max_t(u32, bitflips, ECC_ERR_CNT(*info));
> >> +	}  
> > 
> > Are you sure you handle correctly empty pages with bf?
> >   
> if scramble is enable, i would say yes here.
> when scramble is disabled, i am considering how to use the helper 
> nand_check_erased_ecc_chunk, but it seems that i can't get the ecc
> bytes which is caculated by ecc engine.by the way, nfc dma doesn't send 
> out the ecc parity bytes.

Even if the ECC engine is disabled?

> so i would suggest using scramble.
> 

No, please don't force people to use the scrambler.

> >> +
> >> +const void *
> >> +meson_nand_op_get_dma_safe_output_buf(const struct nand_op_instr *instr)
> >> +{
> >> +	if (WARN_ON(instr->type != NAND_OP_DATA_OUT_INSTR))
> >> +		return NULL;
> >> +
> >> +	if (virt_addr_valid(instr->ctx.data.buf.out) &&
> >> +	    !object_is_on_stack(instr->ctx.data.buf.out))  
> > 
> > Can you please create helpers for that? I guess it will help removing
> > these checks once the core will have a DMA-safe approach.
> >   
> I will use below definition:
> #define BUFFER_IS_DMA_SAFE(x)	\
> 	(virt_addr_valid((x)) && (!object_is_on_stack((x))))
> 
> Is it ok?

Please define a function, not a macro.
