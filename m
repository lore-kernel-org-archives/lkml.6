Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD637C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A9725447
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A9725447
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932477AbeGBBKm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:10:42 -0400
Received: from mx.socionext.com ([202.248.49.38]:9621 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932354AbeGBBKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:10:37 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 02 Jul 2018 10:10:36 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 455B618009A;
        Mon,  2 Jul 2018 10:10:36 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 2 Jul 2018 10:10:36 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id DCE0C403C7;
        Mon,  2 Jul 2018 10:10:35 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id A25BE12013D;
        Mon,  2 Jul 2018 10:10:35 +0900 (JST)
Date:   Mon, 02 Jul 2018 10:10:35 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] regulator: uniphier: add regulator driver for UniPhier SoC
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <20180629110341.GA6556@sirena.org.uk>
References: <1530260533-19415-3-git-send-email-hayashi.kunihiko@socionext.com> <20180629110341.GA6556@sirena.org.uk>
Message-Id: <20180702101034.23E8.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,
Thank you for your comments.

On Fri, 29 Jun 2018 12:03:41 +0100 <broonie@kernel.org> wrote:

> On Fri, Jun 29, 2018 at 05:22:13PM +0900, Kunihiko Hayashi wrote:
> 
> > +++ b/drivers/regulator/uniphier-regulator.c
> > @@ -0,0 +1,251 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Regulator controller driver for UniPhier SoC
> > + * Copyright 2018 Socionext Inc.
> > + * Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > + */
> 
> Please make the entire header a C++ comment so that it looks intentional
> rather than mixing C and C++ like this.

Okay, I'll rewrite it as a C++ comment.

> 
> > +static int uniphier_regulator_enable(struct regulator_dev *rdev)
> > +{
> > +	struct uniphier_regulator_priv *priv = rdev_get_drvdata(rdev);
> > +	u32 val;
> > +
> > +	val = readl_relaxed(priv->base + rdev->desc->enable_reg);
> > +	val &= ~rdev->desc->enable_mask;
> > +	val |= rdev->desc->enable_val;
> > +	writel_relaxed(val, priv->base + rdev->desc->enable_reg);
> > +
> > +	return 0;
> > +}
> 
> Could you use a MMIO regmap for this driver?  All the operations look
> like they're just straight up operations of the sort the standard
> helpers support them and it means the driver will be able to take
> advantage of any improvements the core makes for free.

Indeed. In this case, I can use a MMIO regmap and it's reasonable and
simply to use it.


> Otherwise this looks great, and the above two issues can be fixed as
> followup patches so I'll apply.

And more, as with uniphier_usb3_reset [1], I can reuse soc_data and
use clk_bulk in it. If it's no problem, I'll rewrite like that next.

[1] https://lkml.org/lkml/2018/6/29/183

Thank you,

---
Best Regards,
Kunihiko Hayashi


