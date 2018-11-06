Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6805CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C9920869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C9920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388836AbeKFX7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:59:21 -0500
Received: from mga17.intel.com ([192.55.52.151]:19365 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388284AbeKFX7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:59:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 06:33:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="103861303"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga004.fm.intel.com with ESMTP; 06 Nov 2018 06:33:50 -0800
Date:   Tue, 6 Nov 2018 07:31:43 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
Message-ID: <20181106143143.GA5977@localhost.localdomain>
References: <20181105102301.9752-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105102301.9752-1-jthumshirn@suse.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
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
> blocks.  This means that many of the segments in the SG list will have an
> offset into the page that is not 0 but will be a multiple of 4K.

I probably got this wrong, but I thought a 2M huge page was 512 regular
pages with a compound head, and offsets were from those regular pages
rather than from the head.

Overall though, the patch makes sense to me for this and other reasons.

Acked-by: Keith Busch <keith.busch@intel.com>

 
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
>  
>  	/*
> diff --git a/block/blk.h b/block/blk.h
> index a1841b8ff129..c85e53f21cdd 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -169,7 +169,7 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
>  static inline bool __bvec_gap_to_prev(struct request_queue *q,
>  		struct bio_vec *bprv, unsigned int offset)
>  {
> -	return offset ||
> +	return (offset & queue_virt_boundary(q)) ||
>  		((bprv->bv_offset + bprv->bv_len) & queue_virt_boundary(q));
>  }
>  
> -- 
