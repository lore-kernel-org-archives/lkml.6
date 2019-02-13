Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7B8C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E957C21B1A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfBMDZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:25:22 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3193 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727346AbfBMDZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:25:21 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2011EF1FBB5C16EC2E4D;
        Wed, 13 Feb 2019 11:25:20 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Wed, 13 Feb 2019
 11:25:19 +0800
Subject: Re: [PATCH] f2fs: do not use mutex lock in atomic context
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1549267613-9288-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c98cbfcb-f45d-e9a9-5c2e-6730d0448e82@huawei.com>
Date:   Wed, 13 Feb 2019 11:25:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1549267613-9288-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/4 16:06, Sahitya Tummala wrote:
> Fix below warning coming because of using mutex lock in atomic context.
> 
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:98
> in_atomic(): 1, irqs_disabled(): 0, pid: 585, name: sh
> Preemption disabled at: __radix_tree_preload+0x28/0x130
> Call trace:
>  dump_backtrace+0x0/0x2b4
>  show_stack+0x20/0x28
>  dump_stack+0xa8/0xe0
>  ___might_sleep+0x144/0x194
>  __might_sleep+0x58/0x8c
>  mutex_lock+0x2c/0x48
>  f2fs_trace_pid+0x88/0x14c
>  f2fs_set_node_page_dirty+0xd0/0x184
> 
> Do not use f2fs_radix_tree_insert() to avoid doing cond_resched() with
> spin_lock() acquired.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  fs/f2fs/trace.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
> index ce2a5eb..d0ab533 100644
> --- a/fs/f2fs/trace.c
> +++ b/fs/f2fs/trace.c
> @@ -14,7 +14,7 @@
>  #include "trace.h"
>  
>  static RADIX_TREE(pids, GFP_ATOMIC);
> -static struct mutex pids_lock;
> +static spinlock_t pids_lock;
>  static struct last_io_info last_io;
>  
>  static inline void __print_last_io(void)
> @@ -58,23 +58,29 @@ void f2fs_trace_pid(struct page *page)
>  
>  	set_page_private(page, (unsigned long)pid);
>  
> +retry:
>  	if (radix_tree_preload(GFP_NOFS))
>  		return;
>  
> -	mutex_lock(&pids_lock);
> +	spin_lock(&pids_lock);
>  	p = radix_tree_lookup(&pids, pid);
>  	if (p == current)
>  		goto out;
>  	if (p)
>  		radix_tree_delete(&pids, pid);
>  
> -	f2fs_radix_tree_insert(&pids, pid, current);
> +	if (radix_tree_insert(&pids, pid, current)) {
> +		spin_unlock(&pids_lock);
> +		radix_tree_preload_end();
> +		cond_resched();
> +		goto retry;
> +	}
>  
>  	trace_printk("%3x:%3x %4x %-16s\n",
>  			MAJOR(inode->i_sb->s_dev), MINOR(inode->i_sb->s_dev),
>  			pid, current->comm);

Hi Sahitya,

Can trace_printk sleep? For safety, how about moving it out of spinlock?

Thanks,

>  out:
> -	mutex_unlock(&pids_lock);
> +	spin_unlock(&pids_lock);
>  	radix_tree_preload_end();
>  }
>  
> @@ -119,7 +125,7 @@ void f2fs_trace_ios(struct f2fs_io_info *fio, int flush)
>  
>  void f2fs_build_trace_ios(void)
>  {
> -	mutex_init(&pids_lock);
> +	spin_lock_init(&pids_lock);
>  }
>  
>  #define PIDVEC_SIZE	128
> @@ -147,7 +153,7 @@ void f2fs_destroy_trace_ios(void)
>  	pid_t next_pid = 0;
>  	unsigned int found;
>  
> -	mutex_lock(&pids_lock);
> +	spin_lock(&pids_lock);
>  	while ((found = gang_lookup_pids(pid, next_pid, PIDVEC_SIZE))) {
>  		unsigned idx;
>  
> @@ -155,5 +161,5 @@ void f2fs_destroy_trace_ios(void)
>  		for (idx = 0; idx < found; idx++)
>  			radix_tree_delete(&pids, pid[idx]);
>  	}
> -	mutex_unlock(&pids_lock);
> +	spin_unlock(&pids_lock);
>  }
> 

