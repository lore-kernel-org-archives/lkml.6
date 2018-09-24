Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9696CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4312020676
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlEgEzrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4312020676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbeIXX21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:28:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44518 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbeIXX21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:28:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id p25-v6so2295755pli.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HI/w0v/95vDGLqiVycPJywfORq3ujkHSNScT4D8/p4s=;
        b=UlEgEzrNALpBXJZ6ypLFJfISqr4U63BljJcnZT5lOTu6HqylrkIz41N2rtw6uWUeRi
         sX9BgIIIS0DsRwjANs4lxLMRNh773pC87k+RWAJKJknmB2lX9uM3SB4hsHrSpsjW1KtW
         17GuMrRsGcDY7510zP7sxl4UxmRaZznZLh9jE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HI/w0v/95vDGLqiVycPJywfORq3ujkHSNScT4D8/p4s=;
        b=mVf++unk7nKwROoLpeCfak8+s+likWMEXAwDFDHl3ll94uhwnEOgHMgOLt0+L2Yy4j
         3fheDLBFj9paeFykXnIDsSubp/ZS4rqMgDLmSr+ri67pUiGgzJg/HGWkACtDnEmkw/Cs
         aPEMFfw1OMDb0wwdM2I7E0shihQS4gIIGgL1exwkcZRSNUIYHmoZImg8z7W/IR5YDAH8
         1QF7vgWmY9m0cGUYFZHqXVrbuT92EX3zdnZPLUzLN/IGpB5GArs48PoeGcOmZ4PWHHvP
         Cd92rXRKOGPTHS8Hf2M7O7cIJOEdsd2vtELMT2H2QVS2M0BeQdLWo2nMx2ZUonUAfZdR
         8fFw==
X-Gm-Message-State: ABuFfogbWV6mic3Lbb//VyMmraqbDO8ir7Q9tG/JDgF5rAnrijCqHOfB
        bfiXNN/khIsEPf80muHQYWUKe+PDZRL3Zg==
X-Google-Smtp-Source: ACcGV63O0UOeywvZyHdXfIqLFjLXfb8AGpfpmr25jHWRnsBUUPh+5pWx0orDtgvV89HawYs1A2o1VQ==
X-Received: by 2002:a17:902:8bc4:: with SMTP id r4-v6mr11305160plo.124.1537809915329;
        Mon, 24 Sep 2018 10:25:15 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l79-v6sm64819574pfi.172.2018.09.24.10.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 10:25:14 -0700 (PDT)
Date:   Mon, 24 Sep 2018 10:29:35 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     kishon@ti.com, vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, subhashj@codeaurora.org,
        evgreen@chromium.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/3] phy: qcom-ufs: Declare 20nm qcom ufs qmp phy as
 Broken
Message-ID: <20180924172935.GM1367@tuxbook-pro>
References: <20180904101719.18049-1-vivek.gautam@codeaurora.org>
 <20180904101719.18049-4-vivek.gautam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904101719.18049-4-vivek.gautam@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04 Sep 03:17 PDT 2018, Vivek Gautam wrote:

> Fork out separate configs for 14nm and 20nm qcom ufs qmp phys
> to declare the 20nm phy as broken.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/phy/qualcomm/Kconfig  | 17 +++++++++++++++++
>  drivers/phy/qualcomm/Makefile |  4 ++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
> index 632a0e73ee10..32f7d34eb784 100644
> --- a/drivers/phy/qualcomm/Kconfig
> +++ b/drivers/phy/qualcomm/Kconfig
> @@ -50,6 +50,23 @@ config PHY_QCOM_UFS
>  	help
>  	  Support for UFS PHY on QCOM chipsets.
>  
> +if PHY_QCOM_UFS
> +
> +config PHY_QCOM_UFS_14NM
> +	tristate
> +	default PHY_QCOM_UFS
> +	help
> +	  Support for 14nm UFS QMP phy present on QCOM chipsets.
> +
> +config PHY_QCOM_UFS_20NM
> +	tristate
> +	default PHY_QCOM_UFS
> +	depends on BROKEN
> +	help
> +	  Support for 20nm UFS QMP phy present on QCOM chipsets.
> +
> +endif
> +
>  config PHY_QCOM_USB_HS
>  	tristate "Qualcomm USB HS PHY module"
>  	depends on USB_ULPI_BUS
> diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
> index deb831f453ae..c56efd3af205 100644
> --- a/drivers/phy/qualcomm/Makefile
> +++ b/drivers/phy/qualcomm/Makefile
> @@ -5,7 +5,7 @@ obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
>  obj-$(CONFIG_PHY_QCOM_QMP)		+= phy-qcom-qmp.o
>  obj-$(CONFIG_PHY_QCOM_QUSB2)		+= phy-qcom-qusb2.o
>  obj-$(CONFIG_PHY_QCOM_UFS)		+= phy-qcom-ufs.o
> -obj-$(CONFIG_PHY_QCOM_UFS)		+= phy-qcom-ufs-qmp-14nm.o
> -obj-$(CONFIG_PHY_QCOM_UFS)		+= phy-qcom-ufs-qmp-20nm.o
> +obj-$(CONFIG_PHY_QCOM_UFS_14NM)		+= phy-qcom-ufs-qmp-14nm.o
> +obj-$(CONFIG_PHY_QCOM_UFS_20NM)		+= phy-qcom-ufs-qmp-20nm.o
>  obj-$(CONFIG_PHY_QCOM_USB_HS) 		+= phy-qcom-usb-hs.o
>  obj-$(CONFIG_PHY_QCOM_USB_HSIC) 	+= phy-qcom-usb-hsic.o
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
