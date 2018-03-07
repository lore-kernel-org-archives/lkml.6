Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934409AbeCGU42 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:56:28 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:45636 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933415AbeCGU4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:56:24 -0500
X-Google-Smtp-Source: AG47ELucHZOws53qoggRKrARgRs8adfFoCyUgyo2SonrSATOSWG6o0tFDHvEG+nSKZiZTn1/xaG9og==
Date: Wed, 7 Mar 2018 12:56:21 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Gaurav Kohli <gkohli@codeaurora.org>
cc: akpm@linux-foundation.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] mm: oom: Fix race condition between oom_badness and
 do_exit of task
In-Reply-To: <1520427454-22813-1-git-send-email-gkohli@codeaurora.org>
Message-ID: <alpine.DEB.2.20.1803071254410.165297@chino.kir.corp.google.com>
References: <1520427454-22813-1-git-send-email-gkohli@codeaurora.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2018, Gaurav Kohli wrote:

> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 6fd9773..5f4cc4b 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -114,9 +114,11 @@ struct task_struct *find_lock_task_mm(struct task_struct *p)
>  
>  	for_each_thread(p, t) {
>  		task_lock(t);
> +		get_task_struct(t);
>  		if (likely(t->mm))
>  			goto found;
>  		task_unlock(t);
> +		put_task_struct(t);
>  	}
>  	t = NULL;
>  found:

We hold rcu_read_lock() here, so perhaps only do get_task_struct() before 
doing rcu_read_unlock() and we have a non-NULL t?

> @@ -191,6 +193,7 @@ unsigned long oom_badness(struct task_struct *p, struct mem_cgroup *memcg,
>  			test_bit(MMF_OOM_SKIP, &p->mm->flags) ||
>  			in_vfork(p)) {
>  		task_unlock(p);
> +		put_task_struct(p);
>  		return 0;
>  	}
>  
> @@ -208,7 +211,7 @@ unsigned long oom_badness(struct task_struct *p, struct mem_cgroup *memcg,
>  	 */
>  	if (has_capability_noaudit(p, CAP_SYS_ADMIN))
>  		points -= (points * 3) / 100;
> -
> +	put_task_struct(p);
>  	/* Normalize to oom_score_adj units */
>  	adj *= totalpages / 1000;
>  	points += adj;

This fixes up oom_badness(), but there are other users of 
find_lock_task_mm() in the oom killer as well as other subsystems.
