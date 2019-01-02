Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2289C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3222171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfABRKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 12:10:00 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60408 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfABRKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 12:10:00 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 12545279684
Message-ID: <a8c5337fb0825fa7892b777d29fbda738a1057c4.camel@collabora.com>
Subject: Re: [PATCH 02/10] drm/virtio: fix pageflip flush
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Date:   Wed, 02 Jan 2019 14:09:52 -0300
In-Reply-To: <20181219122708.4586-3-kraxel@redhat.com>
References: <20181219122708.4586-1-kraxel@redhat.com>
         <20181219122708.4586-3-kraxel@redhat.com>
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
> Sending the flush command only makes sense if we actually have
> a framebuffer attached to the scanout (handle != 0).
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index ead5c53d4e..548265b8e8 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -130,11 +130,12 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
>  				   plane->state->src_h >> 16,
>  				   plane->state->src_x >> 16,
>  				   plane->state->src_y >> 16);
> -	virtio_gpu_cmd_resource_flush(vgdev, handle,
> -				      plane->state->src_x >> 16,
> -				      plane->state->src_y >> 16,
> -				      plane->state->src_w >> 16,
> -				      plane->state->src_h >> 16);
> +	if (handle)
> +		virtio_gpu_cmd_resource_flush(vgdev, handle,
> +					      plane->state->src_x >> 16,
> +					      plane->state->src_y >> 16,
> +					      plane->state->src_w >> 16,
> +					      plane->state->src_h >> 16);
>  }
>  
>  static int virtio_gpu_cursor_prepare_fb(struct drm_plane *plane,

Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>

Regards,
Ezequiel

