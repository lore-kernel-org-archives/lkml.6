Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AECCC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3D2267E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZWfzmTss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3D2267E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933955AbeFZJf0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:35:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41626 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932964AbeFZJfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:35:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id v12-v6so8256947ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eS+poQUaGu5RylKjDE47h2+a/AFOcSg/ZD8cHejxkfk=;
        b=ZWfzmTssMas7Avhfd6gfKNINmYUh972cpcDmu5FRPklK+8rloX/Nh/UobNyl7DhjvC
         FyWcskHW7qwqlhjrmgKTpY6luYmdgVwRffeVZNspQsuzRc3pZTQ3KzPmXWI6bXWO6PDX
         1IBSK8Wn63jtWSpJyVzw45HelPpA9q9WVrFQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eS+poQUaGu5RylKjDE47h2+a/AFOcSg/ZD8cHejxkfk=;
        b=L1Fsjjgy052gr0f/cvtrsHo9Ts9UuQoJl9gPgSzljKXRcDI/ZYGA1R5dz4vAiqTe9A
         j4G3SR95dz5yzb9dohHyTjpf0Dqtj+phPk7TTZE3IY22UYxrwQOeyjKmIenRIkZPnX3+
         6BBpAkcRq9AZJwUDH4JkCXOBfIw48aBwJUNfuMZPcDVRxHsnSAcV/2Dr+d+vPXNL0ixl
         X6FDUqkX+Auhll6m6Dhzhmwaos9YwDLyI5Px8YWDjQblxzaS2beSEKHgXQoo9mQNvw8o
         kRgZ9VvkO+CyrstPr3HGNdL7MwLoViPS4I0l8BW8cicI05th8ynBuK9Q+INtxr+OQxiG
         yPnQ==
X-Gm-Message-State: APt69E0RIGowXydJ/dh54s1hMV6B55aDgZ4hNgTUqNOWa1Zhkc4o/v/y
        kpNlVUxMnZRQhrKEDwi4Oe3PVg==
X-Google-Smtp-Source: AAOMgpdcwd2DWhaCmbXMdCVJK01+Gcg6+Vj8JlS42lVTJfBfFtNBwFoxz+DThbk7a4NFUm8e0hTxCg==
X-Received: by 2002:a2e:6f18:: with SMTP id k24-v6mr633899ljc.84.1530005723143;
        Tue, 26 Jun 2018 02:35:23 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id z184-v6sm242621lfd.82.2018.06.26.02.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 02:35:22 -0700 (PDT)
Date:   Tue, 26 Jun 2018 11:35:20 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, tiwai@suse.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/12] ASoC: qdsp6: q6asm-dai: support dt based module
 loading
Message-ID: <20180626093520.GE25217@centauri.ideon.se>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
 <20180626092016.9296-9-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626092016.9296-9-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Tue, Jun 26, 2018 at 10:20:12AM +0100, Srinivas Kandagatla wrote:
> This patch uses new compatible string to make DT based module loading work.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6asm-dai.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
> index 349c6a883c63..1196dc7483d2 100644
> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
> @@ -611,9 +611,16 @@ static int q6asm_dai_dev_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id q6asm_dai_device_id[] = {
> +	{ .compatible = "qcom,q6asm-dais" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, q6asm_dai_device_id);
> +
>  static struct platform_driver q6asm_dai_platform_driver = {
>  	.driver = {
>  		.name = "q6asm-dai",
> +		.of_match_table = of_match_ptr(q6asm_dai_device_id),
>  	},
>  	.probe = q6asm_dai_probe,
>  	.remove = q6asm_dai_dev_remove,
> -- 
> 2.16.2
> 
