Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD17C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD91D22B56
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CN0oBidC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD91D22B56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933043AbeGFWtE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 18:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932439AbeGFWtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 18:49:03 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1330B22B54;
        Fri,  6 Jul 2018 22:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530917343;
        bh=THT9yM0/mf9c4k1eWeHDqmVMmZEjjf8teRRVVTvjbn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CN0oBidCWlCgJcbcN5GjyYZ11cX0fZtvElhVz4eLlqsQfQlikhoRZOWFggxzY1HnY
         n772Gf5aiadqR9s60IJORpeCNDNuco4X3rJK1fODHkhlcE2tPgVfTL2rr7aEDlSJf2
         X7IMwxXr9VBhAA1sIQoiC7djQ+Wrd6i3yNlaMrnE=
Date:   Fri, 6 Jul 2018 15:49:02 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v2] f2fs: give another chance to issue discard with
 current granularity
Message-ID: <20180706224902.GD77984@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180705061551.2961-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705061551.2961-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05, Chao Yu wrote:
> If discard IOs are blocked by user IO, do not skip to select and issue
> discard with lower granularity, retry with current granularity.

We need to stop as soon as possible since user activity comes. Later, discard
thread will try it again in another idle time. What's your concern?

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> - fix deadloop.
>  fs/f2fs/segment.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 1f9ae8270f86..6e2b2e717a40 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1191,7 +1191,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  	struct discard_cmd *dc, *tmp;
>  	struct blk_plug plug;
>  	int i, iter = 0, issued = 0;
> -	bool io_interrupted = false;
> +	bool io_interrupted = false, end_up = false;
>  
>  	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
>  		if (i + 1 < dpolicy->granularity)
> @@ -1199,6 +1199,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  		pend_list = &dcc->pend_list[i];
>  
>  		mutex_lock(&dcc->cmd_lock);
> +retry:
>  		if (list_empty(pend_list))
>  			goto next;
>  		if (unlikely(dcc->rbtree_check))
> @@ -1217,14 +1218,23 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>  			__submit_discard_cmd(sbi, dpolicy, dc);
>  			issued++;
>  skip:
> -			if (++iter >= dpolicy->max_requests)
> +			if (++iter >= dpolicy->max_requests) {
> +				end_up = true;
>  				break;
> +			}
>  		}
>  		blk_finish_plug(&plug);
> +
> +		/*
> +		 * if discard IO was interrupted by user IOs, give another
> +		 * chance to issue discard with current granularity.
> +		 */
> +		if (io_interrupted && !end_up)
> +			goto retry;
>  next:
>  		mutex_unlock(&dcc->cmd_lock);
>  
> -		if (iter >= dpolicy->max_requests)
> +		if (end_up)
>  			break;
>  	}
>  
> -- 
> 2.18.0.rc1
