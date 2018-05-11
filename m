Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbeEKSTq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 14:19:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750746AbeEKSTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 14:19:45 -0400
Date: Fri, 11 May 2018 21:19:44 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiyou.wangcong@gmail.com, eric.dumazet@gmail.com
Subject: Re: [PATCH net V2] tun: fix use after free for ptr_ring
Message-ID: <20180511211920-mutt-send-email-mst@kernel.org>
References: <1526006965-9124-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526006965-9124-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 10:49:25AM +0800, Jason Wang wrote:
> We used to initialize ptr_ring during TUNSETIFF, this is because its
> size depends on the tx_queue_len of netdevice. And we try to clean it
> up when socket were detached from netdevice. A race were spotted when
> trying to do uninit during a read which will lead a use after free for
> pointer ring. Solving this by always initialize a zero size ptr_ring
> in open() and do resizing during TUNSETIFF, and then we can safely do
> cleanup during close(). With this, there's no need for the workaround
> that was introduced by commit 4df0bfc79904 ("tun: fix a memory leak
> for tfile->tx_array").
> 
> Reported-by: syzbot+e8b902c3c3fadf0a9dba@syzkaller.appspotmail.com
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Fixes: 1576d9860599 ("tun: switch to use skb array for tx")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

and will you send the revert pls then?


> ---
> Changes from v1:
> - free ptr_ring during close()
> - use tun_ptr_free() during resie for safety
> ---
>  drivers/net/tun.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index ef33950..9fbbb32 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -681,15 +681,6 @@ static void tun_queue_purge(struct tun_file *tfile)
>  	skb_queue_purge(&tfile->sk.sk_error_queue);
>  }
>  
> -static void tun_cleanup_tx_ring(struct tun_file *tfile)
> -{
> -	if (tfile->tx_ring.queue) {
> -		ptr_ring_cleanup(&tfile->tx_ring, tun_ptr_free);
> -		xdp_rxq_info_unreg(&tfile->xdp_rxq);
> -		memset(&tfile->tx_ring, 0, sizeof(tfile->tx_ring));
> -	}
> -}
> -
>  static void __tun_detach(struct tun_file *tfile, bool clean)
>  {
>  	struct tun_file *ntfile;
> @@ -736,7 +727,8 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
>  			    tun->dev->reg_state == NETREG_REGISTERED)
>  				unregister_netdevice(tun->dev);
>  		}
> -		tun_cleanup_tx_ring(tfile);
> +		if (tun)
> +			xdp_rxq_info_unreg(&tfile->xdp_rxq);
>  		sock_put(&tfile->sk);
>  	}
>  }
> @@ -783,14 +775,14 @@ static void tun_detach_all(struct net_device *dev)
>  		tun_napi_del(tun, tfile);
>  		/* Drop read queue */
>  		tun_queue_purge(tfile);
> +		xdp_rxq_info_unreg(&tfile->xdp_rxq);
>  		sock_put(&tfile->sk);
> -		tun_cleanup_tx_ring(tfile);
>  	}
>  	list_for_each_entry_safe(tfile, tmp, &tun->disabled, next) {
>  		tun_enable_queue(tfile);
>  		tun_queue_purge(tfile);
> +		xdp_rxq_info_unreg(&tfile->xdp_rxq);
>  		sock_put(&tfile->sk);
> -		tun_cleanup_tx_ring(tfile);
>  	}
>  	BUG_ON(tun->numdisabled != 0);
>  
> @@ -834,7 +826,8 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>  	}
>  
>  	if (!tfile->detached &&
> -	    ptr_ring_init(&tfile->tx_ring, dev->tx_queue_len, GFP_KERNEL)) {
> +	    ptr_ring_resize(&tfile->tx_ring, dev->tx_queue_len,
> +			    GFP_KERNEL, tun_ptr_free)) {
>  		err = -ENOMEM;
>  		goto out;
>  	}
> @@ -3219,6 +3212,11 @@ static int tun_chr_open(struct inode *inode, struct file * file)
>  					    &tun_proto, 0);
>  	if (!tfile)
>  		return -ENOMEM;
> +	if (ptr_ring_init(&tfile->tx_ring, 0, GFP_KERNEL)) {
> +		sk_free(&tfile->sk);
> +		return -ENOMEM;
> +	}
> +
>  	RCU_INIT_POINTER(tfile->tun, NULL);
>  	tfile->flags = 0;
>  	tfile->ifindex = 0;
> @@ -3239,8 +3237,6 @@ static int tun_chr_open(struct inode *inode, struct file * file)
>  
>  	sock_set_flag(&tfile->sk, SOCK_ZEROCOPY);
>  
> -	memset(&tfile->tx_ring, 0, sizeof(tfile->tx_ring));
> -
>  	return 0;
>  }
>  
> @@ -3249,6 +3245,7 @@ static int tun_chr_close(struct inode *inode, struct file *file)
>  	struct tun_file *tfile = file->private_data;
>  
>  	tun_detach(tfile, true);
> +	ptr_ring_cleanup(&tfile->tx_ring, tun_ptr_free);
>  
>  	return 0;
>  }
> -- 
> 2.7.4
