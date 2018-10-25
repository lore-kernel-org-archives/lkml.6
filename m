Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1165DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38BD20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38BD20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbeJZFWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:22:36 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:48486 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeJZFWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:22:36 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gFmYE-0001rY-2i; Thu, 25 Oct 2018 22:48:18 +0200
Message-ID: <c6e666eb6bcd84caa0affacd7e994bb413c82950.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] kernel/workqueue: Suppress a false positive lockdep
 complaint
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "tytso@mit.edu" <tytso@mit.edu>
Date:   Thu, 25 Oct 2018 22:47:58 +0200
In-Reply-To: <1540499971.66186.51.camel@acm.org> (sfid-20181025_223935_800776_222DDCFE)
References: <20181025150540.259281-1-bvanassche@acm.org>
         <20181025150540.259281-4-bvanassche@acm.org>
         <2cebeb88640433ce473bc40f9a5c7e06d0661e4d.camel@sipsolutions.net>
         <1540487511.66186.31.camel@acm.org>
         (sfid-20181025_191156_926182_FF0802A9) <11db45f85e2f763c23ae32834dcd016adfce8ad6.camel@sipsolutions.net>
         <1540499971.66186.51.camel@acm.org> (sfid-20181025_223935_800776_222DDCFE)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-25 at 13:39 -0700, Bart Van Assche wrote:
> 
> > +void flush_workqueue_nested(struct workqueue_struct *wq, int subclass)
> >  {
> >  	struct wq_flusher this_flusher = {
> >  		.list = LIST_HEAD_INIT(this_flusher.list),
> > @@ -2652,7 +2653,7 @@ void flush_workqueue(struct workqueue_struct *wq)
> >  	if (WARN_ON(!wq_online))
> >  		return;
> >  
> > -	lock_map_acquire(&wq->lockdep_map);
> > +	lock_acquire_exclusive(&wq->lockdep_map, subclass, 0, NULL, _THIS_IP_);
> >  	lock_map_release(&wq->lockdep_map);
> >  
> >  	mutex_lock(&wq->mutex);
> > [ ... ]
> 
> I don't like this approach because it doesn't match how other kernel code uses
> lockdep annotations. All other kernel code I know of only annotates lock depmaps
> as nested if the same kernel thread calls lock_acquire() twice for the same depmap
> without intervening lock_release(). My understanding is that with your patch
> applied flush_workqueue_nested(wq, 1) calls lock_acquire() only once and with the
> subclass argument set to one. I think this will confuse other people who will read
> the workqueue implementation and who have not followed this conversation.

Hmm, yeah, that's a reasonable complaint. My mental model is more along
the lines of
	"this is a different nested (layered) object instance"
rather than
	"I'm nesting the locks",
so this code change fits well into my model. However, code like
infiniband/core/cma.c does in fact use it with nested object instances
*and* actually (and directly in the code) nested locks.

I think the "actual nesting" could possibly come up with workqueues,
like I described earlier: you have two objects with a workqueue each,
and the objects are somehow layered (like cma.c's listen_id and
conn_id), and each contains a workqueue, and some work running on the
listen_id's workqueue wants to destroy all the conn_id's workqueue(s).
In that case, you do end up really having the nesting.

So in that sense, I still think this API may still be required, and
(perhaps with an appropriate comment) could be used in the dio case even
if there's no actual nesting, without introducing the - IMHO single-use
and more dangerous - destroy_workqueue_no_drain().

johannes

