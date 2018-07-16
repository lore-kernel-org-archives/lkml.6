Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC68ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCBE208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BCBE208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeGPIYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:24:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:45896 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbeGPIYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:24:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 98E96ADBC;
        Mon, 16 Jul 2018 07:58:36 +0000 (UTC)
Date:   Mon, 16 Jul 2018 09:58:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: avoid bothering interrupted task when charge memcg
 in softirq
Message-ID: <20180716075836.GC17280@dhcp22.suse.cz>
References: <1531557122-12540-1-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531557122-12540-1-git-send-email-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 14-07-18 16:32:02, Yafang Shao wrote:
> try_charge maybe executed in packet receive path, which is in interrupt
> context.
> In this situation, the 'current' is the interrupted task, which may has
> no relation to the rx softirq, So it is nonsense to use 'current'.
> 
> Avoid bothering the interrupted if page_counter_try_charge failes.

I agree with Shakeel that this changelog asks for more information about
"why it matters". Small inconsistencies should be tolerable because the
state we rely on is so rarely set that it shouldn't make a visible
difference in practice.

> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  mm/memcontrol.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 68ef266..13f95db 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2123,6 +2123,9 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		goto retry;
>  	}
>  
> +	if (in_softirq())
> +		goto nomem;
> +

If anything would it make more sense to use in_interrupt() to be more
bullet proof for future?

>  	/*
>  	 * Unlike in global OOM situations, memcg is not in a physical
>  	 * memory shortage.  Allow dying and OOM-killed tasks to
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
