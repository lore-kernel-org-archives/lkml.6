Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031115AbeBNPGp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:06:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:37102 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031006AbeBNPGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:06:43 -0500
Date: Wed, 14 Feb 2018 16:06:40 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>, akpm@linux-foundation.org,
        dhowells@redhat.com, hannes@cmpxchg.org
Subject: Re: [PATCH net] bpf: cpumap: use GFP_KERNEL instead of GFP_ATOMIC in
 __cpu_map_entry_alloc()
Message-ID: <20180214150640.GC3443@dhcp22.suse.cz>
References: <1518617854-4486-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518617854-4486-1-git-send-email-jasowang@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-02-18 22:17:34, Jason Wang wrote:
> There're several implications after commit 0bf7800f1799 ("ptr_ring:
> try vmalloc() when kmalloc() fails") with the using of vmalloc() since
> can't allow GFP_ATOMIC but mandate GFP_KERNEL. This will lead a WARN
> since cpumap try to call with GFP_ATOMIC. Fortunately, entry
> allocation of cpumap can only be done through syscall path which means
> GFP_ATOMIC is not necessary, so fixing this by replacing GFP_ATOMIC
> with GFP_KERNEL.

map_update_elem does the following. Unless I am missing something and
the callback doesn't call cpu_map_update_elem there then we are in a
non-preemptible context there and GFP_WAIT would blow up.
		rcu_read_lock();
		err = map->ops->map_update_elem(map, key, value, attr->flags);
		rcu_read_unlock();

> Reported-by: syzbot+1a240cdb1f4cc88819df@syzkaller.appspotmail.com
> Fixes: 0bf7800f1799 ("ptr_ring: try vmalloc() when kmalloc() fails")
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Cc: akpm@linux-foundation.org
> Cc: dhowells@redhat.com
> Cc: hannes@cmpxchg.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  kernel/bpf/cpumap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index fbfdada6..a4bb0b3 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -334,7 +334,7 @@ static int cpu_map_kthread_run(void *data)
>  static struct bpf_cpu_map_entry *__cpu_map_entry_alloc(u32 qsize, u32 cpu,
>  						       int map_id)
>  {
> -	gfp_t gfp = GFP_ATOMIC|__GFP_NOWARN;
> +	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
>  	struct bpf_cpu_map_entry *rcpu;
>  	int numa, err;
>  
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
