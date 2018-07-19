Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF758C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE2D2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE2D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbeGSQgj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:36:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeGSQgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:36:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB84E407563F;
        Thu, 19 Jul 2018 15:52:50 +0000 (UTC)
Received: from llong.remote.csb (ovpn-125-125.rdu2.redhat.com [10.10.125.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0917D2156897;
        Thu, 19 Jul 2018 15:52:46 +0000 (UTC)
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
References: <1529825440-9574-1-git-send-email-longman@redhat.com>
 <1529825440-9574-8-git-send-email-longman@redhat.com>
 <20180702165322.GI533219@devbig577.frc2.facebook.com>
 <bc59aa0a-70fd-583f-452d-9a947757cb69@redhat.com>
 <20180703155823.GS533219@devbig577.frc2.facebook.com>
 <20180719135224.GE2494@hirez.programming.kicks-ass.net>
 <1107494a-9667-df58-dcac-9366e969dc3a@redhat.com>
 <20180719153045.GT72677@devbig577.frc2.facebook.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <de6f931d-613a-3e6a-2a4d-0e49b3bfe2e5@redhat.com>
Date:   Thu, 19 Jul 2018 11:52:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180719153045.GT72677@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 19 Jul 2018 15:52:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 19 Jul 2018 15:52:50 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/2018 11:30 AM, Tejun Heo wrote:
> Hello,
>
> On Thu, Jul 19, 2018 at 10:04:54AM -0400, Waiman Long wrote:
>>> Why would a container not be allowed to create partitions for its
>>> various RT workloads?
>> As far as I understand, Tejun has some concern about the way that
>> partitioning works is inconsistent with how other resources are being
>> managed by cgroup v2 controllers. I adds an incremental patch to
>> temporarily disable the creation of partition below the first level
>> children to buy us time so that we can reach a compromise later on what
>> to do. We can always add features, but taking away features after they
>> are made available will be hard.
>>
>> I am fine either way. It is up to you and Tejun to figure out what
>> should be made available to the users.
> So, the main thing is that putting a cpu into a partition locks away
> the cpu from its ancestors.  That's a system level operation which
> isn't delegatable.  If we want to allow partitioning in subtrees, the
> parent still be able to take away partitioned cpus too even if that
> means ignoring descendants' configurations, which btw is exactly what
> cpuset does for non-partition configs.
>
> I don't think this would be technically too challenging to implement,
> but unless there are immediate use cases for it, we can start simpler
> & restricted.
>
> Thanks.
>
BTW, the way the partition is currently implemented right now is that a
child cannot be a partition root unless its parent is a partition root
itself. That is to avoid turning on partition to affect ancestors
further up the hierarchy than just the parent. So in the case of a
container, it cannot allocate sub-partitions underneath it unless it is
a partition itself. Will that solve your concern?

Thanks,
Longman


