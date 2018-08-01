Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798CAC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311CE208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311CE208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388846AbeHANCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:02:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:36550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387576AbeHANCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:02:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E39B9ACB5;
        Wed,  1 Aug 2018 11:16:50 +0000 (UTC)
Date:   Wed, 1 Aug 2018 13:16:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Li RongQing <lirongqing@baidu.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH 2/2] fs/writeback: do memory cgroup related writeback
 firstly
Message-ID: <20180801111650.GI16767@dhcp22.suse.cz>
References: <1533120516-18279-1-git-send-email-lirongqing@baidu.com>
 <1533120516-18279-2-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533120516-18279-2-git-send-email-lirongqing@baidu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-08-18 18:48:36, Li RongQing wrote:
> When a machine has hundreds of memory cgroups, and some cgroups
> generate more or less dirty pages, but a cgroup of them has lots
> of memory pressure and always tries to reclaim dirty page, then it
> will trigger all cgroups to writeback, which is less efficient:
> 
> 1.if the used memory in a memory cgroup reaches its limit,
> it is useless to writeback other cgroups.
> 2.other cgroups can wait more time to merge write request
> 
> so replace the full flush with flushing writeback of memory cgroup
> whose tasks tries to reclaim memory and trigger writeback, if
> nothing is writeback, then fallback a full flush
> 
> After this patch, the writing performance enhance 5% in below setup:
>   $mount -t cgroup none -o memory /cgroups/memory/
>   $mkdir /cgroups/memory/x1
>   $echo $$ > /cgroups/memory/x1/tasks
>   $echo 100M > /cgroups/memory/x1/memory.limit_in_bytes
>   $cd /cgroups/memory/
>   $seq 10000|xargs  mkdir
>   $fio -filename=/home/test1 -direct=0 -iodepth 1 -thread -rw=write -ioengine=libaio -bs=16k -size=20G
> Before:
> WRITE: io=20480MB, aggrb=779031KB/s, minb=779031KB/s, maxb=779031KB/s, mint=26920msec, maxt=26920msec
> After:
> WRITE: io=20480MB, aggrb=831708KB/s, minb=831708KB/s, maxb=831708KB/s, mint=25215msec, maxt=25215msec

Have you tried v2 interface which should be much more effective when
flushing IO?

> And this patch can reduce io util in this condition, like there
> is two disks, one disks is used to store all kinds of logs, it
> should be less io pressure, and other is used to store hadoop data
> which will write lots of data to disk, but both disk io utils are
> high in fact, since when hadoop reclaims memory, it will wake all
> memory cgroup writeback.

This is not my domain and that might be the reason why the above doesn't
really explain what is going on here. But from my understanding the
flushing behavior for v1 is inherently suboptimal because we lack any
per memcg throttling and per cgroup writeback support. It seems that you
are just trying to paper over this limitation with another ad-hoc
measure.

I might be wrong here but I completely fail to see how this can help to
isolate flushing behavior to the memcg under the reclaim.
 
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  fs/fs-writeback.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 471d863958bc..475cada5d1cf 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -35,6 +35,11 @@
>   */
>  #define MIN_WRITEBACK_PAGES	(4096UL >> (PAGE_SHIFT - 10))
>  
> +/*
> + * if WB cgroup dirty pages is bigger than it, not start a full flush
> + */
> +#define MIN_WB_DIRTY_PAGES 64
> +
>  struct wb_completion {
>  	atomic_t		cnt;
>  };
> @@ -2005,6 +2010,32 @@ void wakeup_flusher_threads(enum wb_reason reason)
>  	if (blk_needs_flush_plug(current))
>  		blk_schedule_flush_plug(current);
>  
> +#ifdef CONFIG_CGROUP_WRITEBACK
> +	if (reason == WB_REASON_VMSCAN) {
> +		unsigned long tmp, pdirty = 0;
> +
> +		rcu_read_lock();
> +		list_for_each_entry_rcu(bdi, &bdi_list, bdi_list) {
> +			struct bdi_writeback *wb = wb_find_current(bdi);
> +
> +			if (wb) {
> +				tmp = mem_cgroup_wb_dirty_stats(wb);
> +				if (tmp) {
> +					pdirty += tmp;
> +					wb_start_writeback(wb, reason);
> +
> +					if (wb == &bdi->wb)
> +						pdirty += MIN_WB_DIRTY_PAGES;
> +				}
> +			}
> +		}
> +		rcu_read_unlock();
> +
> +		if (pdirty > MIN_WB_DIRTY_PAGES)
> +			return;
> +	}
> +#endif
> +
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(bdi, &bdi_list, bdi_list)
>  		__wakeup_flusher_threads_bdi(bdi, reason);
> -- 
> 2.16.2

-- 
Michal Hocko
SUSE Labs
