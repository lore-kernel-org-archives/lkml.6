Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753855AbeBLPv7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:51:59 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48570 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753535AbeBLPv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:51:57 -0500
Date: Mon, 12 Feb 2018 16:52:00 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Yang Shi <yang.shi@linux.alibaba.com>
cc: longman@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4 v6] lib: debugobjects: add global free list and the
 counter
In-Reply-To: <1517872708-24207-3-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1802121649490.1158@nanos.tec.linutronix.de>
References: <1517872708-24207-1-git-send-email-yang.shi@linux.alibaba.com> <1517872708-24207-3-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2018, Yang Shi wrote:
> +	/*
> +	 * The objs on the pool list might be allocated before the work is
> +	 * run, so recheck if pool list it full or not, if not fill pool
> +	 * list from the global free list
> +	 */
> +	while (obj_pool_free < debug_objects_pool_size) {
> +		if (obj_nr_tofree <= 0)
> +			break;
> +
> +		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
> +		hlist_del(&obj->node);
> +		hlist_add_head(&obj->node, &obj_pool);
> +		obj_pool_free++;
> +		obj_nr_tofree--;
> +	}
> +
> +	/*
> +	 * pool list is already full, and there are still objs on the free list,
> +	 * move remaining free objs to a separate list to free the memory later.
> +	 */
> +	if (obj_nr_tofree > 0) {
> +		hlist_move_list(&obj_to_free, &tofree);
> +		obj_nr_tofree = 0;
> +	}
> +
>  	while (obj_pool_free >= debug_objects_pool_size + ODEBUG_FREE_BATCH) {
>  		for (i = 0; i < ODEBUG_FREE_BATCH; i++) {
>  			objs[i] = hlist_entry(obj_pool.first,

This whole section is now pointless and can be removed. There is no way
that this code path can be entered after this change. Surplus objects are
on the obj_to_free list and not on the obj_pool itself.

Thanks,

	tglx
