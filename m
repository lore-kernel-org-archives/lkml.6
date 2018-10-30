Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CD1C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9132080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HgyCJeGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9132080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeJ3S2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:28:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33065 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbeJ3S2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:28:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id f1-v6so9860481edi.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 02:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XDAs3SF98HH12IOYZbN/UWo734FIEEUqVXIC267NxFA=;
        b=HgyCJeGTtjlz+QxSgBLH8KqMos7QpzFNXmFpR7sS2qQ1dG+sMVGN/xyjlFqLp1tnOL
         wvgHiJzZKm91HwsJzr+jtVszUCM19bVgBGXGC7QKOfHv/578c1LSln78kQX5bjKOr5DG
         sLwIzo4Xqn/xYxCMb7vihFmDdQCl/KRCQt8w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=XDAs3SF98HH12IOYZbN/UWo734FIEEUqVXIC267NxFA=;
        b=Ab3ZYOq5zC/KFpIxnwdomJF4iViykemW8MVYw/rMDr0UX/o6hyLxQs1APBaharY1HK
         5t0Wv0oMZ3JCvNW2L2QLCEwtYbKr03Wl6W6c2HYWLiO9xNkaLWEdm1SLf4lkaDUzz2NI
         DSu5ZsT214yWnTc5U35rW7VHzb4wooR2hT5LkKLF8QXLvYP7gxgtQGFfla2yBryS/526
         gZN9kMVWsc3JYswAdMEitvvBC3ZjpnJ6ibA0HkgHJPTdosjwj7fK9GyewnmOGypYWSSe
         jsBeD0vQBFNmcAPObPJU+re0fkuohBqM8nLbUN72wIWfWkfVYHsaF8796iBUvhZx+mG0
         1mEQ==
X-Gm-Message-State: AGRZ1gIOxc8jXquhH7j8rRj1ltjmm1GdsmFuUsq3NWqFtyL5GKlA2mDc
        /y8XEBvOimR1kkYv6WJ+HJ8LEg==
X-Google-Smtp-Source: AJdET5d/1OCY7uHyWaEUV71W9TbUBtCD8ymLHuZIEF8zemcq9AUyD77pXpXk+z2ETF0N72NSud4bfA==
X-Received: by 2002:a17:906:7048:: with SMTP id r8-v6mr12682101ejj.131.1540892157072;
        Tue, 30 Oct 2018 02:35:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id d18-v6sm3748798edq.53.2018.10.30.02.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 02:35:56 -0700 (PDT)
Date:   Tue, 30 Oct 2018 10:35:54 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        David Airlie <airlied@redhat.com>
Subject: Re: [PATCH v4] drm/bochs: add edid support.
Message-ID: <20181030093554.GP21967@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        David Airlie <airlied@redhat.com>
References: <20181029205048.13200-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029205048.13200-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 09:50:48PM +0100, Gerd Hoffmann wrote:
> Recent qemu (latest master branch, upcoming 3.1 release) got support
> for EDID data.  This patch adds guest driver support.
> 
> EDID support in qemu is not (yet) enabled by default, so please use
> 'qemu -device VGA,edid=on' for testing.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

I liked v3 more, but Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch> on
either wone.
-Daniel

> ---
>  drivers/gpu/drm/bochs/bochs.h     |  2 ++
>  drivers/gpu/drm/bochs/bochs_hw.c  | 30 ++++++++++++++++++++++++++++++
>  drivers/gpu/drm/bochs/bochs_kms.c | 20 +++++++++++++++++---
>  3 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
> index e7a69077e4..577a8b917c 100644
> --- a/drivers/gpu/drm/bochs/bochs.h
> +++ b/drivers/gpu/drm/bochs/bochs.h
> @@ -66,6 +66,7 @@ struct bochs_device {
>  	u16 yres_virtual;
>  	u32 stride;
>  	u32 bpp;
> +	struct edid *edid;
>  
>  	/* drm */
>  	struct drm_device  *dev;
> @@ -126,6 +127,7 @@ void bochs_hw_setmode(struct bochs_device *bochs,
>  		      const struct drm_format_info *format);
>  void bochs_hw_setbase(struct bochs_device *bochs,
>  		      int x, int y, u64 addr);
> +int bochs_hw_load_edid(struct bochs_device *bochs);
>  
>  /* bochs_mm.c */
>  int bochs_mm_init(struct bochs_device *bochs);
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
> index cacff73a64..c90a0d492f 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -69,6 +69,35 @@ static void bochs_hw_set_little_endian(struct bochs_device *bochs)
>  #define bochs_hw_set_native_endian(_b) bochs_hw_set_little_endian(_b)
>  #endif
>  
> +static int bochs_get_edid_block(void *data, u8 *buf,
> +				unsigned int block, size_t len)
> +{
> +	struct bochs_device *bochs = data;
> +	size_t i, start = block * EDID_LENGTH;
> +
> +	if (start + len > 0x400 /* vga register offset */)
> +		return -1;
> +
> +	for (i = 0; i < len; i++) {
> +		buf[i] = readb(bochs->mmio + start + i);
> +	}
> +	return 0;
> +}
> +
> +int bochs_hw_load_edid(struct bochs_device *bochs)
> +{
> +	if (!bochs->mmio)
> +		return -1;
> +
> +	kfree(bochs->edid);
> +	bochs->edid = drm_do_get_edid(&bochs->connector,
> +				      bochs_get_edid_block, bochs);
> +	if (bochs->edid == NULL)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  int bochs_hw_init(struct drm_device *dev)
>  {
>  	struct bochs_device *bochs = dev->dev_private;
> @@ -164,6 +193,7 @@ void bochs_hw_fini(struct drm_device *dev)
>  	if (bochs->fb_map)
>  		iounmap(bochs->fb_map);
>  	pci_release_regions(dev->pdev);
> +	kfree(bochs->edid);
>  }
>  
>  void bochs_hw_setmode(struct bochs_device *bochs,
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index 9bc5b438ae..f87c284dd9 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -213,10 +213,17 @@ static void bochs_encoder_init(struct drm_device *dev)
>  
>  static int bochs_connector_get_modes(struct drm_connector *connector)
>  {
> -	int count;
> +	struct bochs_device *bochs =
> +		container_of(connector, struct bochs_device, connector);
> +	int count = 0;
>  
> -	count = drm_add_modes_noedid(connector, 8192, 8192);
> -	drm_set_preferred_mode(connector, defx, defy);
> +	if (bochs->edid)
> +		count = drm_add_edid_modes(connector, bochs->edid);
> +
> +	if (!count) {
> +		count = drm_add_modes_noedid(connector, 8192, 8192);
> +		drm_set_preferred_mode(connector, defx, defy);
> +	}
>  	return count;
>  }
>  
> @@ -271,6 +278,13 @@ static void bochs_connector_init(struct drm_device *dev)
>  	drm_connector_helper_add(connector,
>  				 &bochs_connector_connector_helper_funcs);
>  	drm_connector_register(connector);
> +
> +	bochs_hw_load_edid(bochs);
> +	if (bochs->edid) {
> +		DRM_INFO("Found EDID data blob.\n");
> +		drm_connector_attach_edid_property(connector);
> +		drm_connector_update_edid_property(connector, bochs->edid);
> +	}
>  }
>  
>  
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
