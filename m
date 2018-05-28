Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940507AbeE1RBP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 13:01:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940495AbeE1RBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 13:01:09 -0400
Date: Mon, 28 May 2018 10:01:08 -0700
From: Matthew Wilcox <willy@infradead.org>
To: John Johansen <john.johansen@canonical.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use an IDR to allocate apparmor secids
Message-ID: <20180528170108.GA5448@bombadil.infradead.org>
References: <20180522093259.GA30182@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522093259.GA30182@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ping?

I have this queued up in my XArray tree.  If I don't hear from you before
-rc1, I'll be submitting it as part of the XArray conversion.

On Tue, May 22, 2018 at 02:32:59AM -0700, Matthew Wilcox wrote:
> Replace the custom usage of the radix tree to store a list of free IDs
> with the IDR.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> 
>  security/apparmor/secid.c |  114 ++++------------------------------------------
>  1 file changed, 11 insertions(+), 103 deletions(-)
> 
> diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
> index c2f0c1571156..3ad94b2ffbb2 100644
> --- a/security/apparmor/secid.c
> +++ b/security/apparmor/secid.c
> @@ -18,6 +18,7 @@
>  #include <linux/errno.h>
>  #include <linux/err.h>
>  #include <linux/gfp.h>
> +#include <linux/idr.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  
> @@ -30,18 +31,10 @@
>  /*
>   * secids - do not pin labels with a refcount. They rely on the label
>   * properly updating/freeing them
> - *
> - * A singly linked free list is used to track secids that have been
> - * freed and reuse them before allocating new ones
>   */
>  
> -#define FREE_LIST_HEAD 1
> -
> -static RADIX_TREE(aa_secids_map, GFP_ATOMIC);
> +static DEFINE_IDR(aa_secids);
>  static DEFINE_SPINLOCK(secid_lock);
> -static u32 alloced_secid = FREE_LIST_HEAD;
> -static u32 free_list = FREE_LIST_HEAD;
> -static unsigned long free_count;
>  
>  /*
>   * TODO: allow policy to reserve a secid range?
> @@ -49,65 +42,6 @@ static unsigned long free_count;
>   * TODO: use secid_update in label replace
>   */
>  
> -#define SECID_MAX U32_MAX
> -
> -/* TODO: mark free list as exceptional */
> -static void *to_ptr(u32 secid)
> -{
> -	return (void *)
> -		((((unsigned long) secid) << RADIX_TREE_EXCEPTIONAL_SHIFT));
> -}
> -
> -static u32 to_secid(void *ptr)
> -{
> -	return (u32) (((unsigned long) ptr) >> RADIX_TREE_EXCEPTIONAL_SHIFT);
> -}
> -
> -
> -/* TODO: tag free_list entries to mark them as different */
> -static u32 __pop(struct aa_label *label)
> -{
> -	u32 secid = free_list;
> -	void __rcu **slot;
> -	void *entry;
> -
> -	if (free_list == FREE_LIST_HEAD)
> -		return AA_SECID_INVALID;
> -
> -	slot = radix_tree_lookup_slot(&aa_secids_map, secid);
> -	AA_BUG(!slot);
> -	entry = radix_tree_deref_slot_protected(slot, &secid_lock);
> -	free_list = to_secid(entry);
> -	radix_tree_replace_slot(&aa_secids_map, slot, label);
> -	free_count--;
> -
> -	return secid;
> -}
> -
> -static void __push(u32 secid)
> -{
> -	void __rcu **slot;
> -
> -	slot = radix_tree_lookup_slot(&aa_secids_map, secid);
> -	AA_BUG(!slot);
> -	radix_tree_replace_slot(&aa_secids_map, slot, to_ptr(free_list));
> -	free_list = secid;
> -	free_count++;
> -}
> -
> -static struct aa_label * __secid_update(u32 secid, struct aa_label *label)
> -{
> -	struct aa_label *old;
> -	void __rcu **slot;
> -
> -	slot = radix_tree_lookup_slot(&aa_secids_map, secid);
> -	AA_BUG(!slot);
> -	old = radix_tree_deref_slot_protected(slot, &secid_lock);
> -	radix_tree_replace_slot(&aa_secids_map, slot, label);
> -
> -	return old;
> -}
> -
>  /**
>   * aa_secid_update - update a secid mapping to a new label
>   * @secid: secid to update
> @@ -115,11 +49,10 @@ static struct aa_label * __secid_update(u32 secid, struct aa_label *label)
>   */
>  void aa_secid_update(u32 secid, struct aa_label *label)
>  {
> -	struct aa_label *old;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&secid_lock, flags);
> -	old = __secid_update(secid, label);
> +	idr_replace(&aa_secids, label, secid);
>  	spin_unlock_irqrestore(&secid_lock, flags);
>  }
>  
> @@ -132,7 +65,7 @@ struct aa_label *aa_secid_to_label(u32 secid)
>  	struct aa_label *label;
>  
>  	rcu_read_lock();
> -	label = radix_tree_lookup(&aa_secids_map, secid);
> +	label = idr_find(&aa_secids, secid);
>  	rcu_read_unlock();
>  
>  	return label;
> @@ -167,7 +100,6 @@ int apparmor_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>  	return 0;
>  }
>  
> -
>  int apparmor_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
>  {
>  	struct aa_label *label;
> @@ -186,7 +118,6 @@ void apparmor_release_secctx(char *secdata, u32 seclen)
>  	kfree(secdata);
>  }
>  
> -
>  /**
>   * aa_alloc_secid - allocate a new secid for a profile
>   */
> @@ -195,35 +126,12 @@ u32 aa_alloc_secid(struct aa_label *label, gfp_t gfp)
>  	unsigned long flags;
>  	u32 secid;
>  
> -	/* racey, but at worst causes new allocation instead of reuse */
> -	if (free_list == FREE_LIST_HEAD) {
> -		bool preload = 0;
> -		int res;
> -
> -retry:
> -		if (gfpflags_allow_blocking(gfp) && !radix_tree_preload(gfp))
> -			preload = 1;
> -		spin_lock_irqsave(&secid_lock, flags);
> -		if (alloced_secid != SECID_MAX) {
> -			secid = ++alloced_secid;
> -			res = radix_tree_insert(&aa_secids_map, secid, label);
> -			AA_BUG(res == -EEXIST);
> -		} else {
> -			secid = AA_SECID_INVALID;
> -		}
> -		spin_unlock_irqrestore(&secid_lock, flags);
> -		if (preload)
> -			radix_tree_preload_end();
> -	} else {
> -		spin_lock_irqsave(&secid_lock, flags);
> -		/* remove entry from free list */
> -		secid = __pop(label);
> -		if (secid == AA_SECID_INVALID) {
> -			spin_unlock_irqrestore(&secid_lock, flags);
> -			goto retry;
> -		}
> -		spin_unlock_irqrestore(&secid_lock, flags);
> -	}
> +	idr_preload(gfp);
> +	spin_lock_irqsave(&secid_lock, flags);
> +	secid = idr_alloc(&aa_secids, label, 0, 0, GFP_ATOMIC);
> +	/* XXX: Can return -ENOMEM */
> +	spin_unlock_irqrestore(&secid_lock, flags);
> +	idr_preload_end();
>  
>  	return secid;
>  }
> @@ -237,6 +145,6 @@ void aa_free_secid(u32 secid)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&secid_lock, flags);
> -	__push(secid);
> +	idr_remove(&aa_secids, secid);
>  	spin_unlock_irqrestore(&secid_lock, flags);
>  }
> 
