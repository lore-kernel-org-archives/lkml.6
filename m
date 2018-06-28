Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A8DC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAC5274C5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m4lXN/tf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAC5274C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935038AbeF1OEH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:04:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934483AbeF1OEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=J1sqDgdl8sPhDG8Rf6xrrfwapSUI9sWidWr+/ZgRQgU=; b=m4lXN/tfz1j+nY00ZkDuEz1qz
        gey4Pst0B3RfXuPABEg/U14STuHLtoBhn+8J79By4ZxkgvTdowmZY2z6C8cD1YJYytbrBaeXTOa0Y
        tnIauhGyulpLrCUg+zOZHzkeVaKYwlgmPDm3Am6KVhUsjYLQDPqTARTfPHM+53ZeU9m4frz5qaaE6
        p+zv0XlvjcNZ5hpJliPwUww4qXPgutF7tTuMOPD3Jc+2JEFs4Jwc3QP0nnvyGKMByE4KrOnMfV1Lt
        4Zn/VjrDVe9AeyfXdYHqZxIZraOEB1ZQGmFcgZNL90lWdC/4Qi61UYXK5oH9O/WmuA4ZHpefgIeRI
        tbGRGQHyg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYXWg-0002hP-T0; Thu, 28 Jun 2018 14:03:58 +0000
Date:   Thu, 28 Jun 2018 07:03:58 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ron Minnich <rminnich@sandia.gov>
Subject: Re: [V9fs-developer] [PATCH 4/6] 9p: Remove an unnecessary memory
 barrier
Message-ID: <20180628140358.GG7646@bombadil.infradead.org>
References: <20180628132629.3148-1-willy@infradead.org>
 <20180628132629.3148-5-willy@infradead.org>
 <20180628134029.GA24673@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628134029.GA24673@nautica>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 03:40:29PM +0200, Dominique Martinet wrote:
> Matthew Wilcox wrote on Thu, Jun 28, 2018:
> > --- a/net/9p/client.c
> > +++ b/net/9p/client.c
> > @@ -436,13 +436,9 @@ void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
> >  {
> >  	p9_debug(P9_DEBUG_MUX, " tag %d\n", req->tc->tag);
> >  
> > -	/*
> > -	 * This barrier is needed to make sure any change made to req before
> > -	 * the other thread wakes up will indeed be seen by the waiting side.
> > -	 */
> > -	smp_wmb();
> >  	req->status = status;
> >  
> > +	/* wake_up is an implicit write memory barrier */
> 
> Nope.
> Please note the wmb is _before_ setting status, basically it protects
> from cpu optimizations where status could be set before other fields,
> then other core opportunistically checking and finding status is good so
> other thread continuing.
> 
> I could only reproduce this bug with infiniband network, but it is very
> definitely needed. Here is the commit message of when I added that barrier:
> -----
> 9P: Add memory barriers to protect request fields over cb/rpc threads handoff
> 
> We need barriers to guarantee this pattern works as intended:
> [w] req->rc, 1          [r] req->status, 1
> wmb                     rmb
> [w] req->status, 1      [r] req->rc
> 
> Where the wmb ensures that rc gets written before status,
> and the rmb ensures that if you observe status == 1, rc is the new value.
> -----
> 
> It might need an update to the comment though, if you thought about
> removing it...

Ah!  Yes, that situation is different from what the comment documents.

How about this?

	/*
	 * This barrier is needed to make sure any change made to req before
-	 * the other thread wakes up will indeed be seen by the waiting side.
+	 * the status change is visible to another thread
	 */
