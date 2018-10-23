Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6875C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8053920652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="H4xu4ezz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8053920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbeJWWWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 18:22:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42824 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbeJWWWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 18:22:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id b7-v6so1718532edd.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 06:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4fdDQ/ZgdUgifvv1bjt8Ufp9rym1/ed+7ZvcnC/7xxY=;
        b=H4xu4ezzEvG6BA+8QXjVBvLwla4yFcQdd/ssRWALbOP8kslFcv9idQB+uGkS/WdlnM
         kc7yWR5fXMQhb2zkk0GI7Gr/wmO/J7E4qLR+w1fPUpstMXyUUzQt0CBxYEgh4lwCQ/iE
         uvEIBZzHNMfW0Ocibk2k+S7z2zAaYlxnZoUOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=4fdDQ/ZgdUgifvv1bjt8Ufp9rym1/ed+7ZvcnC/7xxY=;
        b=CdIHo/YdZVXsUXL1rA75wnpnbC8QlLnGj7HPSWvDSQjG4cVYbnbHaEaNuyDtckXaJA
         TxJ7IwI06RaUhgODt/j4uXHYyvK4r8ILgL78q+RP0qelKsSsFfuBMwHgIUrZdcf3GHg3
         Njg3L2+MkPEFz3e1MrzJJudO1Tcd47Vk8FMvKkepVSf3wWQsKQtLdo3TmAIiZmzu+qjj
         VNao7plSG1ajp0JfkhQ9GP2UrdR4NoK6Uuzob713jZLJWQ8Rnxy+ZC1VJ51rs9sBMELn
         wSwAckadCBfbQOxlnwpuodGJzSL+VkobCotDmJFiwLrtFdO4bx3S/i+3/JOwYJQFByGs
         O2Cw==
X-Gm-Message-State: ABuFfoh0t3PwYLY9CHLJevk8YbJp87EGi/+wfP4uNRI6hs/TvCu14ZiS
        tR0ig6s1joyLTSn6xBCaTfOMOg==
X-Google-Smtp-Source: ACcGV60MQa8xF1d7tD5uxh+DkdVv+JCAnVDXDgGtLR3P7iIUS9AlY46jN00tY3vk78U2iSpNJgBE3g==
X-Received: by 2002:a17:906:2da9:: with SMTP id g9-v6mr37928117eji.67.1540303138116;
        Tue, 23 Oct 2018 06:58:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id h3-v6sm697996ede.42.2018.10.23.06.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 06:58:57 -0700 (PDT)
Date:   Tue, 23 Oct 2018 15:58:55 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        sean@poorly.run, airlied@linux.ie, brajeswar.linux@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sabyasachi.linux@gmail.com
Subject: Re: [PATCH] drm/drm_pci.c: Use dma_zalloc_coherent
Message-ID: <20181023135855.GU324@phenom.ffwll.local>
Mail-Followup-To: Souptick Joarder <jrdr.linux@gmail.com>,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        sean@poorly.run, airlied@linux.ie, brajeswar.linux@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sabyasachi.linux@gmail.com
References: <20181023040222.GA1540@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023040222.GA1540@jordon-HP-15-Notebook-PC>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 09:32:22AM +0530, Souptick Joarder wrote:
> Replace dma_alloc_coherent + memset with dma_zalloc_coherent.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Applied, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/drm_pci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
> index 896e42a..1427879 100644
> --- a/drivers/gpu/drm/drm_pci.c
> +++ b/drivers/gpu/drm/drm_pci.c
> @@ -61,15 +61,14 @@ drm_dma_handle_t *drm_pci_alloc(struct drm_device * dev, size_t size, size_t ali
>  		return NULL;
>  
>  	dmah->size = size;
> -	dmah->vaddr = dma_alloc_coherent(&dev->pdev->dev, size, &dmah->busaddr, GFP_KERNEL | __GFP_COMP);
> +	dmah->vaddr = dma_zalloc_coherent(&dev->pdev->dev, size, &dmah->busaddr,
> +						GFP_KERNEL | __GFP_COMP);
>  
>  	if (dmah->vaddr == NULL) {
>  		kfree(dmah);
>  		return NULL;
>  	}
>  
> -	memset(dmah->vaddr, 0, size);
> -
>  	/* XXX - Is virt_to_page() legal for consistent mem? */
>  	/* Reserve */
>  	for (addr = (unsigned long)dmah->vaddr, sz = size;
> -- 
> 1.9.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
