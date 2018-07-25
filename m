Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D758C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E1A2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E1A2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbeGYIui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:50:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:49784 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728357AbeGYIui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:50:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2353FADEF;
        Wed, 25 Jul 2018 07:40:11 +0000 (UTC)
Date:   Wed, 25 Jul 2018 09:40:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "zhaowuyun@wingtech.com" <zhaowuyun@wingtech.com>
Cc:     mgorman <mgorman@techsingularity.net>,
        akpm <akpm@linux-foundation.org>, minchan <minchan@kernel.org>,
        vinmenon <vinmenon@codeaurora.org>, hannes <hannes@cmpxchg.org>,
        "hillf.zj" <hillf.zj@alibaba-inc.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [PATCH] mm: disable preemption before swapcache_free
Message-ID: <20180725074009.GU28386@dhcp22.suse.cz>
References: <2018072514375722198958@wingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2018072514375722198958@wingtech.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25-07-18 14:37:58, zhaowuyun@wingtech.com wrote:
[...]
> Change-Id: I36d9df7ccff77c589b7157225410269c675a8504

What is this?

> Signed-off-by: zhaowuyun <zhaowuyun@wingtech.com>
> ---
> mm/vmscan.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>  
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2740973..acede002 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -674,6 +674,12 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
> BUG_ON(!PageLocked(page));
> BUG_ON(mapping != page_mapping(page));
> + /*
> + * preemption must be disabled to protect current task preempted before
> + * swapcache_free(swap) invoked by the task which do the
> + * __read_swap_cache_async job on the same page
> + */
> + preempt_disable();
> spin_lock_irqsave(&mapping->tree_lock, flags);

Hmm, but spin_lock_irqsave already implies the disabled preemption.
-- 
Michal Hocko
SUSE Labs
