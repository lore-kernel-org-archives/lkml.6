Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2853C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E74420864
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bIawjuL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E74420864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933954AbeGIR1z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:27:55 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41936 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933819AbeGIR1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:27:53 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so6338135ply.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 10:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L63GGCqFZGk7o4vqcIFDQhsJJC7WKsnUKvxUxPDMtDE=;
        b=bIawjuL1ke94p8XNWi2TZAlwKktuGVAlIpvf+xSC0ScH4cPUTUz1yzBcp3NdPsBWjy
         XldgbouAoaGP3monHwI4buGXyR1yD+s9YcyR+G9GvqEvPoDgEE2Qktw61QfRT5qsbLtV
         rch4iFHyL4BBqr3rIeUAjZA9oMPYR5sXoKzb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L63GGCqFZGk7o4vqcIFDQhsJJC7WKsnUKvxUxPDMtDE=;
        b=KhEoDU0iQyelYd/yCmc/zt0SNlNi5UKOBWHP5HJwBKvsM0T3FQd3OKbrrvxg41dLeV
         VLgvM/tRzL1cQXsOby4Z/XiyLDXO4g7JiC/IGqSG4IcaWemBtx16vN2xuo3y8Htyxkda
         UBnfxgBzE0cjYdzxwAgCmORxwBnJgDmEwsi/2cJg/HWjK3krUylmr4JObqzcfiZ5XJWx
         CrwP2/runExhuQdKpVrTx8SuLsF0n3hHNFdBZFt+v8yJ5zXCwAKkl05mq7NwDk0jTyaP
         CoElZvhh26HCIIzTg7HlmQz1bs8WRbz/EspwQrUv5Ch8+lW0OgyWFCX86DnK2mn+4YXW
         rgIg==
X-Gm-Message-State: APt69E2jniAtqtJgDHlEU854sADaaj3fCcf+JSNeHQZzje7Wcg4F8oqU
        awYZdVaFrQMy15SxHj0WB/pJbqxMf5g=
X-Google-Smtp-Source: AAOMgpdUEE8izX9XeuXNHC7lQlmidq1w32VxEeuEc76uYWJJk+p6UrDHi1fNiUklRU2iRQWlV7j8lw==
X-Received: by 2002:a17:902:6b09:: with SMTP id o9-v6mr21076373plk.256.1531157272661;
        Mon, 09 Jul 2018 10:27:52 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a25-v6sm23311954pgv.51.2018.07.09.10.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 10:27:52 -0700 (PDT)
Date:   Mon, 9 Jul 2018 10:30:22 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org
Subject: Re: [PATCH] pinctrl: msm: Pass along set_wake failures
Message-ID: <20180709173022.GH2050@tuxbook-pro>
References: <20180619234349.166190-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619234349.166190-1-evgreen@chromium.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 Jun 16:43 PDT 2018, Evan Green wrote:

> The MSM pinctrl driver quietly swallows errors that occur
> when trying to call .irq_set_wake. It should instead pass
> those failures up the chain so the caller can react to them.
> Swallowing the error for instance causes gpio_keys to think that
> it was able to successfully set a wake IRQ, when in fact it may
> not have been, causing the following warning on resume:
> 
> [   53.777819] Unbalanced IRQ 9 wake disable
> [   53.781979] WARNING: CPU: 0 PID: 1362 at kernel/irq/manage.c:623
> irq_set_irq_wake+0xac/0x12c
> [   53.794758] Modules linked in: spi_gpio spi_bitbang qcom_q6v5_pil
> qcom_common cfg80211 ip6table_filter smsc95xx usbnet mii
> [   54.016419] [<ffffff80081054b0>] irq_set_irq_wake+0xac/0x12c
> [   54.022252] [<ffffff80083c86a4>] msm_gpio_irq_set_wake+0x48/0x68
> [   54.028447] [<ffffff8008104d8c>] set_irq_wake_real+0x50/0x5c
> [   54.034275] [<ffffff80081054d0>] irq_set_irq_wake+0xcc/0x12c
> [   54.040104] [<ffffff800860fd00>] gpio_keys_resume+0x74/0xd8
> [   54.045846] [<ffffff800852018c>] platform_pm_resume+0x54/0x60
> [   54.051771] [<ffffff800852ceb4>] dpm_run_callback+0x104/0x210
> [   54.057694] [<ffffff800852d7cc>] device_resume+0x178/0x1b0
> [   54.063355] [<ffffff800852e938>] dpm_resume+0x1c4/0x38c
> [   54.068745] [<ffffff800852efac>] dpm_resume_end+0x20/0x34
> [   54.074315] [<ffffff80080fe700>] suspend_devices_and_enter+0x518/0x964
> [   54.081044] [<ffffff80080ff1dc>] pm_suspend+0x690/0x6e0
> [   54.086433] [<ffffff80080fd0f8>] state_store+0xd4/0xf8
> [   54.091733] [<ffffff80088a3af0>] kobj_attr_store+0x18/0x28
> [   54.097396] [<ffffff80082980a4>] sysfs_kf_write+0x5c/0x68
> [   54.102961] [<ffffff8008297050>] kernfs_fop_write+0x174/0x1b8
> [   54.108887] [<ffffff800821a9c0>] __vfs_write+0x58/0x160
> [   54.114276] [<ffffff800821acd4>] vfs_write+0xcc/0x184
> [   54.119487] [<ffffff800821af4c>] SyS_write+0x64/0xb4
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 0e22f52b2a19..d48a74ddbc1f 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -779,14 +779,15 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
>  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>  	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>  	unsigned long flags;
> +	int rc;
>  
>  	raw_spin_lock_irqsave(&pctrl->lock, flags);
>  
> -	irq_set_irq_wake(pctrl->irq, on);
> +	rc = irq_set_irq_wake(pctrl->irq, on);
>  
>  	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>  
> -	return 0;
> +	return rc;

Sorry for not getting back to you in a timely manner Evan, I wanted to
read up more on the details of how this is supposed to work. I still
haven't done so, but here's my concern:

When we power down the SoC we're no longer powering either the TLMM or
the GIC, so the MPM or PDC is used to waking the system on some set of
triggers. As such set_wake on an individual pin or irq should be routed
to the MPM/PDC driver, which (in the PDC case) is implemented using
hierarchical irq domains.

As such I think that we shouldn't toggle the wake property of the
summary pin at all; i.e. the patch should remove that call rather than
propagating what I believe is a constant failure.

Regards,
Bjorn
