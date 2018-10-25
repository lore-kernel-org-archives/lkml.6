Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59628C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF88620831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NAjhPP8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF88620831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeJYNu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 09:50:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35034 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeJYNu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 09:50:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id w5-v6so7834546wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 22:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UcUnx+qWOiyHXN9DSnuR8Jj6DG5LBNbTKJXt0guXxpc=;
        b=NAjhPP8XHY0z1fUHdEwHH2rbFOGLrSem7HMvR72KmwgaMUlalg6VHbEnvmLnG7LD8o
         Dz4HnkoA8OUyETUI51KuxNfjP1c+ObdPyuyxNA9QMdWDbSHwNUf9dw0oec5V0X1Qzdbf
         HqU03T9VcJ1NZQtmPw1IjrXbU1+efzq0XYBuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UcUnx+qWOiyHXN9DSnuR8Jj6DG5LBNbTKJXt0guXxpc=;
        b=kKSK86apSAJsYpnGZGjxYGZZyZQu7SLEAtqrgFe3YXAiCxuAtpQanAWecX5fEhBDN7
         ClzfF9s4rywcpHZDWXtSI2im3+aOXkFAomYqL22EWf3Bzf6wDe9D5bAYuynXt95rTOFJ
         P8dwZPih/cY8vvPkG7nJ1gw32DNbN5k9xtNTMu/ficGhBrZCzDQ8Lc9De7nViY4y9gwE
         zFYXY0TKJcvcNy3Ql0neYIgvTShTWlNoC5fi02FsHdZVmTGjN7acnPx6epw33/lbRE9k
         HVdXFLXHYpmkg4XbesqA0DrKOl8wmyZnZ9lzIk6FJdGjK/8M2o94woT4YkQ+hBnKvISM
         dbBg==
X-Gm-Message-State: AGRZ1gI/BN9RZwC8m8D+yRPsYq6V+s827lvD5Cy6OeL0W2+hL3pVPb9D
        lvfpDqtxi7j5QttPYZdsLo84wQ==
X-Google-Smtp-Source: AJdET5cYb+1Tc4iKrHhAw+YFlmgKCPrHimJA26sM1r5P1M3/UiRvHzFMguPjvyhZGvEhcypR/QDSKA==
X-Received: by 2002:a5d:4d46:: with SMTP id a6-v6mr149619wru.316.1540444761638;
        Wed, 24 Oct 2018 22:19:21 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id j46-v6sm11547514wre.91.2018.10.24.22.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 22:19:20 -0700 (PDT)
Date:   Thu, 25 Oct 2018 06:19:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sven Van Asbroeck <svendev@arcx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        andriy.shevchenko@linux.intel.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        yuanzhichang@hisilicon.com, stuyoder@gmail.com,
        linus.walleij@linaro.org, maxime.ripard@bootlin.com,
        bogdan.purcareata@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH anybus v1 2/4] dt-bindings: anybus-bridge: document
 devicetree binding.
Message-ID: <20181025051918.GC4939@dell>
References: <20181024142456.10084-1-svendev@arcx.com>
 <20181024142456.10084-3-svendev@arcx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181024142456.10084-3-svendev@arcx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2018, Sven Van Asbroeck wrote:

> This patch adds devicetree binding documentation for the
> Arcx anybus bridge.
> 
> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
> ---
>  .../bindings/mfd/arcx,anybus-bridge.txt       | 37 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt   |  1 +
>  2 files changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/arcx,anybus-bridge.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/arcx,anybus-bridge.txt b/Documentation/devicetree/bindings/mfd/arcx,anybus-bridge.txt
> new file mode 100644
> index 000000000000..3c0399c4ed45
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/arcx,anybus-bridge.txt
> @@ -0,0 +1,37 @@
> +* Arcx anybus bridge
> +
> +This chip communicates with the SoC over the WEIM bus. It is
> +expected that its Device Tree node is specified as the child of a node
> +corresponding to the WEIM bus used for communication.
> +
> +Required properties:
> +
> +  - compatible : The following chip-specific string:
> +        "arcx,anybus-bridge"
> +
> +  - reg :
> +	weim memory area where the cpld registers are located,	followed by:
> +	weim memory area of the first  anybus-s slot,		followed by:
> +	weim memory area of the second anybus-s slot.
> +
> +  - enable-gpios : the gpio connected to the bridge's 'enable gpio'.
> +
> +  - pwms : the pwm connected to the bridge's 'pwm input'.
> +
> +  - irq-gpios : the gpios connected to the bridge's interrupt lines.
> +	note that there is no need to provide the 'interrupts' property here.
> +
> +Example of usage:
> +
> +&weim {
> +	bridge@0,0 {

I haven't seen this syntax before.

It doesn't mean it's wrong, but will needs Rob et. al to cast an eye.

> +		compatible = "arcx,anybus-bridge";
> +		reg = <0 0 0x100>, <0 0x400000 0x800>, <1 0x400000 0x800>;
> +		fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
> +				0x00000000 0xa0000240 0x00000000>;

This needs to be documented.

> +		enable-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
> +		pwms = <&pwm3 0 571>;
> +		irq-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>,
> +					<&gpio1 5 GPIO_ACTIVE_HIGH>;

Tabbing.

> +	};
> +};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 2c3fc512e746..1bf07b20a8af 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -35,6 +35,7 @@ aptina	Aptina Imaging
>  arasan	Arasan Chip Systems
>  archermind ArcherMind Technology (Nanjing) Co., Ltd.
>  arctic	Arctic Sand
> +arcx	Arcx/Archronix Inc.
>  aries	Aries Embedded GmbH
>  arm	ARM Ltd.
>  armadeus	ARMadeus Systems SARL

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
