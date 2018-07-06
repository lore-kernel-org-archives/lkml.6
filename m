Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122D7C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C014224019
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="R3CVhpqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C014224019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932379AbeGFK5c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:57:32 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41264 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753598AbeGFK5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JN8T7skhl6jKiqzb8rphCCSwFOcS96RWj0zA+brA7ok=; b=R3CVhpqp6t/DBc0kgvt3a3JTF
        2JlhM9mDUvgWPsGS6U8Wz8Vu/pCRPUpjlim06RPj8odAwL91+JA1C5IAAIT19GeU7dFdjBRrzgwgU
        3Z/DN5PJscLtVerChaCZfO7Eauh+TAqXe76lQt3IEd9TSUbSG8JrfJfV7wyzWuF0g00Yg=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:53155)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fbOQT-0005O1-Fb; Fri, 06 Jul 2018 11:57:21 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fbOQQ-0000vh-Mo; Fri, 06 Jul 2018 11:57:18 +0100
Date:   Fri, 6 Jul 2018 11:57:17 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: Re: [PATCH v5 5/7] drm/i2c: tda998x: split tda998x_encoder_dpms into
 enable/disable
Message-ID: <20180706105717.GW17271@n2100.armlinux.org.uk>
References: <20180523093122.27859-1-peda@axentia.se>
 <20180523093122.27859-6-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523093122.27859-6-peda@axentia.se>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 11:31:20AM +0200, Peter Rosin wrote:
> This fits better with the drm_bridge callbacks for when this
> driver becomes a drm_bridge.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/i2c/tda998x_drv.c | 64 ++++++++++++++++++++++-----------------
>  1 file changed, 37 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
> index 933d309d2e0f..3dda07a2fd2f 100644
> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -1163,36 +1163,42 @@ static int tda998x_connector_init(struct tda998x_priv *priv,
>  
>  /* DRM encoder functions */
>  
> -static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
> +static void tda998x_enable(struct tda998x_priv *priv)
>  {
> -	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
> -	bool on;
> +	if (priv->is_on)
> +		return;
>  
> -	/* we only care about on or off: */
> -	on = mode == DRM_MODE_DPMS_ON;
> +	/* enable video ports, audio will be enabled later */
> +	reg_write(priv, REG_ENA_VP_0, 0xff);
> +	reg_write(priv, REG_ENA_VP_1, 0xff);
> +	reg_write(priv, REG_ENA_VP_2, 0xff);
> +	/* set muxing after enabling ports: */
> +	reg_write(priv, REG_VIP_CNTRL_0, priv->vip_cntrl_0);
> +	reg_write(priv, REG_VIP_CNTRL_1, priv->vip_cntrl_1);
> +	reg_write(priv, REG_VIP_CNTRL_2, priv->vip_cntrl_2);
>  
> -	if (on == priv->is_on)
> -		return;
> +	priv->is_on = true;
> +}
>  
> -	if (on) {
> -		/* enable video ports, audio will be enabled later */
> -		reg_write(priv, REG_ENA_VP_0, 0xff);
> -		reg_write(priv, REG_ENA_VP_1, 0xff);
> -		reg_write(priv, REG_ENA_VP_2, 0xff);
> -		/* set muxing after enabling ports: */
> -		reg_write(priv, REG_VIP_CNTRL_0, priv->vip_cntrl_0);
> -		reg_write(priv, REG_VIP_CNTRL_1, priv->vip_cntrl_1);
> -		reg_write(priv, REG_VIP_CNTRL_2, priv->vip_cntrl_2);
> -
> -		priv->is_on = true;
> -	} else {
> -		/* disable video ports */
> -		reg_write(priv, REG_ENA_VP_0, 0x00);
> -		reg_write(priv, REG_ENA_VP_1, 0x00);
> -		reg_write(priv, REG_ENA_VP_2, 0x00);
> +static void tda998x_disable(struct tda998x_priv *priv)
> +{
> +	/* disable video ports */
> +	reg_write(priv, REG_ENA_VP_0, 0x00);
> +	reg_write(priv, REG_ENA_VP_1, 0x00);
> +	reg_write(priv, REG_ENA_VP_2, 0x00);
>  
> -		priv->is_on = false;
> -	}
> +	priv->is_on = false;
> +}
> +
> +static void tda998x_encoder_dpms(struct drm_encoder *encoder, int mode)
> +{
> +	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
> +
> +	/* we only care about on or off: */
> +	if (mode == DRM_MODE_DPMS_ON)
> +		tda998x_enable(priv);
> +	else
> +		tda998x_disable(priv);
>  }
>  
>  static void
> @@ -1606,12 +1612,16 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
>  
>  static void tda998x_encoder_prepare(struct drm_encoder *encoder)
>  {
> -	tda998x_encoder_dpms(encoder, DRM_MODE_DPMS_OFF);
> +	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
> +
> +	tda998x_disable(priv);
>  }
>  
>  static void tda998x_encoder_commit(struct drm_encoder *encoder)
>  {
> -	tda998x_encoder_dpms(encoder, DRM_MODE_DPMS_ON);
> +	struct tda998x_priv *priv = enc_to_tda998x_priv(encoder);
> +
> +	tda998x_enable(priv);
>  }
>  
>  static const struct drm_encoder_helper_funcs tda998x_encoder_helper_funcs = {

Please group the tda998x_encoder_* functions together, and in order of
their use in the function vtables, and just above the function vtables.
That'll mean that all the encoder veneers are together, all the bridge
veneers are together, etc, and probably means later on it's easier to
remove the encoder stuff (as all the encoder code will be in one hunk
rather than scattered throughout the file.)

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
