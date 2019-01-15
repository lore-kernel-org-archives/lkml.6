Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAA9C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156CF20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yp2ICKjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfAODPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:15:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43147 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfAODPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:15:46 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so591488pfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 19:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5l/bt4AI0XhkIfYKQvdqDGHqZfE1+hnzCEigPh5UV0s=;
        b=Yp2ICKjL45/4hcrnSUVNxxZUx11yZxxmoBNnfUdn8FcRxWoS/WMrn3VMrt5tsEnAlJ
         7a7ySAd6hVjedUZxKM2s7Ua+Rl+x//pwi7Btz48J0xaZeU7fTt22N5CUzSNVjM2hfTW/
         dWuRCu3oIeve3xxNo3U5Qw49fUQl9BersJ09c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5l/bt4AI0XhkIfYKQvdqDGHqZfE1+hnzCEigPh5UV0s=;
        b=cXQC/ofFYAz9X7/yVL9r+CWQp26CNyLbsBnLxI2ynMZnA8mMTnT+N9UXS31JZpVVqp
         80f1Y2ocMl7L0b0+fzs9OE7L3ZfPgD79zeol7fAEP9Y8wkWM6g3i/JUYPBHYxIzHhHEl
         BT9tzdE6tW0tcgdWC//E8MD9RADXlC678VC9akrdJlSfcpaVfv+W0OI97biw6LBqBe3c
         PNCgpJTdJU5ujhHv4wOzZ8BGrnPFPS7xjvqzXXBL8i/YasOvgi4lLvovfL56hmx6dXtl
         h/7l5GYT8FSpXg9Ie4WcBA8qjgJSom5cCO55j2Xd7WNqPIUqZKMrumYmvH6jxkGyqPUr
         v+jw==
X-Gm-Message-State: AJcUukcWs4TIVevNvZPHp8lG0BlvdzsYdhhOUcyROh0Hp9WozGZABtHz
        DvSz19Zch7efoH/ao2ZclKrj
X-Google-Smtp-Source: ALg8bN5DxfKUNNG2iVMusX/SzgTRIrg/5WvFAJ+89SBo7ndNuQh6dfQSJ/svahJSKHZyycB85MA5sA==
X-Received: by 2002:a63:4384:: with SMTP id q126mr1765140pga.160.1547522144570;
        Mon, 14 Jan 2019 19:15:44 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6084:4813:7cd6:42d1:f14c:3e90])
        by smtp.gmail.com with ESMTPSA id z62sm2208628pfl.33.2019.01.14.19.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 19:15:43 -0800 (PST)
Date:   Tue, 15 Jan 2019 08:45:35 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     afaerber@suse.de, mturquette@baylibre.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Subject: Re: [PATCH 5/6] clk: actions: Add clock driver for S500 SoC
Message-ID: <20190115031535.GA18089@Mani-XPS-13-9360>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
 <20181231185517.18517-6-manivannan.sadhasivam@linaro.org>
 <154725097174.169631.1773315055825741424@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154725097174.169631.1773315055825741424@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Jan 11, 2019 at 03:56:11PM -0800, Stephen Boyd wrote:
> Quoting Manivannan Sadhasivam (2018-12-31 10:55:16)
> > diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
> > new file mode 100644
> > index 000000000000..93feea8d71e2
> > --- /dev/null
> > +++ b/drivers/clk/actions/owl-s500.c
> > @@ -0,0 +1,524 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +//
> 
> Please make the reset of these the typical /* type of comments.
> 

Okay. I will do separate patchset for converting S700 and S900.

> > +// Actions Semi Owl S500 SoC clock driver
> > +//
> > +// Copyright (c) 2014 Actions Semi Inc.
> > +// Author: David Liu <liuwei@actions-semi.com>
> > +//
> > +// Copyright (c) 2018 Linaro Ltd.
> > +// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > +//
> > +// Copyright (c) 2018 LSI-TEC - Caninos Loucos
> > +// Author: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/platform_device.h>
> 
> I'm amazed nothing else is required to be included.
> 

Most of the generic includes are added in the local header files. But
yeah, we need to declare those here also. Will do it as an incremental
patchset.

> [..]
> > +#define CMU_NANDPLLDEBUG               (0x00E4)
> > +#define CMU_DISPLAYPLLDEBUG            (0x00E8)
> > +#define CMU_TVOUTPLLDEBUG              (0x00EC)
> > +#define CMU_DEEPCOLORPLLDEBUG          (0x00F4)
> > +#define CMU_AUDIOPLL_ETHPLLDEBUG       (0x00F8)
> > +#define CMU_CVBSPLLDEBUG               (0x00FC)
> > +
> > +#define OWL_S500_COREPLL_DELAY         (150)
> > +#define OWL_S500_DDRPLL_DELAY          (63)
> > +#define OWL_S500_DEVPLL_DELAY          (28)
> > +#define OWL_S500_NANDPLL_DELAY         (44)
> > +#define OWL_S500_DISPLAYPLL_DELAY      (57)
> > +#define OWL_S500_ETHERNETPLL_DELAY     (25)
> > +#define OWL_S500_AUDIOPLL_DELAY                (100)
> > +
> > +static const struct clk_pll_table clk_audio_pll_table[] = {
> > +       { 0, 45158400 }, { 1, 49152000 },
> > +       { 0, 0 },
> > +};
> > +
> > +/* pll clocks */
> > +static OWL_PLL_NO_PARENT_DELAY(ethernet_pll_clk, "ethernet_pll_clk", CMU_ETHERNETPLL, 500000000, 0, 0, 0, 0, 0, OWL_S500_ETHERNETPLL_DELAY, NULL, CLK_IGNORE_UNUSED);
> > +static OWL_PLL_NO_PARENT_DELAY(core_pll_clk, "core_pll_clk", CMU_COREPLL, 12000000, 9, 0, 8, 4, 134, OWL_S500_COREPLL_DELAY, NULL, CLK_IGNORE_UNUSED);
> > +static OWL_PLL_NO_PARENT_DELAY(ddr_pll_clk, "ddr_pll_clk", CMU_DDRPLL, 12000000, 8, 0, 8, 1, 67, OWL_S500_DDRPLL_DELAY, NULL, CLK_IGNORE_UNUSED);
> > +static OWL_PLL_NO_PARENT_DELAY(nand_pll_clk, "nand_pll_clk", CMU_NANDPLL, 6000000, 8, 0, 7, 2, 86, OWL_S500_NANDPLL_DELAY, NULL, CLK_IGNORE_UNUSED);
> > +static OWL_PLL_NO_PARENT_DELAY(display_pll_clk, "display_pll_clk", CMU_DISPLAYPLL, 6000000, 8, 0, 8, 2, 126, OWL_S500_DISPLAYPLL_DELAY, NULL, CLK_IGNORE_UNUSED);
> > +static OWL_PLL_NO_PARENT_DELAY(dev_pll_clk, "dev_pll_clk", CMU_DEVPLL, 6000000, 8, 0, 7, 8, 126, OWL_S500_DEVPLL_DELAY, NULL, CLK_IGNORE_UNUSED);
> > +static OWL_PLL_NO_PARENT_DELAY(audio_pll_clk, "audio_pll_clk", CMU_AUDIOPLL, 0, 4, 0, 1, 0, 0, OWL_S500_AUDIOPLL_DELAY, clk_audio_pll_table, CLK_IGNORE_UNUSED);
> > +
> > +static const char *dev_clk_mux_p[] = { "hosc", "dev_pll_clk" };
> 
> These can't be const char * const ?
> 

Ack.

> > +static const char *bisp_clk_mux_p[] = { "display_pll_clk", "dev_clk" };
> > +static const char *sensor_clk_mux_p[] = { "hosc", "bisp_clk" };
> > +static const char *sd_clk_mux_p[] = { "dev_clk", "nand_pll_clk" };
> > +static const char *pwm_clk_mux_p[] = { "losc", "hosc" };
> > +static const char *ahbprediv_clk_mux_p[] = { "dev_clk", "display_pll_clk", "nand_pll_clk", "ddr_pll_clk" };
> > +static const char *uart_clk_mux_p[] = { "hosc", "dev_pll_clk" };
> > +static const char *de_clk_mux_p[] = { "display_pll_clk", "dev_clk" };
> > +static const char *i2s_clk_mux_p[] = { "audio_pll_clk" };
> > +static const char *hde_clk_mux_p[] = { "dev_clk", "display_pll_clk", "nand_pll_clk", "ddr_pll_clk" };
> > +static const char *nand_clk_mux_p[] = { "nand_pll_clk", "display_pll_clk", "dev_clk", "ddr_pll_clk" };
> > +
> > +static struct clk_factor_table sd_factor_table[] = {
> 
> Can these tables be const?
> 

They can but sadly const will get discarded during assignments. I will
fix that in incremental patchset.

> > +       /* bit0 ~ 4 */
> > +       { 0, 1, 1 }, { 1, 1, 2 }, { 2, 1, 3 }, { 3, 1, 4 },
> > +       { 4, 1, 5 }, { 5, 1, 6 }, { 6, 1, 7 }, { 7, 1, 8 },
> > +       { 8, 1, 9 }, { 9, 1, 10 }, { 10, 1, 11 }, { 11, 1, 12 },
> > +       { 12, 1, 13 }, { 13, 1, 14 }, { 14, 1, 15 }, { 15, 1, 16 },
> > +       { 16, 1, 17 }, { 17, 1, 18 }, { 18, 1, 19 }, { 19, 1, 20 },
> > +       { 20, 1, 21 }, { 21, 1, 22 }, { 22, 1, 23 }, { 23, 1, 24 },
> > +       { 24, 1, 25 }, { 25, 1, 26 }, { 26, 1, 27 }, { 27, 1, 28 },
> > +       { 28, 1, 29 }, { 29, 1, 30 }, { 30, 1, 31 }, { 31, 1, 32 },
> > +
> > +       /* bit8: /128 */
> > +       { 256, 1, 1 * 128 }, { 257, 1, 2 * 128 }, { 258, 1, 3 * 128 }, { 259, 1, 4 * 128 },
> > +       { 260, 1, 5 * 128 }, { 261, 1, 6 * 128 }, { 262, 1, 7 * 128 }, { 263, 1, 8 * 128 },
> > +       { 264, 1, 9 * 128 }, { 265, 1, 10 * 128 }, { 266, 1, 11 * 128 }, { 267, 1, 12 * 128 },
> > +       { 268, 1, 13 * 128 }, { 269, 1, 14 * 128 }, { 270, 1, 15 * 128 }, { 271, 1, 16 * 128 },
> > +       { 272, 1, 17 * 128 }, { 273, 1, 18 * 128 }, { 274, 1, 19 * 128 }, { 275, 1, 20 * 128 },
> > +       { 276, 1, 21 * 128 }, { 277, 1, 22 * 128 }, { 278, 1, 23 * 128 }, { 279, 1, 24 * 128 },
> > +       { 280, 1, 25 * 128 }, { 281, 1, 26 * 128 }, { 282, 1, 27 * 128 }, { 283, 1, 28 * 128 },
> > +       { 284, 1, 29 * 128 }, { 285, 1, 30 * 128 }, { 286, 1, 31 * 128 }, { 287, 1, 32 * 128 },
> > +       { 0, 0, 0 },
> > +};
> > +
> > +static struct clk_factor_table bisp_factor_table[] = {
> > +       { 0, 1, 1 }, { 1, 1, 2 }, { 2, 1, 3 }, { 3, 1, 4 },
> > +       { 4, 1, 5 }, { 5, 1, 6 }, { 6, 1, 7 }, { 7, 1, 8 },
> > +       { 0, 0, 0 },
> > +};
> > +
> > +static struct clk_factor_table ahb_factor_table[] = {
> > +       { 1, 1, 2 }, { 2, 1, 3 },
> > +       { 0, 0, 0 },
> > +};
> > +
> > +static struct clk_div_table rmii_ref_div_table[] = {
> > +       { 0, 4 }, { 1, 10 },
> > +       { 0, 0 },
> > +};
> > +
> > +static struct clk_div_table i2s_div_table[] = {
> > +       { 0, 1 }, { 1, 2 }, { 2, 3 }, { 3, 4 },
> > +       { 4, 6 }, { 5, 8 }, { 6, 12 }, { 7, 16 },
> > +       { 8, 24 },
> > +       { 0, 0 },
> > +};
> > +
> > +static struct clk_div_table nand_div_table[] = {
> > +       { 0, 1 }, { 1, 2 }, { 2, 4 }, { 3, 6 },
> > +       { 4, 8 }, { 5, 10 }, { 6, 12 }, { 7, 14 },
> > +       { 8, 16 }, { 9, 18 }, { 10, 20 }, { 11, 22 },
> > +       { 0, 0 },
> > +};
> > +
> > +/* mux clock */
> > +static OWL_MUX(dev_clk, "dev_clk", dev_clk_mux_p, CMU_DEVPLL, 12, 1, CLK_SET_RATE_PARENT);
> > +static OWL_MUX(ahbprediv_clk, "ahbprediv_clk", ahbprediv_clk_mux_p, CMU_BUSCLK1, 8, 3, CLK_SET_RATE_PARENT);
> > +
> > +/* gate clocks */
> > +static OWL_GATE(spi0_clk, "spi0_clk", "ahb_clk", CMU_DEVCLKEN1, 10, 0, CLK_IGNORE_UNUSED);
> > +static OWL_GATE(spi1_clk, "spi1_clk", "ahb_clk", CMU_DEVCLKEN1, 11, 0, CLK_IGNORE_UNUSED);
> [...]
> > +               [CLK_HDMI]              = &hdmi_clk.common.hw,
> > +               [CLK_VDE]               = &vde_clk.common.hw,
> > +               [CLK_VCE]               = &vce_clk.common.hw,
> > +               [CLK_SPDIF]             = &spdif_clk.common.hw,
> > +               [CLK_NAND]              = &nand_clk.common.hw,
> > +               [CLK_ECC]               = &ecc_clk.common.hw,
> > +       },
> > +       .num = CLK_NR_CLKS,
> > +};
> > +
> > +static struct owl_clk_desc s500_clk_desc = {
> 
> This can't be const?
> 

Same as above.

Thanks,
Mani

> > +       .clks       = s500_clks,
> > +       .num_clks   = ARRAY_SIZE(s500_clks),
> > +
> > +       .hw_clks    = &s500_hw_clks,
> > +};
> > +
