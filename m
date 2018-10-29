Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E622EC6786F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB79120843
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQID3cGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB79120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeJ2KZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 06:25:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38158 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbeJ2KZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 06:25:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id f8-v6so3073645pgq.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 18:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kR6i6dEM5L8jvQziX4axM0i1MuEPrKecct7qpmb4utc=;
        b=ZQID3cGwsRbpIhtGn+RQhMexXvCe27aEAuJt0lRFWIWedrbYtRs/mcbme3D/olCqDp
         bVbMbn7XBSrI4350m+jqQVtN/YWBMjQyxwW9ztEfjPS4PPoi1hCykAfZXy6uophYWs2T
         X1Ku/dlvmaTztuCoQv5iDbfWSNYcLUhdXILDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kR6i6dEM5L8jvQziX4axM0i1MuEPrKecct7qpmb4utc=;
        b=a2JeL1sIoKQS8ssNxDYSSXlK/n30CcD2kyoxzi4jR/g26s5n7dnNPx3lbag4HxZFkd
         cDlLT4aGpBdh9SF6qYZbkZWLCxjWhGBXJno87m+aUMNYirqh8RcReuXuQOyJwKpfqv6D
         oxGhbqyTHC/dhOnRNTCdooOjbPb51MqMyS34sgBtwdG0WcZDcPM9I5Z0ehvonVkMJaSm
         X8tbVnNxsIl10oacz3aeakohwZo0iPVvQugZPyW16l3Fv4u9q5VvXY6iKm+OMJUqh1sG
         uR/YumoCByVm60iHZIDPeP8d4u3T/nUYXAQbgEHFchVItYbteLg0/TwS5azlGmZXVURW
         Rejw==
X-Gm-Message-State: AGRZ1gIKEr/X7KvrjHe7QJerNfKKBfCasDiy2ZFsli5O2KczpSvfNm19
        ibvqybHfwxOWnpJ7qGraoTM8ig==
X-Google-Smtp-Source: AJdET5eeRHspcOQg2rpKsqUYXdIklm5NeZULgS0kdl77TU0fcgm6ZBGmxl0lYIlAxJD0iA9+5jQ87A==
X-Received: by 2002:a62:32c4:: with SMTP id y187-v6mr13160728pfy.4.1540777152223;
        Sun, 28 Oct 2018 18:39:12 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 3-v6sm20861664pga.12.2018.10.28.18.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 18:39:11 -0700 (PDT)
Date:   Sun, 28 Oct 2018 18:39:08 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        dianders@chromium.org, evgreen@chromium.org, benchan@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Add reserve-memory nodes
Message-ID: <20181029013908.GD1855@tuxbook-pro>
References: <20181026122745.5094-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026122745.5094-1-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26 Oct 05:27 PDT 2018, Sibi Sankar wrote:

> Add reserve-memory nodes for mpss and mba required for
> remoteproc mss pil.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index d3fe012ad84e..f74892e447f9 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -88,6 +88,16 @@
>  			reg = <0 0x86200000 0 0x2d00000>;
>  			no-map;
>  		};
> +
> +		mpss_region: reserved-memory@8e000000 {
> +			no-map;
> +			reg = <0 0x8e000000 0 0x7800000>;
> +		};
> +
> +		mba_region: reserved-memory@96500000 {
> +			no-map;
> +			reg = <0 0x96500000 0 0x200000>;
> +		};
>  	};
>  
>  	cpus {
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
