Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CF4C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B5720658
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B5720658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeH1Fra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:47:30 -0400
Received: from nautica.notk.org ([91.121.71.147]:39116 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbeH1Fra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:47:30 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 90974C009; Tue, 28 Aug 2018 03:58:09 +0200 (CEST)
Date:   Tue, 28 Aug 2018 03:57:54 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     piaojun <piaojun@huawei.com>, Greg Kurz <groug@kaod.org>
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>, lucho@ionkov.net,
        Dominique Martinet <dominique.martinet@cea.fr>,
        ericvh@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        v9fs-developer@lists.sourceforge.net, rminnich@sandia.gov,
        davem@davemloft.net
Subject: Re: [V9fs-developer] [PATCH v2 2/2] 9p: Add refcount to p9_req_t
Message-ID: <20180828015754.GA8117@nautica>
References: <20180814174342.11068-1-tomasbortoli@gmail.com>
 <20180814174342.11068-2-tomasbortoli@gmail.com>
 <20180827230954.GA21513@nautica>
 <5B84A051.6070903@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B84A051.6070903@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

piaojun wrote on Tue, Aug 28, 2018:
> > (Jun, I think you'll need to ask again to rename 'req' to 'rreq' if you
> > think it's important -- I think such a rename should go in a separate
> > patch anyway, there's plenty of time until the 4.20 merge window)
> > 
> 
> I still think such a rename is necessary, and as you said, it will be
> better go in another patch.

Tomas can you send a patch for that please?
It's not very interesting, but might as well finish this properly :)

> >> diff --git a/net/9p/client.c b/net/9p/client.c
> >> index 7942c0bfcc5b..c9bb5d41afa4 100644
> >> --- a/net/9p/client.c
> >> +++ b/net/9p/client.c
> >> @@ -716,6 +756,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
> >>  
> >>  	err = c->trans_mod->request(c, req);
> >>  	if (err < 0) {
> >> +		/* write won't happen */
> >> +		p9_req_put(req);
> >>  		if (err != -ERESTARTSYS && err != -EFAULT)
> >>  			c->status = Disconnected;
> >>  		goto recalc_sigpending;
> > 
> > p9_client_zc_rpc needs the same put if zc_request failed, I'm not sure
> > why it wasn't here in my draft

Ah, I remember a bit better now, this is not as simple as adding the
same check after zc_request because the zc_request embeds the wait
itself to do its own cleanup after the reply came (unpin pages that were
sent to the server).

This brings in an interesting race condition that if the
wait_event_killable() in the zc_request is interrupted, the user data
pages that were pinned get unpinned and could potentially be moved
before the server replies... Even if they're not moved the user would be
told the read/write failed and could reuse the memory that would be
read/written later.
I'm not sure how this part works but it's probably not great.

Greg, do you have an opinion on this?


This is tricky, we cannot even rely on the refcounting for this as the
zc pages are likely user pages, so it'll be bad if we return from the
syscall and the memory gets accessed later.
On the other hand making that wait non-killable isn't a good solution
either, and we cannot use flush for virtio, so I don't have any idea for
this... Any magic virtio "take-back"?



Well, this would be for another patch anyway - for now I'll just do the
p9_req_put if it hasn't been kicked so that means something like the
following diff.. But my test bed is currently down so I'll wait for
tests to push:
-------8<----------------
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 7728b0acde09..36a1401c0722 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -404,6 +404,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	struct scatterlist *sgs[4];
 	size_t offs;
 	int need_drop = 0;
+	int kicked = 0;
 
 	p9_debug(P9_DEBUG_TRANS, "virtio request\n");
 
@@ -498,6 +499,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	}
 	virtqueue_kick(chan->vq);
 	spin_unlock_irqrestore(&chan->lock, flags);
+	kicked = 1;
 	p9_debug(P9_DEBUG_TRANS, "virtio request kicked\n");
 	err = wait_event_killable(req->wq, req->status >= REQ_STATUS_RCVD);
 	/*
@@ -518,6 +520,10 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	}
 	kvfree(in_pages);
 	kvfree(out_pages);
+	if (!kicked) {
+		/* reply won't come */
+		p9_req_put(req);
+	}
 	return err;
 }
 
-------8<----------------

-- 
Dominique
