Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A98C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8DD21759
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8DD21759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733109AbeHFW46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:56:58 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:31643 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbeHFW44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:56:56 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w76Kk7o8065664;
        Tue, 7 Aug 2018 05:46:07 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Tue, 07 Aug 2018 05:46:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w76Kk6Xc065660
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 7 Aug 2018 05:46:07 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: WARNING in try_charge
To:     Michal Hocko <mhocko@kernel.org>
Cc:     syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, dvyukov@google.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com
References: <fc6e173e-8bda-269f-d44f-1c5f5215beac@I-love.SAKURA.ne.jp>
 <0000000000006350880572c61e62@google.com>
 <20180806174410.GB10003@dhcp22.suse.cz>
 <20180806175627.GC10003@dhcp22.suse.cz>
 <078bde8d-b1b5-f5ad-ed23-0cd94b579f9e@i-love.sakura.ne.jp>
 <20180806203437.GK10003@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <3cf8f630-73b7-20d4-8ad1-bb1c657ee30d@i-love.sakura.ne.jp>
Date:   Tue, 7 Aug 2018 05:46:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806203437.GK10003@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/07 5:34, Michal Hocko wrote:
> On Tue 07-08-18 05:26:23, Tetsuo Handa wrote:
>> On 2018/08/07 2:56, Michal Hocko wrote:
>>> So the oom victim indeed passed the above force path after the oom
>>> invocation. But later on hit the page fault path and that behaved
>>> differently and for some reason the force path hasn't triggered. I am
>>> wondering how could we hit the page fault path in the first place. The
>>> task is already killed! So what the hell is going on here.
>>>
>>> I must be missing something obvious here.
>>>
>> YOU ARE OBVIOUSLY MISSING MY MAIL!
>>
>> I already said this is "mm, oom: task_will_free_mem(current) should ignore MMF_OOM_SKIP for once."
>> problem which you are refusing at https://www.spinics.net/lists/linux-mm/msg133774.html .
>> And you again ignored my mail. Very sad...
> 
> Your suggestion simply didn't make much sense. There is nothing like
> first check is different from the rest.
> 

I don't think your patch is appropriate. It avoids hitting WARN(1) but does not avoid
unnecessary killing of OOM victims.

If you look at https://syzkaller.appspot.com/text?tag=CrashLog&x=15a1c770400000 , you will
notice that both 23766 and 23767 are killed due to task_will_free_mem(current) == false.
This is "unnecessary killing of additional processes".

[  365.869417] syz-executor2 invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), order=0, oom_score_adj=0
[  365.878899] CPU: 0 PID: 23767 Comm: syz-executor2 Not tainted 4.18.0-rc6-next-20180725+ #18
(...snipped...)
[  366.487490] Tasks state (memory values in pages):
[  366.492349] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
[  366.501237] [  23766]     0 23766    17620     8221   126976        0             0 syz-executor3
[  366.510367] [  23767]     0 23767    17618     8218   126976        0             0 syz-executor2
[  366.519409] Memory cgroup out of memory: Kill process 23766 (syz-executor3) score 8252000 or sacrifice child
[  366.529422] Killed process 23766 (syz-executor3) total-vm:70480kB, anon-rss:116kB, file-rss:32768kB, shmem-rss:0kB
[  366.540456] oom_reaper: reaped process 23766 (syz-executor3), now anon-rss:0kB, file-rss:32000kB, shmem-rss:0kB
[  366.550949] syz-executor3 invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), order=0, oom_score_adj=0
[  366.560374] CPU: 1 PID: 23766 Comm: syz-executor3 Not tainted 4.18.0-rc6-next-20180725+ #18
(...snipped...)
[  367.138136] Tasks state (memory values in pages):
[  367.142986] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
[  367.151889] [  23766]     0 23766    17620     8002   126976        0             0 syz-executor3
[  367.160946] [  23767]     0 23767    17618     8218   126976        0             0 syz-executor2
[  367.169994] Memory cgroup out of memory: Kill process 23767 (syz-executor2) score 8249000 or sacrifice child
[  367.180119] Killed process 23767 (syz-executor2) total-vm:70472kB, anon-rss:104kB, file-rss:32768kB, shmem-rss:0kB
[  367.192101] oom_reaper: reaped process 23767 (syz-executor2), now anon-rss:0kB, file-rss:32000kB, shmem-rss:0kB
[  367.202986] ------------[ cut here ]------------
[  367.207845] Memory cgroup charge failed because of no reclaimable memory! This looks like a misconfiguration or a kernel bug.
[  367.207965] WARNING: CPU: 1 PID: 23767 at mm/memcontrol.c:1710 try_charge+0x734/0x1680
[  367.227540] Kernel panic - not syncing: panic_on_warn set ...

