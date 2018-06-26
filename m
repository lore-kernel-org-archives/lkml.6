Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD17C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0491325EB1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RnZ+LVBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0491325EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933810AbeFZJfH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:35:07 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46463 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932544AbeFZJfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:35:04 -0400
Received: by mail-lf0-f66.google.com with SMTP id v17-v6so9827216lfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wgSKiAEQPlmnWkW1XTvviyixUIC5QAnCfkk1fxVLggU=;
        b=RnZ+LVBIuQ9+IBPUr/7HDMEREBCvZ0A2/reb/t2BPR31qhehMM0xiFuqCFVdtddMqo
         chArgbxtmzhztY4azJqXYrNWKzjEzNl8i1Z5zG2DSpqxwQQ5fyLaXKv2tN1Lc6VhkkrK
         gy2Tav9L8iaFIYgFE2C1YOz6IF5vDKXLgUnFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wgSKiAEQPlmnWkW1XTvviyixUIC5QAnCfkk1fxVLggU=;
        b=UXsobbKiTmY4qJ0qRPIJ6/miwZC0Teuwl0C6rA0i+/Qwrv4y6pcSTq2ngou7QdgLiK
         lq8iUf8f+zQLMMBMnk6uiz8qbzazsbPEaWwj/81yE6AisHbe7d0vnZGjwHeABkCP59mO
         zRDsIAWFttTaWKiZWskXg+uvaFARcpO6BjTOCrw6iM7jTNXA1/w23U8G49OT/IU+aCiM
         ftWpxUHHzDyxNZoCgIsy7Iodtu4qB8umTWpdfQWa8YEgoi6wBLu+tiH9EcoVXqAAkcWf
         9+RbF6xaSGuHKOi7s6M7O2fAW+o9eF8Brt5CORS5qv1xi/jWXVSKZzuZpd9GpaIECYy9
         50GA==
X-Gm-Message-State: APt69E3e0euj69JqJ4drzA7dczI9xq+19OGpYurJkWGdM8NmJHTH9EfI
        T8o5NJOMkGRn1EVMGDrNYyyHKg==
X-Google-Smtp-Source: AAOMgpdzwrXqvDv5gVoPHx/gr5uL7D+LCKGRKzLN1lYW9b1oi6lr7oXXddo9Y00X6+qBp24+mcr9nQ==
X-Received: by 2002:a19:a302:: with SMTP id m2-v6mr672955lfe.5.1530005702863;
        Tue, 26 Jun 2018 02:35:02 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id l20-v6sm249429lfg.14.2018.06.26.02.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 02:35:02 -0700 (PDT)
Date:   Tue, 26 Jun 2018 11:35:00 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, tiwai@suse.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 07/12] ASoC: qdsp6: q6afe-dai: support dt based module
 loading
Message-ID: <20180626093500.GD25217@centauri.ideon.se>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
 <20180626092016.9296-8-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626092016.9296-8-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Tue, Jun 26, 2018 at 10:20:11AM +0100, Srinivas Kandagatla wrote:
> This patch uses new compatible string to make DT based module loading work.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6afe-dai.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
> index 5002dd05bf27..1d2e5013c121 100644
> --- a/sound/soc/qcom/qdsp6/q6afe-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
> @@ -1290,9 +1290,16 @@ static int q6afe_dai_dev_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id q6afe_dai_device_id[] = {
> +	{ .compatible = "qcom,q6afe-dais" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, q6afe_dai_device_id);
> +
>  static struct platform_driver q6afe_dai_platform_driver = {
>  	.driver = {
>  		.name = "q6afe-dai",
> +		.of_match_table = of_match_ptr(q6afe_dai_device_id),
>  	},
>  	.probe = q6afe_dai_dev_probe,
>  	.remove = q6afe_dai_dev_remove,
> -- 
> 2.16.2
> 
