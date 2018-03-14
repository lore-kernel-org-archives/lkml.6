Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933166AbeCNCoi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 22:44:38 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:42242 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932840AbeCNCoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 22:44:37 -0400
Subject: Re: [PATCH v8 04/13] [media] vb2: add is_unordered callback for
 drivers
To: Gustavo Padovan <gustavo@padovan.org>, linux-media@vger.kernel.org
Cc: kernel@collabora.com, Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Shuah Khan <shuahkh@osg.samsung.com>, Pawel Osciak <pawel@osciak.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Brian Starkey <brian.starkey@arm.com>, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>
References: <20180309174920.22373-1-gustavo@padovan.org>
 <20180309174920.22373-5-gustavo@padovan.org>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <82d8167e-fea2-6f28-fdfe-69e37474cc27@xs4all.nl>
Date: Tue, 13 Mar 2018 19:44:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180309174920.22373-5-gustavo@padovan.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHs1e3tYXzWFSRpmHbiMm0sDLL6pGMi631ymm5cu+3BsXyzGoukzvztT7mPIK8n6J42vHni6dFH+wzjWJqP8BZ5yfSRfLWmXY79TjDXgomJxyARWrYeh
 n2vF0h1YzkhHqiXQSVi0CaGAPQxJNc9ANhSnudvHFm9TRHA+veSY3zjLmXdJqJ4hD4ra3Y00RtxsJNJCNh2QIMEdRZfyjVFVE4PdFBM5jwNuKZKO4AIShsqD
 ZQopf06oL4e+ENKTkkX62iGMaRL50wXYQPZl5aPyy7xqY2FXn8BQa5plHrpo+MFYF86G4hqVJ2vZVYUKexpDFXSaD5EbUIjCczmtdNpSw4cpe3cx6ALrpt2B
 bR43bv0418H5LsvE2GmRQ7fwSgTUDvXzwGybDc8MkKm+Wlhv4S2ulnK0aE/jWPCjfnXL02HJo8AdJW6KQQPke5LkkgBeb3Su194Zl+n/ujruND0bQgsFPoMq
 QYi4nX248BfbJNgZ
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 09:49 AM, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.com>
> 
> Explicit synchronization benefits a lot from ordered queues, they fit
> better in a pipeline with DRM for example so create a opt-in way for
> drivers notify videobuf2 that the queue is unordered.
> 
> Drivers don't need implement it if the queue is ordered.
> 
> v2: 	- improve comments for is_unordered flag (Hans)
> 
> v3: 	- make it bool (Hans)
> 	- create vb2_ops_set_unordered() helper
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> ---
>  drivers/media/common/videobuf2/videobuf2-v4l2.c |  6 ++++++
>  include/media/videobuf2-core.h                  |  6 ++++++
>  include/media/videobuf2-v4l2.h                  | 10 ++++++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index 886a2d8d5c6c..68291ba8632d 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -961,6 +961,12 @@ void vb2_ops_wait_finish(struct vb2_queue *vq)
>  }
>  EXPORT_SYMBOL_GPL(vb2_ops_wait_finish);
>  
> +bool vb2_ops_set_unordered(struct vb2_queue *q)
> +{
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(vb2_ops_set_unordered);

This should be called vb2_ops_is_unordered. The name after the vb2_ops_
prefix should match the op name (is_unordered).

I also would add this to videobuf2-core.c since there is nothing V4L2
specific about this.

> +
>  MODULE_DESCRIPTION("Driver helper framework for Video for Linux 2");
>  MODULE_AUTHOR("Pawel Osciak <pawel@osciak.com>, Marek Szyprowski");
>  MODULE_LICENSE("GPL");
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 5b6c541e4e1b..46a9e674f7e1 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -370,6 +370,10 @@ struct vb2_buffer {
>   *			callback by calling vb2_buffer_done() with either
>   *			%VB2_BUF_STATE_DONE or %VB2_BUF_STATE_ERROR; may use
>   *			vb2_wait_for_all_buffers() function
> + * @is_unordered:	tell if the queue is unordered, i.e. buffers can be
> + *			dequeued in a different order from how they were queued.
> + *			The default is assumed to be ordered and this function
> + *			only needs to be implemented for unordered queues.
>   * @buf_queue:		passes buffer vb to the driver; driver may start
>   *			hardware operation on this buffer; driver should give
>   *			the buffer back by calling vb2_buffer_done() function;
> @@ -393,6 +397,7 @@ struct vb2_ops {
>  
>  	int (*start_streaming)(struct vb2_queue *q, unsigned int count);
>  	void (*stop_streaming)(struct vb2_queue *q);
> +	bool (*is_unordered)(struct vb2_queue *q);
>  
>  	void (*buf_queue)(struct vb2_buffer *vb);
>  };
> @@ -566,6 +571,7 @@ struct vb2_queue {
>  	u32				cnt_wait_finish;
>  	u32				cnt_start_streaming;
>  	u32				cnt_stop_streaming;
> +	u32				cnt_is_unordered;
>  #endif
>  };
>  
> diff --git a/include/media/videobuf2-v4l2.h b/include/media/videobuf2-v4l2.h
> index 3d5e2d739f05..9de3c887c875 100644
> --- a/include/media/videobuf2-v4l2.h
> +++ b/include/media/videobuf2-v4l2.h
> @@ -291,4 +291,14 @@ void vb2_ops_wait_prepare(struct vb2_queue *vq);
>   */
>  void vb2_ops_wait_finish(struct vb2_queue *vq);
>  
> +/**
> + * vb2_ops_set_unordered - helper function to mark queue as unordered
> + *
> + * @vq: pointer to &struct vb2_queue
> + *
> + * This helper just return true to notify that the driver can't deal with

return -> returns

> + * ordered queues.
> + */
> +bool vb2_ops_set_unordered(struct vb2_queue *q);
> +
>  #endif /* _MEDIA_VIDEOBUF2_V4L2_H */
> 

Regards,

	Hans
