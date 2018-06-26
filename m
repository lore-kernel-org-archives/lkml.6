Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22EEC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C6E267E2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XY6nHcaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C6E267E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934041AbeFZJfo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:35:44 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38464 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933593AbeFZJfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:35:42 -0400
Received: by mail-lf0-f67.google.com with SMTP id a4-v6so6184666lff.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PZVW9Rn6MsGlL0H/an3nINAEyYJxnHuYQugD6DyiKjI=;
        b=XY6nHcaEys6aeimchWL1gvcwiSFHI2TKI+VfYRBZd6Q3b7DgXG/ManX5roIIi3lGLk
         se2Nh2F/sUrScOuyo5dJJHS90WnQVFszf0aj5aSjEjSiSSs+kD85Tbvtl+L96YUdwcjx
         ou+kWDx+iW6QtRLOv5YsAdEdStQzZzyLkjg5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PZVW9Rn6MsGlL0H/an3nINAEyYJxnHuYQugD6DyiKjI=;
        b=fOui7BsZUCdBZoqO4gSawdleiJKKs7qCsm183CuNjjsnt4Q524EDdegC/unX6kAe88
         by+c6qNSIpe0PZSiphwSRd4fUxP3b49vM3BDu1tpao+WFkBUt98IdYtmg/rIwCHkRSBm
         co8sCn7LkGsTSZugTay+edkV8eAXmF4UXXqqIxdd3qbs2o94yVOsKQUy0829t6PLpgbM
         tIEihAvlrUsvvAhyA7a1CWWqCpdzMnKac76qbc/9RBZ8CwTL15k1f+sd+lgfRLO4SclJ
         BUJD5zVx4GgEjCFiAMd9DZFUBsog0lHlWmdzQLwfBRDfiTKRvOTNcjae882Gsh12qcU/
         7DEQ==
X-Gm-Message-State: APt69E0F6IxWtCK6av3myNzaFA2QvKL62Rjb7E3YpoEPNg8EgfdpDDlu
        /lFjGxyLRMtzNPTVtXN1hTH/pQ==
X-Google-Smtp-Source: AAOMgpeoT6MtGomdk+h0YOw8lg7/PzmVXIJ5ZFw5Fn+mA7PZxw+g01BIAAEpatz8PmSDnMFKYr9KoA==
X-Received: by 2002:a19:d754:: with SMTP id o81-v6mr681826lfg.124.1530005740720;
        Tue, 26 Jun 2018 02:35:40 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id f17-v6sm168186lja.85.2018.06.26.02.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 02:35:39 -0700 (PDT)
Date:   Tue, 26 Jun 2018 11:35:37 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org, tiwai@suse.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 09/12] ASoC: qdsp6: q6routing: support dt based module
 loading
Message-ID: <20180626093537.GF25217@centauri.ideon.se>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
 <20180626092016.9296-10-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626092016.9296-10-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

On Tue, Jun 26, 2018 at 10:20:13AM +0100, Srinivas Kandagatla wrote:
> This patch uses new compatible string to make DT based module loading work.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6routing.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
> index 593f66b8622f..ab696bf8d1d3 100644
> --- a/sound/soc/qcom/qdsp6/q6routing.c
> +++ b/sound/soc/qcom/qdsp6/q6routing.c
> @@ -993,9 +993,16 @@ static int q6pcm_routing_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id q6pcm_routing_device_id[] = {
> +	{ .compatible = "qcom,q6adm-routing" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, q6pcm_routing_device_id);
> +
>  static struct platform_driver q6pcm_routing_platform_driver = {
>  	.driver = {
>  		.name = "q6routing",
> +		.of_match_table = of_match_ptr(q6pcm_routing_device_id),
>  	},
>  	.probe = q6pcm_routing_probe,
>  	.remove = q6pcm_routing_remove,
> -- 
> 2.16.2
> 
