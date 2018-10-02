Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD08C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8A1208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kMtxyuxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8A1208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbeJBP2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:28:09 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:44315 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbeJBP2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:28:09 -0400
Received: by mail-ed1-f51.google.com with SMTP id t11-v6so1295098edq.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 01:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cg/vwiYSLn1OE4IKv1/Ko2R0FLlwBXE1VgnSydUWdjQ=;
        b=kMtxyuxKKtD2J/89XO/107SeuACE4gwKMbk36qX6TRD7mWXZTPC6+YAkrdHHX9BBYR
         bY3b3OTMkJ32oPdhMxqpKMlhoMOoaoJUxmQhdUjrVdcSWkcOhPhgtr402aSZSw0grkcG
         IDJGAa+SiuLyJ+ccRU6gsRFo/nzzkcNVo9578=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=cg/vwiYSLn1OE4IKv1/Ko2R0FLlwBXE1VgnSydUWdjQ=;
        b=o/Olpmkb9jDzNcINE9682elUsJ3Wy1n16ynl3rpHHek/g6E2Za697w78kLnBBsRHHF
         x8FhmW504a71JIMqXHVPCReyQznzHyNeiIou2wl4f3XbN+vDhg6NoA1vocmcyuckIg3M
         BdMnVjN2ZAVyb7rQhGRxfv0hbR2NLHOdB57FYwOxiOsIos5Bc0uBNEDLiJ5e+cKy/VRa
         /SlifDN2OPgIMDEX6ftCevvVl4rvj572QKd3OFmHJIfvwH8x6ufY8H2IRFtxpWYWdKmb
         1wjwiUtL2xsU6HnOUvlkrKwEZ+y1Dx0vnrnS+E/Ctr2PYUVGDVPNO2KFPBwDzVJDQPue
         bP0g==
X-Gm-Message-State: ABuFfoj02PMNf7792eKPWJvmHf/o2HzNBkZ8uCC3G+FlTcmlE1xsICgp
        j557bQxMEKJWrTqpDdcnBilT0g==
X-Google-Smtp-Source: ACcGV63GHa/ft3ZY18LSCKIkDQBJf12lH0oNc3NGuCugIon+ELLGjUfnUjiCFR56LysfFqW+/7BLOQ==
X-Received: by 2002:a50:b603:: with SMTP id b3-v6mr23112870ede.181.1538469958345;
        Tue, 02 Oct 2018 01:45:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id f6-v6sm3335139edd.76.2018.10.02.01.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 01:45:57 -0700 (PDT)
Date:   Tue, 2 Oct 2018 10:45:55 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2 1/2] drm: add drm_connector_attach_edid_property()
Message-ID: <20181002084555.GL11082@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
References: <20181002061905.10496-1-kraxel@redhat.com>
 <20181002061905.10496-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002061905.10496-2-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 08:19:04AM +0200, Gerd Hoffmann wrote:
> drm_connector_init doesn't attach the edid property for some connector
> types, drm_connector_attach_edid_property() can be used to enable the
> edid property in these cases.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/drm/drm_connector.h     |  1 +
>  drivers/gpu/drm/drm_connector.c | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 97ea41dc67..4d58966b54 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1083,6 +1083,7 @@ int drm_connector_init(struct drm_device *dev,
>  		       struct drm_connector *connector,
>  		       const struct drm_connector_funcs *funcs,
>  		       int connector_type);
> +void drm_connector_attach_edid_property(struct drm_connector *connector);
>  int drm_connector_register(struct drm_connector *connector);
>  void drm_connector_unregister(struct drm_connector *connector);
>  int drm_connector_attach_encoder(struct drm_connector *connector,
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 6011d769d5..6c6ef4f9b9 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -291,6 +291,26 @@ int drm_connector_init(struct drm_device *dev,
>  EXPORT_SYMBOL(drm_connector_init);
>  
>  /**
> + * drm_connector_attach_edid_property - attach edid property.
> + * @dev: DRM device
> + * @connector: the connector
> + *
> + * Some connector types like DRM_MODE_CONNECTOR_VIRTUAL do not get a
> + * edid property attached by default.  This function can be used to
> + * explicitly enable the edid property in these cases.
> + *

Surplus line. I'd also use this in the connector setup function, so it's a
notch easier to discover. With that:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> + */
> +void drm_connector_attach_edid_property(struct drm_connector *connector)
> +{
> +	struct drm_mode_config *config = &connector->dev->mode_config;
> +
> +	drm_object_attach_property(&connector->base,
> +				   config->edid_property,
> +				   0);
> +}
> +EXPORT_SYMBOL(drm_connector_attach_edid_property);
> +
> +/**
>   * drm_connector_attach_encoder - attach a connector to an encoder
>   * @connector: connector to attach
>   * @encoder: encoder to attach @connector to
> -- 
> 2.9.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
