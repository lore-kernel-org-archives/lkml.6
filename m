Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57016C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B7D2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B7D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbeIFVbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:31:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727847AbeIFVbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:31:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFEBA40216F6;
        Thu,  6 Sep 2018 16:54:38 +0000 (UTC)
Received: from redhat.com (ovpn-120-232.rdu2.redhat.com [10.10.120.232])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7B9592166B41;
        Thu,  6 Sep 2018 16:54:38 +0000 (UTC)
Date:   Thu, 6 Sep 2018 12:54:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net-next 08/11] tun: switch to new type of msg_control
Message-ID: <20180906125051-mutt-send-email-mst@kernel.org>
References: <20180906040526.22518-1-jasowang@redhat.com>
 <20180906040526.22518-9-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906040526.22518-9-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 06 Sep 2018 16:54:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 06 Sep 2018 16:54:39 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 12:05:23PM +0800, Jason Wang wrote:
> This patch introduces to a new tun/tap specific msg_control:
> 
> #define TUN_MSG_UBUF 1
> #define TUN_MSG_PTR  2
> struct tun_msg_ctl {
>        int type;
>        void *ptr;
> };
> 
> This allows us to pass different kinds of msg_control through
> sendmsg(). The first supported type is ubuf (TUN_MSG_UBUF) which will
> be used by the existed vhost_net zerocopy code. The second is XDP
> buff, which allows vhost_net to pass XDP buff to TUN. This could be
> used to implement accepting an array of XDP buffs from vhost_net in
> the following patches.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

At this point, do we want to just add a new sock opt for tap's
benefit? Seems cleaner than (ab)using sendmsg.

> ---
>  drivers/net/tap.c      | 18 ++++++++++++------
>  drivers/net/tun.c      |  6 +++++-
>  drivers/vhost/net.c    |  7 +++++--
>  include/linux/if_tun.h |  7 +++++++
>  4 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index f0f7cd977667..7996ed7cbf18 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -619,7 +619,7 @@ static inline struct sk_buff *tap_alloc_skb(struct sock *sk, size_t prepad,
>  #define TAP_RESERVE HH_DATA_OFF(ETH_HLEN)
>  
>  /* Get packet from user space buffer */
> -static ssize_t tap_get_user(struct tap_queue *q, struct msghdr *m,
> +static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  			    struct iov_iter *from, int noblock)
>  {
>  	int good_linear = SKB_MAX_HEAD(TAP_RESERVE);
> @@ -663,7 +663,7 @@ static ssize_t tap_get_user(struct tap_queue *q, struct msghdr *m,
>  	if (unlikely(len < ETH_HLEN))
>  		goto err;
>  
> -	if (m && m->msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
> +	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
>  		struct iov_iter i;
>  
>  		copylen = vnet_hdr.hdr_len ?
> @@ -724,11 +724,11 @@ static ssize_t tap_get_user(struct tap_queue *q, struct msghdr *m,
>  	tap = rcu_dereference(q->tap);
>  	/* copy skb_ubuf_info for callback when skb has no error */
>  	if (zerocopy) {
> -		skb_shinfo(skb)->destructor_arg = m->msg_control;
> +		skb_shinfo(skb)->destructor_arg = msg_control;
>  		skb_shinfo(skb)->tx_flags |= SKBTX_DEV_ZEROCOPY;
>  		skb_shinfo(skb)->tx_flags |= SKBTX_SHARED_FRAG;
> -	} else if (m && m->msg_control) {
> -		struct ubuf_info *uarg = m->msg_control;
> +	} else if (msg_control) {
> +		struct ubuf_info *uarg = msg_control;
>  		uarg->callback(uarg, false);
>  	}
>  
> @@ -1150,7 +1150,13 @@ static int tap_sendmsg(struct socket *sock, struct msghdr *m,
>  		       size_t total_len)
>  {
>  	struct tap_queue *q = container_of(sock, struct tap_queue, sock);
> -	return tap_get_user(q, m, &m->msg_iter, m->msg_flags & MSG_DONTWAIT);
> +	struct tun_msg_ctl *ctl = m->msg_control;
> +
> +	if (ctl && ctl->type != TUN_MSG_UBUF)
> +		return -EINVAL;
> +
> +	return tap_get_user(q, ctl ? ctl->ptr : NULL, &m->msg_iter,
> +			    m->msg_flags & MSG_DONTWAIT);
>  }
>  
>  static int tap_recvmsg(struct socket *sock, struct msghdr *m,
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index ff1cbf3ebd50..c839a4bdcbd9 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2429,11 +2429,15 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
>  	int ret;
>  	struct tun_file *tfile = container_of(sock, struct tun_file, socket);
>  	struct tun_struct *tun = tun_get(tfile);
> +	struct tun_msg_ctl *ctl = m->msg_control;
>  
>  	if (!tun)
>  		return -EBADFD;
>  
> -	ret = tun_get_user(tun, tfile, m->msg_control, &m->msg_iter,
> +	if (ctl && ctl->type != TUN_MSG_UBUF)
> +		return -EINVAL;
> +
> +	ret = tun_get_user(tun, tfile, ctl ? ctl->ptr : NULL, &m->msg_iter,
>  			   m->msg_flags & MSG_DONTWAIT,
>  			   m->msg_flags & MSG_MORE);
>  	tun_put(tun);
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 4e656f89cb22..fb01ce6d981c 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -620,6 +620,7 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  		.msg_controllen = 0,
>  		.msg_flags = MSG_DONTWAIT,
>  	};
> +	struct tun_msg_ctl ctl;
>  	size_t len, total_len = 0;
>  	int err;
>  	struct vhost_net_ubuf_ref *uninitialized_var(ubufs);
> @@ -664,8 +665,10 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  			ubuf->ctx = nvq->ubufs;
>  			ubuf->desc = nvq->upend_idx;
>  			refcount_set(&ubuf->refcnt, 1);
> -			msg.msg_control = ubuf;
> -			msg.msg_controllen = sizeof(ubuf);
> +			msg.msg_control = &ctl;
> +			ctl.type = TUN_MSG_UBUF;
> +			ctl.ptr = ubuf;
> +			msg.msg_controllen = sizeof(ctl);
>  			ubufs = nvq->ubufs;
>  			atomic_inc(&ubufs->refcount);
>  			nvq->upend_idx = (nvq->upend_idx + 1) % UIO_MAXIOV;
> diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
> index 3d2996dc7d85..ba46dced1f38 100644
> --- a/include/linux/if_tun.h
> +++ b/include/linux/if_tun.h
> @@ -19,6 +19,13 @@
>  
>  #define TUN_XDP_FLAG 0x1UL
>  
> +#define TUN_MSG_UBUF 1
> +#define TUN_MSG_PTR  2

Looks like TUN_MSG_PTR should be pushed out to a follow-up patch?

> +struct tun_msg_ctl {
> +	int type;
> +	void *ptr;
> +};
> +

type actually includes a size. Why not two short fields then?


>  #if defined(CONFIG_TUN) || defined(CONFIG_TUN_MODULE)
>  struct socket *tun_get_socket(struct file *);
>  struct ptr_ring *tun_get_tx_ring(struct file *file);
> -- 
> 2.17.1
