Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A42C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B5C20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B5C20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeJPT4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:56:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:44056 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726718AbeJPT4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:56:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D06DEB030;
        Tue, 16 Oct 2018 12:05:54 +0000 (UTC)
Date:   Tue, 16 Oct 2018 14:05:54 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: Convert mem_cgroup_id::ref to refcount_t type
Message-ID: <20181016120554.GT18839@dhcp22.suse.cz>
References: <153910718919.7006.13400779039257185427.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153910718919.7006.13400779039257185427.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09-10-18 20:46:56, Kirill Tkhai wrote:
> This will allow to use generic refcount_t interfaces
> to check counters overflow instead of currently existing
> VM_BUG_ON(). The only difference after the patch is
> VM_BUG_ON() may cause BUG(), while refcount_t fires
> with WARN(). But this seems not to be significant here,
> since such the problems are usually caught by syzbot
> with panic-on-warn enabled.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h |    2 +-
>  mm/memcontrol.c            |   10 ++++------
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 4399cc3f00e4..7ab2120155a4 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -78,7 +78,7 @@ struct mem_cgroup_reclaim_cookie {
>  
>  struct mem_cgroup_id {
>  	int id;
> -	atomic_t ref;
> +	refcount_t ref;
>  };
>  
>  /*
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7bebe2ddec05..aa728d5b3d72 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4299,14 +4299,12 @@ static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
>  
>  static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
>  {
> -	VM_BUG_ON(atomic_read(&memcg->id.ref) <= 0);
> -	atomic_add(n, &memcg->id.ref);
> +	refcount_add(n, &memcg->id.ref);
>  }
>  
>  static void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
>  {
> -	VM_BUG_ON(atomic_read(&memcg->id.ref) < n);
> -	if (atomic_sub_and_test(n, &memcg->id.ref)) {
> +	if (refcount_sub_and_test(n, &memcg->id.ref)) {
>  		mem_cgroup_id_remove(memcg);
>  
>  		/* Memcg ID pins CSS */
> @@ -4523,7 +4521,7 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>  	}
>  
>  	/* Online state pins memcg ID, memcg ID pins CSS */
> -	atomic_set(&memcg->id.ref, 1);
> +	refcount_set(&memcg->id.ref, 1);
>  	css_get(css);
>  	return 0;
>  }
> @@ -6357,7 +6355,7 @@ subsys_initcall(mem_cgroup_init);
>  #ifdef CONFIG_MEMCG_SWAP
>  static struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
>  {
> -	while (!atomic_inc_not_zero(&memcg->id.ref)) {
> +	while (!refcount_inc_not_zero(&memcg->id.ref)) {
>  		/*
>  		 * The root cgroup cannot be destroyed, so it's refcount must
>  		 * always be >= 1.

-- 
Michal Hocko
SUSE Labs
