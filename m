Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB56C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4365420880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4365420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeILSyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:54:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:38870 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbeILSyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:54:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A081AF5B;
        Wed, 12 Sep 2018 13:50:00 +0000 (UTC)
Date:   Wed, 12 Sep 2018 15:49:59 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Li RongQing <lirongqing@baidu.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hannes@cmpxchg.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH] memcg: remove congestion wait when force empty
Message-ID: <20180912134959.GK10951@dhcp22.suse.cz>
References: <1536743960-19703-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536743960-19703-1-git-send-email-lirongqing@baidu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-09-18 17:19:20, Li RongQing wrote:
> memory.force_empty is used to empty a memory cgoup memory before
> rmdir it, avoid to charge those memory into parent cgroup

We do not reparent LRU pages on the memcg removal. We just keep
those pages around and reclaim them on the memory pressure. So the above
is not true anymore. You can use force_empty to release those pages
earlier though.

> when try_to_free_mem_cgroup_pages returns 0, guess there maybe be
> lots of writeback, so wait. but the waiting and sleep will called
> in shrink_inactive_list, based on numbers of isolated page, so
> remove this wait to reduce unnecessary delay

Have you ever seen this congestion_wait to be actually harmful?
You are right that the reclaim path already does sleep and we even wait
for pages under writeback for memcg v1. But there might be other reasons
why no pages are reclaimable at the moment and this congestion_wait is
meant to sleep for a while before retrying and running out of retries
too early.

That being said, the current code is not really great but could you
describe the actual problem you are seeing? 

> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  mm/memcontrol.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4ead5a4817de..35bd43eaa97e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2897,12 +2897,8 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
>  
>  		progress = try_to_free_mem_cgroup_pages(memcg, 1,
>  							GFP_KERNEL, true);
> -		if (!progress) {
> +		if (!progress)
>  			nr_retries--;
> -			/* maybe some writeback is necessary */
> -			congestion_wait(BLK_RW_ASYNC, HZ/10);
> -		}
> -
>  	}
>  
>  	return 0;
> -- 
> 2.16.2

-- 
Michal Hocko
SUSE Labs
