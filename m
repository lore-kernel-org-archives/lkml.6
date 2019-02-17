Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB86C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED5B2192C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfBQNXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 08:23:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38525 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfBQNXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 08:23:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C769480F7C;
        Sun, 17 Feb 2019 13:23:29 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 37EC260BF7;
        Sun, 17 Feb 2019 13:23:16 +0000 (UTC)
Date:   Sun, 17 Feb 2019 21:23:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        tj@kernel.org, longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v7 21/23] block: Avoid that flushing triggers a lockdep
 complaint
Message-ID: <20190217132311.GD7296@ming.t460p>
References: <20190214230058.196511-1-bvanassche@acm.org>
 <20190214230058.196511-22-bvanassche@acm.org>
 <20190215022658.GB21045@ming.t460p>
 <1550246888.31902.97.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550246888.31902.97.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 17 Feb 2019 13:23:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 08:08:08AM -0800, Bart Van Assche wrote:
> On Fri, 2019-02-15 at 10:26 +0800, Ming Lei wrote:
> > There might be lots of blk_flush_queue instance which is allocated
> > for each hctx, then lots of class key slot may be wasted.
> > 
> > So I suggest to use one nvmet_loop_flush_lock_key for this particular issue,
> > something like the following patch:
> > 
> > diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> > index 4aac1b4a8112..ec4248c12ed9 100644
> > --- a/drivers/nvme/target/loop.c
> > +++ b/drivers/nvme/target/loop.c
> > @@ -524,7 +524,9 @@ static const struct nvme_ctrl_ops nvme_loop_ctrl_ops = {
> >  
> >  static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
> >  {
> > -	int ret;
> > +	static struct lock_class_key  nvme_loop_flush_lock_key;
> > +	int ret, i;
> > +	struct blk_mq_hw_ctx *hctx;
> >  
> >  	ret = nvme_loop_init_io_queues(ctrl);
> >  	if (ret)
> > @@ -553,6 +555,10 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
> >  		goto out_free_tagset;
> >  	}
> >  
> > +	queue_for_each_hw_ctx(ctrl->ctrl.connect_q, hctx, i)
> > +		lockdep_set_class(&hctx->fq->mq_flush_lock,
> > +				&nvme_loop_flush_lock_key);
> > +
> >  	ret = nvme_loop_connect_io_queues(ctrl);
> >  	if (ret)
> >  		goto out_cleanup_connect_q;
> 
> Hi Ming,
> 
> Thanks for your feedback.
> 
> Are you aware that sizeof(struct lock_class_key) is zero if lockdep is
> disabled?

Yes.

> Does this alleviate your concern?

No, I mean in case of CONFIG_LOCKDP.

1) MAX_LOCKDEP_KEYS is defined as 8k-1

2) lock validation runs as graph search algorithm actually, and each lock
class acts as one graph vertex.

So more lock class will make the lock validation much slower, also lock
class key may be overflow.

> 
> I'm not enthusiast about your patch. I don't think that block layer users
> should touch the lock class key of the flush queue. That's a key that should
> be set by the block layer core.

Why? lockdep_set_class is used tree-wide actually.

Thanks,
Ming
