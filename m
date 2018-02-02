Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753378AbeBBR74 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 12:59:56 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35044 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752803AbeBBR73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 12:59:29 -0500
X-Google-Smtp-Source: AH8x2257+NDdorp6v0KUybv4boJgCvLJJcCCgNBe8EDim/dc022t+vHl/L7bVXZsiGDkJL3azqgImw==
Message-ID: <1517594367.3715.130.camel@gmail.com>
Subject: Re: [PATCH net] Revert "defer call to mem_cgroup_sk_alloc()"
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Roman Gushchin <guro@fb.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, "David S . Miller" <davem@davemloft.net>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Date: Fri, 02 Feb 2018 09:59:27 -0800
In-Reply-To: <20180202165754.8551-1-guro@fb.com>
References: <20180202165754.8551-1-guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-02 at 16:57 +0000, Roman Gushchin wrote:
> This patch effectively reverts commit 9f1c2674b328 ("net: memcontrol:
> defer call to mem_cgroup_sk_alloc()").
> 
> Moving mem_cgroup_sk_alloc() to the inet_csk_accept() completely breaks
> memcg socket memory accounting, as packets received before memcg
> pointer initialization are not accounted and are causing refcounting
> underflow on socket release.
> 
> Actually the free-after-use problem was fixed by
> commit c0576e397508 ("net: call cgroup_sk_alloc() earlier in
> sk_clone_lock()") for the cgroup pointer.
> 
> So, let's revert it and call mem_cgroup_sk_alloc() just before
> cgroup_sk_alloc(). This is safe, as we hold a reference to the socket
> we're cloning, and it holds a reference to the memcg.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> ---
>  mm/memcontrol.c                 | 14 ++++++++++++++
>  net/core/sock.c                 |  5 +----
>  net/ipv4/inet_connection_sock.c |  1 -
>  3 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0ae2dc3a1748..0937f2c52c7d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5747,6 +5747,20 @@ void mem_cgroup_sk_alloc(struct sock *sk)
>  	if (!mem_cgroup_sockets_enabled)
>  		return;
>  
> +	/*
> +	 * Socket cloning can throw us here with sk_memcg already
> +	 * filled. It won't however, necessarily happen from
> +	 * process context. So the test for root memcg given
> +	 * the current task's memcg won't help us in this case.
> +	 *
> +	 * Respecting the original socket's memcg is a better
> +	 * decision in this case.
> +	 */
> +	if (sk->sk_memcg) {

Original commit had a BUG_ON(mem_cgroup_is_root(sk->sk_memcg));

I presume it is no longer useful ?

Thanks

> +		css_get(&sk->sk_memcg->css);
> +		return;
> +	}
> +
>  	rcu_read_lock();
