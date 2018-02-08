Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbeBHRwq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 12:52:46 -0500
Received: from 6.mo68.mail-out.ovh.net ([46.105.63.100]:34129 "EHLO
        6.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbeBHRwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 12:52:45 -0500
Date: Thu, 8 Feb 2018 18:52:32 +0100
From: Greg Kurz <groug@kaod.org>
To: v9fs-developer@lists.sourceforge.net,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ron Minnich <rminnich@sandia.gov>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [V9fs-developer] [PATCH] 9p/trans_virtio: discard zero-length
 reply
Message-ID: <20180208185232.46fca063@bahia.lan>
In-Reply-To: <151665492548.14372.18325892476788349632.stgit@bahia.lan>
References: <151665492548.14372.18325892476788349632.stgit@bahia.lan>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10262577651715447185
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtfedrudekgddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping ?

Michael,

Since this is virtio code and you have acked the QEMU part of the fix already,
would you be kind enough to take this through your tree ?

Cheers,

--
Greg

On Mon, 22 Jan 2018 22:02:05 +0100
Greg Kurz <groug@kaod.org> wrote:

> When a 9p request is successfully flushed, the server is expected to just
> mark it as used without sending a 9p reply (ie, without writing data into
> the buffer). In this case, virtqueue_get_buf() will return len == 0 and
> we must not report a REQ_STATUS_RCVD status to the client, otherwise the
> client will erroneously assume the request has not been flushed.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  net/9p/trans_virtio.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 0845aad4ba51..ca08c72ef4de 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -171,7 +171,8 @@ static void req_done(struct virtqueue *vq)
>  		spin_unlock_irqrestore(&chan->lock, flags);
>  		/* Wakeup if anyone waiting for VirtIO ring space. */
>  		wake_up(chan->vc_wq);
> -		p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
> +		if (len)
> +			p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
>  	}
>  }
>  
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> V9fs-developer mailing list
> V9fs-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/v9fs-developer
