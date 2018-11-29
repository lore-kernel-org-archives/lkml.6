Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CA8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD86A20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMP8St01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD86A20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbeK3D4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:56:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45196 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeK3D4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:56:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so1164516pgc.12;
        Thu, 29 Nov 2018 08:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MKKlzWucxfhJmlM3Jz1lg45wY166ncVbnW8yJP+zENU=;
        b=aMP8St01wi6M4tlZYZOESFvcwGmz71dau4wMCv+ttSWvJxdJ10hxRU8CqdCBVIxKhB
         KNqKf0aaWAM68dE/FjbDK1HWO5zNu6cvD60DL6vkDTAWI3oA3yQtLHnfKoOe0L6Hy7/R
         /tZornfdSzk7o/uLJEWemYIaPiSwYRllEl3+zHDIhu6HSX5FTAWBc5brejvp+jnliFwV
         xKja1ZCK28xFoowjyGhsR6W3o+SYka0fv/MquefflaoVIP6O30EJSpS9GqBbbtP9LTIE
         feopc2DR7YqVbDihwV/KVEP53O0/hpmmfmRMZ7oFrLHNS4xshM1XRRP9lV3Ix07I4jXO
         UIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MKKlzWucxfhJmlM3Jz1lg45wY166ncVbnW8yJP+zENU=;
        b=VWok8F9aiygZifGwzcDKMR8qTDJRq/fCO2Bp5PA1ba8zCxpJdXYsKxkP+eOnGvExUH
         0vKKQM+FFNyYcRVP4+VHtsYSLmvtsHixu0CAJh1vPlN4iyDwC0TKRExAhVWRAWYBS2GE
         Moe57nwvAjDUNC9eiO87rVzU1bnD750jYas8D7bkUVA4MoX6m7Cb55sRdPmA9f2S/vcR
         UHdLmD0JujeHlAJKSVEU3JgRmlObWFNu0PgVy7A0/4dlSo/1pwyvfiCN7D+Q87H2gvJH
         udtOE0R7YJENrLcRr4mS+7W+wMdLMJ8B7AqUs7/rhyMCizBGm6fMhtEuMnzF6bqgl2Pd
         EalA==
X-Gm-Message-State: AA+aEWZcOpn6mzhhrqv96NnD9p855RVWH4ZkFqxCt/xlOfoRjjzAvs9s
        Naayxz4F+AlEFoZ0KXQW/VQ=
X-Google-Smtp-Source: AFSGD/VcWJdcp9Dnc0FFy7Z/K+/ICn9bDrZdkYhgYzDtxxqfunNNjOfLaHsLTfGqnR2vmM29Iyqq6g==
X-Received: by 2002:a62:4714:: with SMTP id u20mr2073253pfa.144.1543510211108;
        Thu, 29 Nov 2018 08:50:11 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id k63sm8081914pfc.76.2018.11.29.08.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 08:50:10 -0800 (PST)
Date:   Thu, 29 Nov 2018 08:50:07 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V4 4/4] ARM64: dts: imx: add i.MX8QXP thermal support
Message-ID: <20181129165006.GC2688@localhost.localdomain>
References: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
 <1543458696-4741-5-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543458696-4741-5-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 02:37:47AM +0000, Anson Huang wrote:
> Add i.MX8QXP CPU thermal zone support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> ChangeLog:
> V3->V4:
>   *move the tsens node to inside of SCU node as it is belonging to SCU.
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 9b08688..48f622c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/firmware/imx/rsrc.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/pinctrl/pads-imx8qxp.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  #include "imx8-ca35.dtsi"
>  
> @@ -87,6 +88,12 @@
>  		rtc: rtc {
>  			compatible = "fsl,imx8qxp-sc-rtc";
>  		};
> +
> +		tsens: thermal-sensor {
> +			compatible = "fsl,imx8qxp-sc-thermal";
> +			tsens-num = <1>;
> +			#thermal-sensor-cells = <1>;
> +		};
>  	};
>  
>  	adma_subsys: bus@59000000 {
> @@ -410,4 +417,24 @@
>  		#size-cells = <1>;
>  		ranges = <0x5f000000 0x0 0x5f000000 0x1000000>;
>  	};
> +
> +	thermal_zones: thermal-zones {
> +		cpu-thermal0 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <2000>;
> +			thermal-sensors = <&tsens 355>;
> +			trips {
> +				cpu_alert0: trip0 {
> +					temperature = <107000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};

A passive trip but no cooling maps?

> +				cpu_crit0: trip1 {
> +					temperature = <127000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
>  };
> -- 
> 2.7.4
> 
