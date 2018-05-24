Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033360AbeEXOgX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:36:23 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34795 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935698AbeEXOgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:36:18 -0400
X-Google-Smtp-Source: AB8JxZocuL2cj/De8RI67z/b/ygQ/rdq2yiCxjHy46pJBXwkwqNkC4JUm2ROIglt2zScOtifZWyH6Q==
Date: Thu, 24 May 2018 16:36:14 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v8 3/6] cpuset: Add cpuset.sched.load_balance flag to v2
Message-ID: <20180524143614.GC3948@localhost.localdomain>
References: <1526590545-3350-1-git-send-email-longman@redhat.com>
 <1526590545-3350-4-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526590545-3350-4-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/18 16:55, Waiman Long wrote:

[...]

> +	A parent cgroup cannot distribute all its CPUs to child
> +	scheduling domain cgroups unless its load balancing flag is
> +	turned off.
> +
> +  cpuset.sched.load_balance
> +	A read-write single value file which exists on non-root
> +	cpuset-enabled cgroups.  It is a binary value flag that accepts
> +	either "0" (off) or a non-zero value (on).  This flag is set
> +	by the parent and is not delegatable.
> +
> +	When it is on, tasks within this cpuset will be load-balanced
> +	by the kernel scheduler.  Tasks will be moved from CPUs with
> +	high load to other CPUs within the same cpuset with less load
> +	periodically.
> +
> +	When it is off, there will be no load balancing among CPUs on
> +	this cgroup.  Tasks will stay in the CPUs they are running on
> +	and will not be moved to other CPUs.
> +
> +	The initial value of this flag is "1".	This flag is then
> +	inherited by child cgroups with cpuset enabled.  Its state
> +	can only be changed on a scheduling domain cgroup with no
> +	cpuset-enabled children.

[...]

> +	/*
> +	 * On default hierachy, a load balance flag change is only allowed
> +	 * in a scheduling domain with no child cpuset.
> +	 */
> +	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) && balance_flag_changed &&
> +	   (!is_sched_domain(cs) || css_has_online_children(&cs->css))) {
> +		err = -EINVAL;
> +		goto out;
> +	}

The rule is actually

 - no child cpuset
 - and it must be a scheduling domain

Right?
