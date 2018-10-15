Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ED9C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764B5208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764B5208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeJPC2Z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:28:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34905 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbeJPC2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:28:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 483F030832D8;
        Mon, 15 Oct 2018 18:41:58 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12CB5413C;
        Mon, 15 Oct 2018 18:41:55 +0000 (UTC)
Subject: Re: [PATCH v13 01/11] cpuset: Enable cpuset controller in default
 hierarchy
To:     Tom Hromatka <tom.hromatka@oracle.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <1539366951-8498-1-git-send-email-longman@redhat.com>
 <1539366951-8498-2-git-send-email-longman@redhat.com>
 <bfa8d0a2-ce78-8a0b-2a2e-45b02d6a8239@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <ebff503c-291c-345c-a0ab-e2a4ceb6ad0c@redhat.com>
Date:   Mon, 15 Oct 2018 14:41:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <bfa8d0a2-ce78-8a0b-2a2e-45b02d6a8239@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 15 Oct 2018 18:41:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/2018 02:31 PM, Tom Hromatka wrote:
>
>
> On 10/12/2018 11:55 AM, Waiman Long wrote:
>> Given the fact that thread mode had been merged into 4.14, it is now
>> time to enable cpuset to be used in the default hierarchy (cgroup v2)
>> as it is clearly threaded.
>>
>> The cpuset controller had experienced feature creep since its
>> introduction more than a decade ago. Besides the core cpus and mems
>> control files to limit cpus and memory nodes, there are a bunch of
>> additional features that can be controlled from the userspace. Some of
>> the features are of doubtful usefulness and may not be actively used.
>>
>> This patch enables cpuset controller in the default hierarchy with
>> a minimal set of features, namely just the cpus and mems and their
>> effective_* counterparts.  We can certainly add more features to the
>> default hierarchy in the future if there is a real user need for them
>> later on.
>
> I really appreciate this simplification of the cpuset controller.
>
> I currently have an in-house customer that is unhappy with the
> way cgroups cpuset v1 handles offlined CPUs.  This patchset makes two
> significant improvements over current cpuset v1 behavior.  1) It allows
> for offlined CPUs to be added to a cpuset (even though the CPU is
> offline) and 2) it restores CPUs back to the requested cpuset when they
> come back online.  This is more intuitive and secure for my customers.
> Thank you!
>
> In part because of this patchset, I plan on proposing similar behavior
> for offlined CPUs to cpuset v1.
>
> Thanks.
>
> Tom

If you are just talking about the ability for cpuset to revert back to
its original state when an offlined CPU becomes online again, that
capability can be activated in v1 using the "cpuset_v2_mode" mount
option when mounting the cpuset cgroup. However, that is not the default
for v1.

-Longman


