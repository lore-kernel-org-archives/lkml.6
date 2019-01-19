Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E841EC0031C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 03:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05F42084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 03:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfASDft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 22:35:49 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:45290 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbfASDft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 22:35:49 -0500
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0J3ZlgI011176;
        Sat, 19 Jan 2019 12:35:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Sat, 19 Jan 2019 12:35:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0J3Zlkf011150
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 19 Jan 2019 12:35:47 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH] mm, oom: fix use-after-free in oom_kill_process
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190119005022.61321-1-shakeelb@google.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <02f74c47-4f35-3d59-f767-268844cb875e@i-love.sakura.ne.jp>
Date:   Sat, 19 Jan 2019 12:35:47 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190119005022.61321-1-shakeelb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/19 9:50, Shakeel Butt wrote:
> On looking further it seems like the process selected to be oom-killed
> has exited even before reaching read_lock(&tasklist_lock) in
> oom_kill_process(). More specifically the tsk->usage is 1 which is due
> to get_task_struct() in oom_evaluate_task() and the put_task_struct
> within for_each_thread() frees the tsk and for_each_thread() tries to
> access the tsk. The easiest fix is to do get/put across the
> for_each_thread() on the selected task.

Good catch. p->usage can become 1 while printk()ing a lot at dump_header().

> @@ -981,6 +981,13 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
>  	 * still freeing memory.
>  	 */
>  	read_lock(&tasklist_lock);
> +
> +	/*
> +	 * The task 'p' might have already exited before reaching here. The
> +	 * put_task_struct() will free task_struct 'p' while the loop still try
> +	 * to access the field of 'p', so, get an extra reference.
> +	 */
> +	get_task_struct(p);
>  	for_each_thread(p, t) {
>  		list_for_each_entry(child, &t->children, sibling) {
>  			unsigned int child_points;
> @@ -1000,6 +1007,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
>  			}
>  		}
>  	}
> +	put_task_struct(p);

Moving put_task_struct(p) to after read_unlock(&tasklist_lock) will reduce
latency of a write_lock(&tasklist_lock) waiter.

>  	read_unlock(&tasklist_lock);
>  
>  	/*
> 

By the way, p->usage is already 1 implies that p->mm == NULL due to already
completed exit_mm(p). Then, process_shares_mm(child, p->mm) might fail to
return true for some of children. Not critical but might lead to unnecessary
oom_badness() calls for child selection. Maybe we want to use same logic
__oom_kill_process() uses (i.e. bail out if find_task_lock_mm(p) failed)?
