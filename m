Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161582AbeBNR6p (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:58:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:50596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161508AbeBNR6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:58:41 -0500
Date: Wed, 14 Feb 2018 18:58:38 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
        Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        dhowells@redhat.com, hannes@cmpxchg.org
Subject: Re: [PATCH net] bpf: cpumap: use GFP_KERNEL instead of GFP_ATOMIC in
 __cpu_map_entry_alloc()
Message-ID: <20180214175838.GA7275@dhcp22.suse.cz>
References: <1518617854-4486-1-git-send-email-jasowang@redhat.com>
 <20180214150640.GC3443@dhcp22.suse.cz>
 <20180214183451.25252d72@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214183451.25252d72@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-02-18 18:34:51, Jesper Dangaard Brouer wrote:
> On Wed, 14 Feb 2018 16:06:40 +0100
> Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Wed 14-02-18 22:17:34, Jason Wang wrote:
> > > There're several implications after commit 0bf7800f1799 ("ptr_ring:
> > > try vmalloc() when kmalloc() fails") with the using of vmalloc() since
> > > can't allow GFP_ATOMIC but mandate GFP_KERNEL. This will lead a WARN
> > > since cpumap try to call with GFP_ATOMIC. Fortunately, entry
> > > allocation of cpumap can only be done through syscall path which means
> > > GFP_ATOMIC is not necessary, so fixing this by replacing GFP_ATOMIC
> > > with GFP_KERNEL.  
> > 
> > map_update_elem does the following. Unless I am missing something and
> > the callback doesn't call cpu_map_update_elem there then we are in a
> > non-preemptible context there and GFP_WAIT would blow up.
> > 		rcu_read_lock();
> > 		err = map->ops->map_update_elem(map, key, value, attr->flags);
> > 		rcu_read_unlock();
> 
> Nope - you did miss something ;-)
> 
> You are looking at the wrong place.  Look at /kernel/bpf/syscall.c line 697.
> 
>  vim +697 kernel/bpf/syscall.c
>  [...]
>         } else if (map->map_type == BPF_MAP_TYPE_CPUMAP) {
>                 err = map->ops->map_update_elem(map, key, value, attr->flags);
>                 goto out;
>         }
> 
> You missed that map type BPF_MAP_TYPE_CPUMAP is special cased, and
> is moved outside rcu_read_{lock,unlock} (because it need to create some
> kthreads).
> 
> Further more the BPF-verifier disallow BPF programs runtime changing
> the BPF_MAP_TYPE_CPUMAP.  Right now, we disallow almost everything from
> the bpf-side (even reading the value):
> 
>  vim +2057 kernel/bpf/verifier.c

OK, thanks for the clarification. I am not familiar with the code at all
so I was merely looking at call sites and this one just hit my eyes.

-- 
Michal Hocko
SUSE Labs
