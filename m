Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B62AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB53920664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KZ1VQyjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB53920664
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbeKZU0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:26:02 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40292 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeKZU0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:26:02 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ9WCHf016658;
        Mon, 26 Nov 2018 03:32:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543224732;
        bh=lj4beQVIhIpnWTTXGoAnOz4OJxCuliyayp4KJ6gwpN8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KZ1VQyjsRQpJG3mBoli+druvPTfYDICZE60452/0nJBwwQcaSJ3mcJ5bkz4KPchu+
         z35sdwv9egjyCMyVFtI6HWtdZw6RXLBC5I4iIoW0HoYcOk7luyIHlbzxZPsngxvEDZ
         JNJ33cANcdpjLiq0ShRrXv83hQsIDMyTfGkUya3c=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ9WCsM058914
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 03:32:12 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 03:32:11 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 03:32:11 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ9W947026943;
        Mon, 26 Nov 2018 03:32:09 -0600
Subject: Re: [PATCHv5 4/6] drm/omap: fix incorrect union usage
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        <dri-devel@lists.freedesktop.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
References: <20181121160916.22017-1-sebastian.reichel@collabora.com>
 <20181121160916.22017-5-sebastian.reichel@collabora.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <f22070d8-e5ca-a8ef-2833-f6bef6801682@ti.com>
Date:   Mon, 26 Nov 2018 11:32:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181121160916.22017-5-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/18 18:09, Sebastian Reichel wrote:
> The DSI encoder sets dssdev->ops->dsi.set_config, which is stored at the
> same offset as dssdev->ops->hdmi.set_hdmi_mode. The code in omap_encoder
> only checks if dssdev->ops->hdmi.set_hdmi_mode is NULL. Due to the way
> union works, it won't be NULL if dsi.set_config is set. This means
> dsi_set_config will be called with config=hdmi_mode=false=NULL parameter
> resulting in a NULL dereference. Also the dereference happens while
> console is locked, so kernel hangs without any debug output without
> "fb.lockless_register_fb=1" parameter.
> 
> This restructures the code, so that the HDMI mode is only configured
> for HDMI output types. The new function also has a safe-guard directly
> before accessing the union, that can be optimized away by the compiler
> when the function is inlined and HDMI type has already been checked.
> 
> Fixes: 83910ad3f51fb ("drm/omap: Move most omap_dss_driver operations to omap_dss_device_ops")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/gpu/drm/omapdrm/omap_encoder.c | 62 +++++++++++++++-----------
>  1 file changed, 37 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/omapdrm/omap_encoder.c
> index 32bbe3a80e7d..f356821cd078 100644
> --- a/drivers/gpu/drm/omapdrm/omap_encoder.c
> +++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
> @@ -52,17 +52,48 @@ static const struct drm_encoder_funcs omap_encoder_funcs = {
>  	.destroy = omap_encoder_destroy,
>  };
>  
> +static void omap_encoder_hdmi_mode_set(struct drm_encoder *encoder,
> +				       struct drm_display_mode *adjusted_mode)
> +{
> +	struct drm_device *dev = encoder->dev;
> +	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
> +	struct omap_dss_device *dssdev = omap_encoder->output;
> +	struct drm_connector *connector;
> +	bool hdmi_mode;
> +
> +	hdmi_mode = false;
> +	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
> +		if (connector->encoder == encoder) {
> +			hdmi_mode = omap_connector_get_hdmi_mode(connector);
> +			break;
> +		}
> +	}
> +
> +	/* safe-guard for accessing dssdev->ops->hdmi union */
> +	if (dssdev->output_type != OMAP_DISPLAY_TYPE_HDMI)
> +		return;

If you safeguard the function, it would make sense to do this at the
very beginning of the function. But to be honest, I think this is just
extra. It's a static function, named "hdmi", so I think we can trust
that we call it correctly.

If you're ok with it, I can pick this patch up and drop the safeguard.
Or you can send a new one.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
