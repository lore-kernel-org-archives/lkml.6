Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5ADC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 12:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073122148E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 12:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZC11o8KS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbeL0MMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 07:12:40 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41139 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730960AbeL0MMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 07:12:40 -0500
Received: by mail-ed1-f68.google.com with SMTP id a20so8308985edc.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 04:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FbCLrxngf94dBQUSFkLcqIHz6+USYzwSyhbD3q+6kMo=;
        b=ZC11o8KS17E900rnMNNgvjqGJVzlfFQZcFcYj2PNV/0+Qbt5v50u35iH6M0kFJNKIG
         eungsRo1P63eC7oYslcSAvXt+reaW/OWgEnTrDwfqd9eSykQ60bxe7hd0/yllqV+X8nb
         PF0ahwL+8WLAHlDe+HcU+6UB7EHNT3kUcSWBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=FbCLrxngf94dBQUSFkLcqIHz6+USYzwSyhbD3q+6kMo=;
        b=mGEyO8wKV/B+Yg/ec/YdaYrR11ZRqf8Bo5TSeDs0KTGiGT8dIAaV3lpHezScrZHWPx
         ReZeK5kGYS/yJRXSfk9iaN9BAnqGAdFgzaXGzGQkWZZnYx3VQehk0t5RvqiVPY6wp8he
         lO3k3g4ZTDsxgei4sYBfHFxp/vip/3QsRMWQcnQakMesNt0YyWfWtBhzqj2NIPQjnukn
         n0c21PqiheJUwHGOnpxdmp7oEMtU0lhm+CW8M/E2Ftq1FW9ycalw84Kq3E1hbVqit7G+
         L2HxTVe1bGWTDZiM9TpfuXICgDJiQxPEMnbDWn54LGYPnloiK9yXJOm7gn0tSBwRqCCu
         3wOA==
X-Gm-Message-State: AA+aEWYTQnwkUXKYbhcNf31x/kZ7IZsUa2zSDUWQ8wLP8ln56x9oq/8G
        9LN4PLNbqB3+G/hSrOQSTiMr/d6IYSI=
X-Google-Smtp-Source: AFSGD/UT/sT4L6CINqvL4/wreu4nK0gIBidEsYIdOWymjJQhfozWBWhkLr7G6gfLZzA9/sCcy0nWZQ==
X-Received: by 2002:a50:b3b8:: with SMTP id s53mr18793447edd.122.1545912758498;
        Thu, 27 Dec 2018 04:12:38 -0800 (PST)
Received: from dvetter-linux.ger.corp.intel.com ([194.230.159.220])
        by smtp.gmail.com with ESMTPSA id w31sm11339460edw.82.2018.12.27.04.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 04:12:37 -0800 (PST)
Date:   Thu, 27 Dec 2018 13:12:35 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 2/7] drm: move DRM_SWITCH_POWER defines to drm_device.h
Message-ID: <20181227121234.GE9058@dvetter-linux.ger.corp.intel.com>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20181226210215.GA27610@ravnborg.org>
 <20181226210353.13993-2-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226210353.13993-2-sam@ravnborg.org>
X-Operating-System: Linux dvetter-linux.ger.corp.intel.com
 4.19.10-200.fc28.x86_64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 10:03:48PM +0100, Sam Ravnborg wrote:
> Move DRM_SWITCH_POWER out of drmP.h to allow users
> to get rid of the drmP include.
> 
> DRM_SWITCH_POWER defines are used in combination
> with drm_device.switch_power_state.
> 
> Move the DRM_SWITCH_POWER defines to the file where
> drm_device.switch_power_state is defined.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
>  include/drm/drmP.h       | 5 -----
>  include/drm/drm_device.h | 9 +++++++++
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> index b6b8436b5123..2ba786820052 100644
> --- a/include/drm/drmP.h
> +++ b/include/drm/drmP.h
> @@ -95,11 +95,6 @@ struct dma_buf_attachment;
>  struct pci_dev;
>  struct pci_controller;
>  
> -#define DRM_SWITCH_POWER_ON 0
> -#define DRM_SWITCH_POWER_OFF 1
> -#define DRM_SWITCH_POWER_CHANGING 2
> -#define DRM_SWITCH_POWER_DYNAMIC_OFF 3
> -
>  /* returns true if currently okay to sleep */
>  static inline bool drm_can_sleep(void)
>  {
> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
> index 42411b3ea0c8..c3da194d25f9 100644
> --- a/include/drm/drm_device.h
> +++ b/include/drm/drm_device.h
> @@ -24,6 +24,13 @@ struct inode;
>  struct pci_dev;
>  struct pci_controller;
>  
> +
> +/* Used by drm_device.switch_power_state */
> +#define DRM_SWITCH_POWER_ON 0
> +#define DRM_SWITCH_POWER_OFF 1
> +#define DRM_SWITCH_POWER_CHANGING 2
> +#define DRM_SWITCH_POWER_DYNAMIC_OFF 3

Since this isn't uapi it'd be nice to change it to an enum, which we can
then properly kernel-doc and make your references links in the resulting
html. Otherwise lgtm.

Would need an include stanza for drm_device.h in drm-internals.rst, plus a
bit of kernel-doc cleanup in here I think (which iirc is why I didn't yet
do this).
-Daniel

> +
>  /**
>   * DRM device structure. This structure represent a complete card that
>   * may contain multiple heads.
> @@ -222,6 +229,8 @@ struct drm_device {
>  	struct idr object_name_idr;
>  	struct drm_vma_offset_manager *vma_offset_manager;
>  	/*@} */
> +
> +	/* See DRM_SWITCH_POWER defines */
>  	int switch_power_state;
>  
>  	/**
> -- 
> 2.12.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
