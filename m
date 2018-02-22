Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933330AbeBVQUg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:20:36 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33072 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933134AbeBVQUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:20:33 -0500
X-Google-Smtp-Source: AH8x227lhjV9sBm4cArvhuiNitbStNWQe7bsLyoTgWAbsn7mSsUEBEMkC5MdaFg/Ty6MyPTqkiviiw==
Date: Thu, 22 Feb 2018 11:20:31 -0500
From: Sean Paul <seanpaul@chromium.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>, Monk Liu <monk.liu@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel.daenzer@amd.com>,
        Chunming Zhou <david1.zhou@amd.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: fix drm_get_max_iomem type mismatch
Message-ID: <20180222162031.GF223881@art_vandelay>
References: <20180222114804.1394300-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222114804.1394300-1-arnd@arndb.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 12:47:51PM +0100, Arnd Bergmann wrote:
> When comparing two variables with min()/max(), they should be the same type:
> 
> drivers/gpu/drm/drm_memory.c: In function 'drm_get_max_iomem':
> include/linux/kernel.h:821:16: error: comparison of distinct pointer types lacks a cast [-Werror]
>   (void) (&max1 == &max2);
> 
> This makes the local variable in drm_get_max_iomem make the type
> from resource->end.
> 
> Fixes: 82626363a217 ("drm: add func to get max iomem address v2")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd, I've applied this to drm-misc-next.

Sean

> ---
>  drivers/gpu/drm/drm_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_memory.c b/drivers/gpu/drm/drm_memory.c
> index 7ca500b8c399..3c54044214db 100644
> --- a/drivers/gpu/drm/drm_memory.c
> +++ b/drivers/gpu/drm/drm_memory.c
> @@ -153,7 +153,7 @@ EXPORT_SYMBOL(drm_legacy_ioremapfree);
>  u64 drm_get_max_iomem(void)
>  {
>  	struct resource *tmp;
> -	u64 max_iomem = 0;
> +	resource_size_t max_iomem = 0;
>  
>  	for (tmp = iomem_resource.child; tmp; tmp = tmp->sibling) {
>  		max_iomem = max(max_iomem,  tmp->end);
> -- 
> 2.9.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
