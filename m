Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F75FC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1617D2070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbfACQmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:42:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfACQmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:42:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA42D92A76;
        Thu,  3 Jan 2019 16:42:48 +0000 (UTC)
Received: from redhat.com (ovpn-120-148.rdu2.redhat.com [10.10.120.148])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9710D5D9C5;
        Thu,  3 Jan 2019 16:42:47 +0000 (UTC)
Date:   Thu, 3 Jan 2019 11:42:47 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        cohuck@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com,
        dgilbert@redhat.com, pasic@linux.ibm.com
Subject: Re: [PATCH v1 1/2] virtio-balloon: tweak config_changed
 implementation
Message-ID: <20190103113228-mutt-send-email-mst@kernel.org>
References: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
 <1546493462-32244-2-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546493462-32244-2-git-send-email-wei.w.wang@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 03 Jan 2019 16:42:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 01:31:01PM +0800, Wei Wang wrote:
> virtio-ccw has deadlock issues with reading config registers inside the
> interrupt context, so we tweak the virtballoon_changed implementation
> by moving the config read operations into the related workqueue contexts.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  drivers/virtio/virtio_balloon.c | 54 ++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 728ecd1..9a82a11 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -394,33 +394,15 @@ static void virtballoon_changed(struct virtio_device *vdev)
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

There's one problem with this approach:

previously updating the cmd_id_received here would immediately
stop the report in send_free_pages.

With this approach we are waiting for the wq to schedule,
which might be blocked waiting for report to complete.
So host can no longer quickly stop the report in progress.

A simple work-around would be to set some kind of flag whenever there
is a change interrupt, then have send_free_pages test it
and re-read cmd_id_received.

Needs to be an atomic I guess ...


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
> +		if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> +			queue_work(vb->balloon_wq, &vb->report_free_page_work);
>  	}
> +	spin_unlock_irqrestore(&vb->stop_update_lock, flags);
>  }
>  
>  static void update_balloon_size(struct virtio_balloon *vb)
> @@ -637,11 +619,9 @@ static int send_free_pages(struct virtio_balloon *vb)
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
> @@ -659,6 +639,24 @@ static void report_free_page_func(struct work_struct *work)
>  		dev_err(dev, "Failed to send a stop id, err = %d\n", err);
>  }
>  
> +static void report_free_page_func(struct work_struct *work)
> +{
> +	struct virtio_balloon *vb = container_of(work, struct virtio_balloon,
> +						 report_free_page_work);
> +
> +	virtio_cread(vb->vdev, struct virtio_balloon_config,
> +		     free_page_report_cmd_id, &vb->cmd_id_received);
> +
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
