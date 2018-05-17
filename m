Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeEQKXi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:23:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:48590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751530AbeEQKXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:23:37 -0400
Date: Thu, 17 May 2018 12:23:30 +0200
From: Michal Hocko <mhocko@kernel.org>
To: =?utf-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc: akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Subject: Re: [PATCH] Add the memcg print oom info for system oom
Message-ID: <20180517102330.GS12670@dhcp22.suse.cz>
References: <1526540428-12178-1-git-send-email-ufo19890607@gmail.com>
 <20180517071140.GQ12670@dhcp22.suse.cz>
 <CAHCio2gOLnj4NpkFrxpYVygg6ZeSeuwgp2Lwr6oTHRxHpbmcWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCio2gOLnj4NpkFrxpYVygg6ZeSeuwgp2Lwr6oTHRxHpbmcWw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-05-18 17:44:43, 禹舟键 wrote:
> Hi Michal
> I think the current OOM report is imcomplete. I can get the task which
> invoked the oom-killer and the task which has been killed by the
> oom-killer, and memory info when the oom happened. But I cannot infer the
> certain memcg to which the task killed by oom-killer belongs, because that
> task has been killed, and the dump_task will print all of the tasks in the
> system.

I can see how the origin memcg might be useful, but ...
> 
> mem_cgroup_print_oom_info will print five lines of content including
> memcg's name , usage, limit. I don't think five lines of content will cause
> a big problem. Or it at least prints the memcg's name.

this is not 5 lines at all. We dump memcg stats for the whole oom memcg
subtree. For your patch it would be the whole subtree of the memcg of
the oom victim. With cgroup v1 this can be quite deep as tasks can
belong to inter-nodes as well. Would be

		pr_info("Task in ");
		pr_cont_cgroup_path(task_cgroup(p, memory_cgrp_id));
		pr_cont(" killed as a result of limit of ");

part of that output sufficient for your usecase? You will not get memory
consumption of the group but is that really so relevant when we are
killing individual tasks? Please note that there are proposals to make
the global oom killer memcg aware and select by the memcg size rather
than pick on random tasks
(http://lkml.kernel.org/r/20171130152824.1591-1-guro@fb.com). Maybe that
will be more interesting for your container usecase.
-- 
Michal Hocko
SUSE Labs
