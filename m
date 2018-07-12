Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47748C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E61213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E61213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732562AbeGLPDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:03:18 -0400
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:48724 "EHLO
        18.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732310AbeGLPDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:03:17 -0400
X-Greylist: delayed 983 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jul 2018 11:03:16 EDT
Received: from player732.ha.ovh.net (unknown [10.109.122.11])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 22C561C2ED2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 16:37:02 +0200 (CEST)
Received: from bahia.lan (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player732.ha.ovh.net (Postfix) with ESMTPSA id 3A979200BB;
        Thu, 12 Jul 2018 16:36:50 +0200 (CEST)
Date:   Thu, 12 Jul 2018 16:36:49 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, Ron Minnich <rminnich@sandia.gov>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH v2 4/6] 9p: Embed wait_queue_head into
 p9_req_t
Message-ID: <20180712163649.36057b6e@bahia.lan>
In-Reply-To: <20180711210225.19730-5-willy@infradead.org>
References: <20180711210225.19730-1-willy@infradead.org>
        <20180711210225.19730-5-willy@infradead.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7461620159068674373
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtiedrgeekgdejlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 14:02:23 -0700
Matthew Wilcox <willy@infradead.org> wrote:

> On a 64-bit system, the wait_queue_head_t is 24 bytes while the pointer
> to it is 8 bytes.  Growing the p9_req_t by 16 bytes is better than
> performing a 24-byte memory allocation.
> 

This is true when all tags have been used at least once. But the current code
lazily allocates the wait_queue_head_t, ie, only when a tag is used for the
first time. Your patch causes a full row of wait_quest_head_t to be pre-allocated.

ie, P9_ROW_MAXTAG * 24 = 255 * 24 = 6120

instead of (P9_ROW_MAXTAG * 8) + 24 = 255 * 8 + 24 = 2064

This is nearly a page of allocated memory that might be never used.

Not sure if this is a problem though...

> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---
>  include/net/9p/client.h |  2 +-
>  net/9p/client.c         | 19 +++++--------------
>  net/9p/trans_virtio.c   |  2 +-
>  3 files changed, 7 insertions(+), 16 deletions(-)
> 

... and the diffstat is nice :) so

Reviewed-by: Greg Kurz <groug@kaod.org>

> diff --git a/include/net/9p/client.h b/include/net/9p/client.h
> index e405729cd1c7..0fa0fbab33b0 100644
> --- a/include/net/9p/client.h
> +++ b/include/net/9p/client.h
> @@ -113,7 +113,7 @@ enum p9_req_status_t {
>  struct p9_req_t {
>  	int status;
>  	int t_err;
> -	wait_queue_head_t *wq;
> +	wait_queue_head_t wq;
>  	struct p9_fcall *tc;
>  	struct p9_fcall *rc;
>  	void *aux;
> diff --git a/net/9p/client.c b/net/9p/client.c
> index b89c7298267c..bc8aba6b5ce0 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -282,8 +282,9 @@ p9_tag_alloc(struct p9_client *c, u16 tag, unsigned int max_size)
>  				return ERR_PTR(-ENOMEM);
>  			}
>  			for (col = 0; col < P9_ROW_MAXTAG; col++) {
> -				c->reqs[row][col].status = REQ_STATUS_IDLE;
> -				c->reqs[row][col].tc = NULL;
> +				req = &c->reqs[row][col];
> +				req->status = REQ_STATUS_IDLE;
> +				init_waitqueue_head(&req->wq);
>  			}
>  			c->max_tag += P9_ROW_MAXTAG;
>  		}
> @@ -293,13 +294,6 @@ p9_tag_alloc(struct p9_client *c, u16 tag, unsigned int max_size)
>  	col = tag % P9_ROW_MAXTAG;
>  
>  	req = &c->reqs[row][col];
> -	if (!req->wq) {
> -		req->wq = kmalloc(sizeof(wait_queue_head_t), GFP_NOFS);
> -		if (!req->wq)
> -			goto grow_failed;
> -		init_waitqueue_head(req->wq);
> -	}
> -
>  	if (!req->tc)
>  		req->tc = p9_fcall_alloc(alloc_msize);
>  	if (!req->rc)
> @@ -319,9 +313,7 @@ p9_tag_alloc(struct p9_client *c, u16 tag, unsigned int max_size)
>  	pr_err("Couldn't grow tag array\n");
>  	kfree(req->tc);
>  	kfree(req->rc);
> -	kfree(req->wq);
>  	req->tc = req->rc = NULL;
> -	req->wq = NULL;
>  	return ERR_PTR(-ENOMEM);
>  }
>  
> @@ -409,7 +401,6 @@ static void p9_tag_cleanup(struct p9_client *c)
>  	/* free requests associated with tags */
>  	for (row = 0; row < (c->max_tag/P9_ROW_MAXTAG); row++) {
>  		for (col = 0; col < P9_ROW_MAXTAG; col++) {
> -			kfree(c->reqs[row][col].wq);
>  			kfree(c->reqs[row][col].tc);
>  			kfree(c->reqs[row][col].rc);
>  		}
> @@ -452,7 +443,7 @@ void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
>  	smp_wmb();
>  	req->status = status;
>  
> -	wake_up(req->wq);
> +	wake_up(&req->wq);
>  	p9_debug(P9_DEBUG_MUX, "wakeup: %d\n", req->tc->tag);
>  }
>  EXPORT_SYMBOL(p9_client_cb);
> @@ -773,7 +764,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
>  	}
>  again:
>  	/* Wait for the response */
> -	err = wait_event_killable(*req->wq, req->status >= REQ_STATUS_RCVD);
> +	err = wait_event_killable(req->wq, req->status >= REQ_STATUS_RCVD);
>  
>  	/*
>  	 * Make sure our req is coherent with regard to updates in other
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 05006cbb3361..3e096c98313c 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -490,7 +490,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
>  	virtqueue_kick(chan->vq);
>  	spin_unlock_irqrestore(&chan->lock, flags);
>  	p9_debug(P9_DEBUG_TRANS, "virtio request kicked\n");
> -	err = wait_event_killable(*req->wq, req->status >= REQ_STATUS_RCVD);
> +	err = wait_event_killable(req->wq, req->status >= REQ_STATUS_RCVD);
>  	/*
>  	 * Non kernel buffers are pinned, unpin them
>  	 */

