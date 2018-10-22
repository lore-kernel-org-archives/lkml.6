Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3EDC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AABC20658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AABC20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbeJVTPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:15:13 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:39954 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbeJVTPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:15:13 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9MAuqVL046291;
        Mon, 22 Oct 2018 19:56:52 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Mon, 22 Oct 2018 19:56:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9MAupSs046287
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 22 Oct 2018 19:56:52 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH 1/2] mm, oom: marks all killed tasks as oom victims
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181022071323.9550-1-mhocko@kernel.org>
 <20181022071323.9550-2-mhocko@kernel.org>
 <201810220758.w9M7wojE016890@www262.sakura.ne.jp>
 <20181022084842.GW18839@dhcp22.suse.cz>
 <f5b257f9-47a5-e071-02fa-ce901bd34b04@i-love.sakura.ne.jp>
 <20181022104341.GY18839@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <93f99371-cff8-fc31-a594-eecdff299f16@i-love.sakura.ne.jp>
Date:   Mon, 22 Oct 2018 19:56:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181022104341.GY18839@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/22 19:43, Michal Hocko wrote:
> On Mon 22-10-18 18:42:30, Tetsuo Handa wrote:
>> On 2018/10/22 17:48, Michal Hocko wrote:
>>> On Mon 22-10-18 16:58:50, Tetsuo Handa wrote:
>>>> Michal Hocko wrote:
>>>>> --- a/mm/oom_kill.c
>>>>> +++ b/mm/oom_kill.c
>>>>> @@ -898,6 +898,7 @@ static void __oom_kill_process(struct task_struct *victim)
>>>>>  		if (unlikely(p->flags & PF_KTHREAD))
>>>>>  			continue;
>>>>>  		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, PIDTYPE_TGID);
>>>>> +		mark_oom_victim(p);
>>>>>  	}
>>>>>  	rcu_read_unlock();
>>>>>  
>>>>> -- 
>>>>
>>>> Wrong. Either
>>>
>>> You are right. The mm might go away between process_shares_mm and here.
>>> While your find_lock_task_mm would be correct I believe we can do better
>>> by using the existing mm that we already have. I will make it a separate
>>> patch to clarity.
>>
>> Still wrong. p->mm == NULL means that we are too late to set TIF_MEMDIE
>> on that thread. Passing non-NULL mm to mark_oom_victim() won't help.
> 
> Why would it be too late? Or in other words why would this be harmful?
> 

Setting TIF_MEMDIE after exit_mm() completed is too late.

static void exit_mm(void)
{
(...snipped...)
	task_lock(current);
	current->mm = NULL;
	up_read(&mm->mmap_sem);
	enter_lazy_tlb(mm, current);
	task_unlock(current);
	mm_update_next_owner(mm);
	mmput(mm);
	if (test_thread_flag(TIF_MEMDIE))
		exit_oom_victim();
}
