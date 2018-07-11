Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842C0C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BFDD208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BFDD208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbeGKCdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:33:37 -0400
Received: from mx.socionext.com ([202.248.49.38]:15153 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732277AbeGKCdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:33:37 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 11 Jul 2018 11:31:36 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 98DDE60034;
        Wed, 11 Jul 2018 11:31:36 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 11 Jul 2018 11:31:36 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id F036D40382;
        Wed, 11 Jul 2018 11:31:35 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id BAA5912014A;
        Wed, 11 Jul 2018 11:31:35 +0900 (JST)
Date:   Wed, 11 Jul 2018 11:31:35 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] regulator: uniphier: add regulator driver for UniPhier SoC
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <20180710174451.GE8104@sirena.org.uk>
References: <1531186037-16630-3-git-send-email-hayashi.kunihiko@socionext.com> <20180710174451.GE8104@sirena.org.uk>
Message-Id: <20180711113134.497A.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, 10 Jul 2018 18:44:51 +0100 <broonie@kernel.org> wrote:

> On Tue, Jul 10, 2018 at 10:27:17AM +0900, Kunihiko Hayashi wrote:
> 
> > +static int uniphier_regulator_enable(struct regulator_dev *rdev)
> > +{
> > +	struct uniphier_regulator_priv *priv = rdev_get_drvdata(rdev);
> > +
> > +	return regmap_update_bits(priv->regmap, rdev->desc->enable_reg,
> > +				  rdev->desc->enable_mask,
> > +				  rdev->desc->enable_val);
> > +}
> 
> This is just regulator_enable_regmap() isn't it?  Same for disable,
> unless I'm missing something (which is possible).

Exactly, it's reasonable to replace this with the helper function.
I'll check and apply it.

> > +static int uniphier_regulator_is_enabled(struct regulator_dev *rdev)
> > +{
> > +	struct uniphier_regulator_priv *priv = rdev_get_drvdata(rdev);
> > +	unsigned int val;
> > +	int ret = -EINVAL;
> > +
> > +	regmap_read(priv->regmap, rdev->desc->enable_reg, &val);
> > +	val &= rdev->desc->enable_mask;
> > +
> > +	if (val == rdev->desc->enable_val)
> > +		ret = 1;
> > +	else if (val == rdev->desc->disable_val)
> > +		ret = 0;
> > +
> > +	return ret;
> > +}
> 
> This isn't *quite* regulator_is_enabled_regmap() as it explicitly checks
> if the disable value is set and errors otherwise which would be a good
> fix for that.  Could you do a patch for that?

Although I'm worried that the register have a value that is neither
enable_val or disable_val, the "is_enabled" function returns whether
the regulator is enabled or not, so I can apply regulator_is_enabled_regmap().
I'll apply it in v3.

Thank you,

---
Best Regards,
Kunihiko Hayashi


