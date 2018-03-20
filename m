Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeCTUMb convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 16:12:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751343AbeCTUM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 16:12:28 -0400
Subject: Re: [PATCH v5 2/2] cpuset: Add cpuset.flags control knob to v2
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, efault@gmx.de, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
References: <1521148842-15486-1-git-send-email-longman@redhat.com>
 <1521148842-15486-3-git-send-email-longman@redhat.com>
 <20180319162654.GR2943022@devbig577.frc2.facebook.com>
 <8e553b7e-cab6-1b5d-9110-cc5770ae16c4@redhat.com>
Organization: Red Hat
Message-ID: <cbe9b852-80b6-8341-b51c-4d754d00ce53@redhat.com>
Date: Tue, 20 Mar 2018 16:12:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <8e553b7e-cab6-1b5d-9110-cc5770ae16c4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19/2018 12:33 PM, Waiman Long wrote:
> On 03/19/2018 12:26 PM, Tejun Heo wrote:
>> Hello, Waiman.
>>
>> On Thu, Mar 15, 2018 at 05:20:42PM -0400, Waiman Long wrote:
>>> +	The currently supported flag is:
>>> +
>>> +	  sched_load_balance
>>> +		When it is not set, there will be no load balancing
>>> +		among CPUs on this cpuset.  Tasks will stay in the
>>> +		CPUs they are running on and will not be moved to
>>> +		other CPUs.
>>> +
>>> +		When it is set, tasks within this cpuset will be
>>> +		load-balanced by the kernel scheduler.  Tasks will be
>>> +		moved from CPUs with high load to other CPUs within
>>> +		the same cpuset with less load periodically.
>> Hmm... looks like this is something which can be decided by the cgroup
>> itself and should be made delegatable.  Given that different flags
>> might need different delegation settings and the precedence of
>> memory.oom_group, I think it'd be better to make the flags separate
>> bool files - ie. cpuset.sched_load_balance which contains 0/1 and
>> marked delegatable.
>>
>> Thanks.
>>
> Sure. Will do that.

After some thought, I am planning to impose the following additional
constraints on how sched_load_balance works in v2.

1) sched_load_balance will be made hierarchical, the child will inherit
the flag from its parent.
2) cpu_exclusive will be implicitly associated with sched_load_balance.
IOW, sched_load_balance => !cpu_exclusive, and !sched_load_balance =>
cpu_exclusive.
3) sched_load_balance cannot be 1 on a child if it is 0 on the parent.

With these changes, sched_load_balance will have to be set by the parent
and so will not be delegatable. Please let me know your thought on that.

Cheers,
Longman
