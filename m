Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968CEC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 01:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A2D219E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 01:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A2D219E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeHREJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 00:09:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725763AbeHREJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 00:09:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9BD3C402751D;
        Sat, 18 Aug 2018 01:03:31 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-191.rdu2.redhat.com [10.10.120.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A9CB2156712;
        Sat, 18 Aug 2018 01:03:27 +0000 (UTC)
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
References: <20180719165201.GU72677@devbig577.frc2.facebook.com>
 <20180720113121.GJ2476@hirez.programming.kicks-ass.net>
 <20180720114549.GY72677@devbig577.frc2.facebook.com>
 <20180720154454.GR2494@hirez.programming.kicks-ass.net>
 <20180720155613.GB1934745@devbig577.frc2.facebook.com>
 <4857a9db-ebf5-24f8-c42d-d795f5c75854@redhat.com>
 <20180720163712.GU2494@hirez.programming.kicks-ass.net>
 <8c655adc-6d9e-b767-1024-5d6941c995a9@redhat.com>
 <20180720174100.GC1934745@devbig577.frc2.facebook.com>
 <446ab203-85cd-32ff-40a9-0ba22d5a2534@redhat.com>
 <20180817155946.GJ3978217@devbig004.ftw2.facebook.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <219817a9-773e-e1ea-9b85-7af15919bbc2@redhat.com>
Date:   Fri, 17 Aug 2018 21:03:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180817155946.GJ3978217@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 18 Aug 2018 01:03:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 18 Aug 2018 01:03:31 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/2018 11:59 AM, Tejun Heo wrote:
> Hello, Waiman.
>
> On Mon, Aug 13, 2018 at 01:56:15PM -0400, Waiman Long wrote:
>> The following restrictions are still imposed on a partition root wrt
>> allowable changes in cpuset.cpus:
>> 1) cpuset.cpus cannot be set to "". There must be at least 1 cpu there.
>> 2) Adding cpus that are not in parent's cpuset.cpus (as well as
>> cpuset.cpus.effective) or that will take all the parent's effective cpus
>> away is not allowed.
>>
>> So are these limitations acceptable?
>>
>> The easiest way to remove those restrictions is to forcefully turn off
>> the cpuset.sched.partition flag in the cpuset as well as any
>> sub-partitions when the user try to do that. With that change, there
>> will be no more new restriction on what you can do on cpuset.cpus.
> I think that'd be the right thing to do.  That's what we do with
> cpuset.cpus and cpuset.mems too.  If there's nothing available, we
> ignore the config and show the settings which are currently in effect.
>
> Thanks.
>
Thanks! I will send out an updated patch after the 4.19 merge window closes.

-Longman

