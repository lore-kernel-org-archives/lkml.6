Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161290AbeBNRfB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:35:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1161214AbeBNRe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:34:58 -0500
Date: Wed, 14 Feb 2018 18:34:51 +0100
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
        Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        dhowells@redhat.com, hannes@cmpxchg.org, brouer@redhat.com
Subject: Re: [PATCH net] bpf: cpumap: use GFP_KERNEL instead of GFP_ATOMIC
 in __cpu_map_entry_alloc()
Message-ID: <20180214183451.25252d72@redhat.com>
In-Reply-To: <20180214150640.GC3443@dhcp22.suse.cz>
References: <1518617854-4486-1-git-send-email-jasowang@redhat.com>
        <20180214150640.GC3443@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2018 16:06:40 +0100
Michal Hocko <mhocko@kernel.org> wrote:

> On Wed 14-02-18 22:17:34, Jason Wang wrote:
> > There're several implications after commit 0bf7800f1799 ("ptr_ring:
> > try vmalloc() when kmalloc() fails") with the using of vmalloc() since
> > can't allow GFP_ATOMIC but mandate GFP_KERNEL. This will lead a WARN
> > since cpumap try to call with GFP_ATOMIC. Fortunately, entry
> > allocation of cpumap can only be done through syscall path which means
> > GFP_ATOMIC is not necessary, so fixing this by replacing GFP_ATOMIC
> > with GFP_KERNEL.  
> 
> map_update_elem does the following. Unless I am missing something and
> the callback doesn't call cpu_map_update_elem there then we are in a
> non-preemptible context there and GFP_WAIT would blow up.
> 		rcu_read_lock();
> 		err = map->ops->map_update_elem(map, key, value, attr->flags);
> 		rcu_read_unlock();

Nope - you did miss something ;-)

You are looking at the wrong place.  Look at /kernel/bpf/syscall.c line 697.

 vim +697 kernel/bpf/syscall.c
 [...]
        } else if (map->map_type == BPF_MAP_TYPE_CPUMAP) {
                err = map->ops->map_update_elem(map, key, value, attr->flags);
                goto out;
        }

You missed that map type BPF_MAP_TYPE_CPUMAP is special cased, and
is moved outside rcu_read_{lock,unlock} (because it need to create some
kthreads).

Further more the BPF-verifier disallow BPF programs runtime changing
the BPF_MAP_TYPE_CPUMAP.  Right now, we disallow almost everything from
the bpf-side (even reading the value):

 vim +2057 kernel/bpf/verifier.c


> > Reported-by: syzbot+1a240cdb1f4cc88819df@syzkaller.appspotmail.com
> > Fixes: 0bf7800f1799 ("ptr_ring: try vmalloc() when kmalloc() fails")
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> > Cc: akpm@linux-foundation.org
> > Cc: dhowells@redhat.com
> > Cc: hannes@cmpxchg.org
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  kernel/bpf/cpumap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> > index fbfdada6..a4bb0b3 100644
> > --- a/kernel/bpf/cpumap.c
> > +++ b/kernel/bpf/cpumap.c
> > @@ -334,7 +334,7 @@ static int cpu_map_kthread_run(void *data)
> >  static struct bpf_cpu_map_entry *__cpu_map_entry_alloc(u32 qsize, u32 cpu,
> >  						       int map_id)
> >  {
> > -	gfp_t gfp = GFP_ATOMIC|__GFP_NOWARN;
> > +	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
> >  	struct bpf_cpu_map_entry *rcpu;
> >  	int numa, err;
> >  
> > -- 
> > 2.7.4  
> 



-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
