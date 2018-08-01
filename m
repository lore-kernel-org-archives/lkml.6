Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A07C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE74620851
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iiSWCsWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE74620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbeHAFR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 01:17:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33069 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeHAFR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 01:17:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id r5-v6so10098681pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 20:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NiLJIOejr1FeSHP+QOHuAgF4C59c+gE0vXauyzxAcpM=;
        b=iiSWCsWgQflDJPMMDA/ZEQ0LDX5joy5Zjz5Z3qkoYLN9EsAOxX6Yi716gvRc++GVtp
         ZQkVIZLL/ltNNsep+VZIcFCZP9L+BQgh5OliV3dYarfJFo3DaWTKMi+dJX9gDDRZrglL
         W/gQGwvB67uU8ldiURb6b6YsFgT/qflJCnVJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NiLJIOejr1FeSHP+QOHuAgF4C59c+gE0vXauyzxAcpM=;
        b=ttjh5yqArJXUBlpAA1ID//NqF3++ocxOQJJ8DpCsgOvKZdX3/bOUU+inZiEyxzGwtF
         qupEbwViS5j5KYOPyNWGtvbPvzD5vfro5/V4PQtX+csGraIBpe3jRN2joL7IV305hVuL
         uSTfrYJlG2hQsDMMGPnUCxZsiHW7ikO80BtPrp82HnCeU2z0BUnZFY6SYSn3JCYNdOp5
         3IML0gvKTQWLLyVhegns3qcfTCP4Z2IhwA7ZQuBPayTuyXNpSRasRb5nB9/z+l4NLUzP
         +UwQ/jyabgur8zlErXIo2HsqC9MzQVNanoUshyZCK34ybLYVbxgAmj8FVDp3ovr28XpO
         PZ/w==
X-Gm-Message-State: AOUpUlFjAvVJhao4JaIQBlzOdtWdahARQfXPgyXrB5mFqfe0ogi86riu
        Wl/5NZVBwSMSq+5y6zMbIyGY
X-Google-Smtp-Source: AAOMgpdA3tBvHEdMalgYUQ127EQ82iR0UnCF7BusIDB4VJ0mRj1t8oBKxVblubnHI8ibDdmwXcHzDQ==
X-Received: by 2002:a65:5205:: with SMTP id o5-v6mr22889468pgp.108.1533094469578;
        Tue, 31 Jul 2018 20:34:29 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:730e:f0ae:ac4e:9cdd:28a2:4bf9])
        by smtp.gmail.com with ESMTPSA id h4-v6sm16701951pgp.13.2018.07.31.20.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 20:34:28 -0700 (PDT)
Date:   Wed, 1 Aug 2018 09:04:16 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, afaerber@suse.de,
        robh+dt@kernel.org, linux-clk@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, pn@denx.de, edgar.righi@lsitec.org.br,
        sravanhome@gmail.com
Subject: Re: [PATCH 7/9] clk: actions: Add Actions Semi Owl SoCs Reset
 Management Unit support
Message-ID: <20180801033416.GA15529@Mani-XPS-13-9360>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
 <20180727184527.13287-8-manivannan.sadhasivam@linaro.org>
 <1532946112.3471.2.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532946112.3471.2.camel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Mon, Jul 30, 2018 at 12:21:52PM +0200, Philipp Zabel wrote:
> Hi Manivannan,
> 
> Thank you for the patch, a few small comments below:
> 
> On Sat, 2018-07-28 at 00:15 +0530, Manivannan Sadhasivam wrote:
> > Add Reset Management Unit (RMU) support for Actions Semi Owl SoCs.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/clk/actions/Kconfig      |  1 +
> >  drivers/clk/actions/Makefile     |  1 +
> >  drivers/clk/actions/owl-common.h |  2 +
> >  drivers/clk/actions/owl-reset.c  | 72 ++++++++++++++++++++++++++++++++
> >  drivers/clk/actions/owl-reset.h  | 32 ++++++++++++++
> >  5 files changed, 108 insertions(+)
> >  create mode 100644 drivers/clk/actions/owl-reset.c
> >  create mode 100644 drivers/clk/actions/owl-reset.h
> > 
> > diff --git a/drivers/clk/actions/Kconfig b/drivers/clk/actions/Kconfig
> > index dc38c85a4833..04f0a6355726 100644
> > --- a/drivers/clk/actions/Kconfig
> > +++ b/drivers/clk/actions/Kconfig
> > @@ -2,6 +2,7 @@ config CLK_ACTIONS
> >  	bool "Clock driver for Actions Semi SoCs"
> >  	depends on ARCH_ACTIONS || COMPILE_TEST
> >  	select REGMAP_MMIO
> > +	select RESET_CONTROLLER
> >  	default ARCH_ACTIONS
> >  
> >  if CLK_ACTIONS
> > diff --git a/drivers/clk/actions/Makefile b/drivers/clk/actions/Makefile
> > index 78c17d56f991..ccfdf9781cef 100644
> > --- a/drivers/clk/actions/Makefile
> > +++ b/drivers/clk/actions/Makefile
> > @@ -7,6 +7,7 @@ clk-owl-y			+= owl-divider.o
> >  clk-owl-y			+= owl-factor.o
> >  clk-owl-y			+= owl-composite.o
> >  clk-owl-y			+= owl-pll.o
> > +clk-owl-y			+= owl-reset.o
> >  
> >  # SoC support
> >  obj-$(CONFIG_CLK_OWL_S700)	+= owl-s700.o
> > diff --git a/drivers/clk/actions/owl-common.h b/drivers/clk/actions/owl-common.h
> > index 56f01f7774aa..4dc7f286831f 100644
> > --- a/drivers/clk/actions/owl-common.h
> > +++ b/drivers/clk/actions/owl-common.h
> > @@ -26,6 +26,8 @@ struct owl_clk_desc {
> >  	struct owl_clk_common		**clks;
> >  	unsigned long			num_clks;
> >  	struct clk_hw_onecell_data	*hw_clks;
> > +	struct owl_reset_map		*resets;
> 
> Could this be:
> 	const struct owl_reset_map	*resets;
> ?
> 

Ack.

> > +	unsigned long			num_resets;
> >  	struct regmap			*regmap;
> >  };
> >  
> > diff --git a/drivers/clk/actions/owl-reset.c b/drivers/clk/actions/owl-reset.c
> > new file mode 100644
> > index 000000000000..91b161cc68de
> > --- /dev/null
> > +++ b/drivers/clk/actions/owl-reset.c
> > @@ -0,0 +1,72 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +//
> > +// Actions Semi Owl SoCs Reset Management Unit driver
> > +//
> > +// Copyright (c) 2018 Linaro Ltd.
> > +// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > +
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> 
> This seems unnecessary, since register access is done via regmap.
> 

Will remove this header.

> > +#include <linux/regmap.h>
> > +#include <linux/reset-controller.h>
> > +
> > +#include "owl-reset.h"
> > +
> > +static int owl_reset_assert(struct reset_controller_dev *rcdev,
> > +			    unsigned long id)
> > +{
> > +	struct owl_reset *reset = to_owl_reset(rcdev);
> > +	const struct owl_reset_map *map = &reset->reset_map[id];
> > +	u32 reg;
> > +
> > +	regmap_read(reset->regmap, map->reg, &reg);
> > +	regmap_write(reset->regmap, map->reg, reg & ~map->bit);
> 
> This read-modify-write sequence needs locking against concurrent
> register access. Better use regmap_update_bits():
> 
> 	return regmap_update_bits(reset->regmap, map->reg, map->bit, 0);
> 

Ack.

> > +
> > +	return 0;
> > +}
> > +
> > +static int owl_reset_deassert(struct reset_controller_dev *rcdev,
> > +			      unsigned long id)
> > +{
> > +	struct owl_reset *reset = to_owl_reset(rcdev);
> > +	const struct owl_reset_map *map = &reset->reset_map[id];
> > +	u32 reg;
> > +
> > +	regmap_read(reset->regmap, map->reg, &reg);
> > +	regmap_write(reset->regmap, map->reg, reg | map->bit);
> 
> Better:
> 
> 	return regmap_update_bits(reset->regmap, map->reg, map->bit, map->bit);
> 

Ack.

> > +
> > +	return 0;
> > +}
> > +
> > +static int owl_reset_reset(struct reset_controller_dev *rcdev,
> > +			   unsigned long id)
> > +{
> > +	owl_reset_assert(rcdev, id);
> > +	udelay(1);
> 
> Is the delay valid for all IP cores on all SoCs variants?
> 

It is valid for S900 and S700 for now but I'm not sure about S500. Will
make sure while adding S500 support.

> > +	owl_reset_deassert(rcdev, id);
> > +
> > +	return 0;
> > +}
> > +
> > +static int owl_reset_status(struct reset_controller_dev *rcdev,
> > +			    unsigned long id)
> > +{
> > +	struct owl_reset *reset = to_owl_reset(rcdev);
> > +	const struct owl_reset_map *map = &reset->reset_map[id];
> > +	u32 reg;
> > +
> > +	regmap_read(reset->regmap, map->reg, &reg);
> 
> If this could return an error, better report it.
> 

Ack.

> > +
> > +	/*
> > +	 * The reset control API expects 0 if reset is not asserted,
> > +	 * which is the opposite of what our hardware uses.
> > +	 */
> > +	return !(map->bit & reg);
> > +}
> > +
> > +const struct reset_control_ops owl_reset_ops = {
> > +	.assert		= owl_reset_assert,
> > +	.deassert	= owl_reset_deassert,
> > +	.reset		= owl_reset_reset,
> > +	.status		= owl_reset_status,
> > +};
> > diff --git a/drivers/clk/actions/owl-reset.h b/drivers/clk/actions/owl-reset.h
> > new file mode 100644
> > index 000000000000..1a5e987ba99b
> > --- /dev/null
> > +++ b/drivers/clk/actions/owl-reset.h
> > @@ -0,0 +1,32 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +//
> > +// Actions Semi Owl SoCs Reset Management Unit driver
> > +//
> > +// Copyright (c) 2018 Linaro Ltd.
> > +// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > +
> > +#ifndef _OWL_RESET_H_
> > +#define _OWL_RESET_H_
> > +
> > +#include <linux/reset-controller.h>
> > +#include <linux/spinlock.h>
> 
> spinlock?
> 

Oops. Not needed, will remove that.

> > +
> > +struct owl_reset_map {
> > +	u16	reg;
> 
> Note that this will be aligned to 32-bits. If the intention was to save
> space, consider storing an u8 bit index instead of the mask.
> 

Better to change it to u32, no need of memory saving here :)

> > +	u32	bit;
> > +};
> > +
> > +struct owl_reset {
> > +	struct reset_controller_dev	rcdev;
> > +	struct owl_reset_map		*reset_map;
> 
> Could this be
> 	const struct owl_reset_map	*reset_map;
> ?
> 

Ack.

Thanks,
Mani

> > +	struct regmap			*regmap;
> > +};
> > +
> > +static inline struct owl_reset *to_owl_reset(struct reset_controller_dev *rcdev)
> > +{
> > +	return container_of(rcdev, struct owl_reset, rcdev);
> > +}
> > +
> > +extern const struct reset_control_ops owl_reset_ops;
> > +
> > +#endif /* _OWL_RESET_H_ */
> 
> regards
> Philipp
