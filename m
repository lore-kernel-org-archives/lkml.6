Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754658AbeD3P1X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:27:23 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34296 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754574AbeD3P1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:27:20 -0400
X-Google-Smtp-Source: AB8JxZqYHP3Wnlu4IlnUuN/K8y/oa67yCzXQ4SWSLfJ1JsI79JWvTGkYfyXwsEnMuY0PBTKA/aTmMWBGBRPLYds/iRM=
MIME-Version: 1.0
In-Reply-To: <20180309174920.22373-11-gustavo@padovan.org>
References: <20180309174920.22373-1-gustavo@padovan.org> <20180309174920.22373-11-gustavo@padovan.org>
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date: Mon, 30 Apr 2018 12:27:19 -0300
Message-ID: <CAAEAJfAx5ytB7pJmC2JQkaz8RKs9yjFBG9mndYex-15qdLvE8w@mail.gmail.com>
Subject: Re: [PATCH v8 10/13] [media] vb2: add out-fence support to QBUF
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-media <linux-media@vger.kernel.org>, kernel@collabora.com,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Shuah Khan <shuahkh@osg.samsung.com>, Pawel Osciak <pawel@osciak.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Brian Starkey <brian.starkey@arm.com>, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3UFRRW1030732

Hi guys,

I've a couple questions.

On 9 March 2018 at 14:49, Gustavo Padovan <gustavo@padovan.org> wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.com>
>
> If V4L2_BUF_FLAG_OUT_FENCE flag is present on the QBUF call we create
> an out_fence and send its fd to userspace on the fence_fd field as a
> return arg for the QBUF call.
>
> The fence is signaled on buffer_done(), when the job on the buffer is
> finished.
>
> v9:     - remove in-fences changes from this patch (Alex Courbot)
>         - improve fence context creation (Hans Verkuil)
>         - clean up out fences if vb2_core_qbuf() fails (Hans Verkuil)
>
> v8:
>         - return 0 as fence_fd if OUT_FENCE flag not used (Mauro)
>         - fix crash when checking not using fences in vb2_buffer_done()
>
> v7:
>         - merge patch that add the infrastructure to out-fences into
>         this one (Alex Courbot)
>         - Do not install the fd if there is no fence. (Alex Courbot)
>         - do not report error on requeueing, just WARN_ON_ONCE() (Hans)
>
> v6
>         - get rid of the V4L2_EVENT_OUT_FENCE event. We always keep the
>         ordering in vb2 for queueing in the driver, so the event is not
>         necessary anymore and the out_fence_fd is sent back to userspace
>         on QBUF call return arg
>         - do not allow requeueing with out-fences, instead mark the buffer
>         with an error and wake up to userspace.
>         - send the out_fence_fd back to userspace on the fence_fd field
>
> v5:
>         - delay fd_install to DQ_EVENT (Hans)
>         - if queue is fully ordered send OUT_FENCE event right away
>         (Brian)
>         - rename 'q->ordered' to 'q->ordered_in_driver'
>         - merge change to implement OUT_FENCE event here
>
> v4:
>         - return the out_fence_fd in the BUF_QUEUED event(Hans)
>
> v3:     - add WARN_ON_ONCE(q->ordered) on requeueing (Hans)
>         - set the OUT_FENCE flag if there is a fence pending (Hans)
>         - call fd_install() after vb2_core_qbuf() (Hans)
>         - clean up fence if vb2_core_qbuf() fails (Hans)
>         - add list to store sync_file and fence for the next queued buffer
>
> v2: check if the queue is ordered.
>
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> ---
>  drivers/media/common/videobuf2/videobuf2-core.c | 88 +++++++++++++++++++++++++
>  drivers/media/common/videobuf2/videobuf2-v4l2.c | 20 +++++-
>  include/media/videobuf2-core.h                  | 25 +++++++
>  3 files changed, 132 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 5de5e35cfc40..dd18a9f345c7 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -25,6 +25,7 @@
>  #include <linux/sched.h>
>  #include <linux/freezer.h>
>  #include <linux/kthread.h>
> +#include <linux/sync_file.h>
>
>  #include <media/videobuf2-core.h>
>  #include <media/v4l2-mc.h>
> @@ -357,6 +358,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>                         vb->planes[plane].length = plane_sizes[plane];
>                         vb->planes[plane].min_length = plane_sizes[plane];
>                 }
> +               vb->out_fence_fd = -1;
>                 q->bufs[vb->index] = vb;
>
>                 /* Allocate video buffer memory for the MMAP type */
> @@ -934,10 +936,22 @@ static void vb2_process_buffer_done(struct vb2_buffer *vb, enum vb2_buffer_state
>         case VB2_BUF_STATE_QUEUED:
>                 return;
>         case VB2_BUF_STATE_REQUEUEING:
> +               /* Requeuing with explicit synchronization, spit warning */
> +               WARN_ON_ONCE(vb->out_fence);
> +
>                 if (q->start_streaming_called)
>                         __enqueue_in_driver(vb);
>                 return;
>         default:
> +               if (vb->out_fence) {
> +                       if (state == VB2_BUF_STATE_ERROR)
> +                               dma_fence_set_error(vb->out_fence, -EFAULT);
> +                       dma_fence_signal(vb->out_fence);
> +                       dma_fence_put(vb->out_fence);
> +                       vb->out_fence = NULL;
> +                       vb->out_fence_fd = -1;
> +               }
> +
>                 /* Inform any processes that may be waiting for buffers */
>                 wake_up(&q->done_wq);
>                 break;
> @@ -1353,6 +1367,62 @@ int vb2_core_prepare_buf(struct vb2_queue *q, unsigned int index, void *pb)
>  }
>  EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
>
> +static inline const char *vb2_fence_get_driver_name(struct dma_fence *fence)
> +{
> +       return "vb2_fence";
> +}
> +
> +static inline const char *vb2_fence_get_timeline_name(struct dma_fence *fence)
> +{
> +       return "vb2_fence_timeline";
> +}
> +
> +static inline bool vb2_fence_enable_signaling(struct dma_fence *fence)
> +{
> +       return true;
> +}
> +
> +static const struct dma_fence_ops vb2_fence_ops = {
> +       .get_driver_name = vb2_fence_get_driver_name,
> +       .get_timeline_name = vb2_fence_get_timeline_name,
> +       .enable_signaling = vb2_fence_enable_signaling,
> +       .wait = dma_fence_default_wait,
> +};
> +
> +int vb2_setup_out_fence(struct vb2_queue *q, unsigned int index)
> +{
> +       struct vb2_buffer *vb;
> +
> +       vb = q->bufs[index];
> +
> +       vb->out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
> +
> +       if (call_qop(q, is_unordered, q) || !q->queueing_started)
> +               q->out_fence_context = dma_fence_context_alloc(1);
> +
> +       vb->out_fence = kzalloc(sizeof(*vb->out_fence), GFP_KERNEL);
> +       if (!vb->out_fence)
> +               return -ENOMEM;
> +
> +       dma_fence_init(vb->out_fence, &vb2_fence_ops, &q->out_fence_lock,
> +                      q->out_fence_context, 1);
> +       if (!vb->out_fence) {
> +               put_unused_fd(vb->out_fence_fd);
> +               return -ENOMEM;
> +       }
> +
> +       vb->sync_file = sync_file_create(vb->out_fence);
> +       if (!vb->sync_file) {
> +               put_unused_fd(vb->out_fence_fd);
> +               dma_fence_put(vb->out_fence);
> +               vb->out_fence = NULL;
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(vb2_setup_out_fence);
> +
>  /*
>   * vb2_start_streaming() - Attempt to start streaming.
>   * @q:         videobuf2 queue
> @@ -1482,6 +1552,7 @@ int vb2_core_qbuf(struct vb2_queue *q, unsigned int index, void *pb,
>         list_add_tail(&vb->queued_entry, &q->queued_list);
>         q->queued_count++;
>         q->waiting_for_buffers = false;
> +       q->queueing_started = 1;
>         vb->state = VB2_BUF_STATE_QUEUED;
>         vb->in_fence = in_fence;
>
> @@ -1545,6 +1616,11 @@ int vb2_core_qbuf(struct vb2_queue *q, unsigned int index, void *pb,
>         if (pb)
>                 call_void_bufop(q, fill_user_buffer, vb, pb);
>
> +       if (vb->out_fence) {
> +               fd_install(vb->out_fence_fd, vb->sync_file->file);
> +               vb->sync_file = NULL;
> +       }
> +
>         dprintk(2, "qbuf of buffer %d succeeded\n", vb->index);
>         return 0;
>
> @@ -1552,6 +1628,16 @@ int vb2_core_qbuf(struct vb2_queue *q, unsigned int index, void *pb,
>         spin_unlock_irqrestore(&vb->fence_cb_lock, flags);
>
>  err:
> +       if (vb->sync_file) {
> +               put_unused_fd(vb->out_fence_fd);
> +               vb->out_fence_fd = -1;
> +
> +               dma_fence_put(vb->out_fence);
> +
> +               fput(vb->sync_file->file);
> +               vb->sync_file = NULL;
> +       }
> +
>         /* Fill buffer information for the userspace */
>         if (pb)
>                 call_void_bufop(q, fill_user_buffer, vb, pb);
> @@ -1804,6 +1890,7 @@ static void __vb2_queue_cancel(struct vb2_queue *q)
>         q->start_streaming_called = 0;
>         q->queued_count = 0;
>         q->error = 0;
> +       q->queueing_started = 0;
>
>         list_for_each_entry(vb, &q->queued_list, queued_entry) {
>                 spin_lock_irqsave(&vb->fence_cb_lock, flags);
> @@ -2156,6 +2243,7 @@ int vb2_core_queue_init(struct vb2_queue *q)
>         spin_lock_init(&q->done_lock);
>         mutex_init(&q->mmap_lock);
>         init_waitqueue_head(&q->done_wq);
> +       spin_lock_init(&q->out_fence_lock);
>
>         q->memory = VB2_MEMORY_UNKNOWN;
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> index 1df5dd01c0cd..ab5b2b71d784 100644
> --- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
> +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> @@ -217,7 +217,12 @@ static void __fill_v4l2_buffer(struct vb2_buffer *vb, void *pb)
>         b->sequence = vbuf->sequence;
>         b->reserved = 0;
>
> -       b->fence_fd = 0;
> +       if (b->flags & V4L2_BUF_FLAG_OUT_FENCE) {
> +               b->fence_fd = vb->out_fence_fd;
> +       } else {
> +               b->fence_fd = 0;
> +       }
> +
>         if (vb->in_fence)
>                 b->flags |= V4L2_BUF_FLAG_IN_FENCE;
>         else
> @@ -496,6 +501,10 @@ int vb2_querybuf(struct vb2_queue *q, struct v4l2_buffer *b)
>         ret = __verify_planes_array(vb, b);
>         if (!ret)
>                 vb2_core_querybuf(q, b->index, b);
> +
> +       /* Do not return the out-fence fd on querybuf */
> +       if (vb->out_fence)
> +               b->fence_fd = -1;

We aren't returning the fence_fd but as per the uapi
documentation we should. Which should we correct?

Also, any reason we don't recycle the out fence?

IOW, each time we queue a buffer, a new out fence is
created and returned to user, and has to be closed.

Thanks!
-- 
Ezequiel García, VanguardiaSur
www.vanguardiasur.com.ar
