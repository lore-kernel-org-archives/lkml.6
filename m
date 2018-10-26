Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA79C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19A720834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19A720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeJZQnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:43:14 -0400
Received: from verein.lst.de ([213.95.11.211]:34916 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbeJZQnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:43:14 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E040F68C38; Fri, 26 Oct 2018 10:07:10 +0200 (CEST)
Date:   Fri, 26 Oct 2018 10:07:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com,
        Ming Lei <ming.lei@redhat.com>, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] block: fix the DISCARD request merge
Message-ID: <20181026080710.GA6495@lst.de>
References: <1540350450-15208-1-git-send-email-jianchao.w.wang@oracle.com> <52d2e36c-ed62-151d-e070-7edd06bfc24d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52d2e36c-ed62-151d-e070-7edd06bfc24d@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 04:05:00PM +0800, jianchao.wang wrote:
> Would anyone please take a look at this ?

I did take a look and reply to it..

> 
> Thanks in advance.
> Jianchao
> 
> On 10/24/18 11:07 AM, Jianchao Wang wrote:
> > There are two cases when handle DISCARD merge.
> > If max_discard_segments == 1, the bios/requests need to be contiguous
> > to merge. If max_discard_segments > 1, it takes every bio as a range
> > and different range needn't to be contiguous.
> > 
> > But now, attempt_merge screws this up. It always consider contiguity
> > for DISCARD for the case max_discard_segments > 1 and cannot merge
> > contiguous DISCARD for the case max_discard_segments == 1, because
> > rq_attempt_discard_merge always returns false in this case.
> > This patch fixes both of the two cases above.
> > 
> > Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> > ---
> > 
> > V3:
> >  - Introduce blk_discard_mergable into attempt_merge and
> >    blk_try_merge.
> >  - Some comment changes.
> > 
> > V2:
> >  - Add max_discard_segments > 1 checking in attempt_merge.
> >  - Change patch title and comment.
> >  - Add more comment in attempt_merge
> > 
> >  block/blk-merge.c | 34 ++++++++++++++++++++++++----------
> >  1 file changed, 24 insertions(+), 10 deletions(-)
> > 
> > diff --git a/block/blk-merge.c b/block/blk-merge.c
> > index 42a4674..b258de0 100644
> > --- a/block/blk-merge.c
> > +++ b/block/blk-merge.c
> > @@ -714,6 +714,22 @@ static void blk_account_io_merge(struct request *req)
> >  		part_stat_unlock();
> >  	}
> >  }
> > +/*
> > + * Two cases of handling DISCARD merge:
> > + * If max_discard_segments > 1, the driver takes every bio
> > + * as a range and send them to controller together. The ranges
> > + * needn't to be contiguous.
> > + * Otherwise, the bios/requests will be handled as same as
> > + * others which should be contiguous.
> > + */
> > +static inline bool blk_discard_mergable(struct request *req)
> > +{
> > +	if (req_op(req) == REQ_OP_DISCARD &&
> > +	    queue_max_discard_segments(req->q) > 1)
> > +		return true;
> > +	else
> > +		return false;
> > +}
> >  
> >  /*
> >   * For non-mq, this has to be called with the request spinlock acquired.
> > @@ -731,12 +747,6 @@ static struct request *attempt_merge(struct request_queue *q,
> >  	if (req_op(req) != req_op(next))
> >  		return NULL;
> >  
> > -	/*
> > -	 * not contiguous
> > -	 */
> > -	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next))
> > -		return NULL;
> > -
> >  	if (rq_data_dir(req) != rq_data_dir(next)
> >  	    || req->rq_disk != next->rq_disk
> >  	    || req_no_special_merge(next))
> > @@ -760,11 +770,16 @@ static struct request *attempt_merge(struct request_queue *q,
> >  	 * counts here. Handle DISCARDs separately, as they
> >  	 * have separate settings.
> >  	 */
> > -	if (req_op(req) == REQ_OP_DISCARD) {
> > +
> > +	if (blk_discard_mergable(req)) {
> >  		if (!req_attempt_discard_merge(q, req, next))
> >  			return NULL;
> > -	} else if (!ll_merge_requests_fn(q, req, next))
> > +	} else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next)) {
> > +		if (!ll_merge_requests_fn(q, req, next))
> > +			return NULL;
> > +	} else {
> >  		return NULL;
> > +	}
> >  
> >  	/*
> >  	 * If failfast settings disagree or any of the two is already
> > @@ -888,8 +903,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
> >  
> >  enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
> >  {
> > -	if (req_op(rq) == REQ_OP_DISCARD &&
> > -	    queue_max_discard_segments(rq->q) > 1)
> > +	if (blk_discard_mergable(rq))
> >  		return ELEVATOR_DISCARD_MERGE;
> >  	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
> >  		return ELEVATOR_BACK_MERGE;
> > 
---end quoted text---
