Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeCWC65 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 22:58:57 -0400
Received: from mx22.baidu.com ([220.181.50.185]:39083 "EHLO baidu.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751758AbeCWC64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 22:58:56 -0400
From: "Li,Rongqing" <lirongqing@baidu.com>
To: "Li,Rongqing" <lirongqing@baidu.com>, Michal Hocko <mhocko@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "Andrey Ryabinin" <aryabinin@virtuozzo.com>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF0gbW0vbWVtY29udHJvbC5jOiBzcGVl?=
 =?utf-8?Q?d_up_to_force_empty_a_memory_cgroup?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIG1tL21lbWNvbnRyb2wuYzogc3BlZWQgdXAgdG8g?=
 =?utf-8?Q?force_empty_a_memory_cgroup?=
Thread-Index: AQHTv1/VbuxxIhYpnkemi1IzBVlLeqPXTxaA//+IvQCAAIne0IAEx0wg
Date: Fri, 23 Mar 2018 02:58:36 +0000
Message-ID: <2AD939572F25A448A3AE3CAEA61328C2374832C1@BC-MAIL-M28.internal.baidu.com>
References: <1521448170-19482-1-git-send-email-lirongqing@baidu.com>
 <20180319085355.GQ23100@dhcp22.suse.cz>
 <2AD939572F25A448A3AE3CAEA61328C23745764B@BC-MAIL-M28.internal.baidu.com>
 <20180319103756.GV23100@dhcp22.suse.cz>
 <2AD939572F25A448A3AE3CAEA61328C2374589DC@BC-MAIL-M28.internal.baidu.com>
In-Reply-To: <2AD939572F25A448A3AE3CAEA61328C2374589DC@BC-MAIL-M28.internal.baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.31.62.19]
x-baidu-bdmsfe-datecheck: 1_BC-MAIL-HUB08_2018-03-23 10:58:49:967
x-baidu-bdmsfe-viruscheck: BC-MAIL-HUB08_GRAY_Inside_WithoutAtta_2018-03-23
 10:58:45:006
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2N2x4mL018394



> -----邮件原件-----
> 发件人: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] 代表 Li,Rongqing
> 发送时间: 2018年3月19日 18:52
> 收件人: Michal Hocko <mhocko@kernel.org>
> 抄送: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> cgroups@vger.kernel.org; hannes@cmpxchg.org; Andrey Ryabinin
> <aryabinin@virtuozzo.com>
> 主题: 答复: 答复: [PATCH] mm/memcontrol.c: speed up to force empty a
> memory cgroup
> 
> 
> 
> > -----邮件原件-----
> > 发件人: Michal Hocko [mailto:mhocko@kernel.org]
> > 发送时间: 2018年3月19日 18:38
> > 收件人: Li,Rongqing <lirongqing@baidu.com>
> > 抄送: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > cgroups@vger.kernel.org; hannes@cmpxchg.org; Andrey Ryabinin
> > <aryabinin@virtuozzo.com>
> > 主题: Re: 答复: [PATCH] mm/memcontrol.c: speed up to force empty a
> memory
> > cgroup
> >
> > On Mon 19-03-18 10:00:41, Li,Rongqing wrote:
> > >
> > >
> > > > -----邮件原件-----
> > > > 发件人: Michal Hocko [mailto:mhocko@kernel.org]
> > > > 发送时间: 2018年3月19日 16:54
> > > > 收件人: Li,Rongqing <lirongqing@baidu.com>
> > > > 抄送: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > > > cgroups@vger.kernel.org; hannes@cmpxchg.org; Andrey Ryabinin
> > > > <aryabinin@virtuozzo.com>
> > > > 主题: Re: [PATCH] mm/memcontrol.c: speed up to force empty a
> > memory
> > > > cgroup
> > > >
> > > > On Mon 19-03-18 16:29:30, Li RongQing wrote:
> > > > > mem_cgroup_force_empty() tries to free only 32
> > (SWAP_CLUSTER_MAX)
> > > > > pages on each iteration, if a memory cgroup has lots of page
> > > > > cache, it will take many iterations to empty all page cache, so
> > > > > increase the reclaimed number per iteration to speed it up. same
> > > > > as in
> > > > > mem_cgroup_resize_limit()
> > > > >
> > > > > a simple test show:
> > > > >
> > > > >   $dd if=aaa  of=bbb  bs=1k count=3886080
> > > > >   $rm -f bbb
> > > > >   $time echo
> > 100000000 >/cgroup/memory/test/memory.limit_in_bytes
> > > > >
> > > > > Before: 0m0.252s ===> after: 0m0.178s
> > > >
> > > > Andrey was proposing something similar [1]. My main objection was
> > > > that his approach might lead to over-reclaim. Your approach is
> > > > more conservative because it just increases the batch size. The
> > > > size is still rather arbitrary. Same as SWAP_CLUSTER_MAX but that
> > > > one is a commonly used unit of reclaim in the MM code.
> > > >
> > > > I would be really curious about more detailed explanation why
> > > > having a larger batch yields to a better performance because we
> > > > are doingg SWAP_CLUSTER_MAX batches at the lower reclaim level
> anyway.
> > > >
> > >
> > > Although SWAP_CLUSTER_MAX is used at the lower level, but the call
> > > stack of try_to_free_mem_cgroup_pages is too long, increase the
> > > nr_to_reclaim can reduce times of calling
> > > function[do_try_to_free_pages, shrink_zones, hrink_node ]
> > >
> > > mem_cgroup_resize_limit
> > > --->try_to_free_mem_cgroup_pages:  .nr_to_reclaim = max(1024,
> > > --->SWAP_CLUSTER_MAX),
> > >    ---> do_try_to_free_pages
> > >      ---> shrink_zones
> > >       --->shrink_node
> > >        ---> shrink_node_memcg
> > >          ---> shrink_list          <-------loop will happen in this place
> > [times=1024/32]
> > >            ---> shrink_page_list
> >
> > Can you actually measure this to be the culprit. Because we should
> > rethink our call path if it is too complicated/deep to perform well.
> > Adding arbitrary batch sizes doesn't sound like a good way to go to me.
> 
> Ok, I will try
> 
http://pasted.co/4edbcfff

This is result from ftrace graph, it maybe prove that the deep call path leads to low performance.

And when increase reclaiming page in try_to_free_mem_cgroup_pages, it can reduce calling of shrink_slab, which save times, in my cases, page caches occupy most memory, slab is little, but shrink_slab will be called everytime

Mutex_lock 1 us

try_to_free_mem_cgroup_pages
  do_try_to_free_pages ! 185.020 us
    shrink_node  ! 116.529 us
      shrink_node_memcg   39.203
          shrink_inactive_list  33.960
      shrink_slab   72.955

    shrink_node  61.502 us
      shrink_node_memcg   3.955
      shrink_slab   54.296 us

-RongQing

> -RongQing
> > --
> > Michal Hocko
> > SUSE Labs
