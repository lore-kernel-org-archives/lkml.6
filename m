Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DADC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E6D2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Np6rTVgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E6D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeLKQ2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:28:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36127 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeLKQ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:28:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id u3so14768347wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 08:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=f7K6GN5/aa8DCXT+gCMZwybLJkMHYSJQth2S97vanzo=;
        b=Np6rTVgqPxvJka6+7brT/Eim4w/Hd2CraROFW2i6SrUrrtDFf+5dxyKFNR3HTU+Zgt
         +vCWjDHnZGc+F2olDiYddyTEFyE/GNi7dXqazkNISskFklqX+tdSVgwQx266peIz9ct7
         ePiHh0fyp/cbKyR8yoQ4JWkKDUdxboWNTu/CO7Kbc+hPD0HikMWm5UZWPVkPYk6KshBt
         TVAN4io2nE8969uKqKTlM9HJeuZ9HHUQjRUln6G/cYZK4DZW7daog3ijzWsGzvI107jG
         echLmz0tB9thiCWCCAyAPjjj65fhYTyfmOvQecfFe+330PeTTAP6+VfsaquG/0Z/GKzF
         cpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=f7K6GN5/aa8DCXT+gCMZwybLJkMHYSJQth2S97vanzo=;
        b=LblpA5Ah9tM93hwDllq1RqnUuEE27joZdfvFtKLKjD2hxGtUjGpNjZShYVYhsQ1Lal
         zrnuOh5jOdHjgk2072Yf1QfGCYBsjkiPgi8FdW2Q9paqdnlhwgZID/LHiIuD5sFJwH4y
         VfTA+VGRoRZN29GGelkMGcNyyv2dR2HbpHLmK469h5FVe4XmJNki9u6u5UjpzN0/QL4n
         9t0S+1g3MrhI2ViESubtoy7zxG8a3GXuKbFKpOZFG3tQwl8z8Bk3JrN1iLLS7eJ+bNAO
         UPyd1D1s/czQSvYAG9cszp+Wlhhy3/5wZwIMVM/RDyGispkCWnxAQ2ZfoLGclTZAwUyE
         h6Fg==
X-Gm-Message-State: AA+aEWbRa/5vkUY5lFn925+k42zu5BHNqCRQER2M/0QET7HH6hDRvQ1l
        lxlADsaZFwmkXIxLW8QSCQ9XFA==
X-Google-Smtp-Source: AFSGD/UXMlaOEMcHHY+QljpOlM8+FZoMmIr7+8jsqKzy6aCccOZYqm9qFkRhYtZH8/ETWEHMRXDEXA==
X-Received: by 2002:adf:ce86:: with SMTP id r6mr14862307wrn.257.1544545683894;
        Tue, 11 Dec 2018 08:28:03 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id y34sm44330957wrd.68.2018.12.11.08.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 08:28:02 -0800 (PST)
Message-ID: <8e1c711b477eeee60809f33926cf9c6a52f530cd.camel@baylibre.com>
Subject: Re: [PATCH RESEND v7 1/4] clk: meson: add emmc sub clock phase
 delay driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Tue, 11 Dec 2018 17:28:00 +0100
In-Reply-To: <1544457877-51301-2-git-send-email-jianxin.pan@amlogic.com>
References: <1544457877-51301-1-git-send-email-jianxin.pan@amlogic.com>
         <1544457877-51301-2-git-send-email-jianxin.pan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-11 at 00:04 +0800, Jianxin Pan wrote:
> From: Yixun Lan <yixun.lan@amlogic.com>
> 
> Export the emmc sub clock phase delay ops which will be used
> by the emmc sub clock driver itself.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  drivers/clk/meson/Makefile          |  2 +-
>  drivers/clk/meson/clk-phase-delay.c | 64
> +++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/clkc.h            | 13 ++++++++
>  3 files changed, 78 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/meson/clk-phase-delay.c
> 
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 72ec8c4..39ce566 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for Meson specific clk
>  #
>  
> -obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o
> +obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o clk-
> phase-delay.o
>  obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o sclk-div.o
>  obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
> diff --git a/drivers/clk/meson/clk-phase-delay.c b/drivers/clk/meson/clk-
> phase-delay.c
> new file mode 100644
> index 0000000..84e7b63
> --- /dev/null
> +++ b/drivers/clk/meson/clk-phase-delay.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Amlogic Meson MMC Sub Clock Controller Driver
> + *
> + * Copyright (c) 2017 Baylibre SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Yixun Lan <yixun.lan@amlogic.com>
> + * Author: Jianxin Pan <jianxin.pan@amlogic.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include "clkc.h"
> +
> +static int meson_clk_phase_delay_get_phase(struct clk_hw *hw)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_clk_phase_delay_data *ph;
> +	unsigned long period_ps, p, d;
> +	int degrees;
> +
> +	ph = meson_clk_get_phase_delay_data(clk);
> +	p = meson_parm_read(clk->map, &ph->phase);
> +	degrees = p * 360 / (1 << (ph->phase.width));
> +
> +	period_ps = DIV_ROUND_UP(NSEC_PER_SEC * 1000,
> +				 clk_hw_get_rate(hw));
> +
> +	d = meson_parm_read(clk->map, &ph->delay);
> +	degrees += d * ph->delay_step_ps * 360 / period_ps;
> +	degrees %= 360;
> +
> +	return degrees;
> +}
> +
> +static int meson_clk_phase_delay_set_phase(struct clk_hw *hw, int degrees)
> +{
> +	struct clk_regmap *clk = to_clk_regmap(hw);
> +	struct meson_clk_phase_delay_data *ph;
> +	unsigned long period_ps, d = 0, r;
> +
> +	ph = meson_clk_get_phase_delay_data(clk);
> +	period_ps = DIV_ROUND_UP(NSEC_PER_SEC * 1000, clk_hw_get_rate(hw));
> +
> +	/*
> +	 * First compute the phase index (p), the remainder (r) is the
> +	 * part we'll try to acheive using the delays (d).
> +	 */
> +	r = do_div(degrees, 360 / 1 << (ph->phase.width));
> +	d = DIV_ROUND_CLOSEST(r * period_ps,
> +			      360 * ph->delay_step_ps);
> +	d = min(d, PMASK(ph->delay.width));
> +
> +	meson_parm_write(clk->map, &ph->phase, degrees);
> +	meson_parm_write(clk->map, &ph->delay, d);
> +	return 0;
> +}
> +
> +const struct clk_ops meson_clk_phase_delay_ops = {
> +	.get_phase = meson_clk_phase_delay_get_phase,
> +	.set_phase = meson_clk_phase_delay_set_phase,
> +};
> +EXPORT_SYMBOL_GPL(meson_clk_phase_delay_ops);
> diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
> index 6b96d55..30470c6 100644
> --- a/drivers/clk/meson/clkc.h
> +++ b/drivers/clk/meson/clkc.h
> @@ -105,6 +105,18 @@ struct clk_regmap _name = {				
> 		\
>  	},								\
>  };
>  
> +struct meson_clk_phase_delay_data {
> +	struct parm			phase;
> +	struct parm			delay;
> +	unsigned int			delay_step_ps;
> +};
> +
> +static inline struct meson_clk_phase_delay_data *
> +meson_clk_get_phase_delay_data(struct clk_regmap *clk)
> +{
> +	return clk->data;
> +}

This is only usefull in the related clock driver, no need to export it

> +
>  /* clk_ops */
>  extern const struct clk_ops meson_clk_pll_ro_ops;
>  extern const struct clk_ops meson_clk_pll_ops;
> @@ -112,5 +124,6 @@ struct clk_regmap _name = {				
> 		\
>  extern const struct clk_ops meson_clk_mpll_ro_ops;
>  extern const struct clk_ops meson_clk_mpll_ops;
>  extern const struct clk_ops meson_clk_phase_ops;
> +extern const struct clk_ops meson_clk_phase_delay_ops;
>  
>  #endif /* __CLKC_H */


