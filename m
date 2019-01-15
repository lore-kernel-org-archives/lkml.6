Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B224C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49BB20578
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfAOBAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 20:00:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfAOBA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 20:00:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E880811D3;
        Tue, 15 Jan 2019 01:00:29 +0000 (UTC)
Received: from redhat.com (ovpn-124-229.rdu2.redhat.com [10.10.124.229])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3609E5D962;
        Tue, 15 Jan 2019 01:00:28 +0000 (UTC)
Date:   Mon, 14 Jan 2019 20:00:27 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        cohuck@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com,
        dgilbert@redhat.com, pasic@linux.ibm.com
Subject: Re: [PATCH v3 2/3] virtio-balloon: improve update_balloon_size_func
Message-ID: <20190114195450-mutt-send-email-mst@kernel.org>
References: <1546844466-38079-1-git-send-email-wei.w.wang@intel.com>
 <1546844466-38079-3-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546844466-38079-3-git-send-email-wei.w.wang@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 15 Jan 2019 01:00:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 03:01:05PM +0800, Wei Wang wrote:
> There is no need to update the balloon actual register when there is no
> ballooning request. This patch avoids update_balloon_size when diff is 0.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

It sounds reasonable but it does have a side effect of
not writing into actual anymore.

I am not sure actual never can get out of sync as a result.

So better deferred, pls send this in the next merge window.




> ---
>  drivers/virtio/virtio_balloon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index fb12fe2..e33dc8e 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -457,9 +457,12 @@ static void update_balloon_size_func(struct work_struct *work)
>  			  update_balloon_size_work);
>  	diff = towards_target(vb);
>  
> +	if (!diff)
> +		return;
> +
>  	if (diff > 0)
>  		diff -= fill_balloon(vb, diff);
> -	else if (diff < 0)
> +	else
>  		diff += leak_balloon(vb, -diff);
>  	update_balloon_size(vb);
>  
> -- 
> 2.7.4
