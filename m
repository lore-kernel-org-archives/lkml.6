Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AEEECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F9E21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F9E21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeJSQPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:15:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55276 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbeJSQPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:15:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 159BD207A3; Fri, 19 Oct 2018 10:10:44 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8AE2220618;
        Fri, 19 Oct 2018 10:10:33 +0200 (CEST)
Date:   Fri, 19 Oct 2018 10:10:33 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-mtd@lists.infradead.org>, Rob Herring <robh@kernel.org>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Richard Weinberger <richard@nod.at>,
        Yixun Lan <yixun.lan@amlogic.com>,
        <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v5 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
Message-ID: <20181019101033.0a160506@bbrezillon>
In-Reply-To: <09f76f17-05c4-d9e0-0167-f68e224f00c4@amlogic.com>
References: <1539839345-14021-1-git-send-email-jianxin.pan@amlogic.com>
        <1539839345-14021-3-git-send-email-jianxin.pan@amlogic.com>
        <20181018213308.3f8a5279@bbrezillon>
        <09f76f17-05c4-d9e0-0167-f68e224f00c4@amlogic.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2018 15:29:05 +0800
Liang Yang <liang.yang@amlogic.com> wrote:

> > How about defining that the HW returns an array of __le64 instead and then
> > define the following macros which you can use after converting in the
> > CPU endianness
> > 
> > #define ECC_GET_PROTECTED_OOB_BYTE(x, y)	(((x) >> (8 * (1 + y)) & GENMASK(7, 0))
> > #define ECC_COMPLETE			BIT(31)
> > #define ECC_ERR_CNT(x)			(((x) >> 24) & GENMASK(5, 0))
> > 
> > (I'm not entirely sure the field positions are correct, but I'll let you
> > check that).
> >   
> ok. i think it should be:
> 
> #define ECC_GET_PROTECTED_OOB_BYTE(x, y)	(((x) >> (8 * y) &
> GENMASK(7, 0))
> 
> if x represents the u64 and y represents the index of the u64.

Absolutely.

> 
> 
> 
> >> +
> >> +#define PER_INFO_BYTE	(sizeof(struct meson_nfc_info_format))
> >> +
> >> +struct meson_nfc_nand_chip {
> >> +	struct list_head node;
> >> +	struct nand_chip nand;
> >> +	bool is_scramble;  
> > 
> > I think I already mentioned the NAND_NEED_SCRAMBLING flag []. Please
> > drop this field and test (chip->flags & NAND_NEED_SCRAMBLING) instead.
> >   
> em, i use NAND_NEED_SCRAMBLING and is_scramble is set:
> static int meson_nand_attach_chip(struct nand_chip *nand)
> {
> 	......
> 	meson_chip->is_scramble =
> 		(nand->options & NAND_NEED_SCRAMBLING) ? 1 : 0;
> 	......
> }

Why do you need to add a new field then? Just test
nand->options & NAND_NEED_SCRAMBLING directly or provide a helper
function that does that.
