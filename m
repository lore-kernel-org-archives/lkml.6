Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E8FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B686125116
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBx7NL8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B686125116
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeGBMaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:30:02 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34090 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752235AbeGBM35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:29:57 -0400
Received: by mail-pg0-f67.google.com with SMTP id y5-v6so815470pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 05:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rwBm/W39pEyEfaLUaH26oEZbWY27a+dd87ZUqzRyOeA=;
        b=EBx7NL8jWAL7y5mwx4CNE9alKcuLriK/o+M3YsE1GoRx/7eR14lgQrWs+0J/EoCGtU
         6VHuocZ3nRXM23VoX+3fzHg+WNo9TGPPBczczmdNdsy3Jebh1ryMJAFu4LsKP5xg2fwQ
         1UMjJ3Vch6G49GgFJ0xnARmvHSWzGEYb0mP5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rwBm/W39pEyEfaLUaH26oEZbWY27a+dd87ZUqzRyOeA=;
        b=MZMlMYsCvhlEwfakh5jVQ/97M4IuH/Vt/+lO8OnvqithUXdATEvHUn5ZuO9psESZ0p
         c39ANBpzj+iNDBJwWd69vvUIQPMaZJPZb+YkESlAun9Yc0QNzm7FHXVEUEbzPuoBItSO
         nnc+7/0IqEavqKBBr0rE3iXd1NZhFY2O5lTpO/Bc7GnGm9Zu3guQkOSMNwsdXNy0MjIt
         YUjZ9kAZKq0TaCjT+l8jaT8cr7kkdTdr0YLySSHV5+Uz7rl483sGLe3EA3ecY/RjfEh0
         LfI2t49w4vOkjrU66y6eVVWlkE933NpivUJlkfdKhwo1tV4TcitN8H+LRUK9odbmXArp
         Rxug==
X-Gm-Message-State: APt69E2lWBNsjT9vVE0CIf7VMdMWYoPWUIItB/B3CC8j1SciuMMxYOhb
        SeibVrJM6Duu/IwvsqBaF6Vp
X-Google-Smtp-Source: ADUXVKLOi5MDKqp/brYlBS3KTahEUkLzmGHjp+5w5nHkQKanDEAFPbbBtydGNkxp+OXpLUhnuiVmsQ==
X-Received: by 2002:a63:b305:: with SMTP id i5-v6mr21675938pgf.370.1530534597202;
        Mon, 02 Jul 2018 05:29:57 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id p1-v6sm24917010pfh.58.2018.07.02.05.29.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 05:29:56 -0700 (PDT)
Date:   Mon, 2 Jul 2018 17:59:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] pinctrl: actions: fix unsigned less than zero
 comparison
Message-ID: <20180702122949.GA9925@mani>
References: <20180702121504.6731-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702121504.6731-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Mon, Jul 02, 2018 at 01:15:04PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The check to see if platform_get_irq failed is performed on the
> unsigned value of pctrl->irq[i] and the check is never true because
> an unsigned cannot be less than zero.  Fix this by assinging the
> signed int ret to the return of platform_get_irq and checking ret
> instead.
> 

Thanks for spotting!

> Detected by CoverityScan, CID#1470247 ("Unsigned comparison against 0")
> 
> Fixes: 6c5d0736e9c0 ("pinctrl: actions: Add interrupt support for OWL S900 SoC")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pinctrl/actions/pinctrl-owl.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
> index 4fa9cc377b3b..133ce9e0000a 100644
> --- a/drivers/pinctrl/actions/pinctrl-owl.c
> +++ b/drivers/pinctrl/actions/pinctrl-owl.c
> @@ -1026,11 +1026,10 @@ int owl_pinctrl_probe(struct platform_device *pdev,
>  	}
>  
>  	for (i = 0; i < pctrl->num_irq ; i++) {
> -		pctrl->irq[i] = platform_get_irq(pdev, i);
> -		if (pctrl->irq[i] < 0) {
> -			ret = pctrl->irq[i];
> +		ret = platform_get_irq(pdev, i);
> +		pctrl->irq[i] = ret;

Can we move this statement below if condition:

ret = platform_get_irq(pdev, i);
if (ret < 0)
	goto err_exit;
pctrl->irq[i] = ret;

This looks slightly better.

Thanks,
Mani

> +		if (ret < 0)
>  			goto err_exit;
> -		}
>  	}
>  
>  	ret = owl_gpio_init(pctrl);
> -- 
> 2.17.1
> 
