Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A83C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 04:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960832148E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 04:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XuBPV1SY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeL0EFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 23:05:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45879 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbeL0EFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 23:05:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so8275594pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 20:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cvXQ4mLFRGvm8zhEeMGUp5Fx2IDR+KBFGhFVEaC/w/0=;
        b=XuBPV1SYKUgBhRhQ0vneoxdAM8a4F3343q8jR/tIzeCVZ4Z3x4dZUL6y1uGiogE7Fy
         4v3+OJfO0bfRRQer1tVCKXWzRhIlzhFLrfqw1CMJAD3UzLStTcDYqCS0pcWk/bhwwy55
         ayNaag6o6MGobiQ1q1DuGmAAiW/6O4FQh4m4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cvXQ4mLFRGvm8zhEeMGUp5Fx2IDR+KBFGhFVEaC/w/0=;
        b=IHOBkPPiwa6vLJK+RrrsooNx5RGZFf+w1nBc2ikNH+K+zmUvofO6OBuLWHJa2YCvxw
         jMIOfCbHkc2d8BiA6nz2bPFuRkLwWoOzFLeLfE1mBE1MEk6mvCDUpy7WNscVgIsig5rm
         FSHO5/rn5fJwKWBNLex0uapWyX1FuU6K7WImJ5PbzG7GnMnZR+jaeZPkBShs0mIvTX1e
         d/REKUkPruC7sLz2i54KkpPRvyo4XKwm7dylQkoJIV30Rd5GFjT8YRlUkxNp3x0WIhN2
         r+x4m3DPUkZ7gadg19T2Bnk+J4htmAs5sI22W+hjr3n6D2miCDqeFifWeksnnsAKZgul
         mm3w==
X-Gm-Message-State: AJcUukcEoNnMx3wclL4bQ66fdZUP5fwop4oHHlS4jat1Z26/ozVs63Tl
        qQ4Fb3bUjBd23k9Ksg92qALzRg==
X-Google-Smtp-Source: AFSGD/UZs+p52NYLcCx/BqpT/TKjoGHJpi7g8759+hfAuWmg2k1L9MpVuSEa/lTZw7oOTQNa4N05wg==
X-Received: by 2002:a62:6f88:: with SMTP id k130mr22476992pfc.234.1545883501100;
        Wed, 26 Dec 2018 20:05:01 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k63sm69080469pfc.76.2018.12.26.20.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 20:05:00 -0800 (PST)
Date:   Wed, 26 Dec 2018 20:03:41 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Kishon Vijay Abraham <kishon@ti.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Matt Wagantall <mattw@codeaurora.org>,
        Mitchel Humpherys <mitchelh@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] phy: qcom-ufs: Use iopoll.h readl_poll_timeout macro
Message-ID: <20181227040341.GA9651@builder>
References: <88cd3a2e-2acc-02ff-9f27-284d3b679d10@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88cd3a2e-2acc-02ff-9f27-284d3b679d10@free.fr>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21 Dec 02:13 PST 2018, Marc Gonzalez wrote:

> The private copy of readl_poll_timeout is no longer needed.
> Use the implementation in iopoll.h instead.
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/phy/qualcomm/phy-qcom-ufs-i.h | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-ufs-i.h b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> index 681644e43248..f798fb64de94 100644
> --- a/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> +++ b/drivers/phy/qualcomm/phy-qcom-ufs-i.h
> @@ -23,24 +23,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
> -
> -#define readl_poll_timeout(addr, val, cond, sleep_us, timeout_us) \
> -({ \
> -	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us); \
> -	might_sleep_if(timeout_us); \
> -	for (;;) { \
> -		(val) = readl(addr); \
> -		if (cond) \
> -			break; \
> -		if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) { \
> -			(val) = readl(addr); \
> -			break; \
> -		} \
> -		if (sleep_us) \
> -			usleep_range(DIV_ROUND_UP(sleep_us, 4), sleep_us); \
> -	} \
> -	(cond) ? 0 : -ETIMEDOUT; \
> -})
> +#include <linux/iopoll.h>
>  
>  #define UFS_QCOM_PHY_CAL_ENTRY(reg, val)	\
>  	{				\
> -- 
> 2.17.1
