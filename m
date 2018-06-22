Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ACAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CBB23C7B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CBB23C7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934356AbeFVDAW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 23:00:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934107AbeFVDAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 23:00:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D75530832C2;
        Fri, 22 Jun 2018 03:00:20 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-153.phx2.redhat.com [10.3.116.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F75F17101;
        Fri, 22 Jun 2018 03:00:04 +0000 (UTC)
Subject: Re: [PATCH v10 2/9] cpuset: Add new v2 cpuset.sched.domain_root flag
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
 <1529295249-5207-3-git-send-email-longman@redhat.com>
 <20180620142735.GM2494@hirez.programming.kicks-ass.net>
 <b44b0748-9fec-6bb0-7665-435487e5d8b3@redhat.com>
 <20180621092013.GU2494@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1eb82b46-aa97-2ada-5196-5d7fc1cda87d@redhat.com>
Date:   Fri, 22 Jun 2018 11:00:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180621092013.GU2494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 22 Jun 2018 03:00:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/21/2018 05:20 PM, Peter Zijlstra wrote:
> On Thu, Jun 21, 2018 at 03:58:06PM +0800, Waiman Long wrote:
>
>> As for the inconsistency between the real root and the container root,
>> this is true for almost all the controllers. So it is a generic problem.
>> One possible solution is to create a kind a pseudo root cgroup for the
>> container that looks and feels like a real root. But is there really a
>> need to do that?
> I don't really know. I thought the idea was to make containers
> indistinguishable from a real system. Now I know we're really rather far
> away from that in reality, and I really have no clue how important all
> that is.

That will certainly be the ideal.

> It all depends on how exactly this works; is it like I assumed, that
> this file is owned by the parent instead of the current directory? And
> that if you namespace this, you have an effective read-only file?

Yes, that is right.

> Then fixing the inconsistency is trivial; simply provide a read-only
> file for the actual root cgroup too.
>
> And if the solution is trivial, I don't see a good reason not to do it.

Do you mean providing a flag like READONLY_AT_ROOT so that it will be
read-only at the real root? That is an cgroup architectural decision
that needs input from Tejun. Anyway, this issue is not specific to this
patchset and I would like to break it out as a separate discussion
independent of this patchset.

Cheers,
Longman


