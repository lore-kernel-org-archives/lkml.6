Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972017AbeEYAeA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:34:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966894AbeEYAd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:33:57 -0400
Date: Fri, 25 May 2018 03:33:55 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost: synchronize IOTLB message with dev cleanup
Message-ID: <20180525033250-mutt-send-email-mst@kernel.org>
References: <1526990337-24892-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526990337-24892-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 07:58:57PM +0800, Jason Wang wrote:
> DaeRyong Jeong reports a race between vhost_dev_cleanup() and
> vhost_process_iotlb_msg():
> 
> Thread interleaving:
> CPU0 (vhost_process_iotlb_msg)			CPU1 (vhost_dev_cleanup)
> (In the case of both VHOST_IOTLB_UPDATE and
> VHOST_IOTLB_INVALIDATE)
> =====						=====
> 						vhost_umem_clean(dev->iotlb);
> if (!dev->iotlb) {
> 	        ret = -EFAULT;
> 		        break;
> }
> 						dev->iotlb = NULL;
> 
> The reason is we don't synchronize between them, fixing by protecting
> vhost_process_iotlb_msg() with dev mutex.
> 
> Reported-by: DaeRyong Jeong <threeearcat@gmail.com>
> Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

We should think of a way to have a per-vq lock here, but for now:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/vhost.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index f3bd8e9..f0be5f3 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -981,6 +981,7 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
>  {
>  	int ret = 0;
>  
> +	mutex_lock(&dev->mutex);
>  	vhost_dev_lock_vqs(dev);
>  	switch (msg->type) {
>  	case VHOST_IOTLB_UPDATE:
> @@ -1016,6 +1017,8 @@ static int vhost_process_iotlb_msg(struct vhost_dev *dev,
>  	}
>  
>  	vhost_dev_unlock_vqs(dev);
> +	mutex_unlock(&dev->mutex);
> +
>  	return ret;
>  }
>  ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
> -- 
> 2.7.4
