Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964952AbeBLQZd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:25:33 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48664 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964875AbeBLQZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:25:32 -0500
Date: Mon, 12 Feb 2018 17:25:36 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Yang Shi <yang.shi@linux.alibaba.com>
cc: longman@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4 v6] lib: debugobjects: add global free list and the
 counter
In-Reply-To: <1517872708-24207-3-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1802121718270.1158@nanos.tec.linutronix.de>
References: <1517872708-24207-1-git-send-email-yang.shi@linux.alibaba.com> <1517872708-24207-3-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2018, Yang Shi wrote:
> +	/*
> +	 * Reuse objs from the global free list, they will be reinitialized
> +	 * when allocating
> +	 */
> +	while (obj_nr_tofree > 0 && (obj_pool_free < obj_pool_min_free)) {
> +		raw_spin_lock_irqsave(&pool_lock, flags);
> +		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);

This is racy vs. the worker thread. Assume obj_nr_tofree = 1:

CPU0					CPU1
worker
   lock(&pool_lock);			while (obj_nr_tofree > 0 && ...) {
     obj = hlist_entry(obj_to_free);	  lock(&pool_lock);
     hlist_del(obj);			  
     obj_nr_tofree--;
     ...
   unlock(&pool_lock);
					  obj = hlist_entry(obj_to_free);
					  hlist_del(obj); <------- NULL pointer dereference

Not what you want, right? The counter or the list head need to be rechecked
after the lock is acquired.

> +		hlist_del(&obj->node);
> +		obj_nr_tofree--;
> +		hlist_add_head(&obj->node, &obj_pool);
> +		obj_pool_free++;
> +		raw_spin_unlock_irqrestore(&pool_lock, flags);
> +	}

Thanks,

	tglx
