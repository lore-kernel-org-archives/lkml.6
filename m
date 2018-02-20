Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752923AbeBTQSb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:18:31 -0500
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:39578 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752102AbeBTQSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:18:30 -0500
Subject: Re: [RFCv4 13/21] media: videobuf2-v4l2: support for requests
To: Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Gustavo Padovan <gustavo.padovan@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180220044425.169493-1-acourbot@chromium.org>
 <20180220044425.169493-14-acourbot@chromium.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <86ad101f-f400-c7fd-2aa5-4dc618973f3d@xs4all.nl>
Date: Tue, 20 Feb 2018 17:18:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180220044425.169493-14-acourbot@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJRXKm907lwBJx/lE6VsD/hgACbCmTDOvTgV4jQAjT1d9Uhv9u5IL+Fg4gzQS/agrKXKZivP2Jt86kI3N+EySaOkHg6oSwsIuakHcSoRW7rmhOnoAbkO
 zz3z8g3vwEyQ8u4NAqle1nJo+F1QOPMOcYuMcTsNbhsGc/mFC2VHxjHwMMa90vLUOtm8e49aUtXi3b0mt6vT/KXpTyCm0I1ttERjDD1ZDCBid4aj2r3ePhhA
 5SdSgd3tyhlhwZzkQGc/SJHCkVGey3jYR+8lMXEGP55F4VaY9yOqJLnLSv4Ev7E4sfxV9GW0PBjWdmPCa/rxIf7iSCgJrTt9126fAfkSFr1eKompOl6RfOmQ
 LCjsNspGqzQxUK+ZmwYoEMf0D9Xelv6jKTiMaW7jDz1YHvJ74aKyK+I33fSvMwWr3s/Wzhsp+zdUHbDVkkQxyHHVAxTskmuMIgVkKn/pd/EPpO5tD6pUpYkr
 xv/BoYWeuam3De0a
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/2018 05:44 AM, Alexandre Courbot wrote:
> Add a new vb2_qbuf_request() (a request-aware version of vb2_qbuf())
> that request-aware drivers can call to queue a buffer into a request
> instead of directly into the vb2 queue if relevent.
> 
> This function expects that drivers invoking it are using instances of
> v4l2_request_entity and v4l2_request_entity_data to describe their
> entity and entity data respectively.
> 
> Also add the vb2_request_submit() helper function which drivers can
> invoke in order to queue all the buffers previously queued into a
> request into the regular vb2 queue.
> 
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> ---
>  .../media/common/videobuf2/videobuf2-v4l2.c   | 129 +++++++++++++++++-
>  include/media/videobuf2-v4l2.h                |  59 ++++++++
>  2 files changed, 187 insertions(+), 1 deletion(-)
> 

<snip>

> @@ -776,10 +899,14 @@ EXPORT_SYMBOL_GPL(vb2_ioctl_querybuf);
>  int vb2_ioctl_qbuf(struct file *file, void *priv, struct v4l2_buffer *p)
>  {
>  	struct video_device *vdev = video_devdata(file);
> +	struct v4l2_fh *fh = NULL;
> +
> +	if (test_bit(V4L2_FL_USES_V4L2_FH, &vdev->flags))
> +		fh = file->private_data;

No need for this. All drivers using vb2 will also use v4l2_fh.

>  
>  	if (vb2_queue_is_busy(vdev, file))
>  		return -EBUSY;
> -	return vb2_qbuf(vdev->queue, p);
> +	return vb2_qbuf_request(vdev->queue, p, fh ? fh->entity : NULL);
>  }
>  EXPORT_SYMBOL_GPL(vb2_ioctl_qbuf);
>  
> diff --git a/include/media/videobuf2-v4l2.h b/include/media/videobuf2-v4l2.h
> index 3d5e2d739f05..d4dfa266a0da 100644
> --- a/include/media/videobuf2-v4l2.h
> +++ b/include/media/videobuf2-v4l2.h
> @@ -23,6 +23,12 @@
>  #error VB2_MAX_PLANES != VIDEO_MAX_PLANES
>  #endif
>  
> +struct media_entity;
> +struct v4l2_fh;
> +struct media_request;
> +struct media_request_entity;
> +struct v4l2_request_entity_data;
> +
>  /**
>   * struct vb2_v4l2_buffer - video buffer information for v4l2.
>   *
> @@ -116,6 +122,59 @@ int vb2_prepare_buf(struct vb2_queue *q, struct v4l2_buffer *b);
>   */
>  int vb2_qbuf(struct vb2_queue *q, struct v4l2_buffer *b);
>  
> +#if IS_ENABLED(CONFIG_MEDIA_REQUEST_API)
> +
> +/**
> + * vb2_qbuf_request() - Queue a buffer, with request support
> + * @q:		pointer to &struct vb2_queue with videobuf2 queue.
> + * @b:		buffer structure passed from userspace to
> + *		&v4l2_ioctl_ops->vidioc_qbuf handler in driver
> + * @entity:	request entity to queue for if requests are used.
> + *
> + * Should be called from &v4l2_ioctl_ops->vidioc_qbuf handler of a driver.
> + *
> + * If requests are not in use, calling this is equivalent to calling vb2_qbuf().
> + *
> + * If the request_fd member of b is set, then the buffer represented by b is
> + * queued in the request instead of the vb2 queue. The buffer will be passed
> + * to the vb2 queue when the request is submitted.

I would definitely also prepare the buffer at this time. That way you'll see any
errors relating to the prepare early on.

> + *
> + * The return values from this function are intended to be directly returned
> + * from &v4l2_ioctl_ops->vidioc_qbuf handler in driver.
> + */
> +int vb2_qbuf_request(struct vb2_queue *q, struct v4l2_buffer *b,
> +		     struct media_request_entity *entity);
> +
> +/**
> + * vb2_request_submit() - Queue all the buffers in a v4l2 request.
> + * @data:	request entity data to queue buffers of
> + *
> + * This function should be called from the media_request_entity_ops::submit
> + * hook for instances of media_request_v4l2_entity_data. It will immediately
> + * queue all the request-bound buffers to their respective vb2 queues.
> + *
> + * Errors from vb2_core_qbuf() are returned if something happened. Also, since
> + * v4l2 request entities require at least one buffer for the request to trigger,
> + * this function will return -EINVAL if no buffer have been bound at all for
> + * this entity.
> + */
> +int vb2_request_submit(struct v4l2_request_entity_data *data);
> +
> +#else /* CONFIG_MEDIA_REQUEST_API */
> +
> +static inline int vb2_qbuf_request(struct vb2_queue *q, struct v4l2_buffer *b,
> +				   struct media_request_entity *entity)
> +{
> +	return vb2_qbuf(q, b);
> +}
> +
> +static inline int vb2_request_submit(struct v4l2_request_entity_data *data)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +#endif /* CONFIG_MEDIA_REQUEST_API */
> +
>  /**
>   * vb2_expbuf() - Export a buffer as a file descriptor
>   * @q:		pointer to &struct vb2_queue with videobuf2 queue.
> 

Regards,

	Hans
