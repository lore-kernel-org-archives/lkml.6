Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E349CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9563206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ahBtdCAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9563206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440047AbeKXBYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:24:06 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:43106 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436868AbeKXBYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:24:06 -0500
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E2E1158E;
        Fri, 23 Nov 2018 15:39:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1542983979;
        bh=o9/7zYKUZaT0x8iW1PMeteaD9MEdQeIEArRj3YzsDug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahBtdCAmmLz9On2p/QT6tI3YTgmmYyPUDHxChmsv6gfh9toBe9fbDhaNmbYiDcTH9
         /vztrINAll9IS1G0/+KsdpCmwPwPledIorIH7zunaCXkstCw6V9PcuqQ2QqLoMti/4
         +uX4mNA7oyUXxRVs1ykETsbiLFsigT4yn0kFDY00=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        "Andrew F. Davis" <afd@ti.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/omap: dss: do not allow devm_kasprintf() to fail
Date:   Fri, 23 Nov 2018 16:39:59 +0200
Message-ID: <3550363.0Jm6vJdJjr@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1542974495-12387-1-git-send-email-hofrat@osadl.org>
References: <1542974495-12387-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nicholas,

On Friday, 23 November 2018 14:01:35 EET Nicholas Mc Guire wrote:
> omapdss_display_init() is called by multiple drivers and does not expect
> a return value so without changing all call-sites the low-probability
> failure of devm_kasprintf() can not be reported up the call stack. As
> the amount allocated here is very small (<= 16 bytes) and it is an
> initialization function that most likely will be called during system
> initialization it should be OK to use __GFP_NOFAIL here to prevent
> devm_kasprintf() from returning NULL.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 36c61ae2b755 ("drm/omap: dss: Remove display ordering from
> dss/display.c")
> ---
> 
> Problem located with experimental coccinelle script
> 
> While the use of __GFP_NOFAIL is to be limited (small infrequent
> allocations) this case does seems suitable as it is rare and small
> (initialization) .As all the current drivers using
> omapdss_display_init() currently seem not to initialize dssdev->name
> prior to calling omapdss_display_init() and the unlikely failure
> case can not be reasonably responded (returns void) not allowing
> a allocation failure here should be acceptable.

Given that my plan is to eventually drop omapdss_display_init(), this looks 
fine to me.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Patch was compile tested with: omap2plus_defconfig (implies OMAP_DSS_BASE=m)
> 
> Patch is against 4.20-rc3 (localversion-next is next-20181123)
> 
>  drivers/gpu/drm/omapdrm/dss/display.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/display.c
> b/drivers/gpu/drm/omapdrm/dss/display.c index 34b2a4e..7dbe874 100644
> --- a/drivers/gpu/drm/omapdrm/dss/display.c
> +++ b/drivers/gpu/drm/omapdrm/dss/display.c
> @@ -45,7 +45,8 @@ void omapdss_display_init(struct omap_dss_device *dssdev)
>  	of_property_read_string(dssdev->dev->of_node, "label", &dssdev->name);
> 
>  	if (dssdev->name == NULL)
> -		dssdev->name = devm_kasprintf(dssdev->dev, GFP_KERNEL,
> +		dssdev->name = devm_kasprintf(dssdev->dev,
> +					      GFP_KERNEL | __GFP_NOFAIL,
>  					      "display%u", id);
>  }
>  EXPORT_SYMBOL_GPL(omapdss_display_init);

-- 
Regards,

Laurent Pinchart



