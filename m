Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E77C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B1020831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B1020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeJYUUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:20:35 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61968 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbeJYUUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 16:20:35 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9PBllOZ057925;
        Thu, 25 Oct 2018 20:47:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Thu, 25 Oct 2018 20:47:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9PBlgTA057893
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 25 Oct 2018 20:47:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: KASAN: use-after-free Read in task_is_descendant
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     serge@hallyn.com,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        jmorris@namei.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <76013c9e-0664-ef5e-b6c0-d48f6ce5db3c@i-love.sakura.ne.jp>
 <20181022134634.GA7358@redhat.com>
 <201810250215.w9P2Fm2M078167@www262.sakura.ne.jp>
 <20181025111355.GA3725@redhat.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b0ac67e6-4279-91b3-0178-3176876abe70@i-love.sakura.ne.jp>
Date:   Thu, 25 Oct 2018 20:47:42 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025111355.GA3725@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/25 20:13, Oleg Nesterov wrote:
> On 10/25, Tetsuo Handa wrote:
>>
>> Oleg Nesterov wrote:
>>> On 10/22, Tetsuo Handa wrote:
>>>>> And again, I do not know how/if yama ensures that child is rcu-protected, perhaps
>>>>> task_is_descendant() needs to check pid_alive(child) right after rcu_read_lock() ?
>>>>
>>>> Since the caller (ptrace() path) called get_task_struct(child), child itself can't be
>>>> released. Do we still need pid_alive(child) ?
>>>
>>> get_task_struct(child) can only ensure that this task_struct can't be freed.
>>
>> The report says that it is a use-after-free read at
>>
>>   walker = rcu_dereference(walker->real_parent);
>>
>> which means that walker was already released.
> 
> quite possibly I missed something, but I am not sure I understand your concerns...
> 
> So again, suppose that "child" is already dead. Its task_struct can't be freed,
> but child->real_parent can point to the already freed memory.

Yes.

But if child->real_parent is pointing to the already freed memory,
why does pid_alive(child) == true help?

> 
> This means that the 1st walker = rcu_dereference(walker->real_parent) is fine,
> this simply reads the child->real_parent pointer,

Yes.

>                                                   but on the second iteration
> 
> 	walker = rcu_dereference(walker->real_parent);
> 
> reads the alredy freed memory.

Yes.

> 
>> I wonder whether pid_alive() test helps.
>>
>> We can get
>>
>> [   40.620318] parent or walker is dead.
>> [   40.624146] tracee is dead.
>>
>> messages using below patch and reproducer.
> 
> again, I do not understand, this all looks correct...
> 
>> ----------
>> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
>> index 99cfddd..0d9d786 100644
>> --- a/kernel/ptrace.c
>> +++ b/kernel/ptrace.c
>> @@ -385,6 +385,7 @@ static int ptrace_attach(struct task_struct *task, long request,
>>  	if (mutex_lock_interruptible(&task->signal->cred_guard_mutex))
>>  		goto out;
>>
>> +	schedule_timeout_killable(HZ);
>>  	task_lock(task);
>>  	retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
>>  	task_unlock(task);
>> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
>> index ffda91a..a231ec6 100644
>> --- a/security/yama/yama_lsm.c
>> +++ b/security/yama/yama_lsm.c
>> @@ -283,6 +283,11 @@ static int task_is_descendant(struct task_struct *parent,
>>  		return 0;
>>
>>  	rcu_read_lock();
>> +	if (!pid_alive(parent) || !pid_alive(walker)) {
>> +		rcu_read_unlock();
>> +		printk("parent or walker is dead.\n");
> 
> This is what we need to do, except I think we should change yama_ptrace_access_check().
> And iiuc parent == current, pid_alive(parent) looks unnecessary. Although we need to
> check ptracer_exception_found(), may be it needs some changes too.

There are two task_is_descendant() callers, and one of them is not passing current.

> 
> And yes, task_is_descendant() can hit the dead child, if nothing else it can
> be killed. This can explain the kasan report.

The kasan is reporting that child->real_parent (or maybe child->real_parent->real_parent
or child->real_parent->real_parent->real_parent ...) was pointing to already freed memory,
isn't it?

How can we check that that pointer is pointing to already freed memory? As soon as

  walker = rcu_dereference(walker->real_parent);

is executed, task_alive(walker) will try to read from already freed memory...

