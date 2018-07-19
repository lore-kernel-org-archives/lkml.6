Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46D4C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A2220671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A2220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbeGSSGr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:06:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731661AbeGSSGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:06:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35AD081A8EA9;
        Thu, 19 Jul 2018 17:22:38 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0F192026D6B;
        Thu, 19 Jul 2018 17:22:36 +0000 (UTC)
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
 <de6f931d-613a-3e6a-2a4d-0e49b3bfe2e5@redhat.com>
 <20180719165201.GU72677@devbig577.frc2.facebook.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <69903192-8711-6a1e-0cd0-fbb249a4204b@redhat.com>
Date:   Thu, 19 Jul 2018 13:22:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180719165201.GU72677@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 19 Jul 2018 17:22:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 19 Jul 2018 17:22:38 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/2018 12:52 PM, Tejun Heo wrote:
> Hello,
>
> On Thu, Jul 19, 2018 at 11:52:46AM -0400, Waiman Long wrote:
>> BTW, the way the partition is currently implemented right now is that a
>> child cannot be a partition root unless its parent is a partition root
>> itself. That is to avoid turning on partition to affect ancestors
>> further up the hierarchy than just the parent. So in the case of a
>> container, it cannot allocate sub-partitions underneath it unless it is
>> a partition itself. Will that solve your concern?
> Hmm... so a given ancestor must be able to both
>
> 1. control which cpus are moved into a partition in all of its
>    subtree.

Not at the moment. I do have another idea of adding a "cpus.subpart"
file, for example, to indicate what CPUs a child sub-partition can use
in its partition. This control file only serves as an intention to
grant, it won't affect anything else. Before the partition flag can be
turned on, the kernel will have to check if the cpu list of the child is
also a subset of its parent's cpus.subpart as a precondition. Does that
serve the purpose of letting a parent has a say of what CPUs can be
included in a child partition?

This change will require adding a new cpumask into the cpuset structure,
the code to handle the mask as well as an additional check in the
partition enable code. That will have minimal impact to the current code.

> 2. take away any given cpu from ist subtree.
>
> Right now, I don't think it's achieving either, right?

The only way to take away the CPUs from a sub-partition is to turn off
the partition flag in the child provided that it has no sub-partitions
underneath it.

Do you want a way at the parent level to take CPUs away from child
partitions? The "cpus.subpart" file can probably be used also for this
purpose, but we have to decide what taking CPUs away from child
partition means. Does that mean automatically turn off the partition
flag in the children if there is no CPU left in the partition? There are
some implementation details that need to be fleshed out. I would prefer
not doing this as this will complicate the code without too much benefit
that I can see.

Cheers,
Longman


