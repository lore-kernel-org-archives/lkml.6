Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeFCOp2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 10:45:28 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52953 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbeFCOp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 10:45:27 -0400
Subject: Re: [PATCH v7 2/2] Refactor part of the oom report in dump_header
To: ufo19890607@gmail.com
Cc: akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhoujian <yuzhoujian@didichuxing.com>
References: <1527940734-35161-1-git-send-email-ufo19890607@gmail.com>
 <1527940734-35161-2-git-send-email-ufo19890607@gmail.com>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <abb05530-c259-1178-523a-4368e43f94cc@i-love.sakura.ne.jp>
Date: Sun, 3 Jun 2018 23:45:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1527940734-35161-2-git-send-email-ufo19890607@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/02 20:58, yuzhoujian wrote:
> -void mem_cgroup_print_oom_info(struct mem_cgroup *memcg, struct task_struct *p)
> +void mem_cgroup_print_oom_context(struct mem_cgroup *memcg, struct task_struct *p,
> +			enum oom_constraint constraint, nodemask_t *nodemask)
>  {
> -	struct mem_cgroup *iter;
> -	unsigned int i;
> +	static char origin_memcg_name[NAME_MAX], kill_memcg_name[NAME_MAX];
> +	struct cgroup *origin_cgrp, *kill_cgrp;
>  
>  	rcu_read_lock();
> -
> -	if (p) {
> -		pr_info("Task in ");
> -		pr_cont_cgroup_path(task_cgroup(p, memory_cgrp_id));
> -		pr_cont(" killed as a result of limit of ");
> -	} else {
> -		pr_info("Memory limit reached of cgroup ");
> +	if (memcg) {
> +		origin_cgrp = memcg->css.cgroup;
> +		cgroup_path(origin_cgrp, origin_memcg_name, NAME_MAX);
>  	}
> -
> -	pr_cont_cgroup_path(memcg->css.cgroup);
> -	pr_cont("\n");
> -
> +	kill_cgrp = task_cgroup(p, memory_cgrp_id);
> +	cgroup_path(kill_cgrp, kill_memcg_name, NAME_MAX);
> +
> +	if (p)
> +		pr_info("oom-kill:constraint=%s,nodemask=%*pbl,origin_memcg=%s,kill_memcg=%s,task=%s,pid=%5d,uid=%5d\n",
> +			oom_constraint_text[constraint], nodemask_pr_args(nodemask),
> +			strlen(origin_memcg_name) ? origin_memcg_name : "(null)",

Since origin_memcg_name is printed for both memcg OOM and !memcg OOM,
it is strange that origin_memcg_name is updated only when memcg != NULL.
Have you really tested !memcg OOM case?
