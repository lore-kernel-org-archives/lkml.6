Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CACC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC1420836
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfAKPhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:37:20 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:38123 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbfAKPhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:37:19 -0500
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0BFb5oD003418;
        Sat, 12 Jan 2019 00:37:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Sat, 12 Jan 2019 00:37:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0BFb5gc003406
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 12 Jan 2019 00:37:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 0/2] oom, memcg: do not report racy no-eligible OOM
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <e55fb27c-f23b-0ac5-acfd-7265c0a3b8dc@i-love.sakura.ne.jp>
 <20190109120212.GT31793@dhcp22.suse.cz>
 <201901102359.x0ANxIbn020225@www262.sakura.ne.jp>
 <fbdfdfeb-5664-ddf3-4d65-c64f9851ac26@i-love.sakura.ne.jp>
 <20190111113354.GD14956@dhcp22.suse.cz>
 <0d67b389-91e2-18ab-b596-39361b895c89@i-love.sakura.ne.jp>
 <20190111133401.GA6997@dhcp22.suse.cz>
 <d9f7b139-d51b-93ae-b5ad-856fd9f2c168@i-love.sakura.ne.jp>
 <20190111150703.GI14956@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <baa43a5a-6cae-bc4e-5911-13d4bfcd32f2@i-love.sakura.ne.jp>
Date:   Sat, 12 Jan 2019 00:37:05 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190111150703.GI14956@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/12 0:07, Michal Hocko wrote:
> On Fri 11-01-19 23:31:18, Tetsuo Handa wrote:
>> The OOM killer invoked by [ T9694] called printk() but didn't kill anything.
>> Instead, SIGINT from Ctrl-C killed all thread groups sharing current->mm.
> 
> I still do not get it. Those other processes are not sharing signals.
> Or is it due to injecting the signal too all of them with the proper
> timing?

Pressing Ctrl-C between after task_will_free_mem(p) in oom_kill_process() and
before __oom_kill_process() (e.g. dump_header()) made fatal_signal_pending() = T
for all of them.

> Anyway, could you update your patch and abstract 
> 	if (unlikely(tsk_is_oom_victim(current) ||
> 		     fatal_signal_pending(current) ||
> 		     current->flags & PF_EXITING))
> 
> in try_charge and reuse it in mem_cgroup_out_of_memory under the
> oom_lock with an explanation please?

I don't think doing so makes sense, for

  tsk_is_oom_victim(current) = T && fatal_signal_pending(current) == F

can't happen for mem_cgroup_out_of_memory() under the oom_lock, and
current->flags cannot get PF_EXITING when current is inside
mem_cgroup_out_of_memory(). fatal_signal_pending(current) alone is
appropriate for mem_cgroup_out_of_memory() under the oom_lock because

  tsk_is_oom_victim(current) = F && fatal_signal_pending(current) == T

can happen there.

Also, doing so might become wrong in future, for mem_cgroup_out_of_memory()
is also called from memory_max_write() which does not bail out upon
PF_EXITING. I don't think we can call memory_max_write() after current
thread got PF_EXITING, but nobody knows what change will happen in future.

