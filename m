Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754518AbeE2F7E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 01:59:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55769 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752282AbeE2F7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 01:59:02 -0400
X-Google-Smtp-Source: ADUXVKIfXmPCQjj2aSgJne+/L66T2+dFr8VJSW8tXly1S56TtsMLp8dSdGrpGnj6EM7Yw42K3WTGfA==
Subject: Re: [Xen-devel] [PATCH 3/8] drm/xen-front: fix 32-bit build warning
To: Arnd Bergmann <arnd@arndb.de>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20180525155030.3667352-1-arnd@arndb.de>
 <20180525155030.3667352-3-arnd@arndb.de>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <d08e0200-f431-8713-0286-cd5bbf3441c8@gmail.com>
Date: Tue, 29 May 2018 08:58:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180525155030.3667352-3-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/25/2018 06:50 PM, Arnd Bergmann wrote:
> In 32-bit kernel builds, we cannot cast between a pointer and a 64-bit
> type:
>
> In file included from drivers/gpu/drm/xen/xen_drm_front_cfg.c:18:
> drivers/gpu/drm/xen/xen_drm_front.h: In function 'xen_drm_front_fb_to_cookie':
> drivers/gpu/drm/xen/xen_drm_front.h:129:9: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>    return (u64)fb;
>
> drivers/gpu/drm/xen/xen_drm_front.h: In function 'xen_drm_front_dbuf_to_cookie':
> drivers/gpu/drm/xen/xen_drm_front.h:134:9: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>    return (u64)gem_obj;
>
> drivers/gpu/drm/xen/xen_drm_front_shbuf.c: In function 'backend_unmap':
> drivers/gpu/drm/xen/xen_drm_front_shbuf.c:125:4: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>     ((phys_addr_t)pfn_to_kaddr(page_to_xen_pfn(page)))
>
> Using uintptr_t instead probably does what we want here, although it's
> not clear to me why we assign a virtual address pointer to a phys_addr_t
> in backend_unmap().
>
> Fixes: c575b7eeb89f ("drm/xen-front: Add support for Xen PV display frontend")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/gpu/drm/xen/xen_drm_front.h       | 4 ++--
>   drivers/gpu/drm/xen/xen_drm_front_shbuf.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/xen/xen_drm_front.h b/drivers/gpu/drm/xen/xen_drm_front.h
> index 2c2479b571ae..5693b4a4b02b 100644
> --- a/drivers/gpu/drm/xen/xen_drm_front.h
> +++ b/drivers/gpu/drm/xen/xen_drm_front.h
> @@ -126,12 +126,12 @@ struct xen_drm_front_drm_info {
>   
>   static inline u64 xen_drm_front_fb_to_cookie(struct drm_framebuffer *fb)
>   {
> -	return (u64)fb;
> +	return (uintptr_t)fb;
>   }
>   
>   static inline u64 xen_drm_front_dbuf_to_cookie(struct drm_gem_object *gem_obj)
>   {
> -	return (u64)gem_obj;
> +	return (uintptr_t)gem_obj;
>   }
>   
>   int xen_drm_front_mode_set(struct xen_drm_front_drm_pipeline *pipeline,
> diff --git a/drivers/gpu/drm/xen/xen_drm_front_shbuf.c b/drivers/gpu/drm/xen/xen_drm_front_shbuf.c
> index 8099cb343ae3..d333b67cc1a0 100644
> --- a/drivers/gpu/drm/xen/xen_drm_front_shbuf.c
> +++ b/drivers/gpu/drm/xen/xen_drm_front_shbuf.c
> @@ -122,7 +122,7 @@ static void guest_calc_num_grefs(struct xen_drm_front_shbuf *buf)
>   }
>   
>   #define xen_page_to_vaddr(page) \
> -		((phys_addr_t)pfn_to_kaddr(page_to_xen_pfn(page)))
> +		((uintptr_t)pfn_to_kaddr(page_to_xen_pfn(page)))
>   
>   static int backend_unmap(struct xen_drm_front_shbuf *buf)
>   {
Thank you for your patch: this issue was already discussed [1] and 
applied [2] to
drm-misc-next.

Thank you,
Oleksandr

[1] https://patchwork.freedesktop.org/patch/224359/
[2] https://patchwork.freedesktop.org/patch/224920/
