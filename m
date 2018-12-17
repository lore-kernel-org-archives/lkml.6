Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492F9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D2E206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJea2A6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732880AbeLQMbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:31:33 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34008 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732543AbeLQMbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:31:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so4855170pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 04:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m88e+fJTH87Dgp9XoTMMrMqHMwEQRIMQZVABal1lspU=;
        b=EJea2A6LUKNvDt3CNoSycglVFIcdN32XOxpk4ODeSctcD5VrwvptkUxLai7p5JYAmy
         1c83CXEIYXu3bJ2zEfuSTG3SnWGq5r0ASgy4FL4qfHATMZuWQzcgdahrWUPEZTzHpv8+
         0kkcUcJ8/pIB1rq8X01GV+aGDGNCXRAmQyzww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m88e+fJTH87Dgp9XoTMMrMqHMwEQRIMQZVABal1lspU=;
        b=oG/eznmRW1ExP7T2QOyT5woHHdspLI5X2R2yz7+dn+Wb6ZfPCUnZdO9dBjcz396foa
         ajclKBetFTp+JWwKojRofqXJp+fi07Qya1PPGjn3Kff3DRmjH/EpV/ixHcSEh7UYatMh
         RIzSzoLTMPACw4U+Z9HvfMFQhTQU/BOsXa0MM/uNMaXrre+WlHl2k3hNIUkototeaDkq
         RVRhvVHsMD85HpcqUs1jOD5C9n0OCU6jZivH6xu42mD89RjtMuurB4YU7yqMJARZxgYi
         ABMQccxFH71aHDytbxChXCVf1Kk+QfF5hvJKvcf8pLS07lcrBO38CUQUJywB49AHpwoJ
         HKYA==
X-Gm-Message-State: AA+aEWaMwN3M+PZ9EINvTmvEl9JviEj/LRtDjO8PhgvclsexWLrRIXED
        /yJPwlRQ9VIjDggNSVZWNUat
X-Google-Smtp-Source: AFSGD/XSbZzmBkc39kr1fUxLbwYlpMftXTA+k931Y4WN/VhF6on1mZkLrPth3OH5NxEwJPK2d3L4xA==
X-Received: by 2002:a62:a510:: with SMTP id v16mr12622918pfm.18.1545049891626;
        Mon, 17 Dec 2018 04:31:31 -0800 (PST)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id r2sm17089873pgo.18.2018.12.17.04.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 04:31:31 -0800 (PST)
Date:   Mon, 17 Dec 2018 18:01:24 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] irqchip: irq-rda-intc: Fix return value check in
 rda8810_intc_init()
Message-ID: <20181217123123.GA26530@mani>
References: <1545047898-153890-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545047898-153890-1-git-send-email-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 11:58:18AM +0000, Wei Yongjun wrote:
> In case of error, the function of_io_request_and_map() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 
> Fixes: d852e62ad689 ("irqchip: Add RDA8810PL interrupt driver")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/irqchip/irq-rda-intc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-rda-intc.c b/drivers/irqchip/irq-rda-intc.c
> index 1176291..9601683 100644
> --- a/drivers/irqchip/irq-rda-intc.c
> +++ b/drivers/irqchip/irq-rda-intc.c
> @@ -85,8 +85,8 @@ static int __init rda8810_intc_init(struct device_node *node,
>  				    struct device_node *parent)
>  {
>  	rda_intc_base = of_io_request_and_map(node, 0, "rda-intc");
> -	if (!rda_intc_base)
> -		return -ENXIO;
> +	if (IS_ERR(rda_intc_base))
> +		return PTR_ERR(rda_intc_base);
>  
>  	/* Mask all interrupt sources */
>  	writel_relaxed(RDA_IRQ_MASK_ALL, rda_intc_base + RDA_INTC_MASK_CLR);
> 
> 
> 
