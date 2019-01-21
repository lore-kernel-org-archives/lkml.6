Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97029C37123
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E2920844
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfAUVKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:10:12 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:63562 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfAUVKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:10:11 -0500
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0LLA9lO045555;
        Tue, 22 Jan 2019 06:10:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Tue, 22 Jan 2019 06:10:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0LLA8xh045549
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 22 Jan 2019 06:10:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2 2/2] mm, oom: remove 'prefer children over parent'
 heuristic
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
References: <20190121185033.161015-1-shakeelb@google.com>
 <20190121185033.161015-2-shakeelb@google.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <323023c0-0bb8-f8c4-4359-61a9550bb1e0@i-love.sakura.ne.jp>
Date:   Tue, 22 Jan 2019 06:10:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190121185033.161015-2-shakeelb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/22 3:50, Shakeel Butt wrote:
>>From the start of the git history of Linux, the kernel after selecting
> the worst process to be oom-killed, prefer to kill its child (if the
> child does not share mm with the parent). Later it was changed to prefer
> to kill a child who is worst. If the parent is still the worst then the
> parent will be killed.
> 
> This heuristic assumes that the children did less work than their parent
> and by killing one of them, the work lost will be less. However this is
> very workload dependent. If there is a workload which can benefit from
> this heuristic, can use oom_score_adj to prefer children to be killed
> before the parent.
> 
> The select_bad_process() has already selected the worst process in the
> system/memcg. There is no need to recheck the badness of its children
> and hoping to find a worse candidate. That's a lot of unneeded racy
> work. Also the heuristic is dangerous because it make fork bomb like
> workloads to recover much later because we constantly pick and kill
> processes which are not memory hogs. So, let's remove this whole
> heuristic.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> 
> ---
> Changelog since v1:
> - Improved commit message based on mhocko's comment.
> - Replaced 'p' with 'victim'.
> - Removed extra pr_err message.

But this version omits printing one of "Out of memory (oom_kill_allocating_task)",
"Out of memory" and "Memory cgroup out of memory" message which is unexpected.
We want to propagate that message to __oom_kill_process() ? ;-)
