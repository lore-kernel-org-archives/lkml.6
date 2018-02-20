Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751221AbeBTVkR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 16:40:17 -0500
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:48658 "EHLO
        15.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeBTVkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 16:40:16 -0500
Date: Tue, 20 Feb 2018 17:48:16 +0100
From: Greg Kurz <groug@kaod.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>, netdev@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        Ron Minnich <rminnich@sandia.gov>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [V9fs-developer] [PATCH] net/9p: avoid -ERESTARTSYS leak to
 userspace
Message-ID: <20180220174816.0ef05769@bahia.lan>
In-Reply-To: <151811152925.12219.16418114797025615002.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <151811152925.12219.16418114797025615002.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 5931803662776834327
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtfedrgeejgdeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

It's been two years without any sign of life from 9p maintainers... :-\

Would you apply (or nack) this patch ?

Thanks,

--
Greg

PS: in the case you apply it, probable Cc stable@vger.kernel.org as well


On Thu, 08 Feb 2018 18:38:49 +0100

Greg Kurz <groug@kaod.org> wrote:

> If it was interrupted by a signal, the 9p client may need to send some
> more requests to the server for cleanup before returning to userspace.
> 
> To avoid such a last minute request to be interrupted right away, the
> client memorizes if a signal is pending, clear TIF_SIGPENDING, handle
> the request and call recalc_sigpending() before returning.
> 
> Unfortunately, if the transmission of this cleanup request fails for any
> reason, the transport returns an error and the client propagates it right
> away, without calling recalc_sigpending().
> 
> This ends up with -ERESTARTSYS from the initially interrupted request
> crawling up to syscall exit, with TIF_SIGPENDING cleared by the cleanup
> request. The specific signal handling code, which is responsible for
> converting -ERESTARTSYS to -EINTR is not called, and userspace receives
> the confusing errno value:
> 
> open: Unknown error 512 (512)
> 
> This is really hard to hit in real life. I discovered the issue while
> working on hot-unplug of a virtio-9p-pci device with an instrumented
> QEMU allowing to control request completion.
> 
> Both p9_client_zc_rpc() and p9_client_rpc() functions have this buggy
> error path actually. Their code flow is a bit obscure and the best
> thing to do would probably be a full rewrite: to really ensure this
> situation of clearing TIF_SIGPENDING and returning -ERESTARTSYS can
> never happen.
> 
> But given the general lack of interest for the 9p code, I won't risk
> breaking more things. So this patch simply fix the buggy paths in both
> functions with a trivial label+goto.
> 
> Thanks to Laurent Dufour for his help and suggestions on how to find
> the root cause and how to fix it.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  net/9p/client.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 4c8cf9c1631a..5154eaf19fff 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -769,7 +769,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
>  	if (err < 0) {
>  		if (err != -ERESTARTSYS && err != -EFAULT)
>  			c->status = Disconnected;
> -		goto reterr;
> +		goto recalc_sigpending;
>  	}
>  again:
>  	/* Wait for the response */
> @@ -804,6 +804,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
>  		if (req->status == REQ_STATUS_RCVD)
>  			err = 0;
>  	}
> +recalc_sigpending:
>  	if (sigpending) {
>  		spin_lock_irqsave(&current->sighand->siglock, flags);
>  		recalc_sigpending();
> @@ -867,7 +868,7 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
>  		if (err == -EIO)
>  			c->status = Disconnected;
>  		if (err != -ERESTARTSYS)
> -			goto reterr;
> +			goto recalc_sigpending;
>  	}
>  	if (req->status == REQ_STATUS_ERROR) {
>  		p9_debug(P9_DEBUG_ERROR, "req_status error %d\n", req->t_err);
> @@ -885,6 +886,7 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
>  		if (req->status == REQ_STATUS_RCVD)
>  			err = 0;
>  	}
> +recalc_sigpending:
>  	if (sigpending) {
>  		spin_lock_irqsave(&current->sighand->siglock, flags);
>  		recalc_sigpending();
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> V9fs-developer mailing list
> V9fs-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/v9fs-developer
