Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 329FDC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA06D20020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jAFIHP3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA06D20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935718AbeFMNs5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:48:57 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40890 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934527AbeFMNsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:48:55 -0400
Received: by mail-lf0-f66.google.com with SMTP id q11-v6so4060054lfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 06:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+yg24vdu357IhWcNMLKZXRHCcBu3tV5/PfaUHQV+EFw=;
        b=jAFIHP3pBH8om5maFFdScE+AfkZ/kXRPlZZVBucJw4njb7AT4uSwbO4W+nDrU9RlAU
         YwjvS0fHEgQ485vs0MNiDFDS9z+f/gJcVGL2XoffC0A+YbP/QPAScAIRcsDIwpKuiEpD
         Og+Zk+cBF3T5GqwHMUTYi0C0kQmpysJpjXLaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+yg24vdu357IhWcNMLKZXRHCcBu3tV5/PfaUHQV+EFw=;
        b=RMj8UbAjU92ouUnEu2E2Iaj3u9+UobpikqKEKaq+hWvgWgvIs4v+eF6mIMCLLkCIlr
         jkwHk6oLxwrgtaAjwDA76kzm6P3FS640Ib8dxoA7PDlOcNDz5GedFCUsyIN2i/P02Pri
         F+qYNob2bJ3ST9yqhlacLtyrs6HY8VxcZ7s2EDoSjnP0V69pf0Im7mjSTI20lM7H6APF
         IJVmq1YUjVX+x9LQU1nvp7TF4QyU8n5IwxBLjrKHgCygtOzBhdyvOOB0VaJXm1dOu1KY
         tr8xM222WQWMx0lTw1zfNymEYWzgg0DuvJEj0itDK1OEZ6LwLNtOPK6iBEpWR7w15kXL
         KIMQ==
X-Gm-Message-State: APt69E203/OhTgFId0gkUPxFpI3z9/wGHN3RNW2LSZTOSmPAXYabVJMY
        FRMwHoqD4Z7LkeWfJCgqreW5+Q==
X-Google-Smtp-Source: ADUXVKLqNM2K0Yb9FcLvZdtd7oP5YAEIeAI38lNjcUIousWUCfbK5sLKFa+itguIOLx2jJlQlQ8WCQ==
X-Received: by 2002:a2e:9d0e:: with SMTP id t14-v6mr3150861lji.112.1528897733650;
        Wed, 13 Jun 2018 06:48:53 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id u24-v6sm542543ljj.96.2018.06.13.06.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 06:48:53 -0700 (PDT)
Date:   Wed, 13 Jun 2018 15:48:50 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, mark.brown@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] soc: qcom: Remove depends on ARCH_QCOM
Message-ID: <20180613134850.GA13526@centauri.ideon.se>
References: <20180613125401.11734-1-niklas.cassel@linaro.org>
 <20180613125401.11734-6-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613125401.11734-6-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 02:54:00PM +0200, Niklas Cassel wrote:
> Since commit cab673583d96 ("soc: Unconditionally include qcom Makefile"),
> we unconditionally include the soc/qcom/Makefile.
> 
> This opens up the possibility to compile test the code even when
> building for other architectures.
> 
> Remove the depends on ARCH_QCOM for all Kconfigs, except for
> two Kconfigs that depend on QCOM_SCM, since that triggers lots of build
> errors in qcom_scm. However, that shouldn't stop us from removing
> it from those where it is possible.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 1d4a9f3ada8c..8c83025c466e 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -5,7 +5,7 @@ menu "Qualcomm SoC drivers"
>  
>  config QCOM_COMMAND_DB
>  	bool "Qualcomm Command DB"
> -	depends on (ARCH_QCOM && OF) || COMPILE_TEST
> +	depends on OF || COMPILE_TEST
>  	help
>  	  Command DB queries shared memory by key string for shared system
>  	  resources. Platform drivers that require to set state of a shared
> @@ -14,7 +14,6 @@ config QCOM_COMMAND_DB
>  
>  config QCOM_GENI_SE
>  	tristate "QCOM GENI Serial Engine Driver"
> -	depends on ARCH_QCOM || COMPILE_TEST
>  	help
>  	  This driver is used to manage Generic Interface (GENI) firmware based
>  	  Qualcomm Technologies, Inc. Universal Peripheral (QUP) Wrapper. This
> @@ -32,7 +31,6 @@ config QCOM_GLINK_SSR
>  
>  config QCOM_GSBI
>          tristate "QCOM General Serial Bus Interface"
> -        depends on ARCH_QCOM
>          select MFD_SYSCON
>          help
>            Say y here to enable GSBI support.  The GSBI provides control
> @@ -55,7 +53,7 @@ config QCOM_PM
>  
>  config QCOM_QMI_HELPERS
>  	tristate
> -	depends on ARCH_QCOM && NET
> +	depends on NET
>  	help
>  	  Helper library for handling QMI encoded messages.  QMI encoded
>  	  messages are used in communication between the majority of QRTR
> @@ -76,7 +74,6 @@ config QCOM_RMTFS_MEM
>  
>  config QCOM_SMEM
>  	tristate "Qualcomm Shared Memory Manager (SMEM)"
> -	depends on ARCH_QCOM
>  	depends on HWSPINLOCK
>  	help
>  	  Say y here to enable support for the Qualcomm Shared Memory Manager.
> @@ -85,7 +82,6 @@ config QCOM_SMEM
>  
>  config QCOM_SMD_RPM
>  	tristate "Qualcomm Resource Power Manager (RPM) over SMD"
> -	depends on ARCH_QCOM
>  	depends on RPMSG && OF
>  	help
>  	  If you say yes to this option, support will be included for the
> @@ -122,7 +118,6 @@ config QCOM_SMSM
>  
>  config QCOM_WCNSS_CTRL
>  	tristate "Qualcomm WCNSS control driver"
> -	depends on ARCH_QCOM
>  	depends on RPMSG
>  	help
>  	  Client driver for the WCNSS_CTRL SMD channel, used to download nv
> @@ -130,7 +125,6 @@ config QCOM_WCNSS_CTRL
>  
>  config QCOM_APR
>  	tristate "Qualcomm APR Bus (Asynchronous Packet Router)"
> -	depends on ARCH_QCOM
>  	depends on RPMSG
>  	help
>            Enable APR IPC protocol support between


Hello Andy

It seems like QCOM_APR is from Mark Brown's tree,
so just a heads up that you might get a conflict when applying.

Kind regards,
Niklas
