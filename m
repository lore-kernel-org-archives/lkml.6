Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76181C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199BA2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TuUjBenN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199BA2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeJXS4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:56:22 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42970 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeJXS4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:56:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id b7-v6so4517975edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 03:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NyLaW91G7RjTJeGFUWYsKVeo6JYgAcdIQlSjV4toEI0=;
        b=TuUjBenNS9dQA1KhZD9xm7R/6Awc7nLEhZLHDfJ6M41E8N9XQ0tjHezupJmQwAvrP9
         MZLsMcDlEs3JxBIyYC0j5o/ovjeEaux/GngCvC1zxoGnxsXCgELNRM1UWi5LJCpt8oZM
         0KQJ3w++0dtG4m1clPeb9yLkEYiwnRtsx4dnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=NyLaW91G7RjTJeGFUWYsKVeo6JYgAcdIQlSjV4toEI0=;
        b=MfdLFV7rLj+WrnRrUcGNlKDJFACzXu4jPSFskKh07S/JZO5SlA4wWAOoVc8X4+mouz
         JDBAKShXLUke6Fb8wS5Q83LPot8Y9LhMb0omER576RRwsu89Fs1llBIdZzTXbpzOZX3b
         zP6+/FXdeh8OxNW0/M4Os92xQ7FDkfbYxMs22PyZmqj6gg88iqaTsM+OGHRtujATf7Xt
         1SP2dnTg1aqcFo7QivlU09RaJUwxVBX0UdDDckQ9FysRstb/MQPwfiK8Bv/rDMcvi4QP
         C7W+g/qcggvoDrTD+99jToLWVNPfgJA2ea08+QEj8HJ9zJrzpzgPJFIe0Cdpj9GeHBeb
         sWyg==
X-Gm-Message-State: AGRZ1gIdn42Tf7hgOKJdPmfIJ8mM6/fN5F2GiP90Tm7fX0ILrs7kxN37
        QeJGwUUelDqqei2Yb5YIAkQA/A==
X-Google-Smtp-Source: AJdET5dv3/yzl+TLYxRq9TMDvI1cz2fkb59XGSCdq+lkHkWfqm4f8kqyFX1EB35chLekAK4K2POdQw==
X-Received: by 2002:a17:906:64c:: with SMTP id t12-v6mr1095961ejb.113.1540376929412;
        Wed, 24 Oct 2018 03:28:49 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a3-v6sm918195ejr.55.2018.10.24.03.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 03:28:48 -0700 (PDT)
Date:   Wed, 24 Oct 2018 12:28:46 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v3 1/2] drm: add drm_connector_attach_edid_property()
Message-ID: <20181024102846.GM324@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
References: <20181002111041.17053-1-kraxel@redhat.com>
 <20181002111041.17053-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002111041.17053-2-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 01:10:40PM +0200, Gerd Hoffmann wrote:
> drm_connector_init doesn't attach the edid property for some connector
> types, drm_connector_attach_edid_property() can be used to enable the
> edid property in these cases.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  include/drm/drm_connector.h     |  1 +
>  drivers/gpu/drm/drm_connector.c | 23 ++++++++++++++++++++---
>  2 files changed, 21 insertions(+), 3 deletions(-)
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
> index 6011d769d5..486b784e4d 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -256,9 +256,7 @@ int drm_connector_init(struct drm_device *dev,
>  
>  	if (connector_type != DRM_MODE_CONNECTOR_VIRTUAL &&
>  	    connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
> -		drm_object_attach_property(&connector->base,
> -					      config->edid_property,
> -					      0);
> +		drm_connector_attach_edid_property(connector);
>  
>  	drm_object_attach_property(&connector->base,
>  				      config->dpms_property, 0);
> @@ -291,6 +289,25 @@ int drm_connector_init(struct drm_device *dev,
>  EXPORT_SYMBOL(drm_connector_init);
>  
>  /**
> + * drm_connector_attach_edid_property - attach edid property.
> + * @dev: DRM device

this makes kerneldoc unhappy. Can you pls run make htmldocs and fix?

Thanks, Daniel

> + * @connector: the connector
> + *
> + * Some connector types like DRM_MODE_CONNECTOR_VIRTUAL do not get a
> + * edid property attached by default.  This function can be used to
> + * explicitly enable the edid property in these cases.
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
