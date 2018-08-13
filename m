Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F53C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DB92175D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DB92175D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbeHMUjc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 16:39:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728661AbeHMUjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 16:39:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B9EF04219DC7;
        Mon, 13 Aug 2018 17:56:16 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-66.bos.redhat.com [10.18.17.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95B572166BA0;
        Mon, 13 Aug 2018 17:56:15 +0000 (UTC)
Subject: Re: [PATCH v11 7/9] cpuset: Expose cpus.effective and mems.effective
 on cgroup v2 root
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <20180719153045.GT72677@devbig577.frc2.facebook.com>
 <de6f931d-613a-3e6a-2a4d-0e49b3bfe2e5@redhat.com>
 <20180719165201.GU72677@devbig577.frc2.facebook.com>
 <20180720113121.GJ2476@hirez.programming.kicks-ass.net>
 <20180720114549.GY72677@devbig577.frc2.facebook.com>
 <20180720154454.GR2494@hirez.programming.kicks-ass.net>
 <20180720155613.GB1934745@devbig577.frc2.facebook.com>
 <4857a9db-ebf5-24f8-c42d-d795f5c75854@redhat.com>
 <20180720163712.GU2494@hirez.programming.kicks-ass.net>
 <8c655adc-6d9e-b767-1024-5d6941c995a9@redhat.com>
 <20180720174100.GC1934745@devbig577.frc2.facebook.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <446ab203-85cd-32ff-40a9-0ba22d5a2534@redhat.com>
Date:   Mon, 13 Aug 2018 13:56:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180720174100.GC1934745@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 13 Aug 2018 17:56:16 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 13 Aug 2018 17:56:16 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/2018 01:41 PM, Tejun Heo wrote:
> Hello,
>
> On Fri, Jul 20, 2018 at 01:09:23PM -0400, Waiman Long wrote:
>> On 07/20/2018 12:37 PM, Peter Zijlstra wrote:
>>> On Fri, Jul 20, 2018 at 12:19:29PM -0400, Waiman Long wrote:
>>>> I am not against the idea of making it hierarchical eventually. I am
>>>> just hoping to get thing going by merging the patchset in its current
>>>> form and then we can make it hierarchical in a followup patch.
>>> Where's the rush? Why can't we do this right in one go?
>> For me, the rush comes from RHEL8 as it is a goal to have a fully
>> functioning cgroup v2 in that release.
>>
>> I also believe that most of the use cases of partition can be satisfied
>> with partitions at the first level children. Getting hierarchical
>> partition right may drag on for half a year, maybe, giving our history
>> with cpu v2 controller. No matter what we do to enable hierarchical
>> partition in the future, the current model of using a partition flag is
>> intuitive enough that it won't be changed at least for the first level
>> children.
> I'm fully with Waiman here.  There are people wanting to use it and
> the part most people isn't controversial at all.  I don't see what'd
> be gained by further delaying the whole thing.  If the first level
> partition thing isn't acceptable to everyone, we can even strip down
> further.  We can get .cpus and .mems merged first, which is what most
> people want anyway.

BTW, I am trying to support hierarchical partition. The first thing that
I want to support is to allow removing CPUs from partition root freely.
It turns out that the following existing code in validate_change() will
prevent the removal from happening when it touches any CPUs that are
used in child cpusets:

        /* Each of our child cpusets must be a subset of us */
        ret = -EBUSY;
        cpuset_for_each_child(c, css, cur)
                if (!is_cpuset_subset(c, trial))
                        goto out;

So this is not a new restriction after all.

The following restrictions are still imposed on a partition root wrt
allowable changes in cpuset.cpus:
1) cpuset.cpus cannot be set to "". There must be at least 1 cpu there.
2) Adding cpus that are not in parent's cpuset.cpus (as well as
cpuset.cpus.effective) or that will take all the parent's effective cpus
away is not allowed.

So are these limitations acceptable?

The easiest way to remove those restrictions is to forcefully turn off
the cpuset.sched.partition flag in the cpuset as well as any
sub-partitions when the user try to do that. With that change, there
will be no more new restriction on what you can do on cpuset.cpus.

What is your opinion on the best way forward wrt supporting hierarchical
partitioning?

Thanks,
Longman

