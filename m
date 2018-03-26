Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbeCZNYX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 09:24:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750955AbeCZNYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 09:24:21 -0400
Date: Mon, 26 Mar 2018 16:24:20 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost_net: add missing lock nesting notation
Message-ID: <20180326162416-mutt-send-email-mst@kernel.org>
References: <1522051823-5166-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522051823-5166-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 04:10:23PM +0800, Jason Wang wrote:
> We try to hold TX virtqueue mutex in vhost_net_rx_peek_head_len()
> after RX virtqueue mutex is held in handle_rx(). This requires an
> appropriate lock nesting notation to calm down deadlock detector.
> 
> Fixes: 0308813724606 ("vhost_net: basic polling support")
> Reported-by: syzbot+7f073540b1384a614e09@syzkaller.appspotmail.com
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 8139bc7..12bcfba 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -630,7 +630,7 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk)
>  
>  	if (!len && vq->busyloop_timeout) {
>  		/* Both tx vq and rx socket were polled here */
> -		mutex_lock(&vq->mutex);
> +		mutex_lock_nested(&vq->mutex, 1);
>  		vhost_disable_notify(&net->dev, vq);
>  
>  		preempt_disable();
> @@ -763,7 +763,7 @@ static void handle_rx(struct vhost_net *net)
>  	struct iov_iter fixup;
>  	__virtio16 num_buffers;
>  
> -	mutex_lock(&vq->mutex);
> +	mutex_lock_nested(&vq->mutex, 0);
>  	sock = vq->private_data;
>  	if (!sock)
>  		goto out;
> -- 
> 2.7.4
