Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032098AbeEXK2u (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 06:28:50 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39194 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031078AbeEXK2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 06:28:42 -0400
X-Google-Smtp-Source: AB8JxZrkkrFAl9zq9QZ6rtqHUuDFKQaJ+xSnP13cMzNEs6n/F/Q7Q85toXOh2GUT2y1TKf3XOuJ0Pw==
Date: Thu, 24 May 2018 12:28:37 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v8 4/6] cpuset: Make generate_sched_domains() recognize
 isolated_cpus
Message-ID: <20180524102837.GA3948@localhost.localdomain>
References: <1526590545-3350-1-git-send-email-longman@redhat.com>
 <1526590545-3350-5-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526590545-3350-5-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/18 16:55, Waiman Long wrote:

[...]

> @@ -849,7 +860,12 @@ static void rebuild_sched_domains_locked(void)
>  	 * passing doms with offlined cpu to partition_sched_domains().
>  	 * Anyways, hotplug work item will rebuild sched domains.
>  	 */
> -	if (!cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
> +	if (!top_cpuset.isolation_count &&
> +	    !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
> +		goto out;
> +
> +	if (top_cpuset.isolation_count &&
> +	   !cpumask_subset(top_cpuset.effective_cpus, cpu_active_mask))
>  		goto out;

Do we cover the case in which hotplug removed one of the isolated cpus
from cpu_active_mask?
