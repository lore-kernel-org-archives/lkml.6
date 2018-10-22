Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C2AC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C8920652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C8920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeJVRSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:18:37 -0400
Received: from verein.lst.de ([213.95.11.211]:35103 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbeJVRSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:18:37 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8242168BE1; Mon, 22 Oct 2018 11:00:58 +0200 (CEST)
Date:   Mon, 22 Oct 2018 11:00:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com, tom.leiming@gmail.com,
        hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] block: fix the DISCARD request merge
Message-ID: <20181022090058.GF18755@lst.de>
References: <1540045777-10290-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540045777-10290-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 10:29:37PM +0800, Jianchao Wang wrote:
> There are two cases when handle DISCARD merge
>  - max_discard_segments == 1
>    bios need to be contiguous
>  - max_discard_segments > 1
>    Only nvme right now. It takes every bio as a range and different
>    range needn't to be contiguous.
> 
> But now, attempt_merge screws this up. It always consider contiguity
> for DISCARD for the case max_discard_segments > 1 and cannot merge
> contiguous DISCARD for the case max_discard_segments == 1, because
> rq_attempt_discard_merge always returns false in this case.
> This patch fixes both of the two cases above.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
> 
> V2:
>   - Add max_discard_segments > 1 checking in attempt_merge
>   - Change patch title and comment
>   - Add more comment in attempt_merge
> 
>  block/blk-merge.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 42a4674..8f22374 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -734,8 +734,15 @@ static struct request *attempt_merge(struct request_queue *q,
>  	/*
>  	 * not contiguous
>  	 */
> -	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next))
> -		return NULL;
> +	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next)) {
> +		/*
> +		 * When max_discard_segments is bigger than 1 (only nvme right
> +		 * now), needn't consider the contiguity.
> +		 */
> +		if (!(req_op(req) == REQ_OP_DISCARD &&
> +		      queue_max_discard_segments(q) > 1))
> +			return NULL;

Why not:

		if (req_op(req) != REQ_OP_DISCARD ||
		    queue_max_discard_segments(q) == 1)

which would be a lot more obvious?

> +	 * counts here.
> +	 * Two cases of Handling DISCARD:
> +	 *  - max_discard_segments == 1
> +	 *    The bios need to be contiguous.
> +	 *  - max_discard_segments > 1
> +	 *    Only nvme right now. It takes every bio as a
> +	 *    range and send them to controller together. The ranges
> +	 *    needn't to be contiguous.

The formatting looks odd.  Also I don't think we should mention the
users here, as others might grow (virtio is in the pipe, SCSI could
be supported easily if someone did the work).
