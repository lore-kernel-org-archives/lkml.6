Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EAFC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540C42080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UfXIunvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540C42080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeJ3Sav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:30:51 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43817 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbeJ3Sav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:30:51 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so9849549eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 02:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=F2ZjyZFdLkt6fLOqwV+aBE3WtqltslHKYROQQMBKcGg=;
        b=UfXIunvLisb8pQ260UtUrS5rToiIvdynTFlqmPUxpIdqWfxmNKETS7A9VCFIVd8i/s
         pU5QYTXAavsKXZIDPLq1fYoM63A3llLUoXPxUsfTQbkC6IotW5y/5mRuyMJ67fjzjXjU
         WAIPj1DfzqQdx47Oz6mnMrxm+cECxOD1afN8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=F2ZjyZFdLkt6fLOqwV+aBE3WtqltslHKYROQQMBKcGg=;
        b=raSfZMxlE7IuUYdl20f1L/iGBwEA/AECcK02vV4AwRfpoB+wiOKVkvgayu1Z7ol+eG
         odUv/Es58wUOupxiKqfGl2FgcLdcgDAv5C2RNjfVnzaRRixQm66mv/h54CehC0+fJLE6
         e8aCzyMEuWEhPRrajJ0M4KO7hB9pBs7X7XcFC14CSKKYWMdDROo9x+U00ljfoybO1M74
         I5aA2Fwm5OeABytVRihkMh8m7coEW7M8ffeecvktm9vfzMdNUqlVGiva7Apdlo3F5on7
         lk4hb3jySqLoL+CJ4vyAob02Kkhd2HAxa9w3Rp4sjUMI3EnO2Hy34a6H7Rlwk9Bh1Glq
         rOEQ==
X-Gm-Message-State: AGRZ1gJF9sYE+ppLy6tTsDB6sqZTg5HYqVUdGOddzyKi/qKZOZl48KIn
        Jfz/Xwjhis6rq9YpFlZnquwr2Q==
X-Google-Smtp-Source: AJdET5cRmlt4CZoofwMV1jiV8JK6C18dE1vQRYz9LCCdxtOohB5W87+b41zvu1jx5L7dBgtjTDWcqg==
X-Received: by 2002:a17:906:6c9a:: with SMTP id s26-v6mr4360551ejr.239.1540892287146;
        Tue, 30 Oct 2018 02:38:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id f11-v6sm2698505eds.23.2018.10.30.02.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 02:38:06 -0700 (PDT)
Date:   Tue, 30 Oct 2018 10:38:04 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     virtio-dev@lists.oasis-open.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v4 2/2] drm/virtio: add edid support
Message-ID: <20181030093804.GQ21967@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        virtio-dev@lists.oasis-open.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
References: <20181030063206.19528-1-kraxel@redhat.com>
 <20181030063206.19528-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030063206.19528-3-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 07:32:06AM +0100, Gerd Hoffmann wrote:
> linux guest driver implementation of the VIRTIO_GPU_F_EDID feature.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Like with bochs, I think drm_do_get_edid() here is overkill and fairly
pointless.
-Daniel

> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h     |  3 ++
>  drivers/gpu/drm/virtio/virtgpu_display.c | 12 ++++++
>  drivers/gpu/drm/virtio/virtgpu_drv.c     |  1 +
>  drivers/gpu/drm/virtio/virtgpu_kms.c     |  8 ++++
>  drivers/gpu/drm/virtio/virtgpu_vq.c      | 67 ++++++++++++++++++++++++++++++++
>  5 files changed, 91 insertions(+)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index d29f0c7c76..852078419d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -114,6 +114,7 @@ struct virtio_gpu_output {
>  	struct drm_encoder enc;
>  	struct virtio_gpu_display_one info;
>  	struct virtio_gpu_update_cursor cursor;
> +	struct edid *edid;
>  	int cur_x;
>  	int cur_y;
>  	bool enabled;
> @@ -204,6 +205,7 @@ struct virtio_gpu_device {
>  	spinlock_t ctx_id_idr_lock;
>  
>  	bool has_virgl_3d;
> +	bool has_edid;
>  
>  	struct work_struct config_changed_work;
>  
> @@ -298,6 +300,7 @@ int virtio_gpu_cmd_get_capset_info(struct virtio_gpu_device *vgdev, int idx);
>  int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
>  			      int idx, int version,
>  			      struct virtio_gpu_drv_cap_cache **cache_p);
> +int virtio_gpu_cmd_get_edids(struct virtio_gpu_device *vgdev);
>  void virtio_gpu_cmd_context_create(struct virtio_gpu_device *vgdev, uint32_t id,
>  				   uint32_t nlen, const char *name);
>  void virtio_gpu_cmd_context_destroy(struct virtio_gpu_device *vgdev,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index 8f8fed471e..b5580b11a0 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -169,6 +169,12 @@ static int virtio_gpu_conn_get_modes(struct drm_connector *connector)
>  	struct drm_display_mode *mode = NULL;
>  	int count, width, height;
>  
> +	if (output->edid) {
> +		count = drm_add_edid_modes(connector, output->edid);
> +		if (count)
> +			return count;
> +	}
> +
>  	width  = le32_to_cpu(output->info.r.width);
>  	height = le32_to_cpu(output->info.r.height);
>  	count = drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
> @@ -287,6 +293,8 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
>  	drm_connector_init(dev, connector, &virtio_gpu_connector_funcs,
>  			   DRM_MODE_CONNECTOR_VIRTUAL);
>  	drm_connector_helper_add(connector, &virtio_gpu_conn_helper_funcs);
> +	if (vgdev->has_edid)
> +		drm_connector_attach_edid_property(connector);
>  
>  	drm_encoder_init(dev, encoder, &virtio_gpu_enc_funcs,
>  			 DRM_MODE_ENCODER_VIRTUAL, NULL);
> @@ -378,6 +386,10 @@ int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
>  
>  void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev)
>  {
> +	int i;
> +
> +	for (i = 0 ; i < vgdev->num_scanouts; ++i)
> +		kfree(vgdev->outputs[i].edid);
>  	virtio_gpu_fbdev_fini(vgdev);
>  	drm_mode_config_cleanup(vgdev->ddev);
>  }
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index d9287c144f..f7f32a885a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -80,6 +80,7 @@ static unsigned int features[] = {
>  	 */
>  	VIRTIO_GPU_F_VIRGL,
>  #endif
> +	VIRTIO_GPU_F_EDID,
>  };
>  static struct virtio_driver virtio_gpu_driver = {
>  	.feature_table = features,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index 65060c0852..f6cbbb27e4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -44,6 +44,8 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
>  	virtio_cread(vgdev->vdev, struct virtio_gpu_config,
>  		     events_read, &events_read);
>  	if (events_read & VIRTIO_GPU_EVENT_DISPLAY) {
> +		if (vgdev->has_edid)
> +			virtio_gpu_cmd_get_edids(vgdev);
>  		virtio_gpu_cmd_get_display_info(vgdev);
>  		drm_helper_hpd_irq_event(vgdev->ddev);
>  		events_clear |= VIRTIO_GPU_EVENT_DISPLAY;
> @@ -174,6 +176,10 @@ int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
>  #else
>  	DRM_INFO("virgl 3d acceleration not supported by guest\n");
>  #endif
> +	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
> +		vgdev->has_edid = true;
> +		DRM_INFO("EDID support available.\n");
> +	}
>  
>  	ret = virtio_find_vqs(vgdev->vdev, 2, vqs, callbacks, names, NULL);
>  	if (ret) {
> @@ -219,6 +225,8 @@ int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
>  
>  	if (num_capsets)
>  		virtio_gpu_get_capsets(vgdev, num_capsets);
> +	if (vgdev->has_edid)
> +		virtio_gpu_cmd_get_edids(vgdev);
>  	virtio_gpu_cmd_get_display_info(vgdev);
>  	wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
>  			   5 * HZ);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 4e2e037aed..dd149a59c7 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -604,6 +604,45 @@ static void virtio_gpu_cmd_capset_cb(struct virtio_gpu_device *vgdev,
>  	wake_up(&vgdev->resp_wq);
>  }
>  
> +static int virtio_get_edid_block(void *data, u8 *buf,
> +				 unsigned int block, size_t len)
> +{
> +	struct virtio_gpu_resp_edid *resp = data;
> +	size_t start = block * EDID_LENGTH;
> +
> +	if (start + len > le32_to_cpu(resp->size))
> +		return -1;
> +	memcpy(buf, resp->edid + start, len);
> +	return 0;
> +}
> +
> +static void virtio_gpu_cmd_get_edid_cb(struct virtio_gpu_device *vgdev,
> +				       struct virtio_gpu_vbuffer *vbuf)
> +{
> +	struct virtio_gpu_cmd_get_edid *cmd =
> +		(struct virtio_gpu_cmd_get_edid *)vbuf->buf;
> +	struct virtio_gpu_resp_edid *resp =
> +		(struct virtio_gpu_resp_edid *)vbuf->resp_buf;
> +	uint32_t scanout = le32_to_cpu(cmd->scanout);
> +	struct virtio_gpu_output *output;
> +	struct edid *new_edid, *old_edid;
> +
> +	if (scanout >= vgdev->num_scanouts)
> +		return;
> +	output = vgdev->outputs + scanout;
> +
> +	new_edid = drm_do_get_edid(&output->conn, virtio_get_edid_block, resp);
> +
> +	spin_lock(&vgdev->display_info_lock);
> +	old_edid = output->edid;
> +	output->edid = new_edid;
> +	drm_connector_update_edid_property(&output->conn, output->edid);
> +	spin_unlock(&vgdev->display_info_lock);
> +
> +	kfree(old_edid);
> +	wake_up(&vgdev->resp_wq);
> +}
> +
>  int virtio_gpu_cmd_get_display_info(struct virtio_gpu_device *vgdev)
>  {
>  	struct virtio_gpu_ctrl_hdr *cmd_p;
> @@ -706,6 +745,34 @@ int virtio_gpu_cmd_get_capset(struct virtio_gpu_device *vgdev,
>  	return 0;
>  }
>  
> +int virtio_gpu_cmd_get_edids(struct virtio_gpu_device *vgdev)
> +{
> +	struct virtio_gpu_cmd_get_edid *cmd_p;
> +	struct virtio_gpu_vbuffer *vbuf;
> +	void *resp_buf;
> +	int scanout;
> +
> +	if (WARN_ON(!vgdev->has_edid))
> +		return -EINVAL;
> +
> +	for (scanout = 0; scanout < vgdev->num_scanouts; scanout++) {
> +		resp_buf = kzalloc(sizeof(struct virtio_gpu_resp_edid),
> +				   GFP_KERNEL);
> +		if (!resp_buf)
> +			return -ENOMEM;
> +
> +		cmd_p = virtio_gpu_alloc_cmd_resp
> +			(vgdev, &virtio_gpu_cmd_get_edid_cb, &vbuf,
> +			 sizeof(*cmd_p), sizeof(struct virtio_gpu_resp_edid),
> +			 resp_buf);
> +		cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_GET_EDID);
> +		cmd_p->scanout = cpu_to_le32(scanout);
> +		virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
> +	}
> +
> +	return 0;
> +}
> +
>  void virtio_gpu_cmd_context_create(struct virtio_gpu_device *vgdev, uint32_t id,
>  				   uint32_t nlen, const char *name)
>  {
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
