Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E257C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4945F20846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4945F20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932902AbeFUIWU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:22:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932430AbeFUIWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:22:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0245C057F4E;
        Thu, 21 Jun 2018 08:22:15 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-35.phx2.redhat.com [10.3.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6563E5C54A;
        Thu, 21 Jun 2018 08:22:07 +0000 (UTC)
Subject: Re: [PATCH v10 3/9] cpuset: Simulate auto-off of sched.domain_root at
 cgroup removal
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <1529295249-5207-1-git-send-email-longman@redhat.com>
 <1529295249-5207-4-git-send-email-longman@redhat.com>
 <20180620141144.GI2494@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <6fffa761-a4ab-9974-c6b7-8c2af9d8a875@redhat.com>
Date:   Thu, 21 Jun 2018 16:22:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180620141144.GI2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 21 Jun 2018 08:22:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 10:11 PM, Peter Zijlstra wrote:
> On Mon, Jun 18, 2018 at 12:14:02PM +0800, Waiman Long wrote:
>> @@ -1058,7 +1060,12 @@ static int update_reserved_cpumask(struct cpuset *cpuset,
>>  	 * Check if any CPUs in addmask or delmask are in the effective_cpus
>>  	 * of a sibling cpuset. The implied cpu_exclusive of a scheduling
>>  	 * domain root will ensure there are no overlap in cpus_allowed.
>> +	 *
>> +	 * This check is skipped if the cpuset is dying.
> Comments that state what the code does are mostly useless; please
> explain _why_ if anything.

I  am adding more restrictions on where the domain_root can be turned on
to make sure that there will be no surprise.

I have a script to test the new cpuset v2 functionality and found that
cgroup deletion may sometime failed if there was not enough time for the
previous operation to complete. That is the reason why I relax the
checking for dying cgroup to make my test script pass.

Cheers,
Longman

