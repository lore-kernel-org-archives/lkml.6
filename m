Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB02EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997AE208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997AE208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbeGaCuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:50:54 -0400
Received: from nautica.notk.org ([91.121.71.147]:50929 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbeGaCux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:50:53 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 69CC6C009; Tue, 31 Jul 2018 03:13:11 +0200 (CEST)
Date:   Tue, 31 Jul 2018 03:12:56 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     piaojun <piaojun@huawei.com>
Cc:     v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Greg Kurz <groug@kaod.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [V9fs-developer] [PATCH 1/2] net/9p: embed fcall in req to round
 down buffer allocs
Message-ID: <20180731011256.GA30388@nautica>
References: <20180730093101.GA7894@nautica>
 <1532943263-24378-1-git-send-email-asmadeus@codewreck.org>
 <5B5FB380.1000208@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B5FB380.1000208@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

piaojun wrote on Tue, Jul 31, 2018:
> This is really a *big* patch, but the modification seems no harm. And I
> suggest running testcases to cover this. Please see my comments below.

I'm always running tests, but more never hurt - please help ;)

For reference I'm running a subset of cthon04[1], ltp[2] and some custom
tests like these[3][4]

[1] https://fedorapeople.org/cgit/steved/public_git/cthon04.git/
[2] https://github.com/linux-test-project/ltp
[3] https://github.com/phdeniel/sigmund/blob/master/modules/allfs.inc#L208
[4] https://github.com/phdeniel/sigmund/blob/master/modules/allfs.inc#L251

> > [...]
> > @@ -263,13 +261,13 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
> >  	if (!req)
> >  		return NULL;
> >  
> > -	req->tc = p9_fcall_alloc(alloc_msize);
> > -	req->rc = p9_fcall_alloc(alloc_msize);
> > -	if (!req->tc || !req->rc)
> > +	if (p9_fcall_alloc(&req->tc, alloc_msize))
> > +		goto free;
> > +	if (p9_fcall_alloc(&req->rc, alloc_msize))
> >  		goto free;
> >  
> > -	p9pdu_reset(req->tc);
> > -	p9pdu_reset(req->rc);
> > +	p9pdu_reset(&req->tc);
> > +	p9pdu_reset(&req->rc);
> >  	req->status = REQ_STATUS_ALLOC;
> >  	init_waitqueue_head(&req->wq);
> >  	INIT_LIST_HEAD(&req->req_list);
> > @@ -281,7 +279,7 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
> >  				GFP_NOWAIT);
> >  	else
> >  		tag = idr_alloc(&c->reqs, req, 0, P9_NOTAG, GFP_NOWAIT);
> > -	req->tc->tag = tag;
> > +	req->tc.tag = tag;
> >  	spin_unlock_irq(&c->lock);
> >  	idr_preload_end();
> >  	if (tag < 0)
> > @@ -290,8 +288,8 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
> >  	return req;
> >  
> >  free:
> > -	kfree(req->tc);
> > -	kfree(req->rc);
> > +	kfree(req->tc.sdata);
> > +	kfree(req->rc.sdata);
> 
> I wonder if we will free a wild pointer as 'sdata' has not been initialized NULL.

Good point, it's possible to jump here if the first fcall_alloc failed
since this declustered the two allocations.

Please consider this added to the previous patch (I'll send a v2 after
this has had more time for review, you can find the amended commit in my
9p-test tree meanwhile):
-----8<-----------------------------
diff --git a/net/9p/client.c b/net/9p/client.c
index ba99a94a12c9..fe030ef1c076 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -262,7 +262,7 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
 		return NULL;
 
 	if (p9_fcall_alloc(&req->tc, alloc_msize))
-		goto free;
+		goto free_req;
 	if (p9_fcall_alloc(&req->rc, alloc_msize))
 		goto free;
 
@@ -290,6 +290,7 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
 free:
 	kfree(req->tc.sdata);
 	kfree(req->rc.sdata);
+free_req:
 	kmem_cache_free(p9_req_cache, req);
 	return ERR_PTR(-ENOMEM);
 }
-----8<-----------------------------

The second goto doesn't need changing because rc.sdata will be set to
NULL if the allocation failed

-- 
Dominique
