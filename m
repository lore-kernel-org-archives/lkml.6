Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D64C4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF61D204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF61D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbeIGB6E convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 21:58:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726265AbeIGB6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 21:58:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7FAA940261B4;
        Thu,  6 Sep 2018 21:20:41 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B0B97D4D8;
        Thu,  6 Sep 2018 21:20:38 +0000 (UTC)
Subject: Re: [PATCH v12 9/9] cpuset: Support forced turning off of partition
 flag
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <1535380884-31308-1-git-send-email-longman@redhat.com>
 <1535380884-31308-10-git-send-email-longman@redhat.com>
 <20180827164004.GE3978217@devbig004.ftw2.facebook.com>
 <0daf1f43-2292-0281-3ab8-aef20d0475dc@redhat.com>
Organization: Red Hat
Message-ID: <7a57412b-ccdd-be20-529b-89f0737ce41d@redhat.com>
Date:   Thu, 6 Sep 2018 17:20:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <0daf1f43-2292-0281-3ab8-aef20d0475dc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 21:20:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 06 Sep 2018 21:20:41 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/2018 01:50 PM, Waiman Long wrote:
> On 08/27/2018 12:40 PM, Tejun Heo wrote:
>> Hello, Waiman.
>>
>> On Mon, Aug 27, 2018 at 10:41:24AM -0400, Waiman Long wrote:
>>> Cpuset allows arbitrary modification of cpu list in "cpuset.cpus"
>>> even if the requested CPUs won't be granted in "cpuset.cpus.effective"
>>> as restricted by its parent. However, the validate_change() function
>>> will inhibit removal of CPUs that have been used in child cpusets.
>>>
>>> Being a partition root, however, limits the kind of cpu list
>>> modification that is allowed. Adding CPUs is not allowed if the new
>>> CPUs are not in the parent's effective cpu list that can be put into
>>> "cpuset.cpus.reserved". In addition, a child partition cannot exhaust
>>> all the parent's effective CPUs.
>>>
>>> Because of the implicit cpu exclusive nature of the partition root,
>>> cpu changes that break that cpu exclusivity will not be allowed. Other
>>> changes that break the conditions of being a partition root is generally
>>> allowed. However, the partition flag of the cpuset as well those of
>>> the descendant partitions will be forcefully turned off.
>> First of all, thanks a lot for your persistence.  I'm not necessarily
>> against the flag being forced off but wonder whether the same
>> config/effective approach can be used as in .cpus and .mems.  Can you
>> elaborate a bit on the choice here?
>>
>> Thank you.
> My current code has explicitly assumed the following relationship for
> partition root.
>
>     cpus_allowed = effective_cpus + reserved_cpus
>
> Also effective_cpus cannot be empty. Specifically, cpus_allowed has to
> be equal to effective_cpus before a cpuset can be made a partition root.
>
> Any changes that break the above conditions will turn off the partition
> flag forcefully. The only exception is cpu offlining where cpus_allowed
>> effective_cpus + reserved_cpus can happen.
> One reason for doing so is because reserved_cpus is hidden. So the main
> way to infer that is to do cpus_allowed - effective_cpus.
>
> It is probably doable to make cpus_allowed >= effective_cpus +
> reserved_cpus in general, but we may need to expose reserved_cpus as a
> read-only file, for instance. There may also be other complications that
> we will need to take care of if this is supported. My current preference
> is to not doing that unless there is compelling reason to do so.
>
> Cheers,
> Longman

For the current patch, one of conditions to allow users to turn on the
partition flag is cpus_allowed = effective_cpus. Once the partition flag
is on, the twos have to be the same too except with cpu offlining. This
patch is added to allow arbitrary modification to the cpuset.cpus file
except those that have already been forbidden in the existing code. When
the modification violates the rules of being a partition root, the flag
will be turned off or we will have to deny the modification request.

I am admitting that it is an easy way out in term of programming effort
as I am not sure how much effort is needed to enable arbitrary
modification to cpuset.cpus without force disabling and whether such an
effort is even worthwhile to do.

We can certainly relax the current restrictions in the future.  Any
suggestion to improve the patchset is welcome. I would really like to
see this merged in 4.20 (or maybe 5.0) kernel.

Cheers,
Longman

