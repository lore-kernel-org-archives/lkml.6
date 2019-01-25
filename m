Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E894FC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3555218EA
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548401075;
	bh=N9XMA7a3bQoV94ELIDbjuV0/37IqFrqBcMEl87YKkcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d3ElR1bNFNNJs44ZCsMAhr6RW+kDPc2kLAcQeuncwA8Xl55G4nj2d1Nw0DE9uWhdi
	 MDPSu2lB++Hatwl5h6JLU3xShkAtZzkKOKPTd8pPBoUAlL8hWRRJdyBT1+BqZ5og4m
	 wyDpzk2BXnSMgZx6mm4+kDETuYNu9nD/tlEbH4nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfAYHYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:24:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:40546 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbfAYHYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:24:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73196AEA3;
        Fri, 25 Jan 2019 07:24:31 +0000 (UTC)
Date:   Fri, 25 Jan 2019 08:24:29 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Extract memcg maxable seq_file logic to
 seq_show_memcg_tunable
Message-ID: <20190125072429.GA3560@dhcp22.suse.cz>
References: <20190124194100.GA31425@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124194100.GA31425@chrisdown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-01-19 14:41:00, Chris Down wrote:
> memcg has a significant number of files exposed to kernfs where their
> value is either exposed directly or is "max" in the case of
> PAGE_COUNTER_MAX.
> 
> This patch makes this generic by providing a single function to do this
> work. In combination with the previous patch adding mem_cgroup_from_seq,
> this makes all of the seq_show feeder functions significantly more
> simple.

Yeah this is what I've had in mind when mentioning a helper in the
previous version of the patch. I like this more even though the
resulting savings are not that large.

> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: kernel-team@fb.com

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 64 +++++++++++++++----------------------------------
>  1 file changed, 19 insertions(+), 45 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 98aad31f5226..81b6f752471a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5375,6 +5375,16 @@ static void mem_cgroup_bind(struct cgroup_subsys_state *root_css)
>  		root_mem_cgroup->use_hierarchy = false;
>  }
>  
> +static int seq_puts_memcg_tunable(struct seq_file *m, unsigned long value)
> +{
> +	if (value == PAGE_COUNTER_MAX)
> +		seq_puts(m, "max\n");
> +	else
> +		seq_printf(m, "%llu\n", (u64)value * PAGE_SIZE);
> +
> +	return 0;
> +}
> +
>  static u64 memory_current_read(struct cgroup_subsys_state *css,
>  			       struct cftype *cft)
>  {
> @@ -5385,15 +5395,8 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
>  
>  static int memory_min_show(struct seq_file *m, void *v)
>  {
> -	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> -	unsigned long min = READ_ONCE(memcg->memory.min);
> -
> -	if (min == PAGE_COUNTER_MAX)
> -		seq_puts(m, "max\n");
> -	else
> -		seq_printf(m, "%llu\n", (u64)min * PAGE_SIZE);
> -
> -	return 0;
> +	return seq_puts_memcg_tunable(m,
> +		READ_ONCE(mem_cgroup_from_seq(m)->memory.min));
>  }
>  
>  static ssize_t memory_min_write(struct kernfs_open_file *of,
> @@ -5415,15 +5418,8 @@ static ssize_t memory_min_write(struct kernfs_open_file *of,
>  
>  static int memory_low_show(struct seq_file *m, void *v)
>  {
> -	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> -	unsigned long low = READ_ONCE(memcg->memory.low);
> -
> -	if (low == PAGE_COUNTER_MAX)
> -		seq_puts(m, "max\n");
> -	else
> -		seq_printf(m, "%llu\n", (u64)low * PAGE_SIZE);
> -
> -	return 0;
> +	return seq_puts_memcg_tunable(m,
> +		READ_ONCE(mem_cgroup_from_seq(m)->memory.low));
>  }
>  
>  static ssize_t memory_low_write(struct kernfs_open_file *of,
> @@ -5445,15 +5441,7 @@ static ssize_t memory_low_write(struct kernfs_open_file *of,
>  
>  static int memory_high_show(struct seq_file *m, void *v)
>  {
> -	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> -	unsigned long high = READ_ONCE(memcg->high);
> -
> -	if (high == PAGE_COUNTER_MAX)
> -		seq_puts(m, "max\n");
> -	else
> -		seq_printf(m, "%llu\n", (u64)high * PAGE_SIZE);
> -
> -	return 0;
> +	return seq_puts_memcg_tunable(m, READ_ONCE(mem_cgroup_from_seq(m)->high));
>  }
>  
>  static ssize_t memory_high_write(struct kernfs_open_file *of,
> @@ -5482,15 +5470,8 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  
>  static int memory_max_show(struct seq_file *m, void *v)
>  {
> -	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> -	unsigned long max = READ_ONCE(memcg->memory.max);
> -
> -	if (max == PAGE_COUNTER_MAX)
> -		seq_puts(m, "max\n");
> -	else
> -		seq_printf(m, "%llu\n", (u64)max * PAGE_SIZE);
> -
> -	return 0;
> +	return seq_puts_memcg_tunable(m,
> +		READ_ONCE(mem_cgroup_from_seq(m)->memory.max));
>  }
>  
>  static ssize_t memory_max_write(struct kernfs_open_file *of,
> @@ -6622,15 +6603,8 @@ static u64 swap_current_read(struct cgroup_subsys_state *css,
>  
>  static int swap_max_show(struct seq_file *m, void *v)
>  {
> -	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> -	unsigned long max = READ_ONCE(memcg->swap.max);
> -
> -	if (max == PAGE_COUNTER_MAX)
> -		seq_puts(m, "max\n");
> -	else
> -		seq_printf(m, "%llu\n", (u64)max * PAGE_SIZE);
> -
> -	return 0;
> +	return seq_puts_memcg_tunable(m,
> +		READ_ONCE(mem_cgroup_from_seq(m)->swap.max));
>  }
>  
>  static ssize_t swap_max_write(struct kernfs_open_file *of,
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
