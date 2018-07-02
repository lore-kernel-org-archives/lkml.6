Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6645C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730CF25D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="THZLtmTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730CF25D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeGBNCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:02:32 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38199 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752152AbeGBNC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:02:26 -0400
Received: by mail-pl0-f66.google.com with SMTP id d10-v6so7933525plo.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 06:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XLyQlkj1nrYm7BrPqEZZsPCnwroUKTYU9JTpwN31Ack=;
        b=THZLtmTXO4I0n5HTAtTC3nk9zN3mzfZoZNU9FXCOVs+jRRJExPWE1mrO5DcuqOOOkD
         cYpfZjYyWzlbBbI4xFotcR4iX7nsND6cnYbivqZGAtec7xjJYXEh7++jRtM9vsuT8Cm6
         cYaFekWxetYT6KuLxWHMLQ+XcMzZeABnNM/KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XLyQlkj1nrYm7BrPqEZZsPCnwroUKTYU9JTpwN31Ack=;
        b=FQ6IQtCXxo6zuRs/zZZANFmUKPIhOz20/+lMK0apsbI+M3CL6vTQvNFySj/A+31/FD
         jAVe7fp8wHEmOzPnTOkzrIooWfHBu15Aya5ah7GC21xDJSn5E5QkTY37oVckoG5l3cEm
         vGX+4p3sx5agOE9UnZG6+9bG/L3Wrk50bfX5iHe06vGG7/l92Hr++RUa+tK5XODWs2Qj
         BbYlwrQQRMGNHWD43/FbErgUj3SO7mBNNv/KwRdVfMgBloF2T8QvOJ3AK7FXU8ZCYOZg
         NzFNVHuwWb4420Hy7HdvoXKoaanTMxyC7Vf6bK4f7RjMVU4jQPb41a7yFccKjmwHlQV4
         x//A==
X-Gm-Message-State: APt69E3LVKuqms9fs/8GEabtd5klDbS5pGBbNB3mncJy7JVp81MaRWlD
        TQSpxrd1dLvT0jTxP+i4ypr5
X-Google-Smtp-Source: ADUXVKKKkWZ53kVAQoY16oqdZSyv63tbFOwuNWOpuMLxejMF/40VjjYtUT8OzPou7D+1nh2yg3NfQA==
X-Received: by 2002:a17:902:7891:: with SMTP id q17-v6mr26170658pll.186.1530536545211;
        Mon, 02 Jul 2018 06:02:25 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id s5-v6sm26912551pgo.65.2018.07.02.06.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 06:02:23 -0700 (PDT)
Date:   Mon, 2 Jul 2018 18:32:16 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] pinctrl: actions: fix unsigned less than zero
 comparison
Message-ID: <20180702130216.GA11085@mani>
References: <20180702124708.7295-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702124708.7295-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 01:47:08PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The check to see if platform_get_irq failed is performed on the
> unsigned value of pctrl->irq[i] and the check is never true because
> an unsigned cannot be less than zero.  Fix this by assinging the
> signed int ret to the return of platform_get_irq and checking ret
> instead.
> 
> Detected by CoverityScan, CID#1470247 ("Unsigned comparison against 0")
> 
> Fixes: 6c5d0736e9c0 ("pinctrl: actions: Add interrupt support for OWL S900 SoC")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks!

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> 

Regards,
Mani

> ---
> 
> V2: move pctrl->irq[i] = ret assignment below the check on ret, thanks
> to Manivannan Sadhasivam for suggesting this change.
> 
> ---
>  drivers/pinctrl/actions/pinctrl-owl.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
> index 4fa9cc377b3b..24dc57fcac51 100644
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
> +		if (ret < 0)
>  			goto err_exit;
> -		}
> +		pctrl->irq[i] = ret;
>  	}
>  
>  	ret = owl_gpio_init(pctrl);
> -- 
> 2.17.1
> 
