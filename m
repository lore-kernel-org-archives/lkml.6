Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753583AbeCTNvZ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:51:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753324AbeCTNvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:51:22 -0400
Subject: Re: [PATCH v5 1/2] cpuset: Enable cpuset controller in default
 hierarchy
To: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, efault@gmx.de, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
References: <1521148842-15486-1-git-send-email-longman@redhat.com>
 <1521148842-15486-2-git-send-email-longman@redhat.com>
 <20180319155937.GQ2943022@devbig577.frc2.facebook.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1881c1da-56ec-d76b-b736-fd0919737ec6@redhat.com>
Date: Tue, 20 Mar 2018 09:51:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180319155937.GQ2943022@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19/2018 11:59 AM, Tejun Heo wrote:
> Hello, Waiman.
>
> This looks great.  A couple nitpicks below.
>
>> +     5-3. Cpuset
>> +       5.3-1. Cpuset Interface Files
> Can we put cpuset below pid?  It feels weird to break up cpu, memory
> and io as they represent the three major resources and are in a
> similar fashion.
Sure. I will move it down below pid.

>> +  cpuset.effective_cpus
>> +	A read-only multiple values file which exists on non-root
>> +	cgroups.
>> +
>> +	It lists the onlined CPUs that are actually allowed to be
>> +	used by tasks within the current cgroup. It is a subset of
>> +	"cpuset.cpus".  Its value will be affected by CPU hotplug
>> +	events.
> Can we do cpuset.cpus.availble which lists the cpus available to the
> cgroup instead of the eventual computed mask for the cgroup?  That'd
> be more useful as it doesn't lose the information by and'ing what's
> available with the cgroup's mask and it's trivial to determine the
> effective from the two masks.

I don't get what you want here. cpus is the cpuset's cpus_allowed mask.
effective_cpus is the effective_cpus mask. When you say cpus available
to the cgroup, do you mean the cpu_online_mask or the list of cpus from
the parent? Or do you just want to change the name to cpus.available
instead of effective_cpus?

>> +  cpuset.effective_mems
>> +	A read-only multiple values file which exists on non-root
>> +	cgroups.
>> +
>> +	It lists the onlined memory nodes that are actually allowed
>> +	to be used by tasks within the current cgroup.  It is a subset
>> +	of "cpuset.mems".  Its value will be affected by memory nodes
>> +	hotplug events.
> Ditto.
>
>> +static struct cftype dfl_files[] = {
>> +	{
>> +		.name = "cpus",
>> +		.seq_show = cpuset_common_seq_show,
>> +		.write = cpuset_write_resmask,
>> +		.max_write_len = (100U + 6 * NR_CPUS),
>> +		.private = FILE_CPULIST,
>> +	},
> Is it missing CFTYPE_NOT_ON_ROOT?  Other files too.

Right, I will set CFTYPE_NOT_ON_ROOT to "cpus" and "mems" as we are not
supposed to change them in the root. The effective_cpus and
effective_mems will be there in the root to show what are available.

Cheers,
Longman
