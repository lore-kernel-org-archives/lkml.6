Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4C5C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0902083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0902083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388435AbeHAMtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:49:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:34380 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387559AbeHAMtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:49:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0298AF54;
        Wed,  1 Aug 2018 11:03:56 +0000 (UTC)
Date:   Wed, 1 Aug 2018 13:03:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Li RongQing <lirongqing@baidu.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH 1/2] mm: add a function to return a bdi_writeback dirty
 page statistic
Message-ID: <20180801110356.GH16767@dhcp22.suse.cz>
References: <1533120516-18279-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533120516-18279-1-git-send-email-lirongqing@baidu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-08-18 18:48:35, Li RongQing wrote:
> this is a preparation to optimise a full writeback
> when reclaim memory

Please do not add unused functions. This makes review harder without a
good reason. Besides that we already have mem_cgroup_wb_stats. Why
cannot you reuse it?

> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  include/linux/memcontrol.h | 2 +-
>  mm/memcontrol.c            | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 6c6fb116e925..58e29555ac81 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1141,7 +1141,7 @@ struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb);
>  void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
>  			 unsigned long *pheadroom, unsigned long *pdirty,
>  			 unsigned long *pwriteback);
> -
> +unsigned long mem_cgroup_wb_dirty_stats(struct bdi_writeback *wb);
>  #else	/* CONFIG_CGROUP_WRITEBACK */
>  
>  static inline struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb)
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8c0280b3143e..82d3061e91d1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3640,6 +3640,12 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
>  	}
>  }
>  
> +unsigned long mem_cgroup_wb_dirty_stats(struct bdi_writeback *wb)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
> +
> +	return memcg_page_state(memcg, NR_FILE_DIRTY);
> +}
>  #else	/* CONFIG_CGROUP_WRITEBACK */
>  
>  static int memcg_wb_domain_init(struct mem_cgroup *memcg, gfp_t gfp)
> -- 
> 2.16.2

-- 
Michal Hocko
SUSE Labs
