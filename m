Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B41ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8EB20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8EB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbeGTRIa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:08:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387855AbeGTRIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:08:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D72A81A4EA6;
        Fri, 20 Jul 2018 16:19:30 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A7FA2026D69;
        Fri, 20 Jul 2018 16:19:29 +0000 (UTC)
Subject: Re: [PATCH v11 7/9] cpuset: Expose cpus.effective and mems.effective
 on cgroup v2 root
To:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <bc59aa0a-70fd-583f-452d-9a947757cb69@redhat.com>
 <20180703155823.GS533219@devbig577.frc2.facebook.com>
 <20180719135224.GE2494@hirez.programming.kicks-ass.net>
 <1107494a-9667-df58-dcac-9366e969dc3a@redhat.com>
 <20180719153045.GT72677@devbig577.frc2.facebook.com>
 <de6f931d-613a-3e6a-2a4d-0e49b3bfe2e5@redhat.com>
 <20180719165201.GU72677@devbig577.frc2.facebook.com>
 <20180720113121.GJ2476@hirez.programming.kicks-ass.net>
 <20180720114549.GY72677@devbig577.frc2.facebook.com>
 <20180720154454.GR2494@hirez.programming.kicks-ass.net>
 <20180720155613.GB1934745@devbig577.frc2.facebook.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <4857a9db-ebf5-24f8-c42d-d795f5c75854@redhat.com>
Date:   Fri, 20 Jul 2018 12:19:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180720155613.GB1934745@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 20 Jul 2018 16:19:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 20 Jul 2018 16:19:30 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/2018 11:56 AM, Tejun Heo wrote:
> Hello, Peter.
>
> On Fri, Jul 20, 2018 at 05:44:54PM +0200, Peter Zijlstra wrote:
>>> The currently proposed implementation is somewhere in the middle.  It
>>> kinda gets there by restricting a partition to be a child of another
>>> partition, which may be okay but it does make the whole delegation
>>> mechanism less useful.
>> So the implementation does not set ownership of the 'partition' file to
>> that of the parent directory? Because _that_ is what I understood from
>> Waiman (many versions ago). And that _does_ allow delegation to work
>> nicely.
> So, that part isn't the problem.  The problem is that if we allow
> partitioning nested further away from ancestor, the descendant would
> be able to take away reources from the removed ancestor.  Waiman
> avoids this problem by only allowing partitions to nest but then it's
> kinda weird cuz it's just a separate tree.

The rationale behind the current design is that a parent is allowed to
create a child partition if it fully owns all the cpus it has. That is
true only if it is a partition itself. IOW, making a cpuset a partition
won't affect any ancestors other than the parent.


>>>>> 2. take away any given cpu from ist subtree.
>>>> I really hate this obsession of yours and doubly so for partitions. But
>>>> why would this currently not be allowed?
>>> Well, sorry that you hate it.  It's a fundamental architectural
>>> constraint.  If it can't satisfy that, it should't be in cgroup.
>> So is hierarchical behaviour; but you seem willing to forgo that.
> Well, we do have root or first-level only things.  Things just need to
> be properly delegatable when they're hierarchical (and things should
> be hierarchical only when that actually means something).  While not
> desirable, considering the history, accomodating this specific usage
> that way seems acceptable to me.

I am not against the idea of making it hierarchical eventually. I am
just hoping to get thing going by merging the patchset in its current
form and then we can make it hierarchical in a followup patch.

Cheers,
Longman

