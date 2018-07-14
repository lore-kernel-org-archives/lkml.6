Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDD6ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 09:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EFC20873
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 09:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62EFC20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeGNJXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 05:23:43 -0400
Received: from nautica.notk.org ([91.121.71.147]:54448 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeGNJXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 05:23:43 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 1ACBCC009; Sat, 14 Jul 2018 11:05:17 +0200 (CEST)
Date:   Sat, 14 Jul 2018 11:05:02 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     jiangyiwen <jiangyiwen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH] net/9p: Fix a deadlock case in the
 virtio transport
Message-ID: <20180714090502.GA16186@nautica>
References: <5B49B8CF.40709@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B49B8CF.40709@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jiangyiwen wrote on Sat, Jul 14, 2018:
> When client has multiple threads that issue io requests all the
> time, and the server has a very good performance, it may cause
> cpu is running in the irq context for a long time because it can
> check virtqueue has buf in the *while* loop.
> 
> So we should keep chan->lock in the whole loop.

Hmm, this is generally bad practice to hold a spin lock for long.
In general, spin locks are meant to protect data, not code.

I'd want some numbers to decide on this one, even if I think this
particular case is safe (e.g. this cannot dead-lock)

> Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
> ---
>  net/9p/trans_virtio.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 05006cb..9b0f5f2 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -148,20 +148,18 @@ static void req_done(struct virtqueue *vq)
> 
>  	p9_debug(P9_DEBUG_TRANS, ": request done\n");
> 
> +	spin_lock_irqsave(&chan->lock, flags);
>  	while (1) {
> -		spin_lock_irqsave(&chan->lock, flags);
>  		req = virtqueue_get_buf(chan->vq, &len);
> -		if (req == NULL) {
> -			spin_unlock_irqrestore(&chan->lock, flags);
> +		if (req == NULL)
>  			break;
> -		}
>  		chan->ring_bufs_avail = 1;
> -		spin_unlock_irqrestore(&chan->lock, flags);
>  		/* Wakeup if anyone waiting for VirtIO ring space. */
>  		wake_up(chan->vc_wq);

In particular, the wake up here echoes to wait events that will
immediately try to grab the lock, and will needlessly spin on it until
this thread is done.
If we do go this way I'd want setting chan->ring_bufs_avail to be done
just before unlocking and the wakeup to be done just after unlocking out
of the loop iff we processed at least one iteration here.

That should also save you precious cpu cycles while under lock :)

-- 
Dominique Martinet
