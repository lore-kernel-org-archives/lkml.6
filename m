Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF65C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 10:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF8C214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 10:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfA0K4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 05:56:18 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:21595 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfA0K4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 05:56:18 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0RAuF88050388;
        Sun, 27 Jan 2019 19:56:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Sun, 27 Jan 2019 19:56:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0RAuAXl050345
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 27 Jan 2019 19:56:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] oom, oom_reaper: do not enqueue same task twice
To:     Michal Hocko <mhocko@kernel.org>
Cc:     =?UTF-8?Q?Arkadiusz_Mi=c5=9bkiewicz?= <a.miskiewicz@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Aleksa Sarai <asarai@suse.de>, Jay Kamat <jgkamat@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
References: <1cdbef13-564d-61a6-95f4-579d2cad243d@gmail.com>
 <20190125163731.GJ50184@devbig004.ftw2.facebook.com>
 <a95d004a-4358-7efc-6d21-12aac4411b32@gmail.com>
 <480296c4-ed7a-3265-e84a-298e42a0f1d5@I-love.SAKURA.ne.jp>
 <6da6ca69-5a6e-a9f6-d091-f89a8488982a@gmail.com>
 <72aa8863-a534-b8df-6b9e-f69cf4dd5c4d@i-love.sakura.ne.jp>
 <33a07810-6dbc-36be-5bb6-a279773ccf69@i-love.sakura.ne.jp>
 <34e97b46-0792-cc66-e0f2-d72576cdec59@i-love.sakura.ne.jp>
 <2b0c7d6c-c58a-da7d-6f0a-4900694ec2d3@gmail.com>
 <1d161137-55a5-126f-b47e-b2625bd798ca@i-love.sakura.ne.jp>
 <20190127083724.GA18811@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ec0d0580-a2dd-f329-9707-0cb91205a216@i-love.sakura.ne.jp>
Date:   Sun, 27 Jan 2019 19:56:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190127083724.GA18811@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/27 17:37, Michal Hocko wrote:
> Thanks for the analysis and the patch. This should work, I believe but
> I am not really thrilled to overload the meaning of the MMF_UNSTABLE.
> The flag is meant to signal accessing address space is not stable and it
> is not aimed to synchronize oom reaper with the oom path.
> 
> Can we make use mark_oom_victim directly? I didn't get to think that
> through right now so I might be missing something but this should
> prevent repeating queueing as well.

Yes, TIF_MEMDIE would work. But you are planning to remove TIF_MEMDIE. Also,
TIF_MEMDIE can't avoid enqueuing many threads sharing mm_struct to the OOM
reaper. There is no need to enqueue many threads sharing mm_struct because
the OOM reaper acts on mm_struct rather than task_struct. Thus, enqueuing
based on per mm_struct flag sounds better, but MMF_OOM_VICTIM cannot be
set from wake_oom_reaper(victim) because victim's mm might be already inside
exit_mmap() when wake_oom_reaper(victim) is called after task_unlock(victim).

We could reintroduce MMF_OOM_KILLED in commit 855b018325737f76
("oom, oom_reaper: disable oom_reaper for oom_kill_allocating_task")
if you don't like overloading the meaning of the MMF_UNSTABLE. But since
MMF_UNSTABLE is available in Linux 4.9+ kernels (which covers all LTS stable
versions with the OOM reaper support), we can temporarily use MMF_UNSTABLE
for ease of backporting.

