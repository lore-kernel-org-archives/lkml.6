Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC44BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7502F2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aA5AbF4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7502F2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389722AbeKPXyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:54:22 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36910 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbeKPXyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:54:22 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAGDfbEG026359;
        Fri, 16 Nov 2018 07:41:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542375697;
        bh=MkWrUfirAPYXYKagkymYryhAWLYU/ceBdZsHJgjigfY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aA5AbF4TQ5yD7F5/ty3xKGGH2tARhIBA99jxyMpAx6Hef9ahdMiz424d4TYKyFY0k
         o4TLM3ILnX4YWK/JuMyxVd4qJbLoSxFVE99L3YRI6bKnm1lu+fcePvM5iPjMgAoWbZ
         vktoSaFXTlZnx0eGBgoaluVyWiwogtz4PwuiRwbQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAGDfb7t002990
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Nov 2018 07:41:37 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 16
 Nov 2018 07:41:35 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 16 Nov 2018 07:41:35 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAGDfUxs006509;
        Fri, 16 Nov 2018 07:41:31 -0600
Subject: Re: [PATCHv4 4/6] drm/omap: fix incorrect union usage
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        <dri-devel@lists.freedesktop.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
References: <20181115230645.15748-1-sebastian.reichel@collabora.com>
 <20181115230645.15748-5-sebastian.reichel@collabora.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <f64b580d-14ae-42df-34b9-a1f7c87e5f37@ti.com>
Date:   Fri, 16 Nov 2018 15:41:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181115230645.15748-5-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/18 01:06, Sebastian Reichel wrote:
> The DSI encoder sets dssdev->ops->dsi.set_config, which is stored at the
> same offset as dssdev->ops->hdmi.set_hdmi_mode. The code in omap_encoder
> only checks if dssdev->ops->hdmi.set_hdmi_mode is NULL. Due to the way
> union works, it won't be NULL if dsi.set_config is set. This means
> dsi_set_config will be called with config=hdmi_mode=false=NULL parameter
> resulting in a NULL dereference. Also the dereference happens while
> console is locked, so kernel hangs without any debug output (can be
> avoided by fbmem's lockless_register_fb=1 parameter).
> 
> This fixes the issue by exiting early if the output type definitely
> has no hdmi_set operations.
> 
> Fixes: 83910ad3f51fb ("drm/omap: Move most omap_dss_driver operations to omap_dss_device_ops")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/gpu/drm/omapdrm/omap_encoder.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/omapdrm/omap_encoder.c
> index 32bbe3a80e7d..ba0099f0644c 100644
> --- a/drivers/gpu/drm/omapdrm/omap_encoder.c
> +++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
> @@ -122,6 +122,14 @@ static void omap_encoder_mode_set(struct drm_encoder *encoder,
>  
>  	dssdev = omap_encoder->output;
>  
> +	/* The following operations access dssdev->ops->hdmi, which is a union
> +	 * also used by DSI. This ensures, that the field does not have data
> +	 * for DSI (or any other future output type).
> +	 */
> +	if (dssdev->output_type != OMAP_DISPLAY_TYPE_HDMI &&
> +	    dssdev->output_type != OMAP_DISPLAY_TYPE_DVI)

Good catch.

Why DVI?

I think the whole code block starting from

/* Set the HDMI mode and HDMI infoframe if applicable. */

to the end of the function should be inside

if (dssdev->output_type == OMAP_DISPLAY_TYPE_HDMI)

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
