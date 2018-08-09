Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA00C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AE2217AA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OwE5nn9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3AE2217AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeHIXEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:04:07 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44496 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbeHIXEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:04:07 -0400
Received: by mail-pl0-f65.google.com with SMTP id ba4-v6so3022033plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uFWqEG8UBRBqeWfwnx2ondjG6e8vdPzEuZWTCDmCXn8=;
        b=OwE5nn9EOI5NbLlZNvVOsFwGFTXEQqm5Lz/ZeSPo4Y6a3XUcttTGggoE7fVHqIp7/J
         VtbkKYMsmjXMOZWQVP7vARAceQvZ29CH4RAUWzwnHxupGaM8PjVzmkwrfZ/Bc1kSKvwS
         x14N1CAum5u06+oNOL4gRDqH0AetxUk/AVyyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uFWqEG8UBRBqeWfwnx2ondjG6e8vdPzEuZWTCDmCXn8=;
        b=n0YwKGoPB3iGViOgMnZXd1LCGbzunJX0JxEtqDZW/6Cf2tH927mGWkQmfOidFu4M45
         KGj2502cwZk6Gc1jPw0ycAhvFICvHzOl4nAsmONFypPCGTOaFgORDNVUWKVilxPBZsfy
         WDrnwzyKXS7yFzKAStxygeTu2rfhl2Jn1ZbJ56KpekVBg0JwSIlpxtgvTh/JX+SyHoot
         BZnUg3EBjz9U50FfuxepQkMLD1Yj14/nG9dAOKdFPH7vj81Ry/VMDGkOo4f0K1SSeT++
         DsF5ukTlUWHGWivPBSQc7v+jR8drbqmCbrAXGaccx/sccOJAs6N7wllD7ViEdywZqLLi
         0hKg==
X-Gm-Message-State: AOUpUlGl3RNKS5sQqS9e4rl+yooapmf5kZmRFTVu4q9odc3JGQXSw5fN
        AZsA4isYKgFLZpk7GC5ZJWIhfA==
X-Google-Smtp-Source: AA+uWPzILqpIfN5w8En21xhlv0J6LP42CRkjOle36fp+8c2LynXnckvWpAZ1Az2Ca6kWNsbbGjiBFw==
X-Received: by 2002:a17:902:123:: with SMTP id 32-v6mr3305140plb.181.1533847056836;
        Thu, 09 Aug 2018 13:37:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id f6-v6sm16089029pgf.52.2018.08.09.13.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 13:37:35 -0700 (PDT)
Date:   Thu, 9 Aug 2018 13:37:35 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        andy.gross@linaro.org, dianders@chromium.org,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 07/10] thermal: tsens: Check if the IP is correctly
 enabled by firmware
Message-ID: <20180809203735.GO160295@google.com>
References: <cover.1533815718.git.amit.kucheria@linaro.org>
 <985ed415774fdac9ac21afad4b4b74f30f6c5068.1533815718.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <985ed415774fdac9ac21afad4b4b74f30f6c5068.1533815718.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 06:02:39PM +0530, Amit Kucheria wrote:
> The SROT registers are initialised by the secure firmware at boot. We
> don't have write access to the registers. Check if the block is enabled
> before continuing.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-common.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> index 0b8a793f15f4..d250b757d1f0 100644
> --- a/drivers/thermal/qcom/tsens-common.c
> +++ b/drivers/thermal/qcom/tsens-common.c
> @@ -12,6 +12,11 @@
>  #include <linux/regmap.h>
>  #include "tsens.h"
>  
> +/* SROT */
> +#define CTRL_OFFSET		0x4
> +#define TSENS_EN		BIT(0)
> +
> +/* TM */
>  #define STATUS_OFFSET		0x30
>  #define SN_ADDR_OFFSET		0x4
>  #define SN_ST_TEMP_MASK		0x3ff
> @@ -119,6 +124,8 @@ int __init init_common(struct tsens_device *tmdev)
>  {
>  	void __iomem *tm_base, *srot_base;
>  	struct resource *res;
> +	u32 code;
> +	int ret;
>  	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
>  
>  	if (!op)
> @@ -151,5 +158,15 @@ int __init init_common(struct tsens_device *tmdev)
>  	if (IS_ERR(tmdev->tm_map))
>  		return PTR_ERR(tmdev->tm_map);
>  
> +	if (tmdev->srot_map) {
> +		ret = regmap_read(tmdev->srot_map, CTRL_OFFSET, &code);
> +		if (ret)
> +			return ret;
> +		if (!(code & TSENS_EN)) {
> +			dev_err(tmdev->dev, "tsens device is not enabled\n");
> +			return -ENODEV;
> +		}
> +	}
> +
>  	return 0;
>  }

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
