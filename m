Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932269AbeE3UnB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:43:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48382 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932176AbeE3Um6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:42:58 -0400
Date: Wed, 30 May 2018 13:42:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: ufo19890607 <ufo19890607@gmail.com>
Cc: mhocko@suse.com, rientjes@google.com, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhoujian <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH v4] Print the memcg's name when system-wide OOM happened
Message-Id: <20180530134256.bbf7a8639571a3f8910b6a05@linux-foundation.org>
In-Reply-To: <1526870386-2439-1-git-send-email-ufo19890607@gmail.com>
References: <1526870386-2439-1-git-send-email-ufo19890607@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2018 03:39:46 +0100 ufo19890607 <ufo19890607@gmail.com> wrote:

> From: yuzhoujian <yuzhoujian@didichuxing.com>
> 
> The dump_header does not print the memcg's name when the system
> oom happened. So users cannot locate the certain container which
> contains the task that has been killed by the oom killer.
> 
> System oom report will print the memcg's name after this patch,
> so users can get the memcg's path from the oom report and check
> the certain container more quickly.

lkp-robot is reporting an oops.

> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -433,6 +433,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
>  	if (is_memcg_oom(oc))
>  		mem_cgroup_print_oom_info(oc->memcg, p);
>  	else {
> +		mem_cgroup_print_oom_memcg_name(oc->memcg, p);
>  		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
>  		if (is_dump_unreclaim_slabs())
>  			dump_unreclaimable_slab();

static inline bool is_memcg_oom(struct oom_control *oc)
{
	return oc->memcg != NULL;
}

So in the mem_cgroup_print_oom_memcg_name() call which this patch adds,
oc->memcg is known to be NULL.  How can this possibly work?  
