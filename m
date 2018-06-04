Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeFDGsL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 02:48:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:53089 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751412AbeFDGsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 02:48:10 -0400
Date: Mon, 4 Jun 2018 08:48:07 +0200
From: Michal Hocko <mhocko@kernel.org>
To: ufo19890607@gmail.com
Cc: akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@I-love.SAKURA.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhoujian <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH v7 1/2] Add an array of const char and enum
 oom_constraint in memcontrol.h
Message-ID: <20180604064807.GD19202@dhcp22.suse.cz>
References: <1527940734-35161-1-git-send-email-ufo19890607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527940734-35161-1-git-send-email-ufo19890607@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 02-06-18 19:58:51, ufo19890607@gmail.com wrote:
> From: yuzhoujian <yuzhoujian@didichuxing.com>
> 
> This patch will make some preparation for the follow-up patch: Refactor
> part of the oom report in dump_header. It puts enum oom_constraint in
> memcontrol.h and adds an array of const char for each constraint.

I do not get why you separate this specific part out.
oom_constraint_text is not used in the patch. It is almost always
preferable to have a user of newly added functionality.

> 
> Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
> ---
>  include/linux/memcontrol.h | 14 ++++++++++++++
>  mm/oom_kill.c              |  7 -------
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index d99b71bc2c66..57311b6c4d67 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -62,6 +62,20 @@ struct mem_cgroup_reclaim_cookie {
>  	unsigned int generation;
>  };
>  
> +enum oom_constraint {
> +	CONSTRAINT_NONE,
> +	CONSTRAINT_CPUSET,
> +	CONSTRAINT_MEMORY_POLICY,
> +	CONSTRAINT_MEMCG,
> +};
> +
> +static const char * const oom_constraint_text[] = {
> +	[CONSTRAINT_NONE] = "CONSTRAINT_NONE",
> +	[CONSTRAINT_CPUSET] = "CONSTRAINT_CPUSET",
> +	[CONSTRAINT_MEMORY_POLICY] = "CONSTRAINT_MEMORY_POLICY",
> +	[CONSTRAINT_MEMCG] = "CONSTRAINT_MEMCG",
> +};
> +
>  #ifdef CONFIG_MEMCG
>  
>  #define MEM_CGROUP_ID_SHIFT	16
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 8ba6cb88cf58..c806cd656af6 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -237,13 +237,6 @@ unsigned long oom_badness(struct task_struct *p, struct mem_cgroup *memcg,
>  	return points > 0 ? points : 1;
>  }
>  
> -enum oom_constraint {
> -	CONSTRAINT_NONE,
> -	CONSTRAINT_CPUSET,
> -	CONSTRAINT_MEMORY_POLICY,
> -	CONSTRAINT_MEMCG,
> -};
> -
>  /*
>   * Determine the type of allocation constraint.
>   */
> -- 
> 2.14.1

-- 
Michal Hocko
SUSE Labs
