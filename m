Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753872AbeBVN6P (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:58:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753855AbeBVN6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:58:14 -0500
Subject: Re: [PATCH] debugobjects: fix debug_objects_freed accounting
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
        Yang Shi <yang.shi@linux.alibaba.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
References: <20180222114558.1307380-1-arnd@arndb.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <26d1b3f2-fc7d-2644-5bdb-5238766fc4d4@redhat.com>
Date: Thu, 22 Feb 2018 08:58:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180222114558.1307380-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 06:45 AM, Arnd Bergmann wrote:
> The removal of the batched object freeing has caused the debug_objects_freed
> to become read-only, and the reading is inside an ifdef, so gcc warns that it
> is completely unused without CONFIG_DEBUG_FS:
>
> lib/debugobjects.c:71:14: error: 'debug_objects_freed' defined but not used [-Werror=unused-variable]
>
> Assuming we are still interested in this number, this adds back code to
> count every instance we are about to free while we still hold the spinlock.
>
> Fixes: 636e1970fd7d ("debugobjects: Use global free list in free_object()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  lib/debugobjects.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index faab2c4ea024..748288dba512 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -235,6 +235,9 @@ static void free_obj_work(struct work_struct *work)
>  		hlist_move_list(&obj_to_free, &tofree);

It would be simpler to just do:
               debug_objects_freed += obj_nr_tofree;

>  		obj_nr_tofree = 0;
>  	}
> +	hlist_for_each_entry(obj, &tofree, node)
> +		debug_objects_freed++;
> +
>  	raw_spin_unlock_irqrestore(&pool_lock, flags);
>  
>  	hlist_for_each_entry_safe(obj, tmp, &tofree, node) {

-Longman
