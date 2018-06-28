Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5086DC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F71327474
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F71327474
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966299AbeF1NsI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:48:08 -0400
Received: from nautica.notk.org ([91.121.71.147]:33391 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966279AbeF1NsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:48:06 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jun 2018 09:48:06 EDT
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 5DB86C009; Thu, 28 Jun 2018 15:40:44 +0200 (CEST)
Date:   Thu, 28 Jun 2018 15:40:29 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ron Minnich <rminnich@sandia.gov>
Subject: Re: [V9fs-developer] [PATCH 4/6] 9p: Remove an unnecessary memory
 barrier
Message-ID: <20180628134029.GA24673@nautica>
References: <20180628132629.3148-1-willy@infradead.org>
 <20180628132629.3148-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180628132629.3148-5-willy@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote on Thu, Jun 28, 2018:
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -436,13 +436,9 @@ void p9_client_cb(struct p9_client *c, struct p9_req_t *req, int status)
>  {
>  	p9_debug(P9_DEBUG_MUX, " tag %d\n", req->tc->tag);
>  
> -	/*
> -	 * This barrier is needed to make sure any change made to req before
> -	 * the other thread wakes up will indeed be seen by the waiting side.
> -	 */
> -	smp_wmb();
>  	req->status = status;
>  
> +	/* wake_up is an implicit write memory barrier */

Nope.
Please note the wmb is _before_ setting status, basically it protects
from cpu optimizations where status could be set before other fields,
then other core opportunistically checking and finding status is good so
other thread continuing.

I could only reproduce this bug with infiniband network, but it is very
definitely needed. Here is the commit message of when I added that barrier:
-----
9P: Add memory barriers to protect request fields over cb/rpc threads handoff

We need barriers to guarantee this pattern works as intended:
[w] req->rc, 1          [r] req->status, 1
wmb                     rmb
[w] req->status, 1      [r] req->rc

Where the wmb ensures that rc gets written before status,
and the rmb ensures that if you observe status == 1, rc is the new value.
-----

It might need an update to the comment though, if you thought about
removing it...
-- 
Dominique Martinet | Asmadeus
