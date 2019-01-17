Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974A0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB1720859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9QL1chh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfAQWCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:02:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33509 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfAQWB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:01:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so5374492plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 14:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tgyzZ2qn4CP49J0i8O3gsF/sy9CXNfB2Ncc6bGQio3k=;
        b=D9QL1chh5HqS2m6iVm2svhzJvsTUXRHJdyiXXH52luogDz6xTMtnjfiUl4UDquPl1r
         dGBOMSFeiSrixyskIPd/vCeoKl05VN8ETrMbpVtW6r8d/U8ne/LVs7tMbOkfaPfLMJJM
         ru3NcI+8tbJSq8ak47bt7qTP3ddAaq9rCjz+6RIn8gKr/BDM/L9eI0X/KU7vMso0hE93
         aGgNxh93Mhu5LgNIsOJeAr8av2/HVoE03YcROeeIngq9HKj8SLgUu7PsnOqwqLRP8T97
         FM9af68jaha3MnJub90m4DQoIieDKOtzeOWwdXvw+RCBjUMU5xGZ3qYurbzXqJSL5Pr8
         /A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tgyzZ2qn4CP49J0i8O3gsF/sy9CXNfB2Ncc6bGQio3k=;
        b=b6apFPDHgvj1HFEopF+f0GqnmvtzGAJ6CdO/IYR3u8SM489G92nadhY2edMghzQ3Kc
         z4dPxL2FzTNzJoonEyfB9CDsEUoWqI+v8K2sAPc7oyDlpnCgCpRIdIddbW7JpscHILV6
         3ffWJxRuqvxG9B0exbRbPVH1JOHLs82kNFhlZkoDu7b65XMXhhpXQgSCiq5xfvY2r8lx
         ilho6LUi/lraINvozivFZCrtQhd0D+jgwwOVY6vNhPSE8OmnuOMni2OPxhUmC+Crf1RS
         LXDqNjlRAdxl8BTaYv0aKrBn56a0lt49VWiRFgMc88CccTbLzCQyVzDmr2NNIVPwzTg0
         Fy6w==
X-Gm-Message-State: AJcUukfJ/xp434T0+qhK654VTl4mIOPT+yTxtfvlMJIouEAHY8qebU+F
        AoQTe9V3qM7aEa8ADaME8WE=
X-Google-Smtp-Source: ALg8bN60185tcgJcobq0wnFnKzsFgoqzuIQXioKN3JQLA+Wa7fxTEobEaKDK4r1fSy9JKVJjiBb3SA==
X-Received: by 2002:a17:902:2867:: with SMTP id e94mr16867120plb.264.1547762515663;
        Thu, 17 Jan 2019 14:01:55 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 24sm10314479pfl.32.2019.01.17.14.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 14:01:55 -0800 (PST)
Date:   Thu, 17 Jan 2019 14:01:52 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] ASoC: imx-sgtl5000: lower log level for potential
 probe deferral cases
Message-ID: <20190117220152.GC16918@Asurada-Nvidia.nvidia.com>
References: <20190117090640.12972-1-stefan@agner.ch>
 <20190117090640.12972-5-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117090640.12972-5-stefan@agner.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 10:06:40AM +0100, Stefan Agner wrote:
> Not finding the codec/SSI instance can be due to probe deferral.
> Do not print error messages in those cases.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/imx-sgtl5000.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index 45969e6dfad7..b6cb80480b60 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -104,13 +104,13 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  
>  	ssi_pdev = of_find_device_by_node(ssi_np);
>  	if (!ssi_pdev) {
> -		dev_err(&pdev->dev, "failed to find SSI platform device\n");
> +		dev_dbg(&pdev->dev, "failed to find SSI platform device\n");
>  		ret = -EPROBE_DEFER;
>  		goto fail;
>  	}
>  	codec_dev = of_find_i2c_device_by_node(codec_np);
>  	if (!codec_dev) {
> -		dev_err(&pdev->dev, "failed to find codec platform device\n");
> +		dev_dbg(&pdev->dev, "failed to find codec platform device\n");
>  		ret = -EPROBE_DEFER;
>  		goto fail;
>  	}
> -- 
> 2.20.1
> 
