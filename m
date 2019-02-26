Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DECCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AFA21848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kUqYeVee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfBZRYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:24:35 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54982 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBZRYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gWeSZ/xtlI7LukVl3acUdsI54yp9JlX6hUDN4rt9U40=; b=kUqYeVee1rhjrqplXGYOG6Pmr
        lLiHBGYXzUtAveIwLt7ReD/RPG2eFPzeUFYxMhZqtJrg+mAeOiQyR07jJXWx6z4YK/AuUtdNHP+YK
        tMucfqxXKbD/JVPBdme2ZYQQ9P3fFe2xRtEJBa51zhfbkq6qBmUvt8k3vIfeG3ytpgLKVw9PqBMFW
        ek2qUCV/M9KVo5RNpYbO8QxVXT6L6sk+Z8hwoT1oMKnpArNP6LwqfLKk2u/fj48Js1jr5IaWg6UIP
        Q1YnPPOt3r2diRxSHOUmigtwpW2r3/V+jDfrmi6nR/JAupEOht9IInwA+SfNGXNH5WTcZXUpfd2SR
        mScljZ5Nw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gygSs-0007WJ-Rw; Tue, 26 Feb 2019 17:24:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8CEB123D270C1; Tue, 26 Feb 2019 18:24:21 +0100 (CET)
Date:   Tue, 26 Feb 2019 18:24:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v7 21/23] block: Avoid that flushing triggers a lockdep
 complaint
Message-ID: <20190226172421.GI32494@hirez.programming.kicks-ass.net>
References: <20190214230058.196511-1-bvanassche@acm.org>
 <20190214230058.196511-22-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214230058.196511-22-bvanassche@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 03:00:56PM -0800, Bart Van Assche wrote:
> @@ -472,7 +473,8 @@ struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
>  	if (!fq)
>  		goto fail;
>  
> -	spin_lock_init(&fq->mq_flush_lock);
> +	lockdep_register_key(&fq->key);
> +	spin_lock_init_key(&fq->mq_flush_lock, &fq->key);

What's wrong with:

	spin_lock_init(&fq->wq_flush_lock);
	lockdep_register_key(&fq->key);
	lockdep_set_class(&fq->wq_flush_lock, &fq->key);

?
