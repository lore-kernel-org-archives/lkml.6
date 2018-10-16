Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0651FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19092086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLytGm88"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19092086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeJPWM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:12:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45700 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeJPWM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:12:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id u12-v6so11518791pfn.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 07:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+x5n83alBln1p8uwt58LcByYw3gX8JlkNuH56G5W06k=;
        b=bLytGm88me1DCa9ReKcoFq7lOdBw1xV4xtP3Gc+DOZNEul30cXogMjSE3rY7faTGlL
         DvWyL4DYjmoLsQkZlylDJLa8PIMgGtUt+2w/HCp4CGPrUmQKly7XrAjB6O4SoY6wskoY
         D9QE1IzzLfKzJmLzyV0h3YoA9MOCt6CtpGipA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+x5n83alBln1p8uwt58LcByYw3gX8JlkNuH56G5W06k=;
        b=WC0/M0+swj4tU0aY84lN0ghWUKnzvxAZdnsNaSMDKo6SxfPZUG3/Kn8hbvEBybbETR
         HqHNiFCTozJ4eeIpmEoK6U2Qr4Fhu1ARxOCjlNgpP4lXHeXABFcChiXi0XP9n7do32K3
         d2mEd1590jN8jd0KU7spYuFpFzy6GYrtPly6e2PfnCjECKFrCkYxlHFo6NHb2vEWNNic
         TroaoQve0V/cISSFaaqJmD3RA+cGbC3wovWGfoMOzWV4pMSDmuikQu7m5+YeO1bDmBso
         zHJhoNa9iLebU3z9hkMr+2+J6CgiqR2a4DHW4o/fc/aS+0wPZffvA4QO4d8QVUq4Pm4l
         sEXA==
X-Gm-Message-State: ABuFfohmHDsHZ5iSOKB0C0ue645imdooR1PPz0lu0+/Kb9Jbxjl4EC8H
        HCgDi5b6DM/lqVdpGOTm6Lnd
X-Google-Smtp-Source: ACcGV62HRwAUENeFxD7bAREKyJjCTrChaIUwX8khc93PvAf80Yn9H5oxAjVA7VECxkPBdbzRxcraNw==
X-Received: by 2002:a62:104b:: with SMTP id y72-v6mr22422985pfi.113.1539699706898;
        Tue, 16 Oct 2018 07:21:46 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id h5-v6sm17498913pfo.135.2018.10.16.07.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 07:21:46 -0700 (PDT)
Date:   Tue, 16 Oct 2018 19:51:38 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     heiko@sntech.de, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH] DT: rockchip: Fix stability issues with the
 'performance' governor on rock960
Message-ID: <20181016142138.GA24727@mani>
References: <1539698431-12616-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539698431-12616-1-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 04:00:20PM +0200, Daniel Lezcano wrote:
> When the performance governor is set as default, the rock960 hangs
> around one minute after booting, whatever the activity is (idle, key
> pressed, loaded, ...).
> 
> Based on the commit log found at https://patchwork.kernel.org/patch/10092377/
> 
> "vdd_log has no consumer and therefore will not be set to a specific
> voltage. Still the PWM output pin gets configured and thence the vdd_log
> output voltage will changed from it's default. Depending on the idle
> state of the PWM this will slightly over or undervoltage the logic supply
> of the RK3399 and cause instability with GbE (undervoltage) and PCIe
> (overvoltage). Since the default value set by a voltage divider is the
> correct supply voltage and we don't need to change it during runtime we
> remove the rail from the devicetree completely so the PWM pin will not
> be configured."
> 
> After removing the vdd-log from the rock960's specific DT, the board
> does no longer hang and shows a stable behavior.
> 
> Apply the same change for the rock960 by removing the vdd-log from the
> DT.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Tested on Rock960 v1.2 board, hence

Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks a ton!

Regards,
Mani

> ---
>  arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> index 6c8c4ab..56abbb0 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> @@ -57,18 +57,6 @@
>  		regulator-always-on;
>  		vin-supply = <&vcc_sys>;
>  	};
> -
> -	vdd_log: vdd-log {
> -		compatible = "pwm-regulator";
> -		pwms = <&pwm2 0 25000 0>;
> -		regulator-name = "vdd_log";
> -		regulator-min-microvolt = <800000>;
> -		regulator-max-microvolt = <1400000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		vin-supply = <&vcc_sys>;
> -	};
> -
>  };
>  
>  &cpu_l0 {
> -- 
> 2.7.4
> 
