Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970553AbeCSVeC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:34:02 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:46147 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965043AbeCSP7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:40 -0400
X-Google-Smtp-Source: AG47ELubZqdzN6gnLxtx/A8CR2pV/hsz5qqwNRbRvX0pshJWEx3+Fo991RshmZreqXtSzmeU80nIrg==
Date: Mon, 19 Mar 2018 08:59:37 -0700
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, efault@gmx.de, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v5 1/2] cpuset: Enable cpuset controller in default
 hierarchy
Message-ID: <20180319155937.GQ2943022@devbig577.frc2.facebook.com>
References: <1521148842-15486-1-git-send-email-longman@redhat.com>
 <1521148842-15486-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521148842-15486-2-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Waiman.

This looks great.  A couple nitpicks below.

> +     5-3. Cpuset
> +       5.3-1. Cpuset Interface Files

Can we put cpuset below pid?  It feels weird to break up cpu, memory
and io as they represent the three major resources and are in a
similar fashion.

> +  cpuset.effective_cpus
> +	A read-only multiple values file which exists on non-root
> +	cgroups.
> +
> +	It lists the onlined CPUs that are actually allowed to be
> +	used by tasks within the current cgroup. It is a subset of
> +	"cpuset.cpus".  Its value will be affected by CPU hotplug
> +	events.

Can we do cpuset.cpus.availble which lists the cpus available to the
cgroup instead of the eventual computed mask for the cgroup?  That'd
be more useful as it doesn't lose the information by and'ing what's
available with the cgroup's mask and it's trivial to determine the
effective from the two masks.

> +  cpuset.effective_mems
> +	A read-only multiple values file which exists on non-root
> +	cgroups.
> +
> +	It lists the onlined memory nodes that are actually allowed
> +	to be used by tasks within the current cgroup.  It is a subset
> +	of "cpuset.mems".  Its value will be affected by memory nodes
> +	hotplug events.

Ditto.

> +static struct cftype dfl_files[] = {
> +	{
> +		.name = "cpus",
> +		.seq_show = cpuset_common_seq_show,
> +		.write = cpuset_write_resmask,
> +		.max_write_len = (100U + 6 * NR_CPUS),
> +		.private = FILE_CPULIST,
> +	},

Is it missing CFTYPE_NOT_ON_ROOT?  Other files too.

Thanks.

-- 
tejun
