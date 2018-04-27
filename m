Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932834AbeD0QFu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:05:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758629AbeD0QFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:05:46 -0400
Date: Fri, 27 Apr 2018 19:05:45 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kevin Easton <kevin@guarana.org>
Cc: Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net] vhost: Use kzalloc() to allocate vhost_msg_node
Message-ID: <20180427185501-mutt-send-email-mst@kernel.org>
References: <000000000000a5b2b1056a86e98c@google.com>
 <20180427154502.GA22544@la.guarana.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427154502.GA22544@la.guarana.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 11:45:02AM -0400, Kevin Easton wrote:
> The struct vhost_msg within struct vhost_msg_node is copied to userspace,
> so it should be allocated with kzalloc() to ensure all structure padding
> is zeroed.
> 
> Signed-off-by: Kevin Easton <kevin@guarana.org>
> Reported-by: syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com

Does it help if a patch naming the padding is applied,
and then we init just the relevant field?
Just curious.

> ---
>  drivers/vhost/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index f3bd8e9..1b84dcff 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2339,7 +2339,7 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
>  /* Create a new message. */
>  struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>  {
> -	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
> +	struct vhost_msg_node *node = kzalloc(sizeof *node, GFP_KERNEL);
>  	if (!node)
>  		return NULL;
>  	node->vq = vq;
> -- 
> 2.8.1
