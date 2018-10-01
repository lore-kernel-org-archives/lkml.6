Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABF1C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007242089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QV3sCOdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007242089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeJAX4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:56:35 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:45993 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeJAX4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:56:35 -0400
Received: by mail-ed1-f52.google.com with SMTP id h6-v6so13455659eds.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WjSBADx5iAwpC9f8+0fMFQ4KnaPWdti3y5/ED67vFjk=;
        b=QV3sCOdAX+OZyOfDKyxLU9T1kRu+UkiakoTRS6KlkqkfRvLUrKSLBwCZEo5mP4Ol3L
         YItHCr0+sru4rg3G/GVFRGvQr5HMT0dQ5/GyOHQnxRnntYtSYw7r/6oAwRvIwqm2v94q
         VKmo8XshsV/UI0kokEoiuYMnXUaxU8JvbPljI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=WjSBADx5iAwpC9f8+0fMFQ4KnaPWdti3y5/ED67vFjk=;
        b=A7B7OwiHsR9FYR8uzabEQ8J/RTzqvbLyvmjmvhY/a33vE6z5CgrLTl609VYDyNtCKH
         dgAK06MvUfMaVxlCfiM2Cz8G7whYyixVV7y7pgzz8f/FluP9y9GZAOuCLzyJgH6OW2je
         ypGQpixH0dpWF2tThg6MaXVejQFdFalQ0TZ7mztoZIxIAoJwuZde6tR6cmFX33x/Ngud
         eWLtaXn9xDbAFrWwbAPE3HDdmrbsi00c+Ul2najaMvnpke3fPtS2p6vzn776lfx2rOE8
         giIMXkPWPg1rFsH7iJpcc9CBrZiMLDJNm8cMfBNYRAq9rHlCDZ9o2hllwN9G4zHoihv5
         HzJQ==
X-Gm-Message-State: ABuFfogE7kdAjoXyctzyCN01yBrPnKczlt5pzx0qXb7iAXWtenoldhyt
        6fDE7fICUkc7Fht1odDQ+F734w==
X-Google-Smtp-Source: ACcGV62KmT36OHIlzs6KAYHJDiy0d0XV53fNWmRwsc/qIvnFgyFRdWRil0MmiEZN4a9ppj75ntAVTw==
X-Received: by 2002:aa7:d1cf:: with SMTP id g15-v6mr4709760edp.163.1538414266464;
        Mon, 01 Oct 2018 10:17:46 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t8-v6sm2095281ejx.62.2018.10.01.10.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 10:17:45 -0700 (PDT)
Date:   Mon, 1 Oct 2018 19:17:43 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 1/2] drm: virtual connectors can have edid too
Message-ID: <20181001171743.GG11082@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
References: <20181001121911.27140-1-kraxel@redhat.com>
 <20181001121911.27140-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001121911.27140-2-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 02:19:10PM +0200, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

This will add edid support to all virtual connectors. Probably a bit much,
and I don't think what everyone else wants for their virtual hw drivers.

I think better to wrap a new drm_connector_attach_edid_property(), which
virtual drivers can call when needed. Also: Might be good to update the
kerneldoc, and perhaps double-check no userspace will go boom on this
change (yes I'm paranoid).
-Daniel

> ---
>  drivers/gpu/drm/drm_connector.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 6011d769d5..95cbbf7ee5 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -254,8 +254,7 @@ int drm_connector_init(struct drm_device *dev,
>  	config->num_connector++;
>  	spin_unlock_irq(&config->connector_list_lock);
>  
> -	if (connector_type != DRM_MODE_CONNECTOR_VIRTUAL &&
> -	    connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
> +	if (connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
>  		drm_object_attach_property(&connector->base,
>  					      config->edid_property,
>  					      0);
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
