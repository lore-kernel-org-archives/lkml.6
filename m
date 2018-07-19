Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA19CC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA6120673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA6120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbeGSOsS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:48:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731497AbeGSOsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:48:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E64987AAB;
        Thu, 19 Jul 2018 14:04:57 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2AC41C700;
        Thu, 19 Jul 2018 14:04:54 +0000 (UTC)
Subject: Re: [PATCH v11 7/9] cpuset: Expose cpus.effective and mems.effective
 on cgroup v2 root
To:     Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <1529825440-9574-1-git-send-email-longman@redhat.com>
 <1529825440-9574-8-git-send-email-longman@redhat.com>
 <20180702165322.GI533219@devbig577.frc2.facebook.com>
 <bc59aa0a-70fd-583f-452d-9a947757cb69@redhat.com>
 <20180703155823.GS533219@devbig577.frc2.facebook.com>
 <20180719135224.GE2494@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1107494a-9667-df58-dcac-9366e969dc3a@redhat.com>
Date:   Thu, 19 Jul 2018 10:04:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180719135224.GE2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 19 Jul 2018 14:04:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 19 Jul 2018 14:04:57 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/2018 09:52 AM, Peter Zijlstra wrote:
> On Tue, Jul 03, 2018 at 08:58:23AM -0700, Tejun Heo wrote:
>> Hello, Waiman.
>>
>> On Tue, Jul 03, 2018 at 08:41:31AM +0800, Waiman Long wrote:
>>>> So, effective changing when enabling partition on a child feels wrong
>>>> to me.  It's supposed to contain what's actually allowed to the cgroup
>>>> from its parent and that shouldn't change regardless of how those
>>>> resources are used.  It's still given to the cgroup from its parent.
>>> Another way to work around this issue is to expose the reserved_cpus in
>>> the parent for holding CPUs that can taken by a chid partition. That
>>> will require adding one more cpuset file for those cgroups that are
>>> partition roots.
>> Yeah, that should work.
>>
>>> I don't mind restricting that to the first level children for now. That
>>> does restrict where we can put the container root if we want a separate
>>> partition for a container. Let's hear if others have any objection about
>>> that.
>> As currently implemented, partioning locks away the cpus which should
>> be a system level decision, not container level, so it makes sense to
>> me that it is only available to system root.
> I'm terribly confused, what?!
>
> Why would a container not be allowed to create partitions for its
> various RT workloads?

As far as I understand, Tejun has some concern about the way that
partitioning works is inconsistent with how other resources are being
managed by cgroup v2 controllers. I adds an incremental patch to
temporarily disable the creation of partition below the first level
children to buy us time so that we can reach a compromise later on what
to do. We can always add features, but taking away features after they
are made available will be hard.

I am fine either way. It is up to you and Tejun to figure out what
should be made available to the users.

Cheers,
Longman


