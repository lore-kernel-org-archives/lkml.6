Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384DAC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C578A20878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C578A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeJHQib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 12:38:31 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:31804 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJHQib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 12:38:31 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w989RhjZ066688;
        Mon, 8 Oct 2018 18:27:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Mon, 08 Oct 2018 18:27:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w989RdOd066609
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 8 Oct 2018 18:27:43 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] mm, oom_adj: avoid meaningless loop to find processes
 sharing mm
To:     ytk.lee@samsung.com, "mhocko@kernel.org" <mhocko@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <67eedc4c-7afa-e845-6c88-9716fd820de6@i-love.sakura.ne.jp>
 <af7ae9c4-d7f1-69af-58fa-ec6949161f5b@I-love.SAKURA.ne.jp>
 <20181008011931epcms1p82dd01b7e5c067ea99946418bc97de46a@epcms1p8>
 <20181008061407epcms1p519703ae6373a770160c8f912c7aa9521@epcms1p5>
 <CGME20181008011931epcms1p82dd01b7e5c067ea99946418bc97de46a@epcms1p2>
 <20181008083855epcms1p20e691e5a001f3b94b267997c24e91128@epcms1p2>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f5bdf4a7-e491-1cda-590c-792526f49050@i-love.sakura.ne.jp>
Date:   Mon, 8 Oct 2018 18:27:39 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008083855epcms1p20e691e5a001f3b94b267997c24e91128@epcms1p2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/08 17:38, Yong-Taek Lee wrote:
>>
>> On 2018/10/08 15:14, Yong-Taek Lee wrote:
>>>> On 2018/10/08 10:19, Yong-Taek Lee wrote:
>>>>> @@ -1056,6 +1056,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>>>>>         struct mm_struct *mm = NULL;
>>>>>         struct task_struct *task;
>>>>>         int err = 0;
>>>>> +       int mm_users = 0;
>>>>>
>>>>>         task = get_proc_task(file_inode(file));
>>>>>         if (!task)
>>>>> @@ -1092,7 +1093,8 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>>>>>                 struct task_struct *p = find_lock_task_mm(task);
>>>>>
>>>>>                 if (p) {
>>>>> -                       if (atomic_read(&p->mm->mm_users) > 1) {
>>>>> +                       mm_users = atomic_read(&p->mm->mm_users);
>>>>> +                       if ((mm_users > 1) && (mm_users != get_nr_threads(p))) {
>>>>
>>>> How can this work (even before this patch)? When clone(CLONE_VM without CLONE_THREAD/CLONE_SIGHAND)
>>>> is requested, copy_process() calls copy_signal() in order to copy sig->oom_score_adj and
>>>> sig->oom_score_adj_min before calling copy_mm() in order to increment mm->mm_users, doesn't it?
>>>> Then, we will get two different "struct signal_struct" with different oom_score_adj/oom_score_adj_min
>>>> but one "struct mm_struct" shared by two thread groups.
>>>>
>>>
>>> Are you talking about race between __set_oom_adj and copy_process?
>>> If so, i agree with your opinion. It can not set oom_score_adj properly for copied process if __set_oom_adj
>>> check mm_users before copy_process calls copy_mm after copy_signal. Please correct me if i misunderstood anything.
>>
>> You understand it correctly.
>>
>> Reversing copy_signal() and copy_mm() is not sufficient either. We need to use a read/write lock
>> (read lock for copy_process() and write lock for __set_oom_adj()) in order to make sure that
>> the thread created by clone() becomes reachable from for_each_process() path in __set_oom_adj().
>>
> 
> Thank you for your suggestion. But i think it would be better to seperate to 2 issues. How about think these
> issues separately because there are no dependency between race issue and my patch. As i already explained,
> for_each_process path is meaningless if there is only one thread group with many threads(mm_users > 1 but 
> no other thread group sharing same mm). Do you have any other idea to avoid meaningless loop ? 

Yes. I suggest reverting commit 44a70adec910d692 ("mm, oom_adj: make sure processes
sharing mm have same view of oom_score_adj") and commit 97fd49c2355ffded ("mm, oom:
kill all tasks sharing the mm").

> 
>>>
>>>>>                                 mm = p->mm;
>>>>>                                 atomic_inc(&mm->mm_count);
>>>>>                         }
>>>
>>
> 



