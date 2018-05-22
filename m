Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeEVDpN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:45:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752687AbeEVDpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 23:45:10 -0400
Date: Tue, 22 May 2018 06:45:09 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hannes@stressinduktion.org,
        edumazet@google.com
Subject: Re: [PATCH net] tuntap: raise EPOLLOUT on device up
Message-ID: <20180522063128-mutt-send-email-mst@kernel.org>
References: <1526648443-24128-1-git-send-email-jasowang@redhat.com>
 <20180521.114742.427929977852677864.davem@davemloft.net>
 <20180522010700-mutt-send-email-mst@kernel.org>
 <358628f8-a296-ad0e-985b-307895ed5520@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <358628f8-a296-ad0e-985b-307895ed5520@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 11:22:11AM +0800, Jason Wang wrote:
> 
> 
> On 2018年05月22日 06:08, Michael S. Tsirkin wrote:
> > On Mon, May 21, 2018 at 11:47:42AM -0400, David Miller wrote:
> > > From: Jason Wang <jasowang@redhat.com>
> > > Date: Fri, 18 May 2018 21:00:43 +0800
> > > 
> > > > We return -EIO on device down but can not raise EPOLLOUT after it was
> > > > up. This may confuse user like vhost which expects tuntap to raise
> > > > EPOLLOUT to re-enable its TX routine after tuntap is down. This could
> > > > be easily reproduced by transmitting packets from VM while down and up
> > > > the tap device. Fixing this by set SOCKWQ_ASYNC_NOSPACE on -EIO.
> > > > 
> > > > Cc: Hannes Frederic Sowa <hannes@stressinduktion.org>
> > > > Cc: Eric Dumazet <edumazet@google.com>
> > > > Fixes: 1bd4978a88ac2 ("tun: honor IFF_UP in tun_get_user()")
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > I'm no so sure what to do with this patch.
> > > 
> > > Like Michael says, this flag bit is only checks upon transmit which
> > > may or may not happen after this point.  It doesn't seem to be
> > > guaranteed.
> 
> The flag is checked in tun_chr_poll() as well.
> 
> > Jason, can't we detect a link up transition and respond accordingly?
> > What do you think?
> > 
> 
> I think we've already tried to do this, in tun_net_open() we call
> write_space(). But the problem is the bit may not be set at that time.

Which bit? __dev_change_flags seems to set IFF_UP before calling
ndo_open. The issue  I think is that tun_sock_write_space
exits if SOCKWQ_ASYNC_NOSPACE is clear.

And now I think I understand what is going on:

	When link is down, writes to the device might fail with -EIO.
	Userspace needs an indication when the status is resolved.  As a fix,
	tun_net_open attempts to wake up writers - but that is only effective if
	SOCKWQ_ASYNC_NOSPACE has been set in the past.  As a quick hack, set
	SOCKWQ_ASYNC_NOSPACE when write fails because of the link down status.
	If no writes failed, userspace does not know that interface
	was down so should not care that it's going up.


does this describe what this line of code does?
If yes feel free to include this info in a code comment and commit log.



> A second thought is to set the bit in tun_chr_poll() instead of -EIO like:
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index d45ac37..46a1573 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1423,6 +1423,13 @@ static void tun_net_init(struct net_device *dev)
>         dev->max_mtu = MAX_MTU - dev->hard_header_len;
>  }
> 
> +static bool tun_sock_writeable(struct tun_struct *tun, struct tun_file
> *tfile)
> +{
> +       struct sock *sk = tfile->socket.sk;
> +
> +       return (tun->dev->flags & IFF_UP) && sock_writeable(sk);
> +}
> +
>  /* Character device part */
> 
>  /* Poll */
> @@ -1445,10 +1452,9 @@ static __poll_t tun_chr_poll(struct file *file,
> poll_table *wait)
>         if (!ptr_ring_empty(&tfile->tx_ring))
>                 mask |= EPOLLIN | EPOLLRDNORM;
> 
> -       if (tun->dev->flags & IFF_UP &&
> -           (sock_writeable(sk) ||
> -            (!test_and_set_bit(SOCKWQ_ASYNC_NOSPACE, &sk->sk_socket->flags)
> &&
> -             sock_writeable(sk))))
> +       if (tun_sock_writeable(tun, tfile) ||
> +           (!test_and_set_bit(SOCKWQ_ASYNC_NOSPACE, &sk->sk_socket->flags)
> &&
> +            tun_sock_writeable(tun, tfile)));
>                 mask |= EPOLLOUT | EPOLLWRNORM;
> 
>         if (tun->dev->reg_state != NETREG_REGISTERED)
> 
> Does this make more sense?
> 
> Thanks
