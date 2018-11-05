Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BCEC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4C320819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4C320819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbeKEUPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:15:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbeKEUPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:15:09 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D65AA30820D8;
        Mon,  5 Nov 2018 10:56:01 +0000 (UTC)
Received: from ming.t460p (ovpn-8-33.pek2.redhat.com [10.72.8.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 75DEA104C529;
        Mon,  5 Nov 2018 10:55:54 +0000 (UTC)
Date:   Mon, 5 Nov 2018 18:55:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
Message-ID: <20181105105548.GC12367@ming.t460p>
References: <20181105102301.9752-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105102301.9752-1-jthumshirn@suse.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 05 Nov 2018 10:56:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 11:23:01AM +0100, Johannes Thumshirn wrote:
> With drivers like iSer we are seeing a lot of bio splitting and smaller I/Os
> being submitted to the driver.
> 
> The root cause of this issue that the virtual boundary mask code does not take
> into consideration that some of the memory segments in the SG list may have
> come from a huge memory page that is being managed in the SG list as 4K

I guess you mean something like 64K PAGE_SIZE, instead of huge page.

> blocks.  This means that many of the segments in the SG list will have an
> offset into the page that is not 0 but will be a multiple of 4K.
> 
> Cc: Jan Kara <jack@suse.cz>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/blk-merge.c | 2 +-
>  block/blk.h       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 6b5ad275ed56..208658a901c6 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -46,7 +46,7 @@ static inline bool bio_will_gap(struct request_queue *q,
>  		bio_get_first_bvec(prev_rq->bio, &pb);
>  	else
>  		bio_get_first_bvec(prev, &pb);
> -	if (pb.bv_offset)
> +	if (pb.bv_offset & queue_virt_boundary(q))
>  		return true;

The change should only make difference in case that PAGE_SIZE is bigger
than 4K. If yes, please add the description in commit log.


Thanks,
Ming
