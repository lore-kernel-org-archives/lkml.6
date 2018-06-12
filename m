Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 23E74C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE59520693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNEL45Z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE59520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754206AbeFLE73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:59:29 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41470 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753202AbeFLE70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:59:26 -0400
Received: by mail-pl0-f66.google.com with SMTP id az12-v6so13632580plb.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 21:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ko8/2hUSLqVBxrBFBxEn/7fUe9jeZyvDGfSDgr+0dsI=;
        b=MNEL45Z4QgulrARS91dj14FLwHl9vH5JnzmCbZmneQiV4UjyE8ouNj4HQ2NmuDIkkO
         8/oKAAO73O3n3Mmdp14uROz+JRn5fWJV5bedsNfBZzefDOsMVZKHbEZ60zNGrc/hmsee
         Sf3Kf78fliYkg09PC+toTW5CJ9qJ3biSXAoAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ko8/2hUSLqVBxrBFBxEn/7fUe9jeZyvDGfSDgr+0dsI=;
        b=RiDoiyEmkY9eb36R9j7EBzoYcyl53MOlG/7iIryCsno1ih3qIi1xIEjgZGIKjS2pj2
         xSIjvRwmWkBRTnySvjDxJPou0muaX68BVKYwASzbXRIK8joNdpQMWSQFVfVgokxYp+aB
         /jM87njApzMehHBDOG1+4U8OzYd3b4oX+VRdqjtCi7jrK1rRWXhqHu3Sp79iHCS9FTcR
         gjSaLHBVIFmBSGJCPaHLCloJxcyBff3VMsITtKNVVTtD1Gr/WsjoSf01VZU5HOEZpTYg
         3aZ57kHu1Wupf8V7C05LqEGwVWhDQM4pS+WeQiEaq60TOI2EQMGR1e8YlTUC7KYZzb9Q
         lMUQ==
X-Gm-Message-State: APt69E1OGIS9V6KlZfAcZLivdbteONT0wV3CP+mWqaZnJtl+hv5IGHUy
        nbTE/2wCXtQq2YwPzXPIzmdW4w==
X-Google-Smtp-Source: ADUXVKLas/OC+XEIDMkUb8nT2ulhW8dxb8gNapqhXHzLd6Vvqbf3cD6Zetx9o6TiV+YMvk8BQVuwnQ==
X-Received: by 2002:a17:902:28c8:: with SMTP id f66-v6mr2362398plb.60.1528779565984;
        Mon, 11 Jun 2018 21:59:25 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c191-v6sm26561pfg.48.2018.06.11.21.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 21:59:25 -0700 (PDT)
Date:   Mon, 11 Jun 2018 22:01:36 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     andy.gross@linaro.org, rnayak@codeaurora.org,
        kramasub@codeaurora.org, sdharia@codeaurora.org,
        swboyd@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sdm845: Enable debug UART and
 I2C10 on sdm845-mtp
Message-ID: <20180612050136.GV510@tuxbook-pro>
References: <20180607204608.27688-1-dianders@chromium.org>
 <20180607204608.27688-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607204608.27688-2-dianders@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07 Jun 13:46 PDT 2018, Douglas Anderson wrote:

> The debug UART is very useful to have.  I2C10 is enabled as an example
> of a I2C port we can talk on for now.  Eventually we'll want to put
> peripherals under it.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 52 +++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index 979ab49913f1..e1eda143a725 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -12,4 +12,56 @@
>  / {
>  	model = "Qualcomm Technologies, Inc. SDM845 MTP";
>  	compatible = "qcom,sdm845-mtp";
> +
> +	aliases {
> +		serial0 = &uart9;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&i2c10 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +};
> +
> +&qupv3_id_1 {
> +	status = "okay";
> +};
> +
> +&uart9 {
> +	status = "okay";
> +};
> +
> +/* PINCTRL - additions to nodes defined in sdm845.dtsi */
> +
> +&qup_i2c10_default {
> +	pinconf {
> +		pins = "gpio55", "gpio56";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +};
> +
> +&qup_uart9_default {
> +	pinconf-tx {
> +		pins = "gpio4";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	pinconf-rx {
> +		pins = "gpio5";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +};
> +
> +&qup_uart9_sleep {
> +	pinconf {
> +		pins = "gpio4", "gpio5";
> +		bias-pull-down;
> +	};
>  };
> -- 
> 2.17.1.1185.g55be947832-goog
> 
