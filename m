Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09873C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B974720840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NS3IIYvC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B974720840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeKIQGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:06:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34077 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeKIQGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:06:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id f12-v6so483358plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 22:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SWzl7OukwhybX1iOcUp/6Ya3iTdfFdz2L5vI1Y/+WC0=;
        b=NS3IIYvC9cG0i3eStT75xUOGkGAmsylsUeMaI6Gd+9uFaf+wSypRMnqy5WoWcL6NuY
         pV6SE8Pl6RCy+Y2omiczefmW4Hj35WM/FpdyWYLfRTNRDo2no5r2YsvB+UR49/uT20uX
         JYvwvCgNQPqaoc2/cgJQcSjCsg3pTH8xuiA6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SWzl7OukwhybX1iOcUp/6Ya3iTdfFdz2L5vI1Y/+WC0=;
        b=TpO55xoWynjgs2P9yL6gVGI/RHqNV4k1yapwQ4aOIJ7BFe6K3+ASSQG1qcW53cJPXb
         CKEgPZoVbkm0du/oNzrINGB6++rqorv+IHL+mvcoNHGS7Y+T6GtGzYxEY4mi4L3c7HxI
         Dn8J8U1DbuJlaLoQmRtcuswV0klyjpHRI05Jebd29cXbkGzXmD6tV86FTfov5sY05gek
         QCbKuk+QXFfjA38BxstZ/DTfGDIIWyWjvYGR0qU2Co/O0Ef+Ijva2Bg2WEnQHVGhQT77
         gdUxd5ThoRHKlQJphGMMH+CPVsKanapmbYT0c5mJFZ8v37drX3i/bgu7XfvD5u/TYXm7
         iKbg==
X-Gm-Message-State: AGRZ1gKEM5X4snT9yGBFSDF8ypvwfFcibkgOdwbHlwSPlaVq9FqOuWMz
        h2R7G6AFRE0bcvSeKGfAFQaNyA==
X-Google-Smtp-Source: AJdET5f7jhM+M5tiys8e3Y7UZ8W/OGLUs7oeG1bbg4jRQeAPdWB7aHIdoVjEL6Z6EHGrfPfdZWpsLw==
X-Received: by 2002:a17:902:1e3:: with SMTP id b90-v6mr4813793plb.117.1541744850234;
        Thu, 08 Nov 2018 22:27:30 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t78-v6sm9926366pfk.59.2018.11.08.22.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 22:27:29 -0800 (PST)
Date:   Thu, 8 Nov 2018 22:27:27 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: defconfig: Enable some qcom remoteproc configs
Message-ID: <20181109062727.GB10915@tuxbook-pro>
References: <20181109061631.8245-1-vkoul@kernel.org>
 <20181109061631.8245-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109061631.8245-2-vkoul@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08 Nov 22:16 PST 2018, Vinod Koul wrote:

> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Enable remoteproc configs to boot the remoteprocs on QC chipsets. These
> are common configs and not specific to a specific SoC so should be enabled
> across the board.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/configs/defconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index b02da2e7a39a..b38d92c96c81 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -614,9 +614,15 @@ CONFIG_TEGRA_IOMMU_SMMU=y
>  CONFIG_ARM_SMMU=y
>  CONFIG_ARM_SMMU_V3=y
>  CONFIG_QCOM_IOMMU=y
> +CONFIG_REMOTEPROC=m
> +CONFIG_QCOM_ADSP_PIL=m

This is now CONFIG_QCOM_Q6V5_PAS

> +CONFIG_QCOM_Q6V5_PIL=m

and CONFIG_QCOM_Q6V5_MSS

> +CONFIG_QCOM_SYSMON=m
>  CONFIG_RPMSG_QCOM_GLINK_RPM=y
> +CONFIG_RPMSG_QCOM_GLINK_SMEM=m
>  CONFIG_RPMSG_QCOM_SMD=y
>  CONFIG_RASPBERRYPI_POWER=y
> +CONFIG_QCOM_GLINK_SSR=m
>  CONFIG_QCOM_SMEM=y
>  CONFIG_QCOM_SMD_RPM=y
>  CONFIG_QCOM_SMP2P=y

Apart from that this looks good.

Regards,
Bjorn
