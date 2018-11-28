Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D40C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C91C2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YOCiG5s5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C91C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbeK1U3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:29:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39314 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbeK1U3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:29:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so17562161wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=J2KaQppUb7HoYan5jNxZK54Kvo3hccmWf4TfzYENl5I=;
        b=YOCiG5s5IXIfFKf/4VjDF86d+GktK3ExgK4YJ4D0NPZ1APPU4YOsYdABvHqn+ihIWk
         o1GKk2BIwqKAJfJJiEFAbiUZcI+oxyEUCgNnSaEyECS6LkAkq85ucCAgMAmhHqWozm8Z
         tNl/jEoUfFCDUI5pyJEsQB2uBU86uuIWeoodo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=J2KaQppUb7HoYan5jNxZK54Kvo3hccmWf4TfzYENl5I=;
        b=AfxzTG9zPCG7MNaAL9QcXvW5Y/LWqL88ZiXxUrlzN8apGCrZAdZRvwvehO6fVpiSlg
         cvYK6jdIWF5iWLyTcJRKnGPy2/BgDgCDrR2i5IvOZg+iMShNeJfEpiBVR8C0E0PI5W9A
         GA8mq3GZ03vXcCOkimUPGtpmtOLPBB4zIU5qXDSXeFPlp/vApRsCutaZeocPszBFx+7c
         hXmm6fLQRXpQlVjT52qIpAWp07KekGhGAwAV6sRLSReFw7F5e6c/99zQDlquRjdye9ZP
         Jb+jd9vMwuaw8lvd+3V0dW5jCn8r+WRfObx97vKC1XTO4lmwXUAuUqGb1EHFpR2RkRsk
         alrQ==
X-Gm-Message-State: AA+aEWZ2GsFG9S7ORrQQUTkVGBdnGHa+WB0TkWQ8TJSgd+lva/Q3ENyU
        StppqLNxvr1Fl6vdRoSGDfT2Aw==
X-Google-Smtp-Source: AFSGD/Vk6q+yNtWwVrwxAgPk4DA3+Bj8NJSfHCtXnmPTWBdkJzl5ffTuH7VLUUEAOOE5KMCQi/1lvQ==
X-Received: by 2002:adf:e608:: with SMTP id p8mr30576609wrm.166.1543397323851;
        Wed, 28 Nov 2018 01:28:43 -0800 (PST)
Received: from dell ([2.31.167.233])
        by smtp.gmail.com with ESMTPSA id x10sm6387635wrn.29.2018.11.28.01.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:28:43 -0800 (PST)
Date:   Wed, 28 Nov 2018 09:28:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Priit Laes <plaes@plaes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH 05/14] dt-bindings: mfd: axp20x: add support for
 regulator-ramp-delay for AXP209
Message-ID: <20181128092841.GY4272@dell>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <4333f81dfa1d9be082b09ab9ddf2694cb56285e2.1543245984.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4333f81dfa1d9be082b09ab9ddf2694cb56285e2.1543245984.git-series.plaes@plaes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018, Priit Laes wrote:

> From: Olliver Schinagl <oliver@schinagl.nl>
> 
> The AXP209 supports ramping up voltages on several regulators such as
> DCDC2 and LDO3, therefore we can use the standard 'regulator-ramp-delay'
> property for those 2 regulators.
> 
> Note that the voltage ramp only works when the regulator is already
> enabled. E.g. when going from say 0.7 V to 3.6 V.
> 
> When turning on the regulator, no voltage ramp is performed in hardware.
> 
> What this means, is that if the bootloader brings up the voltage at 0.7 V,
> the ramp delay property is properly applied. If however, the bootloader
> leaves the power off, no ramp delay is applied when the power is
> enabled by the regulator framework.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index 188f037..5542212 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -32,6 +32,11 @@ Required properties:
>  - interrupt-controller: The PMIC has its own internal IRQs
>  - #interrupt-cells: Should be set to 1
>  
> +Supported common regulator properties, see regulator.txt for more information:

regulator.txt should be a relative path.

../regulator/regulator.txt in this case.

Once changed, please apply my:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
