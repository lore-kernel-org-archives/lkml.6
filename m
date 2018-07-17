Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A669ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9EF20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9EF20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbeGQMOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:14:46 -0400
Received: from nautica.notk.org ([91.121.71.147]:37120 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730875AbeGQMOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:14:46 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 40513C009; Tue, 17 Jul 2018 13:42:30 +0200 (CEST)
Date:   Tue, 17 Jul 2018 13:42:15 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     jiangyiwen <jiangyiwen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH v2] net/9p: Fix a deadlock case in the
 virtio transport
Message-ID: <20180717114215.GA14414@nautica>
References: <5B4DCD0A.8040600@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B4DCD0A.8040600@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: net/9p: Fix a deadlock case in the virtio transport

I hadn't noticed in the v1, but how is that a deadlock fix?
The previous code doesn't look like it deadlocks to me, the commit
message is more correct.

jiangyiwen wrote on Tue, Jul 17, 2018:
> When client has multiple threads that issue io requests
> all the time, and the server has a very good performance,
> it may cause cpu is running in the irq context for a long
> time because it can check virtqueue has buf in the *while*
> loop.
> 
> So we should keep chan->lock in the whole loop.
> 
> Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
> ---
>  net/9p/trans_virtio.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 05006cb..e5fea8b 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -148,20 +148,15 @@ static void req_done(struct virtqueue *vq)
> 
>  	p9_debug(P9_DEBUG_TRANS, ": request done\n");
> 
> -	while (1) {
> -		spin_lock_irqsave(&chan->lock, flags);
> -		req = virtqueue_get_buf(chan->vq, &len);
> -		if (req == NULL) {
> -			spin_unlock_irqrestore(&chan->lock, flags);
> -			break;
> -		}
> -		chan->ring_bufs_avail = 1;
> -		spin_unlock_irqrestore(&chan->lock, flags);
> -		/* Wakeup if anyone waiting for VirtIO ring space. */
> -		wake_up(chan->vc_wq);
> +	spin_lock_irqsave(&chan->lock, flags);
> +	while ((req = virtqueue_get_buf(chan->vq, &len)) != NULL) {
>  		if (len)
>  			p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
>  	}
> +	chan->ring_bufs_avail = 1;

Do we have a guarantee that req_done is only called if there is at least
one buf to read?
For example, that there isn't two threads queueing the same callback but
the first one reads everything and the second has nothing to read?

If virtblk_done takes care of setting up a "req_done" bool to only
notify waiters if something has been done I'd rather have a reason to do
differently, even if you can argue that nothing bad will happen in case
of a gratuitous wake_up

> +	spin_unlock_irqrestore(&chan->lock, flags);
> +	/* Wakeup if anyone waiting for VirtIO ring space. */
> +	wake_up(chan->vc_wq);
>  }

Thanks,
-- 
Dominique
