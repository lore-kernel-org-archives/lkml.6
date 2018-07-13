Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25827ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BFC2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 21:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BFC2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbeGMVff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 17:35:35 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:13824 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731897AbeGMVff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 17:35:35 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6DLJ2Lk007247;
        Sat, 14 Jul 2018 06:19:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Sat, 14 Jul 2018 06:19:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6DLIvD8007226
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 14 Jul 2018 06:19:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [patch -mm] mm, oom: remove oom_lock from exit_mmap
To:     Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.1807121432370.170100@chino.kir.corp.google.com>
 <20180713142612.GD19960@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <44d26c25-6e09-49de-5e90-3c16115eb337@i-love.sakura.ne.jp>
Date:   Sat, 14 Jul 2018 06:18:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180713142612.GD19960@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/13 23:26, Michal Hocko wrote:
> On Thu 12-07-18 14:34:00, David Rientjes wrote:
> [...]
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 0fe4087d5151..e6328cef090f 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -488,9 +488,11 @@ void __oom_reap_task_mm(struct mm_struct *mm)
>>  	 * Tell all users of get_user/copy_from_user etc... that the content
>>  	 * is no longer stable. No barriers really needed because unmapping
>>  	 * should imply barriers already and the reader would hit a page fault
>> -	 * if it stumbled over a reaped memory.
>> +	 * if it stumbled over a reaped memory. If MMF_UNSTABLE is already set,
>> +	 * reaping as already occurred so nothing left to do.
>>  	 */
>> -	set_bit(MMF_UNSTABLE, &mm->flags);
>> +	if (test_and_set_bit(MMF_UNSTABLE, &mm->flags))
>> +		return;
> 
> This could lead to pre mature oom victim selection
> oom_reaper			exiting victim
> oom_reap_task			exit_mmap
>   __oom_reap_task_mm		  __oom_reap_task_mm
> 				    test_and_set_bit(MMF_UNSTABLE) # wins the race
>   test_and_set_bit(MMF_UNSTABLE)
> set_bit(MMF_OOM_SKIP) # new victim can be selected now.
> 
> Besides that, why should we back off in the first place. We can
> race the two without any problems AFAICS. We already do have proper
> synchronization between the two due to mmap_sem and MMF_OOM_SKIP.
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index fc41c0543d7f..4642964f7741 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3073,9 +3073,7 @@ void exit_mmap(struct mm_struct *mm)
>  		 * which clears VM_LOCKED, otherwise the oom reaper cannot
>  		 * reliably test it.
>  		 */
> -		mutex_lock(&oom_lock);
>  		__oom_reap_task_mm(mm);
> -		mutex_unlock(&oom_lock);
>  
>  		set_bit(MMF_OOM_SKIP, &mm->flags);

David and Michal are using different version as a baseline here.
David is making changes using timeout based back off (in linux-next.git)
which is inappropriately trying to use MMF_UNSTABLE for two purposes.

Michal is making changes using current code (in linux.git) which does not
address David's concern.

My version ( https://marc.info/?l=linux-mm&m=153119509215026 ) is
making changes using current code which also provides oom-badness
based back off in order to address David's concern.

>  		down_write(&mm->mmap_sem);

Anyway, I suggest doing

  mutex_lock(&oom_lock);
  set_bit(MMF_OOM_SKIP, &mm->flags);
  mutex_unlock(&oom_lock);

like I mentioned at
http://lkml.kernel.org/r/201807130620.w6D6KiAJ093010@www262.sakura.ne.jp
even if we make changes on top of linux-next's timeout based back off.

