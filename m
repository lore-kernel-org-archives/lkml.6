Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676E0C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBA420849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBA420849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeLLOYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:24:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbeLLOYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:24:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6BBDC3DE2C;
        Wed, 12 Dec 2018 14:24:32 +0000 (UTC)
Received: from redhat.com (ovpn-122-106.rdu2.redhat.com [10.10.122.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id 93CF8608C6;
        Wed, 12 Dec 2018 14:24:31 +0000 (UTC)
Date:   Wed, 12 Dec 2018 09:24:31 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>
Subject: Re: [PATCH net V2 3/4] Revert "net: vhost: lock the vqs one by one"
Message-ID: <20181212092102-mutt-send-email-mst@kernel.org>
References: <20181212100819.21295-1-jasowang@redhat.com>
 <20181212100819.21295-4-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212100819.21295-4-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 12 Dec 2018 14:24:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 06:08:18PM +0800, Jason Wang wrote:
> This reverts commit 78139c94dc8c96a478e67dab3bee84dc6eccb5fd. We don't
> protect device IOTLB with vq mutex, which will lead e.g use after free
> for device IOTLB entries. And since we've switched to use
> mutex_trylock() in previous patch, it's safe to revert it without
> having deadlock.
> 
> Fixes: commit 78139c94dc8c ("net: vhost: lock the vqs one by one")
> Cc: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

I'd try to put this in 4.20 if we can
and it's needed for -stable I think.

Also looks like we should allow iotlb entries per vq
to improve locking. What do you think?

> ---
>  drivers/vhost/vhost.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 5915f240275a..55e5aa662ad5 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -295,11 +295,8 @@ static void vhost_vq_meta_reset(struct vhost_dev *d)
>  {
>  	int i;
>  
> -	for (i = 0; i < d->nvqs; ++i) {
> -		mutex_lock(&d->vqs[i]->mutex);
> +	for (i = 0; i < d->nvqs; ++i)
>  		__vhost_vq_meta_reset(d->vqs[i]);
> -		mutex_unlock(&d->vqs[i]->mutex);
> -	}
>  }
>  
>  static void vhost_vq_reset(struct vhost_dev *dev,
> @@ -895,6 +892,20 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
>  #define vhost_get_used(vq, x, ptr) \
>  	vhost_get_user(vq, x, ptr, VHOST_ADDR_USED)
>  
> +static void vhost_dev_lock_vqs(struct vhost_dev *d)
> +{
> +	int i = 0;
> +	for (i = 0; i < d->nvqs; ++i)
> +		mutex_lock_nested(&d->vqs[i]->mutex, i);
> +}
> +
> +static void vhost_dev_unlock_vqs(struct vhost_dev *d)
> +{
> +	int i = 0;
> +	for (i = 0; i < d->nvqs; ++i)
> +		mutex_unlock(&d->vqs[i]->mutex);
> +}
> +
>  static int vhost_new_umem_range(struct vhost_umem *umem,
>  				u64 start, u64 size, u64 end,
>  				u64 userspace_addr, int perm)
> @@ -976,6 +987,7 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
>  	int ret = 0;
>  
>  	mutex_lock(&dev->mutex);
> +	vhost_dev_lock_vqs(dev);
>  	switch (msg->type) {
>  	case VHOST_IOTLB_UPDATE:
>  		if (!dev->iotlb) {
> @@ -1009,6 +1021,7 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
>  		break;
>  	}
>  
> +	vhost_dev_unlock_vqs(dev);
>  	mutex_unlock(&dev->mutex);
>  
>  	return ret;
> -- 
> 2.17.1
