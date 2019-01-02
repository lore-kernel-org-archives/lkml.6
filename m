Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCDAC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987DA2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbfABRKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 12:10:21 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60420 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfABRKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 12:10:21 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id DA1FA27967A
Message-ID: <6bf1a372bfe9b4849138ecf7800b5758049f3bd9.camel@collabora.com>
Subject: Re: [PATCH 03/10] drm/virtio: drop virtio_gpu_fence_cleanup()
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Date:   Wed, 02 Jan 2019 14:10:12 -0300
In-Reply-To: <20181219122708.4586-4-kraxel@redhat.com>
References: <20181219122708.4586-1-kraxel@redhat.com>
         <20181219122708.4586-4-kraxel@redhat.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-19 at 13:27 +0100, Gerd Hoffmann wrote:
> Just call drm_fence_put directly instead.
> Also set vgfb->fence to NULL after dropping the reference.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h   | 1 -
>  drivers/gpu/drm/virtio/virtgpu_fence.c | 8 --------
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 2 +-
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 6 ++++--
>  4 files changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 63704915f8..bfb31fc3d0 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -337,7 +337,6 @@ int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma);
>  /* virtio_gpu_fence.c */
>  struct virtio_gpu_fence *virtio_gpu_fence_alloc(
>  	struct virtio_gpu_device *vgdev);
> -void virtio_gpu_fence_cleanup(struct virtio_gpu_fence *fence);
>  int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
>  			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
>  			  struct virtio_gpu_fence *fence);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
> index 4d6826b278..21bd4c4a32 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_fence.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
> @@ -81,14 +81,6 @@ struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev)
>  	return fence;
>  }
>  
> -void virtio_gpu_fence_cleanup(struct virtio_gpu_fence *fence)
> -{
> -	if (!fence)
> -		return;
> -
> -	dma_fence_put(&fence->f);
> -}
> -
>  int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
>  			  struct virtio_gpu_ctrl_hdr *cmd_hdr,
>  			  struct virtio_gpu_fence *fence)
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 161b80fee4..14ce8188c0 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -351,7 +351,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
>  		virtio_gpu_cmd_resource_create_3d(vgdev, qobj, &rc_3d);
>  		ret = virtio_gpu_object_attach(vgdev, qobj, fence);
>  		if (ret) {
> -			virtio_gpu_fence_cleanup(fence);
> +			dma_fence_put(&fence->f);
>  			goto fail_backoff;
>  		}
>  		ttm_eu_fence_buffer_objects(&ticket, &validate_list, &fence->f);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index 548265b8e8..024c2aa0c9 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -169,8 +169,10 @@ static void virtio_gpu_cursor_cleanup_fb(struct drm_plane *plane,
>  		return;
>  
>  	vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
> -	if (vgfb->fence)
> -		virtio_gpu_fence_cleanup(vgfb->fence);
> +	if (vgfb->fence) {
> +		dma_fence_put(&vgfb->fence->f);
> +		vgfb->fence = NULL;
> +	}
>  }
>  
>  static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,

Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>

Regards,
Ezequiel

