Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbeEaGtz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 02:49:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:50816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753825AbeEaGty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 02:49:54 -0400
Date: Thu, 31 May 2018 08:49:51 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ufo19890607 <ufo19890607@gmail.com>, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@I-love.SAKURA.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yuzhoujian <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH v4] Print the memcg's name when system-wide OOM happened
Message-ID: <20180531064951.GG15278@dhcp22.suse.cz>
References: <1526870386-2439-1-git-send-email-ufo19890607@gmail.com>
 <20180530134256.bbf7a8639571a3f8910b6a05@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530134256.bbf7a8639571a3f8910b6a05@linux-foundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-05-18 13:42:56, Andrew Morton wrote:
> On Mon, 21 May 2018 03:39:46 +0100 ufo19890607 <ufo19890607@gmail.com> wrote:
> 
> > From: yuzhoujian <yuzhoujian@didichuxing.com>
> > 
> > The dump_header does not print the memcg's name when the system
> > oom happened. So users cannot locate the certain container which
> > contains the task that has been killed by the oom killer.
> > 
> > System oom report will print the memcg's name after this patch,
> > so users can get the memcg's path from the oom report and check
> > the certain container more quickly.
> 
> lkp-robot is reporting an oops.
> 
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -433,6 +433,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
> >  	if (is_memcg_oom(oc))
> >  		mem_cgroup_print_oom_info(oc->memcg, p);
> >  	else {
> > +		mem_cgroup_print_oom_memcg_name(oc->memcg, p);
> >  		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
> >  		if (is_dump_unreclaim_slabs())
> >  			dump_unreclaimable_slab();
> 
> static inline bool is_memcg_oom(struct oom_control *oc)
> {
> 	return oc->memcg != NULL;
> }
> 
> So in the mem_cgroup_print_oom_memcg_name() call which this patch adds,
> oc->memcg is known to be NULL.  How can this possibly work?  

This version is broken. The current version [1] seems to be doing the
right thing in that regards AFAICS. It has some other issues though.
Can we drop the current code from the mmotm tree and start over?

[1] http://lkml.kernel.org/r/1527413551-5982-1-git-send-email-ufo19890607@gmail.com
-- 
Michal Hocko
SUSE Labs
