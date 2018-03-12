Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932415AbeCLVRu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 17:17:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:55508 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932242AbeCLVRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 17:17:49 -0400
Date: Mon, 12 Mar 2018 21:17:42 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 3/3] dcache: account external names as indirectly
 reclaimable memory
Message-ID: <20180312211742.GR30522@ZenIV.linux.org.uk>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305133743.12746-5-guro@fb.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 01:37:43PM +0000, Roman Gushchin wrote:
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 5c7df1df81ff..a0312d73f575 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -273,8 +273,16 @@ static void __d_free(struct rcu_head *head)
>  static void __d_free_external(struct rcu_head *head)
>  {
>  	struct dentry *dentry = container_of(head, struct dentry, d_u.d_rcu);
> -	kfree(external_name(dentry));
> -	kmem_cache_free(dentry_cache, dentry); 
> +	struct external_name *name = external_name(dentry);
> +	unsigned long bytes;
> +
> +	bytes = dentry->d_name.len + offsetof(struct external_name, name[1]);
> +	mod_node_page_state(page_pgdat(virt_to_page(name)),
> +			    NR_INDIRECTLY_RECLAIMABLE_BYTES,
> +			    -kmalloc_size(kmalloc_index(bytes)));
> +
> +	kfree(name);
> +	kmem_cache_free(dentry_cache, dentry);
>  }

That can't be right - external names can be freed in release_dentry_name_snapshot()
and copy_name() as well.  When do you want kfree_rcu() paths accounted for, BTW?
At the point where we are freeing them, or where we are scheduling their freeing?
