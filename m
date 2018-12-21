Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77754C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E4221920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N5wVGd5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403978AbeLUOsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:48:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34310 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403932AbeLUOsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:48:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so5549102wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 06:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jBvUjJGmLfm+76HsCp+hk+XimqnVcVgnpBrUs8HKzik=;
        b=N5wVGd5unGUPunNqOJWBfU7s0/2sbkd5lxQfx7kHu26fkXv3PhHVou/h2SLimkHw5N
         gjL4dP0OIyex+2UYyOv7AddxRPk1BOb1s75Bm9Ac7i7TN35+0gR12SeygFctQTY0SgF8
         eMvvbH+lwjnUFIhPpCX/0nUWP326xDUjv1tEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jBvUjJGmLfm+76HsCp+hk+XimqnVcVgnpBrUs8HKzik=;
        b=sXc99nON6+kLD5YN1d/xwbvGM35WDOxbsTOOjVsVRgXRQtLEqdKKth6NE1WkHNMjy7
         AOvsOduFlmkUJ3Ks5xvzh8O2NoVY7uvxqd7OCugUXMk0ZXVb6vx44thSOHl/YWEGxnQf
         BMWk/2PZx9p1xC75VyeMe+Ie1IOD4TLPjoxw39mblDkYiJv5FxcsjPgrwEYVFvruKSXk
         2IXB3kbhLD+yt4XOt9vHRYuXbvFsEKOOm3YEszOMyvGMgkCu/qZK5DbAEbErf3RjxQTU
         RMUL05loWQlMArVMUmCtn7eYODOjfl/PPAr0ixRa4c3/TIi4BjolGPtjRcQ9ATDpvbxa
         53Jw==
X-Gm-Message-State: AJcUukcdHltMtuFELpf3lxgtd1z6n8fklBMVsZ9ceAWYO0DGfMCK+NiW
        YgLJ1PQr9hL8W0r8xbHovytCfA==
X-Google-Smtp-Source: ALg8bN62lQiGh2WHQCq3RwdChhlNhRozCoVNM+FxJygdzB0zlp1EbeJrTzxeJJhVpqK6jrKo0p/QcA==
X-Received: by 2002:a5d:6152:: with SMTP id y18mr3073432wrt.141.1545403677092;
        Fri, 21 Dec 2018 06:47:57 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id f18sm8925747wrs.92.2018.12.21.06.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 06:47:56 -0800 (PST)
Date:   Fri, 21 Dec 2018 14:47:54 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Wu Hao <hao.wu@intel.com>,
        Tomohiro Kusumi <kusumi.tomohiro@gmail.com>,
        "Bryant G . Ly" <bryantly@linux.vnet.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        David Kershner <david.kershner@unisys.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Johan Hovold <johan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Subject: Re: [PATCH v9 07/12] dt-bindings: mfd: Add a document for PECI
 client MFD
Message-ID: <20181221144754.GS13248@dell>
References: <20181218210417.30140-1-jae.hyun.yoo@linux.intel.com>
 <20181218210417.30140-8-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181218210417.30140-8-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018, Jae Hyun Yoo wrote:

> This commit adds a dt-bindings document for PECI client MFD.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: James Feist <james.feist@linux.intel.com>
> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Vernon Mauery <vernon.mauery@linux.intel.com>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mfd/intel-peci-client.txt        | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/intel-peci-client.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/intel-peci-client.txt b/Documentation/devicetree/bindings/mfd/intel-peci-client.txt
> new file mode 100644
> index 000000000000..5d1d5d0a552f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/intel-peci-client.txt
> @@ -0,0 +1,34 @@
> +* Intel PECI client bindings
> +
> +PECI (Platform Environment Control Interface) is a one-wire bus interface that
> +provides a communication channel from PECI clients in Intel processors and
> +chipset components to external monitoring or control devices. PECI is designed
> +to support the following sideband functions:
> +
> +- Processor and DRAM thermal management
> +- Platform Manageability
> +- Processor Interface Tuning and Diagnostics
> +- Failure Analysis
> +
> +Required properties:
> +- compatible : Should be "intel,peci-client".
> +- reg        : Should contain address of a client CPU. According to the PECI
> +	       specification, client addresses start from 0x30.
> +
> +Example:
> +	peci-bus@0 {
> +		compatible = "vendor,soc-peci";
> +		reg = <0x0 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		peci-client@30 {
> +			compatible = "intel,peci-client";
> +			reg = <0x30>;
> +		};
> +
> +		peci-client@31 {
> +			compatible = "intel,peci-client";
> +			reg = <0x31>;
> +		};

The PECI Client driver (masquerading as an MFD driver in this set)
doesn't actually do anything special.  Instead of detailing it here,
register the child devices directly instead.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
