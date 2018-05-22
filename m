Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbeEVQy6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:54:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751229AbeEVQyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:54:55 -0400
Date: Wed, 23 May 2018 00:54:48 +0800
From: Wei Xu <wexu@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jfreimann@redhat.com,
        tiwei.bie@intel.com
Subject: Re: [RFC V4 PATCH 7/8] vhost: packed ring support
Message-ID: <20180522165448.GA13523@wei-ubt>
References: <1526473941-16199-1-git-send-email-jasowang@redhat.com>
 <1526473941-16199-8-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526473941-16199-8-git-send-email-jasowang@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 08:32:20PM +0800, Jason Wang wrote:
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/net.c   |   3 +-
>  drivers/vhost/vhost.c | 539 ++++++++++++++++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h |   8 +-
>  3 files changed, 513 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 8304c30..f2a0f5b 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1358,6 +1382,8 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
>  			break;
>  		}
>  		vq->last_avail_idx = s.num;
> +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> +			vq->avail_wrap_counter = s.num >> 31;
>  		/* Forget the cached index value. */
>  		vq->avail_idx = vq->last_avail_idx;
>  		break;
> @@ -1366,6 +1392,8 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
>  		s.num = vq->last_avail_idx;
>  		if (copy_to_user(argp, &s, sizeof s))
>  			r = -EFAULT;
> +		if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> +			s.num |= vq->avail_wrap_counter << 31;
>  		break;
>  	case VHOST_SET_VRING_ADDR:
>  		if (copy_from_user(&a, argp, sizeof a)) {

'last_used_idx' also needs to be saved/restored here.

I have figured out the root cause of broken device after reloading
'virtio-net' module, all indices have been reset for a reloading but
'last_used_idx' is not properly reset in this case. This confuses
handle_rx()/tx().

Wei
