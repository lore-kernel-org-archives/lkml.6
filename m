Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E9DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 01:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36A8208C1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 01:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOjZhyXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbeLOBrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 20:47:40 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39489 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeLOBrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 20:47:40 -0500
Received: by mail-pg1-f195.google.com with SMTP id w6so3465969pgl.6;
        Fri, 14 Dec 2018 17:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TzfGt5gJofimzxV/+FAhN7Dc4mIJAhSYfyF+BnGPH0g=;
        b=cOjZhyXZfCAokPxhv7k00zi5qoamBGK1r2CYoDfpW87kBm0nrz9+CCugoIskU59umh
         CzXlxS/yDU2ZwO3R14VJkBa0MtB5tIPwLLCXKu+6nfIgOGGJzBx+WhAhD2KpkjyQpCnn
         0lkzI1Y7ENg/lPiQavGCttcvQ3StQlpkb3UhbWosOyo20DQuyh4Owi6ONYBsSnAlxgPt
         fx7pyxlzSYyNukY3WUeJjfenewf2tsJTLhzIodtGVD3CQ+1CypHI8TIo7MhH9q8Jsqki
         yd54z3pxSAIY6OompjeHaAvT4oCRfTWVEhxLAs1E8tmFKQFAyqkD8boJ7KXI8Tq0cCz4
         jerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TzfGt5gJofimzxV/+FAhN7Dc4mIJAhSYfyF+BnGPH0g=;
        b=DevFdVZO5/AMUlFytyBCo+nc5VAnMcw1XwpgaCcKPxH4YhEqvKpLIujX9opd8yxp4h
         4ATd9Pebbs0HR+8RtOTJWtuq/FoWunyEZYJkQRvuGJ8L12RProg5SVLM3CRWusWPMkgG
         u+zR+I9nbF4q6l6htFAFeH+zgn0U6hMQctxmVFGJMk1m/8d7V93xi+qHvWYY2Oh9g+JD
         OWvutduQ9xIxuVbAZ0JeyGsNGKBbsn9etqFPh1RI0jPGF2uxSOLknMAR3sliYcwhdtIZ
         s0uluUuk0PvmUkQI1k2WtQ/zDwooG/7+o8Zc3oSrI4aigqHNlvX320QQDRgkt/6tpoDK
         EkBA==
X-Gm-Message-State: AA+aEWa1mcohXY/KJhsMIDJQDfyIgZzCff2VmziesLY6jkc8s0OebtvH
        +PGO+AqH2nMNipCFfiQ2fGM=
X-Google-Smtp-Source: AFSGD/Wbh8uz18SAZt9axHooUikpQWfT4I0ZpQjPUVfZICbIfybkrF3FiEULWbGalgAO+Hy2txzqmg==
X-Received: by 2002:a62:64d7:: with SMTP id y206mr4996281pfb.84.1544838458911;
        Fri, 14 Dec 2018 17:47:38 -0800 (PST)
Received: from localhost.localdomain ([73.93.152.175])
        by smtp.gmail.com with ESMTPSA id w136sm9687953pfd.169.2018.12.14.17.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 17:47:37 -0800 (PST)
Date:   Fri, 14 Dec 2018 17:47:34 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] thermal: stm32: read factory settings inside
 stm_thermal_prepare
Message-ID: <20181215014732.GA24528@localhost.localdomain>
References: <1544102603-14899-1-git-send-email-david.hernandezsanchez@st.com>
 <1544102603-14899-2-git-send-email-david.hernandezsanchez@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544102603-14899-2-git-send-email-david.hernandezsanchez@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Dec 06, 2018 at 01:23:32PM +0000, David HERNANDEZ SANCHEZ wrote:
> Calling stm_thermal_read_factory_settings before clocking
> internal peripheral causes bad register values and makes
> temperature computation wrong.
> 
> Calling stm_thermal_read_factory_settings inside
> stm_thermal_prepare fixes this problem as internal
> peripheral is well clocked at this stage.
> 
> Signed-off-by: David Hernandez Sanchez <david.hernandezsanchez@st.com>
> Fixes: 1d693155 ("thermal: add stm32 thermal driver")

Please append patch version in the title next time to help tracking it.

> 
> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
> index 47623da..daa1257 100644
> --- a/drivers/thermal/st/stm_thermal.c
> +++ b/drivers/thermal/st/stm_thermal.c
> @@ -532,6 +532,10 @@ static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
>  	if (ret)
>  		return ret;
>  
> +	ret = stm_thermal_read_factory_settings(sensor);
> +	if (ret)
> +		goto thermal_unprepare;
> +
>  	ret = stm_thermal_calibration(sensor);
>  	if (ret)
>  		goto thermal_unprepare;
> @@ -636,10 +640,6 @@ static int stm_thermal_probe(struct platform_device *pdev)
>  	/* Populate sensor */
>  	sensor->base = base;
>  
> -	ret = stm_thermal_read_factory_settings(sensor);
> -	if (ret)
> -		return ret;
> -
>  	sensor->clk = devm_clk_get(&pdev->dev, "pclk");
>  	if (IS_ERR(sensor->clk)) {
>  		dev_err(&pdev->dev, "%s: failed to fetch PCLK clock\n",
> -- 
> 2.7.4
