Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B295BC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F37250EE
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F37250EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936862AbeF2QMR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:12:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:53559 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936537AbeF2QMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:12:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 09:12:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="51511896"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga008.fm.intel.com with SMTP; 29 Jun 2018 09:12:05 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 29 Jun 2018 19:12:05 +0300
Date:   Fri, 29 Jun 2018 19:12:05 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Use kvzalloc for allocating blob property memory
Message-ID: <20180629161205.GE5565@intel.com>
References: <20180629142710.2069-1-michel@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180629142710.2069-1-michel@daenzer.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 04:27:10PM +0200, Michel Dänzer wrote:
> From: Michel Dänzer <michel.daenzer@amd.com>
> 
> The property size may be controlled by userspace, can be large (I've
> seen failure with order 4, i.e. 16 pages / 64 KB) and doesn't need to be
> physically contiguous.

I wonder if we should enforce some kind of reasonable limit
on the blob size. Looks like we allow anything up to
ULONG_MAX currently. We can't tell at createblob time how
the thing is going to be used, so can't have any kind
of property specific limit unfortunately.

> 
> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
> ---
>  drivers/gpu/drm/drm_property.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
> index 1f8031e30f53..cdb10f885a4f 100644
> --- a/drivers/gpu/drm/drm_property.c
> +++ b/drivers/gpu/drm/drm_property.c
> @@ -532,7 +532,7 @@ static void drm_property_free_blob(struct kref *kref)
>  
>  	drm_mode_object_unregister(blob->dev, &blob->base);
>  
> -	kfree(blob);
> +	kvfree(blob);
>  }
>  
>  /**
> @@ -559,7 +559,7 @@ drm_property_create_blob(struct drm_device *dev, size_t length,
>  	if (!length || length > ULONG_MAX - sizeof(struct drm_property_blob))
>  		return ERR_PTR(-EINVAL);
>  
> -	blob = kzalloc(sizeof(struct drm_property_blob)+length, GFP_KERNEL);
> +	blob = kvzalloc(sizeof(struct drm_property_blob)+length, GFP_KERNEL);
>  	if (!blob)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -576,7 +576,7 @@ drm_property_create_blob(struct drm_device *dev, size_t length,
>  	ret = __drm_mode_object_add(dev, &blob->base, DRM_MODE_OBJECT_BLOB,
>  				    true, drm_property_free_blob);
>  	if (ret) {
> -		kfree(blob);
> +		kvfree(blob);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -- 
> 2.18.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
