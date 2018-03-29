Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbeC2Ms0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:48:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751008AbeC2MsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:48:24 -0400
Date: Thu, 29 Mar 2018 15:48:22 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost: validate log when IOTLB is enabled
Message-ID: <20180329154803-mutt-send-email-mst@kernel.org>
References: <1522310404-8486-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522310404-8486-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 04:00:04PM +0800, Jason Wang wrote:
> Vq log_base is the userspace address of bitmap which has nothing to do
> with IOTLB. So it needs to be validated unconditionally otherwise we
> may try use 0 as log_base which may lead to pin pages that will lead
> unexpected result (e.g trigger BUG_ON() in set_bit_to_user()).
> 
> Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")
> Reported-by: syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

stable material I guess.

> ---
>  drivers/vhost/vhost.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 5d5a9d9..5320039 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1244,14 +1244,12 @@ static int vq_log_access_ok(struct vhost_virtqueue *vq,
>  /* Caller should have vq mutex and device mutex */
>  int vhost_vq_access_ok(struct vhost_virtqueue *vq)
>  {
> -	if (vq->iotlb) {
> -		/* When device IOTLB was used, the access validation
> -		 * will be validated during prefetching.
> -		 */
> -		return 1;
> -	}
> -	return vq_access_ok(vq, vq->num, vq->desc, vq->avail, vq->used) &&
> -		vq_log_access_ok(vq, vq->log_base);
> +	int ret = vq_log_access_ok(vq, vq->log_base);
> +
> +	if (ret || vq->iotlb)
> +		return ret;
> +
> +	return vq_access_ok(vq, vq->num, vq->desc, vq->avail, vq->used);
>  }
>  EXPORT_SYMBOL_GPL(vhost_vq_access_ok);
>  
> -- 
> 2.7.4
