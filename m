Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827F5C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508BA205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547586512;
	bh=yevKcF954BE7mM3Xu241ckLM3kiOZ7uqMctA8K/2sqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UWM9mAaugleHv7lJnltDGCmB+pKZ9q8YB0xet8Lu9NRQpSVjocPvgMKPzrhldtVv5
	 bFjkAGZqwgI9y7oy6AwT82Cq0EbILYVMevfN0XjokHkR3B59qZDkv5DSVe4Xpid+Pn
	 na1XIKMjIZSwQctckC6tKO4ff41Dr830QHPehu3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390222AbfAOVIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:08:30 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38484 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbfAOVIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:08:30 -0500
Received: by mail-ot1-f68.google.com with SMTP id e12so3902380otl.5;
        Tue, 15 Jan 2019 13:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ief8Sahwz9dleuFZ1PF7fq768QfDizjpb918XybQ2RY=;
        b=i4UUp4LJpmH/fgwk6ElJ5OxnOUEWa9uj3d/34X0tbUqoDT0t4LB9hlvBitefczau1U
         wCWW7uIbzFC677Iti5BBIKLXyqLs7SSIflTlVA/WXGqF96kO2qSIG0ZYZLlBqb3oWGZ4
         Ornx0pDma+YYCatpWGVTIYZUBiP5LXFxkBw6ll/1xyFhz5ye298/trWTmuuie9UPzvI1
         +A+3r2xbcacpO9A62dteFxXa3IanoBn02CA18La1HMtziR4vK7sL7e1p4qH1IvoGDZvD
         VGSqBeA3oj4i8AbytFu022EjRCRBt1G6OfHl4IytqGV2Q4usAKnv3+vDMeGSbdlvWIO6
         12YQ==
X-Gm-Message-State: AJcUukf5/q1rS/ds17IoRHjtCpsAdLZR3mHSleFgnZwJt3eetkiULXyj
        6h2eqcp3/8EwS7aG5rFvgA==
X-Google-Smtp-Source: ALg8bN5xnPASuqM9X7l7AlaWtkvR9n7xo0E4HvL2pBfHvPB1gLhCPGnfWehNEKzkAUwq3Lzr1Hl1cA==
X-Received: by 2002:a05:6830:1c5:: with SMTP id r5mr3564589ota.356.1547586509003;
        Tue, 15 Jan 2019 13:08:29 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id q131sm2022121oih.1.2019.01.15.13.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 13:08:28 -0800 (PST)
Date:   Tue, 15 Jan 2019 15:08:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Urs =?iso-8859-1?Q?F=E4ssler?= <urs.fassler@bbv.ch>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v2 3/5] dt-binding: pcf85063: add xtal load capacitance
Message-ID: <20190115210827.GA25046@bogus>
References: <20190108185414.26922-1-sam@ravnborg.org>
 <20190108185414.26922-4-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190108185414.26922-4-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 07:54:12PM +0100, Sam Ravnborg wrote:
> The NXP pcf85063 supports two different xtal load capacitance
> - 7000fF  (7pF)    HW default, Linux driver default
> - 12500fF (12.5pF) Minimum power consumption
> 
> To obtain a precise RTC the pcf85063 must be configured
> with the correct capacitance load of the xtal.
> 
> Add a property to specify the xtal capacitance load.
> The default value matches that of the current Linux driver.
> 
> With a dedicated binding remove the entry in rtc.txt
> 
> Signed-off-by: Søren Andersen <san@skov.dk>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Urs Fässler <urs.fassler@bbv.ch>
> ---
>  Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt | 18 ++++++++++++++++++
>  Documentation/devicetree/bindings/rtc/rtc.txt          |  1 -
>  2 files changed, 18 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
> new file mode 100644
> index 000000000000..ad5e8eaa370e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf85063.txt
> @@ -0,0 +1,18 @@
> +* NXP PCF85063 Real Time Clock
> +
> +Required properties:
> +- compatible: Should contain "nxp,pcf85063".
> +- reg: I2C address for chip.
> +
> +Optional property:
> +- quartz-load-femtofarads: The capacitive load of the quartz(x-tal),

Probably should put this in rtc.txt so it can be shared.

> +  expressed in femto Farad (fF). Valid values are 7000 and 12500.
> +  Default value (if no value is specified) is 7000fF.
> +
> +Example:
> +
> +pcf85063: pcf85063@51 {

rtc@51

> +	compatible = "nxp,pcf85063";
> +	reg = <0x51>;
> +	quartz-load-femtofarads = <12500>;
> +};
> diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
> index e07b15d151ac..efac6dc5b914 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc.txt
> @@ -52,7 +52,6 @@ microcrystal,rv3029	Real Time Clock Module with I2C-Bus
>  nxp,pcf2127		Real-time clock
>  nxp,pcf2129		Real-time clock
>  nxp,pcf8563		Real-time clock/calendar
> -nxp,pcf85063		Tiny Real-Time Clock
>  pericom,pt7c4338	Real-time Clock Module
>  ricoh,r2025sd		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
>  ricoh,r2221tl		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
> -- 
> 2.12.0
> 
