Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932737AbeCSKiJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 06:38:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:44313 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932415AbeCSKh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 06:37:59 -0400
Date: Mon, 19 Mar 2018 11:37:56 +0100
From: Michal Hocko <mhocko@kernel.org>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?=
 mm/memcontrol.c: speed up to force empty a memory cgroup
Message-ID: <20180319103756.GV23100@dhcp22.suse.cz>
References: <1521448170-19482-1-git-send-email-lirongqing@baidu.com>
 <20180319085355.GQ23100@dhcp22.suse.cz>
 <2AD939572F25A448A3AE3CAEA61328C23745764B@BC-MAIL-M28.internal.baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2AD939572F25A448A3AE3CAEA61328C23745764B@BC-MAIL-M28.internal.baidu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 19-03-18 10:00:41, Li,Rongqing wrote:
> 
> 
> > -----邮件原件-----
> > 发件人: Michal Hocko [mailto:mhocko@kernel.org]
> > 发送时间: 2018年3月19日 16:54
> > 收件人: Li,Rongqing <lirongqing@baidu.com>
> > 抄送: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > cgroups@vger.kernel.org; hannes@cmpxchg.org; Andrey Ryabinin
> > <aryabinin@virtuozzo.com>
> > 主题: Re: [PATCH] mm/memcontrol.c: speed up to force empty a memory
> > cgroup
> > 
> > On Mon 19-03-18 16:29:30, Li RongQing wrote:
> > > mem_cgroup_force_empty() tries to free only 32 (SWAP_CLUSTER_MAX)
> > > pages on each iteration, if a memory cgroup has lots of page cache, it
> > > will take many iterations to empty all page cache, so increase the
> > > reclaimed number per iteration to speed it up. same as in
> > > mem_cgroup_resize_limit()
> > >
> > > a simple test show:
> > >
> > >   $dd if=aaa  of=bbb  bs=1k count=3886080
> > >   $rm -f bbb
> > >   $time echo 100000000 >/cgroup/memory/test/memory.limit_in_bytes
> > >
> > > Before: 0m0.252s ===> after: 0m0.178s
> > 
> > Andrey was proposing something similar [1]. My main objection was that his
> > approach might lead to over-reclaim. Your approach is more conservative
> > because it just increases the batch size. The size is still rather arbitrary. Same
> > as SWAP_CLUSTER_MAX but that one is a commonly used unit of reclaim in
> > the MM code.
> > 
> > I would be really curious about more detailed explanation why having a
> > larger batch yields to a better performance because we are doingg
> > SWAP_CLUSTER_MAX batches at the lower reclaim level anyway.
> > 
> 
> Although SWAP_CLUSTER_MAX is used at the lower level, but the call stack of 
> try_to_free_mem_cgroup_pages is too long, increase the nr_to_reclaim can reduce
> times of calling function[do_try_to_free_pages, shrink_zones, hrink_node ]
> 
> mem_cgroup_resize_limit
> --->try_to_free_mem_cgroup_pages:  .nr_to_reclaim = max(1024,  SWAP_CLUSTER_MAX),
>    ---> do_try_to_free_pages 
>      ---> shrink_zones
>       --->shrink_node
>        ---> shrink_node_memcg
>          ---> shrink_list          <-------loop will happen in this place [times=1024/32]
>            ---> shrink_page_list

Can you actually measure this to be the culprit. Because we should
rethink our call path if it is too complicated/deep to perform well.
Adding arbitrary batch sizes doesn't sound like a good way to go to me.
-- 
Michal Hocko
SUSE Labs
