Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932976AbeBUQf5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:35:57 -0500
Received: from resqmta-po-12v.sys.comcast.net ([96.114.154.171]:37598 "EHLO
        resqmta-po-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932880AbeBUQfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:35:55 -0500
Date: Wed, 21 Feb 2018 10:35:51 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Shakeel Butt <shakeelb@google.com>
cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] fs: fsnotify: account fsnotify metadata to
 kmemcg
In-Reply-To: <20180221030101.221206-4-shakeelb@google.com>
Message-ID: <alpine.DEB.2.20.1802211029080.13404@nuc-kabylake>
References: <20180221030101.221206-1-shakeelb@google.com> <20180221030101.221206-4-shakeelb@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfMHdd0LGot/zrxQ4rqTs5cMhgsmTyr6RkLXbJGlFLQCfYwa8dFg4e+HbOtfk9LQUalzgc55rbeisRmT61RN7BuN3Lm0A8WLrvr+gM/thorQmEfim/TxQ
 +Hsrxz1298aUYuG29A5/aaEI2pL6+/88VsGGKIJpAWcbVPzjJxL1r6FxCmKt3yqBUMmgi06PEx1cR1ybU+ogzYLx4u4G9uU/au/ODQhzc+PvqbkYmeDHY/Bo
 Lv0e5Wa8smLdq59Y3pH62lb3FDi6CreNQJ1AN+uRatZDMzL47+DJC/2j5d/nM8UbXIW1Gn2Oitao9Ng7YyMA05+UPvjnbJVYNNPj0DX1NV0jXIviiFcfsrQd
 VRjeVPF3DCbg/PGuXOya797ODJ3f15ILaU0MaQ5Qe9Curie/ytTrNxaShFfFkm472AZfkN6I4FttP27c+U+4NLI4SuoKQkX6oROEw0YY4C5yBEPqbBWIJb+I
 z2Bf6dAmr0W2SubbKXWJXLyDSl7cCUT1lFL9EL/BhvUDxoyE7l9y7bjJrAc15BxlLvTiN3XJzxWdFN2GvjUCj818aATopYHFEbbrUhyr74xxtt15rZnrxuf3
 sHopa1fkoJwV1F9ptMeUp1zpJ1PZM1U9Ak9GxkrlrUGaz4chh83SDoPnhrXOKHAXsBY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2018, Shakeel Butt wrote:

> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 6702a6a0bbb5..0d9493ebc7cd 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
>  	if (fanotify_is_perm_event(mask)) {
>  		struct fanotify_perm_event_info *pevent;
>
> -		pevent = kmem_cache_alloc(fanotify_perm_event_cachep,
> -					  GFP_KERNEL);
> +		pevent = kmem_cache_alloc_memcg(fanotify_perm_event_cachep,
> +						GFP_KERNEL, memcg);
>  		if (!pevent)

#1

> index 8b73332735ba..ed8e7b5f3981 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -98,7 +98,7 @@ int inotify_handle_event(struct fsnotify_group *group,
>  	i_mark = container_of(inode_mark, struct inotify_inode_mark,
>  			      fsn_mark);
>
> -	event = kmalloc(alloc_len, GFP_KERNEL);
> +	event = kmalloc_memcg(alloc_len, GFP_KERNEL, group->memcg);
>  	if (unlikely(!event))
>  		return -ENOMEM;

#2


So we have all this churn for those two allocations which are basically
the same code for two different notification schemes.

Could you store the task that is requesting the fsnotify action instead of
the memcg? Then do the allocation in the context of that task. That
reduces the modifications to fsnotify.
