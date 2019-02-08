Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD553C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B31E21924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TJ710YP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfBHI5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:57:05 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38562 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBHI5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:57:04 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so2131556ede.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 00:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+7NDUQ5aQOIw2rFcRXYdkNTyYipiNPcJM26MgjQS3UU=;
        b=TJ710YP7q9U8iZW95on41/B/jzfIOMX9fEr8YCkZQTpGqLeR3n1QnDEK2Qa/ibx7w9
         c1YDT5EOlSih6NJFtaSSfRTm56Zka0WlgNAqVw8Go76JxB5nE5735ZDZpbKSsBWaIU4U
         pB+Ofm+v7rdueux8N2x0xlANoTCYsVQSqQLeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=+7NDUQ5aQOIw2rFcRXYdkNTyYipiNPcJM26MgjQS3UU=;
        b=F0Qr4BTOrUkrydqFDxRpx89kxGeXdemXoWAn2Szo2MCUwJDTwIUR4Ptb6hZr4iXbnQ
         jvAtrAeBRvlG2XAQ3wiTpcRVoNnbCd/KKzpPOapGEnPoiQrmQefyHUAptYnv4RuG8dqI
         XMznZrqoLix5sDGc9gebfW0Psz9NvCoX2MlVd9Br0G2hOTOsI+Mnp4F0wib/LtkLg/kk
         a8FDazqFzwhIyHu8ITtiV58OMQ6ENS289hriFdoBWZuQEPdkgBYS88l0PJJB8Lm/sZWQ
         Mqb4U2pW1+yoaXt8VewyP8H5AXCzp5yUo7v4TT95rMY8bfvXQAA5tiqXSehsumpCqZHn
         Jhpw==
X-Gm-Message-State: AHQUAuZzVtGHihUe4EFsJnqk0RYZfrRjuku5QTtB2zuVqSasABTytzh9
        VRZq7TXxpVy2Vg6rpzk2M31FJA==
X-Google-Smtp-Source: AHgI3Iaxrm9GZUtVBfB8l4as5+bmKhj98k4PUULRg7Hsj07BTnpDWeOC6yHTj7yHjaj6P8igd8lzEg==
X-Received: by 2002:a17:906:b3c9:: with SMTP id cg9mr14996848ejb.159.1549616223007;
        Fri, 08 Feb 2019 00:57:03 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b45sm468260eda.34.2019.02.08.00.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 00:57:01 -0800 (PST)
Date:   Fri, 8 Feb 2019 09:56:59 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm: tweak header name
Message-ID: <20190208085659.GI23159@phenom.ffwll.local>
Mail-Followup-To: "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <20190124142448.23243-1-mst@redhat.com>
 <20190124142448.23243-4-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124142448.23243-4-mst@redhat.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 01:02:58AM -0500, Michael S. Tsirkin wrote:
> Use linux/mman.h to make sure we get all mmap flags we need.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

drmP.h is seriously deprecated (and a monster mess). If this fixes
anything, I think would be better to include the right header in the right
places, and leave drmP.h to die quietly ...

What exactly does this fix?
-Daniel

> ---
>  include/drm/drmP.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> index bdb0d5548f39..a3184416ddc5 100644
> --- a/include/drm/drmP.h
> +++ b/include/drm/drmP.h
> @@ -57,8 +57,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/dma-fence.h>
>  #include <linux/module.h>
> -
> -#include <asm/mman.h>
> +#include <linux/mman.h>
>  #include <asm/pgalloc.h>
>  #include <linux/uaccess.h>
>  
> -- 
> MST
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
