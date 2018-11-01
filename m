Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127F7C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4E9204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DgPOVyDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4E9204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbeKAV21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:28:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51823 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbeKAV20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:28:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id w7-v6so1223729wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 05:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vfzbpknVCqECxsauJcQ+o/bUMKV4e8t1GdIo/KGlMUc=;
        b=DgPOVyDkyn1rtFKkUfv9s2YOMC5ZKsiv6O6cMHUUAg2qJzdcJjvdfYTdvmQVFWFrUQ
         82Kea0tivdfg8vSLG2fDC7KVL5ZNtSpw0u/v22clBwtCUTejPa4YAWbyTc/R914zdryL
         BLoaoLvDUOGa/V2hyPCIneXMZj7IYZRaaShW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vfzbpknVCqECxsauJcQ+o/bUMKV4e8t1GdIo/KGlMUc=;
        b=b7YUYT9AkpC2UjYx24y0YfEzbXfPsrIieH8Yj1ZVwJO3EWrX7fNfsx4c8qIP+9iMzn
         Tf4eZX/2XssG5JqS6IpUK8lk/Eu/qXcZPNfez8g3NF6EbtyKZlDdF1fbaIStmxFSvE8w
         JcNsVpQ6RRrRGFQZtzz8/vK9oOHBsO5GOHBsWaEaUstHtIsm5e1nzJypmZezsCRQ8Rkw
         uP6Q9+ecPKUnBu/LQeCUmQPfbpKqOHOIlINhlWA0dtgHNyGHmjZt0vcvXm3hAq27gUSW
         BIXiK9Pm8Qy8c1JdzT2znzn2a7zMlsTiiOPj8XqgKCgocUDmE0NLAWMWwdjbNZLA/u95
         17dw==
X-Gm-Message-State: AGRZ1gIdgzkG5E/ORl47H7piJznCHFfRd8iDSZ2eWHKD/uVnGjp5nR7T
        a4wQ/zRiloAAMHmVb2RkjNGRVA==
X-Google-Smtp-Source: AJdET5fBu92xwN94KiHaxfdcqbcOszpwtb0o1zp7kKMN2EYC96WBFxDffqMck8ke2VUerj8v/wqiEw==
X-Received: by 2002:a1c:3d03:: with SMTP id k3-v6mr5802535wma.90.1541075140340;
        Thu, 01 Nov 2018 05:25:40 -0700 (PDT)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id c19-v6sm1190855wmb.34.2018.11.01.05.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 05:25:39 -0700 (PDT)
Subject: Re: [PATCH] ASoC: qdsp6: q6afe: Fix wrong MI2S SD line mask
To:     Rohit kumar <rohitkr@codeaurora.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        niklas.cassel@linaro.org
References: <1541073067-29553-1-git-send-email-rohitkr@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9b8e6d31-a406-a0c6-fd6c-7e2b876e21ab@linaro.org>
Date:   Thu, 1 Nov 2018 12:25:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1541073067-29553-1-git-send-email-rohitkr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/11/18 11:51, Rohit kumar wrote:
> SD line mask for MI2S starts from BIT 0 instead of BIT 1.
> Fix all bit mask for MI2S SD lines.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/qdsp6/q6afe.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
> index 000775b..829b5e987 100644
> --- a/sound/soc/qcom/qdsp6/q6afe.c
> +++ b/sound/soc/qcom/qdsp6/q6afe.c
> @@ -49,14 +49,14 @@
>   #define AFE_PORT_I2S_SD1		0x2
>   #define AFE_PORT_I2S_SD2		0x3
>   #define AFE_PORT_I2S_SD3		0x4
> -#define AFE_PORT_I2S_SD0_MASK		BIT(0x1)
> -#define AFE_PORT_I2S_SD1_MASK		BIT(0x2)
> -#define AFE_PORT_I2S_SD2_MASK		BIT(0x3)
> -#define AFE_PORT_I2S_SD3_MASK		BIT(0x4)
> -#define AFE_PORT_I2S_SD0_1_MASK		GENMASK(2, 1)
> -#define AFE_PORT_I2S_SD2_3_MASK		GENMASK(4, 3)
> -#define AFE_PORT_I2S_SD0_1_2_MASK	GENMASK(3, 1)
> -#define AFE_PORT_I2S_SD0_1_2_3_MASK	GENMASK(4, 1)
> +#define AFE_PORT_I2S_SD0_MASK		BIT(0x0)
> +#define AFE_PORT_I2S_SD1_MASK		BIT(0x1)
> +#define AFE_PORT_I2S_SD2_MASK		BIT(0x2)
> +#define AFE_PORT_I2S_SD3_MASK		BIT(0x3)
> +#define AFE_PORT_I2S_SD0_1_MASK		GENMASK(1, 0)
> +#define AFE_PORT_I2S_SD2_3_MASK		GENMASK(3, 2)
> +#define AFE_PORT_I2S_SD0_1_2_MASK	GENMASK(2, 0)
> +#define AFE_PORT_I2S_SD0_1_2_3_MASK	GENMASK(3, 0)
>   #define AFE_PORT_I2S_QUAD01		0x5
>   #define AFE_PORT_I2S_QUAD23		0x6
>   #define AFE_PORT_I2S_6CHS		0x7
> 
