Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB33C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFEC20847
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFEC20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbeH2Q5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:57:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42957 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeH2Q5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:57:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id l5so1216766edw.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 06:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3AcqTnFARe4eICo7el1vTmTxXOQFejt/7wWPIBDyQ1I=;
        b=XJ/3zx5/INJGncE1qSgwtrmJtDajbkGvNq22PIVHo9V16BDadaP6szykP0MhMLqNaD
         Pr3gFXtPRYRvSZFzAhOq1x5c57ovyxZzdUKTYLt/Iym775rbHDPgEhJhM4+v0wRUkfGc
         uFdhJQfQuHl8r+yBqoqCvTGejNF51jjlbvrLVYYSYvBMiv8mNBFJXPtdggyLkhyWGSLp
         PSq3dC37jNPuj0u6CWapbGsZ2B7Mb4thSgGSAtZrBqkoIFqI/Mqm0PLz875Lmi7lO0zG
         TGXY0Zx0BjdUyYsfFIUUSl/K8aOu1GfZ7BZeuF364LA3Uh3Qp/U+DJupDg3XIAAFSOUL
         iP2Q==
X-Gm-Message-State: APzg51B0jgTIARQtHLZX+qZWnfNnAOm/ejmVvglZKFb20j/N6xQMFAad
        IsjMcjEQHy3ViUyuEigK/TFaCQ==
X-Google-Smtp-Source: ANB0VdZ4is37Mwfvo9qCjfolprTX8kOiyYvu/xa383b1KJCXzl7y1b8cV0oKIaDyn634dnZXVr7NWA==
X-Received: by 2002:a50:a623:: with SMTP id d32-v6mr7431378edc.8.1535547641043;
        Wed, 29 Aug 2018 06:00:41 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id z19-v6sm2078364edd.77.2018.08.29.06.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 06:00:40 -0700 (PDT)
Subject: Re: [PATCH V4 4/4] video: simplefb: switch to use clk_bulk API to
 simplify clock operations
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        thor.thayer@linux.intel.com, linux-imx@nxp.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Boyd <sboyd@codeaurora.org>
References: <1535547100-25634-1-git-send-email-aisheng.dong@nxp.com>
 <1535547100-25634-5-git-send-email-aisheng.dong@nxp.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <66eb6870-3674-0fdb-f5fb-4915a76191f6@redhat.com>
Date:   Wed, 29 Aug 2018 15:00:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1535547100-25634-5-git-send-email-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29-08-18 14:51, Dong Aisheng wrote:
> Switching to use clk_bulk API to simplify clock operations.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Tested-by: Thor Thayer <thor.thayer@linux.intel.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> v3->v4:
>   * no changes
> v2->v3:
>   * fix a build warning on x86 platform due to a wrong
>     of the prototype of simplefb_clocks_enable
> v1->v2:
>   * switch to clk_bulk_get_all from of_clk_bulk_get_all
> ---
>   drivers/video/fbdev/simplefb.c | 66 ++++++++----------------------------------
>   1 file changed, 12 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index 9a9d748..ed9a4c8 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -182,7 +182,7 @@ struct simplefb_par {
>   #if defined CONFIG_OF && defined CONFIG_COMMON_CLK
>   	bool clks_enabled;
>   	unsigned int clk_count;
> -	struct clk **clks;
> +	struct clk_bulk_data *clks;
>   #endif
>   #if defined CONFIG_OF && defined CONFIG_REGULATOR
>   	bool regulators_enabled;
> @@ -214,37 +214,13 @@ static int simplefb_clocks_get(struct simplefb_par *par,
>   			       struct platform_device *pdev)
>   {
>   	struct device_node *np = pdev->dev.of_node;
> -	struct clk *clock;
> -	int i;
>   
>   	if (dev_get_platdata(&pdev->dev) || !np)
>   		return 0;
>   
> -	par->clk_count = of_clk_get_parent_count(np);
> -	if (!par->clk_count)
> -		return 0;
> -
> -	par->clks = kcalloc(par->clk_count, sizeof(struct clk *), GFP_KERNEL);
> -	if (!par->clks)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < par->clk_count; i++) {
> -		clock = of_clk_get(np, i);
> -		if (IS_ERR(clock)) {
> -			if (PTR_ERR(clock) == -EPROBE_DEFER) {
> -				while (--i >= 0) {
> -					if (par->clks[i])
> -						clk_put(par->clks[i]);
> -				}
> -				kfree(par->clks);
> -				return -EPROBE_DEFER;
> -			}
> -			dev_err(&pdev->dev, "%s: clock %d not found: %ld\n",
> -				__func__, i, PTR_ERR(clock));
> -			continue;
> -		}
> -		par->clks[i] = clock;
> -	}
> +	par->clk_count = clk_bulk_get_all(&pdev->dev, &par->clks);
> +	if ((par->clk_count < 0) && (par->clk_count == -EPROBE_DEFER))
> +		return -EPROBE_DEFER;
>   
>   	return 0;
>   }
> @@ -252,39 +228,21 @@ static int simplefb_clocks_get(struct simplefb_par *par,
>   static void simplefb_clocks_enable(struct simplefb_par *par,
>   				   struct platform_device *pdev)
>   {
> -	int i, ret;
> +	int ret;
> +
> +	ret = clk_bulk_prepare_enable(par->clk_count, par->clks);
> +	if (ret)
> +		dev_warn(&pdev->dev, "failed to enable clocks\n");

If clk_bulk_prepare_enable() fails, it leaves all clocks disabled,
so you should not set par->clks_enabled = true; then.

Otherwise this patch looks good.

Regards,

Hans



>   
> -	for (i = 0; i < par->clk_count; i++) {
> -		if (par->clks[i]) {
> -			ret = clk_prepare_enable(par->clks[i]);
> -			if (ret) {
> -				dev_err(&pdev->dev,
> -					"%s: failed to enable clock %d: %d\n",
> -					__func__, i, ret);
> -				clk_put(par->clks[i]);
> -				par->clks[i] = NULL;
> -			}
> -		}
> -	}
>   	par->clks_enabled = true;
>   }
>   
>   static void simplefb_clocks_destroy(struct simplefb_par *par)
>   {
> -	int i;
> -
> -	if (!par->clks)
> -		return;
> -
> -	for (i = 0; i < par->clk_count; i++) {
> -		if (par->clks[i]) {
> -			if (par->clks_enabled)
> -				clk_disable_unprepare(par->clks[i]);
> -			clk_put(par->clks[i]);
> -		}
> -	}
> +	if (par->clks_enabled)
> +		clk_bulk_disable_unprepare(par->clk_count, par->clks);
>   
> -	kfree(par->clks);
> +	clk_bulk_put_all(par->clk_count, par->clks);
>   }
>   #else
>   static int simplefb_clocks_get(struct simplefb_par *par,
> 
