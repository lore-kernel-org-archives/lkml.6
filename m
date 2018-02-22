Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933136AbeBVQJ1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:09:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932952AbeBVQJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:09:26 -0500
Subject: Re: [PATCH] [v2] debugobjects: fix debug_objects_freed accounting
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
        Yang Shi <yang.shi@linux.alibaba.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
References: <20180222155335.1647466-1-arnd@arndb.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d251931d-0a8e-b525-ab1c-1adf291334ff@redhat.com>
Date: Thu, 22 Feb 2018 11:09:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180222155335.1647466-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 10:52 AM, Arnd Bergmann wrote:
> The removal of the batched object freeing has caused the debug_objects_freed
> to become read-only, and the reading is inside an ifdef, so gcc warns that it
> is completely unused without CONFIG_DEBUG_FS:
>
> lib/debugobjects.c:71:14: error: 'debug_objects_freed' defined but not used [-Werror=unused-variable]
>
> Assuming we are still interested in this number, this adds back code to
> keep track of the freed objects.
>
> Fixes: 636e1970fd7d ("debugobjects: Use global free list in free_object()")
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> --
> v2: simplify the counting as pointed out by Longman
> ---
>  lib/debugobjects.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index faab2c4ea024..105ecfc47d8c 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -233,6 +233,7 @@ static void free_obj_work(struct work_struct *work)
>  	 */
>  	if (obj_nr_tofree) {
>  		hlist_move_list(&obj_to_free, &tofree);
> +		debug_objects_freed += obj_nr_tofree;
>  		obj_nr_tofree = 0;
>  	}
>  	raw_spin_unlock_irqrestore(&pool_lock, flags);

Acked-by:  Waiman Long <longman@redhat.com>
