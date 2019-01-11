Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EAEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB1221848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391802AbfAKPC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:02:28 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:41082 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731345AbfAKObf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:31:35 -0500
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0BEVOq9048653;
        Fri, 11 Jan 2019 23:31:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Fri, 11 Jan 2019 23:31:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0BEVHuf048476
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 11 Jan 2019 23:31:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 0/2] oom, memcg: do not report racy no-eligible OOM
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <e55fb27c-f23b-0ac5-acfd-7265c0a3b8dc@i-love.sakura.ne.jp>
 <20190109120212.GT31793@dhcp22.suse.cz>
 <201901102359.x0ANxIbn020225@www262.sakura.ne.jp>
 <fbdfdfeb-5664-ddf3-4d65-c64f9851ac26@i-love.sakura.ne.jp>
 <20190111113354.GD14956@dhcp22.suse.cz>
 <0d67b389-91e2-18ab-b596-39361b895c89@i-love.sakura.ne.jp>
 <20190111133401.GA6997@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <d9f7b139-d51b-93ae-b5ad-856fd9f2c168@i-love.sakura.ne.jp>
Date:   Fri, 11 Jan 2019 23:31:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190111133401.GA6997@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/11 22:34, Michal Hocko wrote:
> On Fri 11-01-19 21:40:52, Tetsuo Handa wrote:
> [...]
>> Did you notice that there is no
>>
>>   "Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n"
>>
>> line between
>>
>>   [   71.304703][ T9694] Memory cgroup out of memory: Kill process 9692 (a.out) score 904 or sacrifice child
>>
>> and
>>
>>   [   71.309149][   T54] oom_reaper: reaped process 9750 (a.out), now anon-rss:0kB, file-rss:0kB, shmem-rss:185532kB
>>
>> ? Then, you will find that [ T9694] failed to reach for_each_process(p) loop inside
>> __oom_kill_process() in the first round of out_of_memory() call because
>> find_lock_task_mm() == NULL at __oom_kill_process() because Ctrl-C made that victim
>> complete exit_mm() before find_lock_task_mm() is called.
> 
> OK, so we haven't killed anything because the victim has exited by the
> time we wanted to do so. We still have other tasks sharing that mm
> pending and not killed because nothing has killed them yet, right?

The OOM killer invoked by [ T9694] called printk() but didn't kill anything.
Instead, SIGINT from Ctrl-C killed all thread groups sharing current->mm.

> 
> How come the oom reaper could act on this oom event at all then?
> 
> What am I missing?
> 

The OOM killer invoked by [ T9750] did not call printk() but hit
task_will_free_mem(current) in out_of_memory() and invoked the OOM reaper,
without calling mark_oom_victim() on all thread groups sharing current->mm.
Did you notice that I wrote that

  Since mm-oom-marks-all-killed-tasks-as-oom-victims.patch does not call mark_oom_victim()
  when task_will_free_mem() == true,

? :-(

