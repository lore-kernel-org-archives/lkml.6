Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEE4C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F93320837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544226000;
	bh=e+i18ptXgWFt9j8GyC6dvfmEiCo969yuO/b4JWxR4lE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v+rI//g6JKqj/43ACkuesLvC6mZ2vRLrwPGouDu0GYCaVWYVmrhNEw72QsXobc2KA
	 mox3WvGH+TR8wG1BWFZ4aucU3stPV+fQ5ba5pP6cYFhwT6y+eInOmJp+exBT9I3yNY
	 VrlcAeh441X08pyC7SZI6d+Re3cOJpnI+tW9bcro=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F93320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbeLGXj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:39:59 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42844 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeLGXj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:39:59 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so5387579otk.9;
        Fri, 07 Dec 2018 15:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XyOqOJY4BnIwvTKXSdaA9jGeql9SaNqvcpghlgdK8rU=;
        b=K6SixG/SnStLbCtjT+0EaaJYh4bE/Y6QFzpt0O1NKQgiz5JuiL2vETKRl9SnVmZ+hY
         WjgDSEshJASg+vDP/4vmLXnJDeQDBDr6dOiyolk7pyckxcR333PMvV8GuDZQRYNWRAJR
         qjOD8yLYLqbqo7dFtvjHiOWpOmzhWH3Um0V7i20oKnNEeMRno6AkqJHK4vSnfICdzd0/
         P9N3sqWOT3QX7B9kgKdxg3kzLzNBAQZvUdDVosgCjtfQwA3W+qp6ta3UX9teoobJQ5vx
         FoBAVSE7zlkMI5xSHJmB0RHras9N/okyZMPiUhuCT0jWvjlhqVLu2EM5l0xhi0eK0RDv
         J0WQ==
X-Gm-Message-State: AA+aEWYyBRYsZMV5fm3elIJlI+KHsIA5luhS0PMX8eDQ6juyzfVDW3QR
        LN8S1F2cDr+Ktw2cf6h5Iw==
X-Google-Smtp-Source: AFSGD/U4Y49ev6bzFuxYTMZ2wYZWPqMz0+ZO3IZbz6G0EMcuqJ+vxaNAHMu2Pq0lMS1VQBr9c5chwQ==
X-Received: by 2002:a9d:2015:: with SMTP id n21mr2957154ota.289.1544225998071;
        Fri, 07 Dec 2018 15:39:58 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w17sm2187881otk.12.2018.12.07.15.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:39:57 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:39:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     olof@lixom.net, arnd@arndb.de, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net, overseas.sales@unisoc.com
Subject: Re: [PATCH v3 09/15] dt-bindings: timer: Document RDA8810PL SoC timer
Message-ID: <20181207233956.GA13852@bogus>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
 <20181128135106.9255-10-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128135106.9255-10-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 07:21:00PM +0530, Manivannan Sadhasivam wrote:
> Document RDA Micro RDA8810PL SoC timer.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/timer/rda,8810pl-timer.txt       | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
> new file mode 100644
> index 000000000000..06cc2b00be12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
> @@ -0,0 +1,21 @@
> +RDA Micro RDA8810PL Timer
> +
> +Required properties:
> +- compatible      :  "rda,8810pl-timer"
> +- reg             :  Offset and length of the register set for the device.
> +- interrupts      :  Should contain the interrupts.

How many?

> +- interrupt-names :  Valid names are: "hwtimer", "ostimer".

It's more than just valid names, but rather must be those 2 strings.

> +                     See ../resource-names.txt
> +
> +Example:
> +
> +		apb@20900000 {
> +			compatible = "simple-bus";
> +			...
> +			timer@10000 {
> +				compatible = "rda,8810pl-timer";
> +				reg = <0x10000 0x1000>;
> +				interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
> +					     <17 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-names = "hwtimer", "ostimer";
> +			};
> -- 
> 2.17.1
> 
