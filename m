Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967787AbeBNMyz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 07:54:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967589AbeBNMyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 07:54:54 -0500
Date: Wed, 14 Feb 2018 14:54:53 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        christoffer.dall@linaro.org
Subject: Re: [PATCH net] tuntap: try not batch packets for devmap
Message-ID: <20180214145329-mutt-send-email-mst@kernel.org>
References: <1518579365-4851-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518579365-4851-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 11:36:05AM +0800, Jason Wang wrote:
> Commit 762c330d670e ("tuntap: add missing xdp flush") tries to fix the
> devmap stall caused by missed xdp flush by counting the pending xdp
> redirected packets and flush when it exceeds NAPI_POLL_WEIGHT or
> MSG_MORE is clear. This may lead BUG() since xdp_do_flush() was
> called under process context with preemption enabled. Simply disable
> preemption may silent the warning but be not enough since process may
> move between different CPUS during a batch which cause xdp_do_flush()
> misses some CPU where the process run previously. For -net, fix this
> by simply calling xdp_do_flush() immediately after xdp_do_redirect(),
> a side effect is that this removes any possibility of batching which
> could be addressed in the future.
> 
> Reported-by: Christoffer Dall <christoffer.dall@linaro.org>
> Fixes: 762c330d670e ("tuntap: add missing xdp flush")

Much of that patch is reverted here. How about a revert
followed by a one-liner calling xdp_do_redirect?
Will make backporting easier for people.

> Signed-off-by: Jason Wang <jasowang@redhat.com>

change itself is fine, feel free to include my

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  drivers/net/tun.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 17e496b..6a4cd97 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -181,7 +181,6 @@ struct tun_file {
>  	struct tun_struct *detached;
>  	struct ptr_ring tx_ring;
>  	struct xdp_rxq_info xdp_rxq;
> -	int xdp_pending_pkts;
>  };
>  
>  struct tun_flow_entry {
> @@ -1666,10 +1665,10 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  		case XDP_REDIRECT:
>  			get_page(alloc_frag->page);
>  			alloc_frag->offset += buflen;
> -			++tfile->xdp_pending_pkts;
>  			err = xdp_do_redirect(tun->dev, &xdp, xdp_prog);
>  			if (err)
>  				goto err_redirect;
> +			xdp_do_flush_map();
>  			rcu_read_unlock();
>  			return NULL;
>  		case XDP_TX:
> @@ -1988,11 +1987,6 @@ static ssize_t tun_chr_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	result = tun_get_user(tun, tfile, NULL, from,
>  			      file->f_flags & O_NONBLOCK, false);
>  
> -	if (tfile->xdp_pending_pkts) {
> -		tfile->xdp_pending_pkts = 0;
> -		xdp_do_flush_map();
> -	}
> -
>  	tun_put(tun);
>  	return result;
>  }
> @@ -2330,12 +2324,6 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
>  			   m->msg_flags & MSG_DONTWAIT,
>  			   m->msg_flags & MSG_MORE);
>  
> -	if (tfile->xdp_pending_pkts >= NAPI_POLL_WEIGHT ||
> -	    !(m->msg_flags & MSG_MORE)) {
> -		tfile->xdp_pending_pkts = 0;
> -		xdp_do_flush_map();
> -	}
> -
>  	tun_put(tun);
>  	return ret;
>  }
> @@ -3167,7 +3155,6 @@ static int tun_chr_open(struct inode *inode, struct file * file)
>  	sock_set_flag(&tfile->sk, SOCK_ZEROCOPY);
>  
>  	memset(&tfile->tx_ring, 0, sizeof(tfile->tx_ring));
> -	tfile->xdp_pending_pkts = 0;
>  
>  	return 0;
>  }
> -- 
> 2.7.4
