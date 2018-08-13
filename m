Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8714BC46460
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 01:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C41B217D0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 01:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C41B217D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbeHME2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 00:28:32 -0400
Received: from nautica.notk.org ([91.121.71.147]:53287 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbeHME2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 00:28:32 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id E37D6C009; Mon, 13 Aug 2018 03:48:30 +0200 (CEST)
Date:   Mon, 13 Aug 2018 03:48:15 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     piaojun <piaojun@huawei.com>
Cc:     Tomas Bortoli <tomasbortoli@gmail.com>, ericvh@gmail.com,
        rminnich@sandia.gov, lucho@ionkov.net,
        Dominique Martinet <dominique.martinet@cea.fr>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, v9fs-developer@lists.sourceforge.net,
        davem@davemloft.net
Subject: Re: [V9fs-developer] [PATCH 2/2] 9p: Add refcount to p9_req_t
Message-ID: <20180813014815.GB6777@nautica>
References: <20180811144254.23665-1-tomasbortoli@gmail.com>
 <20180811144254.23665-2-tomasbortoli@gmail.com>
 <5B70E0D1.2080300@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B70E0D1.2080300@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

piaojun wrote on Mon, Aug 13, 2018:
> Could you help paste the reason of the crash bug to help others
> understand more clearly? And I have another question below.

The problem for tcp (but other transports have a similar problem) is
that with a malicious server like syzkaller they can try to submit
replies before the request came in.

This leads in the writer thread trying to write a buffer that has
already been freed, and if memory has been reused could potentially leak
some information.

Now, with the previous patches this is based on this would be a slab and
the likeliness of it being sensitive information is rather low (it would
likely be some other packet being sent twice, or a mix and match of two
packets that would have been sent anyway), but it would nevertheless be
a use after free.


There is a second advantage to this reference counting, that is now we
have this system we will be able to implement flush asynchronously.
This will remove the need for the 'goto again' in p9_client_rpc which
was making 9p threads unkillable in practice if the server would not
reply to the flush requests.
Even if the server replies I've always found myself needing to hit ^C
multiple times to exit a process doing I/Os and I think fixing that
behaviour will make 9p more comfortable to use.


> > diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> > index 20f46f13fe83..686e24e355d0 100644
> > --- a/net/9p/trans_fd.c
> > +++ b/net/9p/trans_fd.c
> > @@ -132,6 +132,7 @@ struct p9_conn {
> >  	struct list_head req_list;
> >  	struct list_head unsent_req_list;
> >  	struct p9_req_t *req;
> > +	struct p9_req_t *wreq;
> 
> Why adding a wreq for write work? And I wonder we should rename req to
> rreq?

We need to store a pointer to the request for the write thread because
we need to put the reference to it when we're done writing its content.

Previously, the worker would only store the write buffer there but
that's not enough to figure what request to dereference.


I personally don't think renaming req to rreq would bring much but it
could be done in another patch if you think that'd be helpful; I think
it shouldn't be done here at least to make the patch more readable.

-- 
Dominique
