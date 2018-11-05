Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7F3C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9A22081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nihh5otJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9A22081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbeKEWye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:54:34 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37293 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeKEWye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:54:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id o15-v6so5908862wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 05:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tYpa0kukXlkRPSeXFDSSUloQpoUra5r/PJeoDEAXsNA=;
        b=Nihh5otJBPw5lzscQy0Fs5KzVHESXz5a7+0myKye1dypBIcqNdBQJxud3CaDR3DG/B
         DCDL7OemsNYHaxpdwi00KiGjOhwf0bXBQjWwBli+0rpqX5+tt9z68Fd9jFOjEZc3Nxeo
         RR7CdHAtBf5VFK2MkWxwLYXCZuxtJH7x90FzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tYpa0kukXlkRPSeXFDSSUloQpoUra5r/PJeoDEAXsNA=;
        b=CnQyMNBrJ3Ws1R5YnboOF4Em5dywrqE5wAKO/hzX0LebRcVsnwjNWDFC+0D+9QwVtb
         7iXgK4aOTTYdYAKdo//yNuw2ArqQCHQt/KRBmqcWmmY6q94r4FvZcwklDzx9gfMP40C0
         aL/JpjnKGrqCZtVPBo/s666qpfpp64X+olRVq2MdKEDxSnDFhixR7RR9+bPScpwc9Hin
         LF19EOCu4kQNFBnp3oNpgdEAN+cCr1RSUr3aVompVppk1/KefqQSOWeeBAUk3MYuT6mj
         2VG1spb/wmw04K4aPmLxu1HXJTkK19xA9nENXC7kIKj6k2pqsgBjr9/e/UBTlihmLHVI
         cTQw==
X-Gm-Message-State: AGRZ1gLSECZHiSKRM5FNe9eJ1RXhZAwrmHMHEJOr9J2DkE82YXwm1MeA
        BRT1K/pua0mOFHNNUVnB0eONlZ5mXWM=
X-Google-Smtp-Source: AJdET5fpLFHMa/1EkOj8QRPom44EbvlAKxtuk4C6R63W4W4mu2wCZAYBx1OL59ol5D+06O1TV28ErA==
X-Received: by 2002:a5d:4182:: with SMTP id m2-v6mr1355602wrp.8.1541424884955;
        Mon, 05 Nov 2018 05:34:44 -0800 (PST)
Received: from [192.168.0.40] ([80.125.190.7])
        by smtp.googlemail.com with ESMTPSA id k73-v6sm20377264wmd.33.2018.11.05.05.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 05:34:44 -0800 (PST)
Subject: Re: [PATCH V2 2/2] clocksource: imx-gpt: add necessary kfree to avoid
 resource leak
To:     Anson Huang <anson.huang@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1541379930-14538-1-git-send-email-Anson.Huang@nxp.com>
 <1541379930-14538-2-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dea51d27-0957-f762-773f-e0e0e001045c@linaro.org>
Date:   Mon, 5 Nov 2018 14:34:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541379930-14538-2-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On 05/11/2018 02:10, Anson Huang wrote:
> kfree should be called to free resource in error path
> before return.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/clocksource/timer-imx-gpt.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
> index a3d6ccb..0f78b30 100644
> --- a/drivers/clocksource/timer-imx-gpt.c
> +++ b/drivers/clocksource/timer-imx-gpt.c
> @@ -477,12 +477,16 @@ static int __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_type t
>  		return -ENOMEM;
>  
>  	imxtm->base = of_iomap(np, 0);
> -	if (!imxtm->base)
> +	if (!imxtm->base) {
> +		kfree(imxtm);
>  		return -ENXIO;
> +	}
>  
>  	imxtm->irq = irq_of_parse_and_map(np, 0);
> -	if (imxtm->irq <= 0)
> +	if (imxtm->irq <= 0) {
> +		kfree(imxtm);
>  		return -EINVAL;
> +	}
>  
>  	imxtm->clk_ipg = of_clk_get_by_name(np, "ipg");

Please convert to timer-of API.

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

