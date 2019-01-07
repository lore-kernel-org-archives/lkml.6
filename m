Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0CDC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EC82089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfAGU7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:59:00 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:64271 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfAGU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:58:59 -0500
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x07KwkEH027220;
        Tue, 8 Jan 2019 05:58:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Tue, 08 Jan 2019 05:58:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x07KwgpP027210
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 8 Jan 2019 05:58:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 1/2] mm, oom: marks all killed tasks as oom victims
To:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20190107143802.16847-1-mhocko@kernel.org>
 <20190107143802.16847-2-mhocko@kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <1054b5c6-19c0-53a4-206e-dd55f5a3d732@i-love.sakura.ne.jp>
Date:   Tue, 8 Jan 2019 05:58:41 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190107143802.16847-2-mhocko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/07 23:38, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Historically we have called mark_oom_victim only to the main task
> selected as the oom victim because oom victims have access to memory
> reserves and granting the access to all killed tasks could deplete
> memory reserves very quickly and cause even larger problems.
> 
> Since only a partial access to memory reserves is allowed there is no
> longer this risk and so all tasks killed along with the oom victim
> can be considered as well.
> 
> The primary motivation for that is that process groups which do not
> shared signals would behave more like standard thread groups wrt oom
> handling (aka tsk_is_oom_victim will work the same way for them).
> 
> - Use find_lock_task_mm to stabilize mm as suggested by Tetsuo
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/oom_kill.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index f0e8cd9edb1a..0246c7a4e44e 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -892,6 +892,7 @@ static void __oom_kill_process(struct task_struct *victim)
>  	 */
>  	rcu_read_lock();
>  	for_each_process(p) {
> +		struct task_struct *t;
>  		if (!process_shares_mm(p, mm))
>  			continue;
>  		if (same_thread_group(p, victim))
> @@ -911,6 +912,11 @@ static void __oom_kill_process(struct task_struct *victim)
>  		if (unlikely(p->flags & PF_KTHREAD))
>  			continue;
>  		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_TGID);
> +		t = find_lock_task_mm(p);
> +		if (!t)
> +			continue;
> +		mark_oom_victim(t);
> +		task_unlock(t);

Thank you for updating this patch. This patch is correct from the point of
view of avoiding TIF_MEMDIE race. But if I recall correctly, the reason we
did not do this is to avoid depleting memory reserves. And we still grant
full access to memory reserves for CONFIG_MMU=n case. Shouldn't the changelog
mention CONFIG_MMU=n case?

>  	}
>  	rcu_read_unlock();
>  
> 

