Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF23ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1FB20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 10:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rNIWs6Ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1FB20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeINPOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 11:14:05 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33136 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeINPOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 11:14:05 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:44f6:3500:d929:375b:d608:66c7])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9713CCE;
        Fri, 14 Sep 2018 12:00:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536919216;
        bh=fkLDJ1vcjotoev74fEWdu5Z6ky57HKqSmdVCAeaRR0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNIWs6EpF0YE3kX//u4gQe3zLf1H4WG4l0aHhvRMYp9Fsb3X6cs4yAPUcY5cjZoB9
         SilGEDHqyPyal8tAsWzGYH22M7V2AkpV5jFbyw95SggEkiBE3S5FhwuDiSF07i+bMU
         XBKp5EUH+M8DGBt0CA+U0PvECU90wa/dcctiWW4w=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     linus.walleij@linaro.org, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        p.zabel@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, architt@codeaurora.org,
        a.hajda@samsung.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, sean@poorly.run,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] drm/imx: support handling bridge timings bus flags
Date:   Fri, 14 Sep 2018 13:00:29 +0300
Message-ID: <1666767.e3BgH42IGz@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180912183222.25414-7-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch> <20180912183222.25414-7-stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Thank you for the patch.

On Wednesday, 12 September 2018 21:32:20 EEST Stefan Agner wrote:
> A bridge might require specific settings for the pixel data on
> the bus. Copy the bus flags from the bridge timings if a bridge
> is in use.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/gpu/drm/imx/parallel-display.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/imx/parallel-display.c
> b/drivers/gpu/drm/imx/parallel-display.c index aefd04e18f93..7798a0621df7
> 100644
> --- a/drivers/gpu/drm/imx/parallel-display.c
> +++ b/drivers/gpu/drm/imx/parallel-display.c
> @@ -239,6 +239,9 @@ static int imx_pd_bind(struct device *dev, struct device
> *master, void *data) if (ret && ret != -ENODEV)
>  		return ret;
> 
> +	if (imxpd->bridge && imxpd->bridge->timings)
> +		imxpd->bus_flags = imxpd->bridge->timings->input_bus_flags;

As explained in different replies in this mail thread (and in v1), we need 
something more complex than this.

How about creating a helper function that would take a sampling edge, setup 
and hold times, clock frequency and internal delay on the driving side, and 
return which edge to drive the data on ? I agree with you that the logic is 
complex, so we shouldn't duplicate it in multiple drivers. If you submit such 
a patch I'll implement support for configuring the clock edge in the R-Car DU 
driver and test it with the ADV7123.

>  	imxpd->dev = dev;
> 
>  	ret = imx_pd_register(drm, imxpd);

-- 
Regards,

Laurent Pinchart



