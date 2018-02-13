Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934482AbeBMJZX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:25:23 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35453 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933807AbeBMJYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:24:51 -0500
X-Google-Smtp-Source: AH8x224Y3iQy+Evc+XlAetGnukyrou3AHe2CC7CGjib3d0gEeRtsP6P7INU5RqDLLOl0MhkXfSm98Q==
Subject: Re: [PATCH v3 2/5] clk: mediatek: modify MT7622 audsys to adapt MFD
 device
To: Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Garlic Tseng <garlic.tseng@mediatek.com>
References: <cover.1518424204.git.ryder.lee@mediatek.com>
 <f8e87179bd7700130e294393592719fac8590c59.1518424204.git.ryder.lee@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <cb75cdaa-eb84-d01e-60bd-21a928ddc090@gmail.com>
Date: Tue, 13 Feb 2018 10:24:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f8e87179bd7700130e294393592719fac8590c59.1518424204.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/12/2018 12:28 PM, Ryder Lee wrote:
> As the new MFD device is in place, switch probing method to adapt it.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mt7622-aud.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
> index 13f752d..68c52a9 100644
> --- a/drivers/clk/mediatek/clk-mt7622-aud.c
> +++ b/drivers/clk/mediatek/clk-mt7622-aud.c
> @@ -142,11 +142,16 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
>  {
>  	struct clk_onecell_data *clk_data;
>  	struct device_node *node = pdev->dev.of_node;
> +	struct device_node *pnode = pdev->dev.parent->of_node;
>  	int r;
>  
>  	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
>  
> -	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
> +	/* Check if called from MFD */
> +	if (!pnode)
> +		pnode = node;

This is needed for backwards compatibility, correct?
Please change the comment accordingly. The same holds for mt2701 driver.

Thanks,
Matthias

> +
> +	mtk_clk_register_gates(pnode, audio_clks, ARRAY_SIZE(audio_clks),
>  			       clk_data);
>  
>  	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> 
