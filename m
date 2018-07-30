Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4CFC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84DC20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 07:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84DC20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeG3J0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 05:26:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:34962 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbeG3J0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 05:26:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 00:53:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="75665730"
Received: from chanse1-mobl.ger.corp.intel.com (HELO [10.252.51.109]) ([10.252.51.109])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jul 2018 00:53:01 -0700
Subject: Re: [PATCH] drm/kms/plane: Avoiding redundant checks in case of
 EDEADLK retries
To:     Satendra Singh Thakur <satendra.t@samsung.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     vineet.j@samsung.com, hemanshu.s@samsung.com,
        nishant.y08@samsung.com, sst2005@gmail.com
References: <CGME20180730055515epcas5p3358ce6d5e80b66256ea92aa5659f74bb@epcas5p3.samsung.com>
 <20180730055515epcas5p3358ce6d5e80b66256ea92aa5659f74bb~GD9F1P8zb2847928479epcas5p3D@epcas5p3.samsung.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <9fa529a6-8ad0-9e9d-99a4-1db8284ecefd@linux.intel.com>
Date:   Mon, 30 Jul 2018 09:53:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730055515epcas5p3358ce6d5e80b66256ea92aa5659f74bb~GD9F1P8zb2847928479epcas5p3D@epcas5p3.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 30-07-18 om 07:18 schreef Satendra Singh Thakur:
> 1. Currently, if modeset_lock is re-tried many times in case of EDEADLK
> error, then this will be the code flow
>
> retry:
> 	ret = drm_modeset_lock();
>
> if (ret)-->this is true
> 		goto out;
>
> out:
> 	if (fb)
> 	if (plane->old_fb)
> 	if (ret == -EDEADLK)
> 		goto retry;
> It can be observed that checks on fb, old_fb are redundant
> in retry-case.
> If we keep if (ret == -EDEADLK) right after the out label,
> that will avoid redundant checks.
> It won't affect normal scenario (non-retry case).
> 2. Moved NULL assignment inside if statement related to NULL check
>
> Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
> ---
>  drivers/gpu/drm/drm_plane.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 0350544..ed42cd4 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -658,9 +658,10 @@ static int __setplane_internal(struct drm_plane *plane,
>  	}
>  
>  out:
> -	if (plane->old_fb)
> +	if (plane->old_fb) {
>  		drm_framebuffer_put(plane->old_fb);
> -	plane->old_fb = NULL;
> +		plane->old_fb = NULL;
> +	}
>  
>  	return ret;
>  }
> @@ -1097,17 +1098,17 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
>  	}
>  
>  out:
> -	if (fb)
> -		drm_framebuffer_put(fb);
> -	if (plane->old_fb)
> -		drm_framebuffer_put(plane->old_fb);
> -	plane->old_fb = NULL;
> -
>  	if (ret == -EDEADLK) {
>  		ret = drm_modeset_backoff(&ctx);
>  		if (!ret)
>  			goto retry;
>  	}
> +	if (fb)
> +		drm_framebuffer_put(fb);
> +	if (plane->old_fb) {
> +		drm_framebuffer_put(plane->old_fb);
> +		plane->old_fb = NULL;
> +	}
>  
>  	drm_modeset_drop_locks(&ctx);
>  	drm_modeset_acquire_fini(&ctx);

It's not redundant. plane->old_fb is protected by the plane_mutex lock and should be
null before dropping the locks in drm_modeset_backoff(). Else other code will trip
with a WARN_ON(plane->old_fb != NULL);

Before sending any more patches I would strongly suggest setting
CONFIG_DEBUG_WW_MUTEX_SLOWPATH and CONFIG_PROVE_LOCKING in your kernel, and try to
run the IGT testsuite.

~Maarten

