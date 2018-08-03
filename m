Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300E2C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89962172D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89962172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbeHCIKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:10:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:52836 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729601AbeHCIKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:10:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6BB58ADF7;
        Fri,  3 Aug 2018 06:15:28 +0000 (UTC)
Date:   Fri, 3 Aug 2018 08:15:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-patch-test@lists.linaro.org
Subject: Re: [PATCH v1] mm:memcg: skip memcg of current in
 mem_cgroup_soft_limit_reclaim
Message-ID: <20180803061527.GA27245@dhcp22.suse.cz>
References: <1533275285-12387-1-git-send-email-zhaoyang.huang@spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533275285-12387-1-git-send-email-zhaoyang.huang@spreadtrum.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 03-08-18 13:48:05, Zhaoyang Huang wrote:
> for the soft_limit reclaim has more directivity than global reclaim, we
> have current memcg be skipped to avoid potential page thrashing.

a) this changelog doesn't really explain the problem nor does it explain
   why the proposed solution is reasonable or why it works at all and
b) no, this doesn't really work. You could easily break the current soft
   limit semantic.

I understand that you are not really happy about how the soft limit
works. Me neither but this whole interface is a huge mistake of past and
the general recommendation is to not use it. We simply cannot fix it
because it is unfixable. The semantic is just broken and somebody might
really depend on it.

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
> ---
>  mm/memcontrol.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8c0280b..9d09e95 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2537,12 +2537,21 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  			mz = mem_cgroup_largest_soft_limit_node(mctz);
>  		if (!mz)
>  			break;
> -
> +		/*
> +		 * skip current memcg to avoid page thrashing, for the
> +		 * mem_cgroup_soft_reclaim has more directivity than
> +		 * global reclaim.
> +		 */
> +		if (get_mem_cgroup_from_mm(current->mm) == mz->memcg) {
> +			reclaimed = 0;
> +			goto next;
> +		}
>  		nr_scanned = 0;
>  		reclaimed = mem_cgroup_soft_reclaim(mz->memcg, pgdat,
>  						    gfp_mask, &nr_scanned);
>  		nr_reclaimed += reclaimed;
>  		*total_scanned += nr_scanned;
> +next:
>  		spin_lock_irq(&mctz->lock);
>  		__mem_cgroup_remove_exceeded(mz, mctz);
>  
> -- 
> 1.9.1

-- 
Michal Hocko
SUSE Labs
