Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E047FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF86E222DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550160636;
	bh=YBHqDtMsjWetectlm9T2hWO8robenBzYj8k7/Tfam78=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=OVo8oRKx8ECzbb8tW1s60Qek1aPQMruV9KHsSPJwD1oYhwtr633Ev3qgzNoq6ZCtk
	 4jiLPow+U6hNKq9rtj+1RwEwaIJ/YXmT9y6imtBguvmzBhbJGvqmCd9jogw9li4OvJ
	 veHFcDkWHDoolmJ0o40q/buoj8wWQsvnMIeMufWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502617AbfBNQKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:10:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfBNQKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:10:34 -0500
Received: from [192.168.0.101] (unknown [49.77.183.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A686B222DC;
        Thu, 14 Feb 2019 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550160633;
        bh=YBHqDtMsjWetectlm9T2hWO8robenBzYj8k7/Tfam78=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ELrOI3065O0GUJM5byyS15f22XHp12K8xt/7961N3C4F4w9HF+YwNjchpDs41ZhGz
         ImZYrqAQhKS7uMBRfbXRK6KiJh2RDD/Xu/56V03gsRiYAbsF8kMkn4lAi0HP7Lu++s
         oz6vDqZeoR0Is08kgJd/jk7URZi2loRqFNJ4Csvk=
Subject: Re: [f2fs-dev] [PATCH] f2fs: do not use mutex lock in atomic context
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <1549267613-9288-1-git-send-email-stummala@codeaurora.org>
 <c98cbfcb-f45d-e9a9-5c2e-6730d0448e82@huawei.com>
 <20190214074628.GD7308@codeaurora.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <5650af07-c55d-fcb4-ca98-eca45248392d@kernel.org>
Date:   Fri, 15 Feb 2019 00:10:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190214074628.GD7308@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-2-14 15:46, Sahitya Tummala wrote:
> On Wed, Feb 13, 2019 at 11:25:31AM +0800, Chao Yu wrote:
>> On 2019/2/4 16:06, Sahitya Tummala wrote:
>>> Fix below warning coming because of using mutex lock in atomic context.
>>>
>>> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:98
>>> in_atomic(): 1, irqs_disabled(): 0, pid: 585, name: sh
>>> Preemption disabled at: __radix_tree_preload+0x28/0x130
>>> Call trace:
>>>  dump_backtrace+0x0/0x2b4
>>>  show_stack+0x20/0x28
>>>  dump_stack+0xa8/0xe0
>>>  ___might_sleep+0x144/0x194
>>>  __might_sleep+0x58/0x8c
>>>  mutex_lock+0x2c/0x48
>>>  f2fs_trace_pid+0x88/0x14c
>>>  f2fs_set_node_page_dirty+0xd0/0x184
>>>
>>> Do not use f2fs_radix_tree_insert() to avoid doing cond_resched() with
>>> spin_lock() acquired.
>>>
>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>> ---
>>>  fs/f2fs/trace.c | 20 +++++++++++++-------
>>>  1 file changed, 13 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
>>> index ce2a5eb..d0ab533 100644
>>> --- a/fs/f2fs/trace.c
>>> +++ b/fs/f2fs/trace.c
>>> @@ -14,7 +14,7 @@
>>>  #include "trace.h"
>>>  
>>>  static RADIX_TREE(pids, GFP_ATOMIC);
>>> -static struct mutex pids_lock;
>>> +static spinlock_t pids_lock;
>>>  static struct last_io_info last_io;
>>>  
>>>  static inline void __print_last_io(void)
>>> @@ -58,23 +58,29 @@ void f2fs_trace_pid(struct page *page)
>>>  
>>>  	set_page_private(page, (unsigned long)pid);
>>>  
>>> +retry:
>>>  	if (radix_tree_preload(GFP_NOFS))
>>>  		return;
>>>  
>>> -	mutex_lock(&pids_lock);
>>> +	spin_lock(&pids_lock);
>>>  	p = radix_tree_lookup(&pids, pid);
>>>  	if (p == current)
>>>  		goto out;
>>>  	if (p)
>>>  		radix_tree_delete(&pids, pid);
>>>  
>>> -	f2fs_radix_tree_insert(&pids, pid, current);
>>> +	if (radix_tree_insert(&pids, pid, current)) {
>>> +		spin_unlock(&pids_lock);
>>> +		radix_tree_preload_end();
>>> +		cond_resched();
>>> +		goto retry;
>>> +	}
>>>  
>>>  	trace_printk("%3x:%3x %4x %-16s\n",
>>>  			MAJOR(inode->i_sb->s_dev), MINOR(inode->i_sb->s_dev),
>>>  			pid, current->comm);
>>
>> Hi Sahitya,
>>
>> Can trace_printk sleep? For safety, how about moving it out of spinlock?
>>
> Hi Chao,
> 
> Yes, trace_printk() is safe to use in atomic context (unlike printk).

Hi Sahitya,

Thanks for your confirmation. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,
> Sahitya.
> 
>> Thanks,
>>
>>>  out:
>>> -	mutex_unlock(&pids_lock);
>>> +	spin_unlock(&pids_lock);
>>>  	radix_tree_preload_end();
>>>  }
>>>  
>>> @@ -119,7 +125,7 @@ void f2fs_trace_ios(struct f2fs_io_info *fio, int flush)
>>>  
>>>  void f2fs_build_trace_ios(void)
>>>  {
>>> -	mutex_init(&pids_lock);
>>> +	spin_lock_init(&pids_lock);
>>>  }
>>>  
>>>  #define PIDVEC_SIZE	128
>>> @@ -147,7 +153,7 @@ void f2fs_destroy_trace_ios(void)
>>>  	pid_t next_pid = 0;
>>>  	unsigned int found;
>>>  
>>> -	mutex_lock(&pids_lock);
>>> +	spin_lock(&pids_lock);
>>>  	while ((found = gang_lookup_pids(pid, next_pid, PIDVEC_SIZE))) {
>>>  		unsigned idx;
>>>  
>>> @@ -155,5 +161,5 @@ void f2fs_destroy_trace_ios(void)
>>>  		for (idx = 0; idx < found; idx++)
>>>  			radix_tree_delete(&pids, pid[idx]);
>>>  	}
>>> -	mutex_unlock(&pids_lock);
>>> +	spin_unlock(&pids_lock);
>>>  }
>>>
>>
> 
