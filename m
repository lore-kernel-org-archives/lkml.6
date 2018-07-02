Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F133DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 04:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB67256AB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 04:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKCMlkVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB67256AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753210AbeGBEwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 00:52:18 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42291 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751922AbeGBEwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 00:52:09 -0400
Received: by mail-pg0-f68.google.com with SMTP id c10-v6so6553401pgu.9
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 21:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IhejKG3CgaidyoORaSHR4+Xcr/bkj6kYj2jcTDA/x9Q=;
        b=MKCMlkVFHF1HZZZc7ri0xKuZ0x4DIg9vcDK4Pn0slfDTVuSBbxpVcTr57yyasDse36
         30jZe1vDz5yYIY4lEUrMny3XeX1SSgyCveNc+2UfO/wjh/Q/jvM213B+6T9VdJ2IrRfm
         Ltt2Ek2jCpTO7wQaf9MIk/4rYubHRwmkKhfbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IhejKG3CgaidyoORaSHR4+Xcr/bkj6kYj2jcTDA/x9Q=;
        b=tuoApurBZWh+/shDk3Y+LFvtrjo8EhOP5qWSLYFqHjx5knKWfb8LslVx6//vIk/qCB
         RBVduCG7YFSQ0jrx7fLpKp2oHHh6jWBlpVDIbiO3h6kkBXlDA4Yg8CphVe+8m4QR0qRt
         oCAmVRvLQF6mKP2IOuvmwagce+6wC2twZ3ffweGHKRzTp73dMFcFerC9CLwM6t8SUsoW
         4y/md+KXcc+DfomVTc5bPbOffchCylc8Yc4uDA3X2nWtANfcfgh8EadBM5RLw7HBmj7u
         lsXCHvoGTXJULDclU3HY1v8iK1viYIu6ihMtvTbfUYWkUK/fJNe6pRjEBMn69nuxFKcX
         J/8A==
X-Gm-Message-State: APt69E3IXsCM2/ACUSbMCRdjZ2w4IvRJpWoYUEdiZ5uNsaXSapTi8mAw
        nf9icccmwcoiMN2LHJHZ8sbevQ==
X-Google-Smtp-Source: ADUXVKKM0Dm4XTqetBaJpXafOV606h2GnnQrb1E08LBkvck2MkzX/Td8umhGLVDw5N+xj4YUY/xiKA==
X-Received: by 2002:a63:6e07:: with SMTP id j7-v6mr20800993pgc.251.1530507128590;
        Sun, 01 Jul 2018 21:52:08 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id f10-v6sm19109642pgr.30.2018.07.01.21.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 21:52:07 -0700 (PDT)
Date:   Mon, 2 Jul 2018 10:22:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?Q?S=C3=A9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] ARM: dts: imx6ull: add operating points
Message-ID: <20180702045205.fdh4dwwhwyfftptl@vireshk-i7>
References: <20180629145221.10393-1-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180629145221.10393-1-sebastien.szymanski@armadeus.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-18, 16:52, Sébastien Szymanski wrote:
> i.MX6ULL has different operating ranges than i.MX6UL so add the
> operating points for the i.MX6ULL and removed them form board device

s/removed/remove/
s/form/from/

> trees. A 25mV offset is added to the minimum allowed values like for the
> i.MX6UL.
> The valid frequencies are now selected by the cpufreq driver according
> to ratings stored in fuses since commit 0aa9abd4c212 ("cpufreq: imx6q:
> check speed grades for i.MX6ULL")
> 
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>  arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi | 14 --------------
>  arch/arm/boot/dts/imx6ull.dtsi              | 19 +++++++++++++++++++
>  2 files changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
> index 3dffbcd50bf6..183193e8580d 100644
> --- a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
> +++ b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
> @@ -20,20 +20,6 @@
>  
>  &cpu0 {
>  	clock-frequency = <792000000>;
> -	operating-points = <
> -		/* kHz	uV */
> -		792000  1225000
> -		528000	1175000
> -		396000	1025000
> -		198000	950000
> -	>;
> -	fsl,soc-operating-points = <
> -		/* KHz	uV */
> -		792000  1175000
> -		528000	1175000
> -		396000	1175000
> -		198000	1175000
> -	>;
>  };
>  
>  &iomuxc {
> diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
> index ebc25c98e5e1..ade64bd46fab 100644
> --- a/arch/arm/boot/dts/imx6ull.dtsi
> +++ b/arch/arm/boot/dts/imx6ull.dtsi
> @@ -48,6 +48,25 @@
>  /* Delete CAAM node in AIPS-2 (i.MX6UL specific) */
>  /delete-node/ &crypto;
>  
> +&cpu0 {
> +	operating-points = <
> +		/* kHz	uV */
> +		900000	1275000
> +		792000	1225000
> +		528000	1175000
> +		396000	1025000
> +		198000	950000
> +	>;
> +	fsl,soc-operating-points = <
> +		/* KHz	uV */
> +		900000	1175000
> +		792000	1175000
> +		528000	1175000
> +		396000	1175000
> +		198000	1175000
> +	>;
> +};
> +
>  / {
>  	soc {
>  		aips3: aips-bus@2200000 {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
