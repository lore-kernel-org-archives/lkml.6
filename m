Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAC4C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B3920846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B3920846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754299AbeFUHlH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:41:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751150AbeFUHlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:41:04 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8DF381DEA;
        Thu, 21 Jun 2018 07:41:03 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-35.phx2.redhat.com [10.3.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6AB91001646;
        Thu, 21 Jun 2018 07:40:56 +0000 (UTC)
Subject: Re: [PATCH v9 3/7] cpuset: Add cpuset.sched.load_balance flag to v2
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>
References: <1527601294-3444-1-git-send-email-longman@redhat.com>
 <1527601294-3444-4-git-send-email-longman@redhat.com>
 <20180531122638.GJ12180@hirez.programming.kicks-ass.net>
 <42cc1f44-2355-1c0c-b575-49c863303c42@redhat.com>
 <20180531152050.GK12180@hirez.programming.kicks-ass.net>
 <ebe7f0c1-b2dc-57ad-e5cb-7edf0fee4626@redhat.com>
 <20180531160857.GM12180@hirez.programming.kicks-ass.net>
 <54c607c3-e742-4da9-c89a-4ed54146e3bd@redhat.com>
 <20180620144613.GP2476@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <560427ef-a592-9389-3334-45c8e44d43e8@redhat.com>
Date:   Thu, 21 Jun 2018 15:40:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180620144613.GP2476@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 21 Jun 2018 07:41:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 10:46 PM, Peter Zijlstra wrote:
> On Thu, May 31, 2018 at 12:42:20PM -0400, Waiman Long wrote:
>> Thinking about isolcpus emulation, I now realize that it is more than
>> just disabling load balancing. it also disables some kernel threads like
>> kworker from running so that an userspace application can monopolize as
>> much of a cpu as possible. Disabling kernel threads from running isn't
>> that hard if it is only done once at boot time. it is trickier if we
>> have to do it at run time.
> Don't think it is all that difficult, we just need a notifier for when
> that housekeeping thing changes and ensure that everybody who uses it
> re-evaluates crap.

Yes, it is certainly doable. I can work on that on my free time once the
first cpuset v2 patch is done. There is enough complexity in the current
patchset and I don't want to add stuff that is not a part of the core
cpuset functionality at this point. We can also add new feature in the
future, but once it is in, it is hard to change it.

>> Without good isolcpus emulation, disabling load balance kind of loses
>> its usefulness. So I am going to take out the load_balance flag for now
>> unless I hear objection otherwise.
> I'm not seeing the direct link between the load_balance flag and
> isolcpus emulation in the proposed stuff.
>
> We can tie the housekeeping mask to whatever CPUs remain in the root
> cgroup, couple that to that notifier and it should all just work I
> think.

The group of cpus in isolcpus are outside the reach of the scheduler and
so is equivalent to turning off load balancing in that sense. Of course,
there may also be other stuff that need to be considered in order to
have a proper emulation of isolcpus.

Cheers,
Longman


