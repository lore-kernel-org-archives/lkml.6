Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED430C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38EF2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfADPoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:44:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfADPoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:44:38 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5863D80F6C;
        Fri,  4 Jan 2019 15:44:37 +0000 (UTC)
Received: from redhat.com (ovpn-124-210.rdu2.redhat.com [10.10.124.210])
        by smtp.corp.redhat.com (Postfix) with SMTP id AF7A61001F53;
        Fri,  4 Jan 2019 15:44:35 +0000 (UTC)
Date:   Fri, 4 Jan 2019 10:44:35 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
        pbonzini@redhat.com, dgilbert@redhat.com
Subject: Re: [PATCH v2 1/2] virtio-balloon: tweak config_changed
 implementation
Message-ID: <20190104103213-mutt-send-email-mst@kernel.org>
References: <1546585913-34804-1-git-send-email-wei.w.wang@intel.com>
 <1546585913-34804-2-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546585913-34804-2-git-send-email-wei.w.wang@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 04 Jan 2019 15:44:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 03:11:52PM +0800, Wei Wang wrote:
> virtio-ccw has deadlock issues with reading the config space inside the
> interrupt context, so we tweak the virtballoon_changed implementation
> by moving the config read operations into the related workqueue contexts.
> The config_read_bitmap is used as a flag to the workqueue callbacks
> about the related config fields that need to be read.
> 
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  drivers/virtio/virtio_balloon.c | 81 +++++++++++++++++++++++++++--------------
>  1 file changed, 53 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 728ecd1..35ee762 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -61,6 +61,10 @@ enum virtio_balloon_vq {
>  	VIRTIO_BALLOON_VQ_MAX
>  };
>  
> +enum virtio_balloon_config_read {
> +	VIRTIO_BALLOON_CONFIG_READ_CMD_ID = 0,
> +};
> +
>  struct virtio_balloon {
>  	struct virtio_device *vdev;
>  	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq;
> @@ -77,6 +81,8 @@ struct virtio_balloon {
>  	/* Prevent updating balloon when it is being canceled. */
>  	spinlock_t stop_update_lock;
>  	bool stop_update;
> +	/* Bitmap to indicate if reading the related config fields are needed */
> +	unsigned long config_read_bitmap;
>  
>  	/* The list of allocated free pages, waiting to be given back to mm */
>  	struct list_head free_page_list;

It seems that you never initialize this bitmap. Probably harmless here
but generally using uninitialized memory isn't good.


> @@ -390,37 +396,31 @@ static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
>  	return num_returned;
>  }
>  
> +static void virtio_balloon_queue_free_page_work(struct virtio_balloon *vb)
> +{
> +	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> +		return;
> +
> +	/* No need to queue the work if the bit was already set. */
> +	if (test_and_set_bit(VIRTIO_BALLOON_CONFIG_READ_CMD_ID,
> +			     &vb->config_read_bitmap))
> +		return;
> +
> +	queue_work(vb->balloon_wq, &vb->report_free_page_work);
> +}
> +
>  static void virtballoon_changed(struct virtio_device *vdev)
>  {
>  	struct virtio_balloon *vb = vdev->priv;
>  	unsigned long flags;
> -	s64 diff = towards_target(vb);
> -
> -	if (diff) {
> -		spin_lock_irqsave(&vb->stop_update_lock, flags);
> -		if (!vb->stop_update)
> -			queue_work(system_freezable_wq,
> -				   &vb->update_balloon_size_work);
> -		spin_unlock_irqrestore(&vb->stop_update_lock, flags);
> -	}
>  
> -	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> -		virtio_cread(vdev, struct virtio_balloon_config,
> -			     free_page_report_cmd_id, &vb->cmd_id_received);
> -		if (vb->cmd_id_received == VIRTIO_BALLOON_CMD_ID_DONE) {
> -			/* Pass ULONG_MAX to give back all the free pages */
> -			return_free_pages_to_mm(vb, ULONG_MAX);
> -		} else if (vb->cmd_id_received != VIRTIO_BALLOON_CMD_ID_STOP &&
> -			   vb->cmd_id_received !=
> -			   virtio32_to_cpu(vdev, vb->cmd_id_active)) {
> -			spin_lock_irqsave(&vb->stop_update_lock, flags);
> -			if (!vb->stop_update) {
> -				queue_work(vb->balloon_wq,
> -					   &vb->report_free_page_work);
> -			}
> -			spin_unlock_irqrestore(&vb->stop_update_lock, flags);
> -		}
> +	spin_lock_irqsave(&vb->stop_update_lock, flags);
> +	if (!vb->stop_update) {
> +		queue_work(system_freezable_wq,
> +			   &vb->update_balloon_size_work);
> +		virtio_balloon_queue_free_page_work(vb);
>  	}
> +	spin_unlock_irqrestore(&vb->stop_update_lock, flags);
>  }
>  
>  static void update_balloon_size(struct virtio_balloon *vb)
> @@ -609,6 +609,16 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
>  	return 0;
>  }
>  
> +static void virtio_balloon_read_cmd_id_received(struct virtio_balloon *vb)
> +{
> +	if (!test_and_clear_bit(VIRTIO_BALLOON_CONFIG_READ_CMD_ID,
> +				&vb->config_read_bitmap))
> +		return;
> +
> +	virtio_cread(vb->vdev, struct virtio_balloon_config,
> +		     free_page_report_cmd_id, &vb->cmd_id_received);
> +}
> +
>  static int send_free_pages(struct virtio_balloon *vb)
>  {
>  	int err;
> @@ -620,6 +630,7 @@ static int send_free_pages(struct virtio_balloon *vb)
>  		 * stop the reporting.
>  		 */
>  		cmd_id_active = virtio32_to_cpu(vb->vdev, vb->cmd_id_active);
> +		virtio_balloon_read_cmd_id_received(vb);
>  		if (cmd_id_active != vb->cmd_id_received)
>  			break;
>  
> @@ -637,11 +648,9 @@ static int send_free_pages(struct virtio_balloon *vb)
>  	return 0;
>  }
>  
> -static void report_free_page_func(struct work_struct *work)
> +static void virtio_balloon_report_free_page(struct virtio_balloon *vb)
>  {
>  	int err;
> -	struct virtio_balloon *vb = container_of(work, struct virtio_balloon,
> -						 report_free_page_work);
>  	struct device *dev = &vb->vdev->dev;
>  
>  	/* Start by sending the received cmd id to host with an outbuf. */
> @@ -659,6 +668,22 @@ static void report_free_page_func(struct work_struct *work)
>  		dev_err(dev, "Failed to send a stop id, err = %d\n", err);
>  }
>  
> +static void report_free_page_func(struct work_struct *work)
> +{
> +	struct virtio_balloon *vb = container_of(work, struct virtio_balloon,
> +						 report_free_page_work);
> +
> +	virtio_balloon_read_cmd_id_received(vb);

This will not achieve what you are trying to do,
which is cancel reporting if it's in progress.

You need to re-read each time you compare to cmd_id_active.

An API similar to
	u32 virtio_balloon_cmd_id_received(vb)
seems to be called for, and I would rename cmd_id_received to
cmd_id_received_cache to make sure we caught all users.



> +	if (vb->cmd_id_received == VIRTIO_BALLOON_CMD_ID_DONE) {
> +		/* Pass ULONG_MAX to give back all the free pages */
> +		return_free_pages_to_mm(vb, ULONG_MAX);
> +	} else if (vb->cmd_id_received != VIRTIO_BALLOON_CMD_ID_STOP &&
> +		   vb->cmd_id_received !=
> +		   virtio32_to_cpu(vb->vdev, vb->cmd_id_active)) {
> +		virtio_balloon_report_free_page(vb);
> +	}
> +}
> +
>  #ifdef CONFIG_BALLOON_COMPACTION
>  /*
>   * virtballoon_migratepage - perform the balloon page migration on behalf of
> -- 
> 2.7.4
