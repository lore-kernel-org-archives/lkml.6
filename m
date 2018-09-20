Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA592C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567EE21532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vGpTwZ++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567EE21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388251AbeIUCGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:06:31 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36264 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeIUCGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:06:31 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A2E661C86;
        Thu, 20 Sep 2018 22:21:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1537474876;
        bh=skZjKh8hJaHWnEN+2VQvCQPBzit+qp2hRFCU1ZkhgYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vGpTwZ++JmNhL4gYz0nZ+zWPWBXPzpHPEJTJ0ziHPRD6hYZL85BigbilJu5276ye7
         qxRfCxetm07jXNk2tgEk179ZWBIuT/E98M3VyFWZ9cOcE68eYcyfEfc8BQ+rsnAUtE
         VTZMKUzEnBsneR97XN/GONHkeWo0MDYb+isvZt0I=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] [media] ad5820: DT new optional field enable-gpios
Date:   Thu, 20 Sep 2018 23:21:28 +0300
Message-ID: <1939782.bRt5jKDIiS@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180920161912.17063-3-ricardo.ribalda@gmail.com>
References: <20180920161912.17063-1-ricardo.ribalda@gmail.com> <20180920161912.17063-3-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Thursday, 20 September 2018 19:19:11 EEST Ricardo Ribalda Delgado wrote:
> Document new enable-gpio field. It can be used to disable the part
> without turning down its regulator.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  Documentation/devicetree/bindings/media/i2c/ad5820.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> b/Documentation/devicetree/bindings/media/i2c/ad5820.txt index
> 5940ca11c021..07d577bb37f7 100644
> --- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> +++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
> @@ -8,6 +8,11 @@ Required Properties:
> 
>    - VANA-supply: supply of voltage for VANA pin
> 
> +Optional properties:
> +
> +   - enable-gpios : GPIO spec for the XSHUTDOWN pin.

xshutdown is active-low, so enable is active-high. Should this be documented 
explicitly, to avoid polarity errors ? Maybe something along the lines of

- enable-gpios: GPIO spec for the XSHUTDOWN pin. Note that the polarity of the 
enable GPIO is the opposite of the XSHUTDOWN pin (asserting the enable GPIO 
deasserts the XSHUTDOWN signal and vice versa).

> If specified, it will be
> +     asserted when VANA-supply is enabled.

That documents a driver behaviour, is it needed in DT ?


>  Example:
> 
>         ad5820: coil@c {
> @@ -15,5 +20,6 @@ Example:
>                 reg = <0x0c>;
> 
>                 VANA-supply = <&vaux4>;
> +               enable-gpios = <&msmgpio 26 GPIO_ACTIVE_HIGH>;
>         };

-- 
Regards,

Laurent Pinchart



