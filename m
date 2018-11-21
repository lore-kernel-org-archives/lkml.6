Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAD9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F532145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nu3I3P+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F532145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeKUTEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:04:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34231 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbeKUTEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:04:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so4693202wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 00:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AHB+dqlmaZHCyyuJMtTiuADWA2EBQl6FwzI4ofcomg8=;
        b=Nu3I3P+c4VnOSkqyWgrVEB2q1TlMlfOTzmjbymp4J0pa0KPOsoyZrw/q0rhVTFRhD3
         V1Py2BCKmzuCUE+035j+q0/mGLr2NJKEt5o9X9dW0uWHTR6sYq+hRLP3R9db0kRpGI6g
         AvXqM4hw7TBW0Wry78BFNAg2G2S40AJeikXjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AHB+dqlmaZHCyyuJMtTiuADWA2EBQl6FwzI4ofcomg8=;
        b=R8cGXLb1O1VIrFIRRFk887Ly6qAylFN5jnMr9NN9TulTVGO2kkbvld/X/cH08K0LQg
         ubMqioME7we9b6Yq/qYCN09sSVDeMFdFj0fQ4qhPW4PrVfXAmLaUTGd0Rpt2NvMi6Qod
         zKlEbOVOJ2E8NjbBfRLotHVksTNYLIZuQZt5J6yzs1ZHwh0hK4anFO2oW07aU8eUhFfT
         MQfMESZE1WJglXro+gSMRWfaHE7kpK6p1PmgDkSJx6cxsgKCyCyC5uTjkrhn8NDsTt3W
         R8u2xU8cKWNiiRlqczatGVuZNqnbdGM20Gq29Kzt5Chr0+dtDmlL7Mdxuh9VRkzP9GfE
         5/JQ==
X-Gm-Message-State: AA+aEWYUcyJGLzJ2bGqCXM3rFstUMYVp7worFPxX9mhKMNNiN/BErKZn
        LVdW9ng6cd2tzrJf0XehUhMsQA==
X-Google-Smtp-Source: AFSGD/WUQyZTNwfesFkN+uNXxb0dBnISGxbPvu7Tgf+dQtg9BoD14mKwq8JxP9wUCte95PZkEmQQRA==
X-Received: by 2002:adf:b253:: with SMTP id y19mr3521758wra.184.1542789061241;
        Wed, 21 Nov 2018 00:31:01 -0800 (PST)
Received: from [192.168.0.40] (239.22.136.77.rev.sfr.net. [77.136.22.239])
        by smtp.googlemail.com with ESMTPSA id i13sm27004643wrw.32.2018.11.21.00.31.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 00:31:00 -0800 (PST)
Subject: Re: [PATCH V5 2/2] thermal: imx: save one condition block for normal
 case of nvmem initialization
To:     Anson Huang <anson.huang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1542779052-29536-1-git-send-email-Anson.Huang@nxp.com>
 <1542779052-29536-2-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b28efba1-e04a-7e33-126b-b92c7aa5e9a9@linaro.org>
Date:   Wed, 21 Nov 2018 09:30:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542779052-29536-2-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2018 06:49, Anson Huang wrote:
> Put return value checks of calling imx_init_from_nvmem_cells()
> into one block to save one condition block for normal case.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/thermal/imx_thermal.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
> index c924396..bb6754a 100644
> --- a/drivers/thermal/imx_thermal.c
> +++ b/drivers/thermal/imx_thermal.c
> @@ -742,9 +742,10 @@ static int imx_thermal_probe(struct platform_device *pdev)
>  
>  	if (of_find_property(pdev->dev.of_node, "nvmem-cells", NULL)) {
>  		ret = imx_init_from_nvmem_cells(pdev);
> -		if (ret == -EPROBE_DEFER)
> -			return ret;
>  		if (ret) {
> +			if (ret == -EPROBE_DEFER)
> +				return ret;
> +
>  			dev_err(&pdev->dev, "failed to init from nvmem: %d\n",
>  				ret);
>  			return ret;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

