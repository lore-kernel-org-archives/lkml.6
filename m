Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15428C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F80206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F80206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeLCL5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:57:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:60108 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbeLCL5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:57:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9D867AC66;
        Mon,  3 Dec 2018 11:56:46 +0000 (UTC)
Date:   Mon, 3 Dec 2018 12:56:46 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] mm/vmscan: Enable kswapd to reclaim low-protected
 memory
Message-ID: <20181203115646.GP31738@dhcp22.suse.cz>
References: <20181203080119.18989-1-xlpang@linux.alibaba.com>
 <20181203080119.18989-2-xlpang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203080119.18989-2-xlpang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 03-12-18 16:01:18, Xunlei Pang wrote:
> There may be cgroup memory overcommitment, it will become
> even common in the future.
> 
> Let's enable kswapd to reclaim low-protected memory in case
> of memory pressure, to mitigate the global direct reclaim
> pressures which could cause jitters to the response time of
> lantency-sensitive groups.

Please be more descriptive about the problem you are trying to handle
here. I haven't actually read the patch but let me emphasise that the
low limit protection is important isolation tool. And allowing kswapd to
reclaim protected memcgs is going to break the semantic as it has been
introduced and designed.

> 
> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
> ---
>  mm/vmscan.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 62ac0c488624..3d412eb91f73 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3531,6 +3531,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
>  
>  	count_vm_event(PAGEOUTRUN);
>  
> +retry:
>  	do {
>  		unsigned long nr_reclaimed = sc.nr_reclaimed;
>  		bool raise_priority = true;
> @@ -3622,6 +3623,13 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
>  			sc.priority--;
>  	} while (sc.priority >= 1);
>  
> +	if (!sc.nr_reclaimed && sc.memcg_low_skipped) {
> +		sc.priority = DEF_PRIORITY;
> +		sc.memcg_low_reclaim = 1;
> +		sc.memcg_low_skipped = 0;
> +		goto retry;
> +	}
> +
>  	if (!sc.nr_reclaimed)
>  		pgdat->kswapd_failures++;
>  
> -- 
> 2.13.5 (Apple Git-94)
> 

-- 
Michal Hocko
SUSE Labs
