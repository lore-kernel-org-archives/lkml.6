Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED68C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D0520838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544226082;
	bh=/vFVuCmMmBnM1YfwMDuAUt/yWHB7VD0W4w7+CdaR6SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wTeMJJDW+ZvpZxncoicEuZ1ZtEKEywKMVVqXT4Pa5tHfTtMp6VXWfddk6gLPYPiqO
	 cwEuywiw5yBHnxIxTWOf+U00js2VyjhOfZNQtthnhLf3NcH9vw9VQOVDtL+kSD42G3
	 ryyQHfMUSErhv9AiONTLmIM9erhhGzt5/unBl5qw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D0520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbeLGXlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:41:20 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37907 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeLGXlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:41:20 -0500
Received: by mail-oi1-f196.google.com with SMTP id a77so4760396oii.5;
        Fri, 07 Dec 2018 15:41:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FThLvHYtzhh7fh5FRCCbMJ/T+i3MTpBuZnWYLFaoqkw=;
        b=iGW4Sz2EittZAMUWvfQRb5Y74BSc1SDrsFxirwMc/3vDpXx1PQR5Sv4v9z9GvSIZzX
         ZIfPjaShvNDfhm2SGj/PQNaKJ+1rIfi/3ZeYw9HM/MRqvVOghCNkdi6kGtZ4H229bD5r
         iWtB6y61AK8qGE7UneC18B7vRYa/DBKHOlTK/UZ5gbaAPJWZrsuQrvM+2wxYAMmjZRY2
         IpNQynDH6rjg6wfoNjKDBo6ydNbVc//Odw1n5EnS0Sbf0fy7sM8IL1f30LfwJ1Pbkdxl
         /tYI8x1a3YolftO7KzrHLkUoPbJ2DFYxD0uEqexJ35fv4T25ocTA8vKxGH0VgIQpu29H
         HCDA==
X-Gm-Message-State: AA+aEWYeB8IGXA53U+xD+PBoClJTteDOhmA8KuHktsJEdC7VAaEMzomI
        FVqLehp2xemVJkiyJQY71Q==
X-Google-Smtp-Source: AFSGD/VMnwEVB3WS+uzno7tLhRy5t28oP/Goob78P3aKFQ1HB9m8hB12LCm2LGaFd4gR5Ef/NttGsQ==
X-Received: by 2002:aca:b707:: with SMTP id h7mr2275856oif.89.1544226079294;
        Fri, 07 Dec 2018 15:41:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o189sm2245305oif.23.2018.12.07.15.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 15:41:18 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:41:18 -0600
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
Subject: Re: [PATCH v3 12/15] dt-bindings: serial: Document RDA Micro UART
Message-ID: <20181207234118.GA16289@bogus>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
 <20181128135106.9255-13-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181128135106.9255-13-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 07:21:03PM +0530, Manivannan Sadhasivam wrote:
> From: Andreas Färber <afaerber@suse.de>
> 
> Add an initial binding for the UART in RDA Micro RDA8810PL SoC.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/serial/rda,8810pl-uart.txt           | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt b/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
> new file mode 100644
> index 000000000000..ee03116d7415
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
> @@ -0,0 +1,15 @@
> +RDA Micro UART
> +
> +Required properties:
> +- compatible :  "rda,8810pl-uart" for RDA8810PL SoCs.
> +- reg        :  Offset and length of the register set for the device.
> +- interrupts :  Should contain UART interrupt.

Uarts generally need a clock.

> +
> +
> +Example:
> +
> +		uart2: serial@20a90000 {
> +			compatible = "rda,8810pl-uart";
> +			reg = <0x20a90000 0x1000>;
> +			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> -- 
> 2.17.1
> 
