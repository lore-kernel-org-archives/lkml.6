Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E99C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D149C2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 18:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaAMkvpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D149C2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbeI3AsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 20:48:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41285 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeI3AsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 20:48:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3-v6so6672940pgv.8;
        Sat, 29 Sep 2018 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tDXzf/udT2sLICh0F22dZmfyKcOE6GKdhC9TxcJib8o=;
        b=SaAMkvppvQTYGQVtNj3RcYow2tvFEWnQXsWIP7k1NdH5nlSz5e6+28aZq+J+Pcv/iB
         B5rHD6HcnlrnmBteGs4zByny8fsuelYReWqzCL4gF04tUbxjVDSd7Mv/4557Z0uNtpMy
         wY50UqQN3m0iBtq3DVB3Jfz4G21X17PxNhM91r08KpfXAE5GSagVtUNHEaeQP/IUcp6t
         pOyCCeQJOaO6n8NypCeiKaekdxXsSe3ZbfWSREMACao+dg47lkczR9RHLzgYil3N85R8
         0qsHRsyh8QphOh/dkCgT2KgOT5KJsIwZiPT/KfWQc4YTxM9KscW3Jz65SLpcivYK+EF4
         mzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tDXzf/udT2sLICh0F22dZmfyKcOE6GKdhC9TxcJib8o=;
        b=nUo/9x58F7MGlxN+E3FqItnEkoVXc8WwnwnIOZLrSJmWsNGtlwmoGeFAcZP6xDU5aZ
         DydSDfBSXYUjiJZSM1r5uyAN5/AYbTpy27D4NkONzSrx9xwwTT59FCt8H1b0FirBb0xZ
         s1MDgATDDZzAx4KCSRZlszzzbE8Av+dq5sYb5WeT0LmD0/CHl47gdIueT6mVAywxbTmO
         MPmz01alZuRbNHXmZZ1NGqg8McVBVH+Tnr7gSauAiAmdygdrFPVNP8QvF5LVk6fC1swW
         rA4/mko15p+Rxp24cUqsaT7fHeIxBOkzvBpzKOo23uVrxk885Um+3vZoE02JFCcRJJ23
         XC+A==
X-Gm-Message-State: ABuFfohId/fNdqmh5z/GG29LYJCDuD/NijfjdDjbvpW3dKSxd6L9tVJ1
        S/RREpKLbG7sTlbUZNuziVM=
X-Google-Smtp-Source: ACcGV63yscddTUXp+MU7pwVbHt+9bogVEYBKbUkq+SKLnTPEUkf/Tgd4Px4eTAUToGrGbYiuDHgscA==
X-Received: by 2002:a62:1a16:: with SMTP id a22-v6mr4025109pfa.237.1538245140891;
        Sat, 29 Sep 2018 11:19:00 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u62-v6sm13227276pfu.69.2018.09.29.11.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 11:18:59 -0700 (PDT)
Date:   Sat, 29 Sep 2018 11:18:58 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Radu Rendec <radu.rendec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [v3,2/3] watchdog: mpc8xxx: provide boot status
Message-ID: <20180929181858.GA5758@roeck-us.net>
References: <207741bf9c994a869f574a93d4fb4152d4e169c9.1537163779.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <207741bf9c994a869f574a93d4fb4152d4e169c9.1537163779.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 06:22:50AM +0000, Christophe Leroy wrote:
> mpc8xxx watchdog driver supports the following platforms:
> - mpc8xx
> - mpc83xx
> - mpc86xx
> 
> Those three platforms have a 32 bits register which provides the
> reason of the last boot, including whether it was caused by the
> watchdog.
> 
> mpc8xx: Register RSR, bit SWRS (bit 3)
> mpc83xx: Register RSR, bit SWRS (bit 28)
> mpc86xx: Register RSTRSCR, bit WDT_RR (bit 11)
> 
> This patch maps the register as defined in the device tree and updates
> wdt.bootstatus based on the value of the watchdog related bit. Then
> the information can be retrieved via the WDIOC_GETBOOTSTATUS ioctl.
> 
> Hereunder is an example of devicetree for mpc8xx,
> the Reset Status Register being at offset 0x288:
> 
> 		WDT: watchdog@0 {
> 			compatible = "fsl,mpc823-wdt";
> 			reg = <0x0 0x10 0x288 0x4>;
> 		};
> 
> On the mpc83xx, RSR is at offset 0x910
> On the mpc86xx, RSTRSCR is at offset 0xe0094
> 
> Suggested-by: Radu Rendec <radu.rendec@gmail.com>
> Tested-by: Christophe Leroy <christophe.leroy@c-s.fr> # On mpc885
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/mpc8xxx_wdt.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> index 1dcf5f10cdd9..069072e6747d 100644
> --- a/drivers/watchdog/mpc8xxx_wdt.c
> +++ b/drivers/watchdog/mpc8xxx_wdt.c
> @@ -47,6 +47,7 @@ struct mpc8xxx_wdt {
>  struct mpc8xxx_wdt_type {
>  	int prescaler;
>  	bool hw_enabled;
> +	u32 rsr_mask;
>  };
>  
>  struct mpc8xxx_wdt_ddata {
> @@ -159,6 +160,24 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>  		return -ENODEV;
>  	}
>  
> +	res = platform_get_resource(ofdev, IORESOURCE_MEM, 1);
> +	if (res) {
> +		bool status;
> +		u32 __iomem *rsr = ioremap(res->start, resource_size(res));
> +
> +		if (!rsr)
> +			return -ENOMEM;
> +
> +		status = in_be32(rsr) & wdt_type->rsr_mask;
> +		ddata->wdd.bootstatus = status ? WDIOF_CARDRESET : 0;
> +		 /* clear reset status bits related to watchdog timer */
> +		out_be32(rsr, wdt_type->rsr_mask);
> +		iounmap(rsr);
> +
> +		dev_info(dev, "Last boot was %scaused by watchdog\n",
> +			 status ? "" : "not ");
> +	}
> +
>  	spin_lock_init(&ddata->lock);
>  
>  	ddata->wdd.info = &mpc8xxx_wdt_info,
> @@ -216,6 +235,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.compatible = "mpc83xx_wdt",
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x10000,
> +			.rsr_mask = BIT(3), /* RSR Bit SWRS */
>  		},
>  	},
>  	{
> @@ -223,6 +243,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x10000,
>  			.hw_enabled = true,
> +			.rsr_mask = BIT(20), /* RSTRSCR Bit WDT_RR */
>  		},
>  	},
>  	{
> @@ -230,6 +251,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x800,
>  			.hw_enabled = true,
> +			.rsr_mask = BIT(28), /* RSR Bit SWRS */
>  		},
>  	},
>  	{},
