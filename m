Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D186BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975C82086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fRpjW4u6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975C82086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbeK0VzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:55:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35699 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbeK0VzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:55:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so22212520wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L1Z7YTA6x/xzyt+ShupwiuCkWyAwa1/XgCcPq78pEww=;
        b=fRpjW4u6KVh3CECuuQ5yBkehuBBlSwJFVyiZ685oaLUQk5SM2bSZs1ICn+KGryT0Ds
         12rQfJSndlhEaP+dlN3nxfFrpW4ShmaZ9bSgoKCqDem2YF364L401Vy0LRU8CfmYLBwL
         5vGfZn2yFXHb7mXZ3263tFYR2NssTt5qgp950=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L1Z7YTA6x/xzyt+ShupwiuCkWyAwa1/XgCcPq78pEww=;
        b=pduZ8CxpJq3obpfRlLX/5QHTCvtBYK8dAprgzJ0tbu5jVppc5xBM9P3V868Zp0GsQy
         aQ6OtYLRKYUmbO0ep1YVjx1paTCF4/3ojdKcHa/bqexaBUBGEBB9pZI8bJGOz/o+CQY/
         Ula1KU6nC5JeqkfKEaOjCeoE4bl6n8FAsq7x+j0htcszFcRilmO7YpcOgbOWfv3mExu/
         tFGzuKbsRl4/R63Wr4Bdoj7SSoCA6p5Qd/jUJ5zJDFx5ivCESr4kJpX5AMIyMrJsG9hd
         MhljK2XPDrDQ8p7r9G6fWyR405z3ZD/ilNXAKCu52CVFLVj8Fk5UDzmrZT6uosBtGxpc
         x67Q==
X-Gm-Message-State: AA+aEWZl3j5zc8SvDZWsonipMY0QbBuGihMVsyHhr0fMTLQoKE+1bpWp
        cXM2/qsQkFn18byN9t+T+/D2aQ==
X-Google-Smtp-Source: AFSGD/WIgQ74uVrPuIXGbQzDdT1rf26UD/bJLoMuzNEq8w2CUFPrb7tRy/yi+aOxNGggIiYL4f9Zow==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr26524987wrs.281.1543316256612;
        Tue, 27 Nov 2018 02:57:36 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a17sm4900963wrs.58.2018.11.27.02.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 02:57:35 -0800 (PST)
Date:   Tue, 27 Nov 2018 10:57:33 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathan@marek.ca, ctatlor97@gmail.com
Subject: Re: [PATCH 2/2] backlight: lm3630a: add backlight driver match_table
Message-ID: <20181127105733.5t275fixa3utnkaz@holly.lan>
References: <20181124141703.29232-1-masneyb@onstation.org>
 <20181124141703.29232-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181124141703.29232-2-masneyb@onstation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 09:17:03AM -0500, Brian Masney wrote:
> From: Jonathan Marek <jonathan@marek.ca>
> 
> Add device tree support to the lm3630a driver.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> [masneyb@onstation.org: checkpatch fixes; add 'a' to compatible string]
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> This is part of upstreaming various components of the LG Nexus 5
> (hammerhead) phone.
> 
>  drivers/video/backlight/lm3630a_bl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index 2030a6b77a09..159d4013d9c2 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -470,11 +470,18 @@ static const struct i2c_device_id lm3630a_id[] = {
>  	{}
>  };

Similar to my reply to the DT bindings: I would have expected there
to be code to handle DT properties here.


Daniel.



>  
> +static const struct of_device_id lm3630a_match_table[] = {
> +	{ .compatible = "ti,lm3630a", },
> +	{ },
> +};
> +
> +
>  MODULE_DEVICE_TABLE(i2c, lm3630a_id);
>  
>  static struct i2c_driver lm3630a_i2c_driver = {
>  	.driver = {
>  		   .name = LM3630A_NAME,
> +		   .of_match_table = lm3630a_match_table,
>  		   },
>  	.probe = lm3630a_probe,
>  	.remove = lm3630a_remove,
> -- 
> 2.17.2
> 
