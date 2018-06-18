Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA00C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37A520852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37A520852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965471AbeFRPH3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:07:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964942AbeFRPHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:07:25 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35A3130820CA;
        Mon, 18 Jun 2018 15:07:25 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-25.phx2.redhat.com [10.3.117.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A69F6308BDA2;
        Mon, 18 Jun 2018 15:07:17 +0000 (UTC)
Subject: Re: [PATCH v10 0/9] cpuset: Enable cpuset controller in default
 hierarchy
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <1529295249-5207-1-git-send-email-longman@redhat.com>
 <20180618142036.GA13097@localhost.localdomain>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <dc91e2ad-239d-3144-0814-c5da181f4ac6@redhat.com>
Date:   Mon, 18 Jun 2018 23:07:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180618142036.GA13097@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 18 Jun 2018 15:07:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 10:20 PM, Juri Lelli wrote:
> Hi,
>
> On 18/06/18 12:13, Waiman Long wrote:
>> v10:
>>  - Remove the cpuset.sched.load_balance patch for now as it may not
>>    be that useful.
>>  - Break the large patch 2 into smaller patches to make them a bit
>>    easier to review.
>>  - Test and fix issues related to changing "cpuset.cpus" and cpu
>>    online/offline in a domain root.
>>  - Rename isolated_cpus to reserved_cpus as this cpumask holds CPUs
>>    reserved for child sched domains.
>>  - Rework the scheduling domain debug printing code in the last patch.
>>  - Document update to the newly moved
>>    Documentation/admin-guide/cgroup-v2.rst.
> There seem to be two (similar but different) 6/9 in the set. Something
> went wrong?

The isolated_cpus patch is old, I forgot to remove it before sending out
the patch.


> Also I can't seem to be able to create a subgroup with an isolated
> domain root. I think that, when doing the following
>
>  # mount -t cgroup2 none /sys/fs/cgroup
>  # echo "+cpuset" >/sys/fs/cgroup/cgroup.subtree_control 
>  # mkdir /sys/fs/cgroup/g1
>  # echo 0-1 >/sys/fs/cgroup/g1/cpuset.cpus
>  # echo 1 >/sys/fs/cgroup/g1/cpuset.sched.domain_root
>
> rebuild_sched_domains_locked exits early, since
> top_cpuset.effective_cpus != cpu_active_mask. (effective_cpus being 2-3
> at this point since I'm testing this on a 0-3 system)
>
> In your v9 this [1] was adding a special condition to make rebuilding of
> domains happen. Was the change intentional?

Can you reply to the relevant patch to pinpoint what condition are you
talking about? I do try to eliminate domain rebuild as much as possible,
but I am just not sure which condition you have question about.

Cheers,
Longman



