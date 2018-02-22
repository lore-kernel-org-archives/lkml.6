Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933276AbeBVQDP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:03:15 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:47064 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933068AbeBVQDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:03:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0SyMKCt._1519315380;
Subject: Re: [PATCH] [v2] debugobjects: fix debug_objects_freed accounting
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
References: <20180222155335.1647466-1-arnd@arndb.de>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <f5507df5-eb0a-60d7-1122-6b4a324681dd@linux.alibaba.com>
Date: Thu, 22 Feb 2018 08:02:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180222155335.1647466-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/18 7:52 AM, Arnd Bergmann wrote:
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

Thanks for catching this.

Acked-by: Yang Shi <yang.shi@linux.alibaba.com>

> ---
>   lib/debugobjects.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index faab2c4ea024..105ecfc47d8c 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -233,6 +233,7 @@ static void free_obj_work(struct work_struct *work)
>   	 */
>   	if (obj_nr_tofree) {
>   		hlist_move_list(&obj_to_free, &tofree);
> +		debug_objects_freed += obj_nr_tofree;
>   		obj_nr_tofree = 0;
>   	}
>   	raw_spin_unlock_irqrestore(&pool_lock, flags);
