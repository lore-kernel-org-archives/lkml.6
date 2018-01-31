Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753297AbeAaQCC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 11:02:02 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46568 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbeAaQCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 11:02:00 -0500
Date: Wed, 31 Jan 2018 17:01:56 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Yang Shi <yang.shi@linux.alibaba.com>
cc: longman@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 v4] lib: debugobjects: handle objects free in a batch
 outside the loop
In-Reply-To: <1516839468-3431-2-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1801311644120.9911@nanos.tec.linutronix.de>
References: <1516839468-3431-1-git-send-email-yang.shi@linux.alibaba.com> <1516839468-3431-2-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2018, Yang Shi wrote:

> There are nested loops on debug objects free path, sometimes it may take
> over hundred thousands of loops, then cause soft lockup with
> !CONFIG_PREEMPT occasionally, like below:
> 
> NMI watchdog: BUG: soft lockup - CPU#15 stuck for 22s! [stress-ng-getde:110342]
> 
>  CPU: 15 PID: 110342 Comm: stress-ng-getde Tainted: G
> E   4.9.44-003.ali3000.alios7.x86_64.debug #1
>  Hardware name: Dell Inc. PowerEdge R720xd/0X6FFV, BIOS
> 1.6.0 03/07/2013
>  task: ffff884cbb0d0000 task.stack: ffff884cabc70000
>  RIP: 0010:[<ffffffff817d647b>]  [<ffffffff817d647b>]
> _raw_spin_unlock_irqrestore+0x3b/0x60
>  RSP: 0018:ffff884cabc77b78  EFLAGS: 00000292
>  RAX: ffff884cbb0d0000 RBX: 0000000000000292 RCX: 0000000000000000
>  RDX: ffff884cbb0d0000 RSI: 0000000000000001 RDI: 0000000000000292
>  RBP: ffff884cabc77b88 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff8357a0d8
>  R13: ffff884cabc77bc8 R14: ffffffff8357a0d0 R15: 00000000000000fc
>  FS:  00002aee845fd2c0(0000) GS:ffff8852bd400000(0000)
> knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000002991808 CR3: 0000005123abf000 CR4: 00000000000406e0
>  Stack:
>   ffff884ff4fe0000 ffff884ff4fd8000 ffff884cabc77c00 ffffffff8141177e
>   0000000000000202 ffff884cbb0d0000 ffff884cabc77bc8 0000000000000006
>   ffff884ff4fda000 ffffffff8357a0d8 0000000000000000 91f5d976f6020b6c

Please trim that. The register content is not really interesting

> @@ -186,11 +199,25 @@ static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
>  static void free_obj_work(struct work_struct *work)
>  {
>  	struct debug_obj *objs[ODEBUG_FREE_BATCH];
> +	struct hlist_node *tmp;
> +	struct debug_obj *obj;
>  	unsigned long flags;
>  	int i;
>  
>  	if (!raw_spin_trylock_irqsave(&pool_lock, flags))
>  		return;
> +
> +	/* Move free obj to pool list from global free list */

If the pool is full, why would you shuffle those objects to the pool list
first just to free them 10 lines further down?

> +	if (obj_free > 0) {

  obj_nr_tofree might be a more descriptive name for this variable

> +		hlist_for_each_entry_safe(obj, tmp, &obj_to_free, node) {
> +			hlist_del(&obj->node);
> +			hlist_add_head(&obj->node, &obj_pool);
> +			obj_pool_free++;
> +			obj_pool_used--;
> +			obj_free--;
> +		}
> +	}

The other thing here is that this whole list walk operation happens with
the pool lock held and interrupts disabled. That's suboptimal at best.

So the right thing to do here is:

	HLIST_HEAD(tofree);
		
  	if (!raw_spin_trylock_irqsave(&pool_lock, flags))
  		return;

	while (obj_pool_free < debug_objects_pool_size) {
		if (!obj_nr_tofree)
			break:
		hlist_del(...)
		hlist_add(...)
	}

	if (obj_nr_tofree) {
		hlist_move_list(&obj_to_free, &freelist);
		....
	}

	while (obj_pool_free >= debug_objects_pool_size + ODEBUG_FREE_BATCH) {
	      ....
	}

	raw_spin_unlock_irqrestore(&pool_lock, flags);

	hlist_for_each_entry_safe(obj, tmp, &tofree, node) {
		hlist_del();
		kmem_cache_free(....);
	}

That way you minimize the lock held times and spare pointless list walks
and shuffling.

Thanks,

	tglx
