Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F3C13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397A220870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a0xxq581"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397A220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbeG3PuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:50:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35764 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731600AbeG3PuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:50:19 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so14024953wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 07:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n3eJlqfm7xqMB5Btksh9Lv/pCCHQqbI9bADbWEs/zl8=;
        b=a0xxq581SJ+pyB6F/V2s8vCC/9qvhMiPA9vTvLDVJAhR2pXBX5OV3i6y5rNjrmkaYY
         j0aR4D5nUNp3lHcIV5w9b6r6mqgsFPukICB1sq643ydPOLXUxIuC0MKFvpnnZQPu5nj7
         mPyPXsjuLX7Q6b2tg0Z/khVcyd99i0tzRl734=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n3eJlqfm7xqMB5Btksh9Lv/pCCHQqbI9bADbWEs/zl8=;
        b=X9ysZ1Kak2qX/Gmp3pF1Dm179lamkHL215g74Fa9fA3tKsOxxPs9+biqvEIbEZt8TI
         X8PgH6RONnGEt7WRQAMqAggohaBeiXbPMnf7/43eRDUbFT74k3+ttzVpdL2Ag0Tpk9rj
         PO9IXG+NFIZZnHxgkpSyNS0ufbMxXOjrErD0xzH0vTgw2Px3EBJd3qWjcVt1z1JKIu5n
         dg0Mne9TL//JSUCo2LLJurfSiBT3aemlgLtkzqiMilCPOaN86BpbvGvZCOOO37SUaHvN
         Ax/OkRicxxnhB4wloI9zgbqnldu3Q8Uud+BLA/AbvhWaJcpNog/KjHzbGZvED3WzXEzY
         re+Q==
X-Gm-Message-State: AOUpUlGe3KkzGF3KOzFEe3nffN6lzAU+UWXT8WKzUANaiRF012T3cyfN
        7d0XtKAGhIkx81O4FF1n8FyfsbxsRdQ=
X-Google-Smtp-Source: AAOMgpehu5Rdu2EefTB8LhXttO3uOa9IcjvDfrxiwRUIGcIdbnpCXn8vpjrjTIBbfb6c9ZQsr1UtdA==
X-Received: by 2002:a1c:15ce:: with SMTP id 197-v6mr14674187wmv.99.1532960105198;
        Mon, 30 Jul 2018 07:15:05 -0700 (PDT)
Received: from [192.168.0.22] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id z11-v6sm25192251wrm.94.2018.07.30.07.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 07:15:04 -0700 (PDT)
Subject: Re: [PATCH] thermal: armada: fix incorrect check for drvdata
 allocation failure
To:     Colin King <colin.king@canonical.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180730122716.6267-1-colin.king@canonical.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cad2f4c3-77c1-c233-975d-ed72fd640163@linaro.org>
Date:   Mon, 30 Jul 2018 16:14:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730122716.6267-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Colin,

On 30/07/2018 14:27, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the drvdata allocation failure is being incorrectly checked by
> checking priv and not drvdata.  Fix this and also free priv to fix a
> memory leak.
> 
> Detected by Coverity Scan, CID#1472102 ("Logically dead code")
> 
> Fixes: c9899c183921 ("thermal: armada: use the resource managed registration helper alternative")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/thermal/armada_thermal.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 4164a5a4e480..b164fd9f21ac 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -611,8 +611,10 @@ static int armada_thermal_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> -	if (!priv)
> +	if (!drvdata) {
> +		devm_kfree(&pdev->dev, priv);

This is not necessary, resources will be free when the driver is
destroyed after the probe fails.

>  		return -ENOMEM;
> +	}
>  
>  	priv->dev = &pdev->dev;
>  	priv->data = (struct armada_thermal_data *)match->data;

Thanks for sending this fix. However, another fix was already submitted
for this.

  -- Daniel




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

