Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965345AbeCSRwG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 13:52:06 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:41744 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965837AbeCSRv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 13:51:59 -0400
X-Google-Smtp-Source: AG47ELsVuzoRn300rA+Jd52YbJ70SpoV3wvrEvLURc3FoTyERp93yLo+ze6pl+c6ToxcZKem7tuslw==
Date: Mon, 19 Mar 2018 10:51:57 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: "Li,Rongqing" <lirongqing@baidu.com>
cc: Michal Hocko <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_=E7=AD=94=E5=A4=8D=3A_=5BPATCH=5D_mm=2Fmemcontrol=2Ec=3A_speed_up_to_force_empty_a_memory_cgroup?=
In-Reply-To: <2AD939572F25A448A3AE3CAEA61328C2374589DC@BC-MAIL-M28.internal.baidu.com>
Message-ID: <alpine.DEB.2.20.1803191044310.177918@chino.kir.corp.google.com>
References: <1521448170-19482-1-git-send-email-lirongqing@baidu.com> <20180319085355.GQ23100@dhcp22.suse.cz> <2AD939572F25A448A3AE3CAEA61328C23745764B@BC-MAIL-M28.internal.baidu.com> <20180319103756.GV23100@dhcp22.suse.cz>
 <2AD939572F25A448A3AE3CAEA61328C2374589DC@BC-MAIL-M28.internal.baidu.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2018, Li,Rongqing wrote:

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
> > Can you actually measure this to be the culprit. Because we should rethink
> > our call path if it is too complicated/deep to perform well.
> > Adding arbitrary batch sizes doesn't sound like a good way to go to me.
> 
> Ok, I will try
> 

Looping in mem_cgroup_resize_limit(), which takes memcg_limit_mutex on 
every iteration which contends with lowering limits in other cgroups (on 
our systems, thousands), calling try_to_free_mem_cgroup_pages() with less 
than SWAP_CLUSTER_MAX is lame.  It would probably be best to limit the 
nr_pages to the amount that needs to be reclaimed, though, rather than 
over reclaiming.

If you wanted to be invasive, you could change page_counter_limit() to 
return the count - limit, fix up the callers that look for -EBUSY, and 
then use max(val, SWAP_CLUSTER_MAX) as your nr_pages.
