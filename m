Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA95C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F9C2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XncqEMlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F9C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeICXnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:43:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34252 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbeICXnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:43:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so550394pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7FHEuzvE/SpSiZhddHdf1IekIZ2xsVjoeaGcMqigOzU=;
        b=XncqEMlrLgvQIPw0xoEi4OOTtHLa04HX5UXT/ZdthR7Eir0/DRg5ekV3aViJ25wrbF
         +g7QYSoT2R05RCjTegY0j0KBz/frsPJpA1sUz7weQMu3L6q9j6cIxK+9WSrAYDU2dCzZ
         MpnhRHPntinChq+lM+Y3vzroUAqzd+OAs/8Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7FHEuzvE/SpSiZhddHdf1IekIZ2xsVjoeaGcMqigOzU=;
        b=TRlO3iyxTtD7mHSUlZUE5ByukRjsQVDgqNkpncmrZeVKjn1CvW84hQg0G+DJ/DtSCv
         u+f3XOZc6XP+TW3/JNeuR6oZ2+v0omsWZFa32od5+sZsFzOyLXzHUr7vWj2ZBY8Lk7xT
         zk0GXR0+oQduz0NaYIM4N3V50zLx+92VX9b00swUy0WVSL7DBvpSKLfDx9XB07SoHPyI
         J+zcVguYC1e/QDNv9jt5LXWqgY0ordD4keHEWyZ0Ikf/tqDoeIzB801i8l51t8ttLKm0
         M9KJrRF7rHbUixaDBOYIVuq2OsFccS9lsP8RAH9AT+bcX6LPEQfX88C8Ik/Ia0v932BT
         PF+w==
X-Gm-Message-State: APzg51DMNOp5G5icQNNcg5SWWmAKpOYgQMB3tdS6aibMWkXdRLfI4HpS
        h3ZbhcPDBajt5cZUKhzRMD9nVRLqgMs=
X-Google-Smtp-Source: ANB0VdYQwE3rLpzHxVcnKlDyRk20/MN8FFqj+wMc/qX/li0d0i9FJhHfPPjhcerbbuH0kuLeL0ivuw==
X-Received: by 2002:a63:9712:: with SMTP id n18-v6mr26928783pge.92.1536002498174;
        Mon, 03 Sep 2018 12:21:38 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g25-v6sm37062355pfd.23.2018.09.03.12.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 12:21:37 -0700 (PDT)
Date:   Mon, 3 Sep 2018 12:25:31 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 9/9] soc: qcom: Allow COMPILE_TEST of qcom SoC Kconfigs
Message-ID: <20180903192531.GE3456@tuxbook-pro>
References: <20180829075724.9095-1-niklas.cassel@linaro.org>
 <20180829075724.9095-10-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829075724.9095-10-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29 Aug 00:57 PDT 2018, Niklas Cassel wrote:

> Since commit cab673583d96 ("soc: Unconditionally include qcom Makefile"),
> we unconditionally include the soc/qcom/Makefile.
> 
> This opens up the possibility to compile test the code even when building
> for other architectures.
> 
> Allow COMPILE_TEST for all qcom SoC Kconfigs, except for two Kconfigs
> that depend on QCOM_SCM, since that triggers lots of build errors in
> qcom_scm.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/Kconfig | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index cf4ece232897..684cb51694d1 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -33,7 +33,7 @@ config QCOM_GLINK_SSR
>  
>  config QCOM_GSBI
>          tristate "QCOM General Serial Bus Interface"
> -        depends on ARCH_QCOM
> +        depends on ARCH_QCOM || COMPILE_TEST
>          select MFD_SYSCON
>          help
>            Say y here to enable GSBI support.  The GSBI provides control
> @@ -42,7 +42,7 @@ config QCOM_GSBI
>  
>  config QCOM_LLCC
>  	tristate "Qualcomm Technologies, Inc. LLCC driver"
> -	depends on ARCH_QCOM
> +	depends on ARCH_QCOM || COMPILE_TEST
>  	help
>  	  Qualcomm Technologies, Inc. platform specific
>  	  Last Level Cache Controller(LLCC) driver. This provides interfaces
> @@ -73,7 +73,8 @@ config QCOM_PM
>  
>  config QCOM_QMI_HELPERS
>  	tristate
> -	depends on ARCH_QCOM && NET
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on NET
>  	help
>  	  Helper library for handling QMI encoded messages.  QMI encoded
>  	  messages are used in communication between the majority of QRTR
> @@ -104,7 +105,7 @@ config QCOM_RPMH
>  
>  config QCOM_SMEM
>  	tristate "Qualcomm Shared Memory Manager (SMEM)"
> -	depends on ARCH_QCOM
> +	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on HWSPINLOCK
>  	help
>  	  Say y here to enable support for the Qualcomm Shared Memory Manager.
> @@ -113,7 +114,7 @@ config QCOM_SMEM
>  
>  config QCOM_SMD_RPM
>  	tristate "Qualcomm Resource Power Manager (RPM) over SMD"
> -	depends on ARCH_QCOM
> +	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on RPMSG
>  	help
>  	  If you say yes to this option, support will be included for the
> @@ -150,7 +151,7 @@ config QCOM_SMSM
>  
>  config QCOM_WCNSS_CTRL
>  	tristate "Qualcomm WCNSS control driver"
> -	depends on ARCH_QCOM
> +	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on RPMSG
>  	help
>  	  Client driver for the WCNSS_CTRL SMD channel, used to download nv
> @@ -158,7 +159,7 @@ config QCOM_WCNSS_CTRL
>  
>  config QCOM_APR
>  	tristate "Qualcomm APR Bus (Asynchronous Packet Router)"
> -	depends on ARCH_QCOM
> +	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on RPMSG
>  	help
>            Enable APR IPC protocol support between
> -- 
> 2.17.1
> 
