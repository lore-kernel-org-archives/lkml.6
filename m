Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613FBC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C2624EC1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C2624EC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeGCAlm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 20:41:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752741AbeGCAlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 20:41:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DAAC1F122D;
        Tue,  3 Jul 2018 00:41:39 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-30.sin2.redhat.com [10.67.116.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 603402026D76;
        Tue,  3 Jul 2018 00:41:32 +0000 (UTC)
Subject: Re: [PATCH v11 7/9] cpuset: Expose cpus.effective and mems.effective
 on cgroup v2 root
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
References: <1529825440-9574-1-git-send-email-longman@redhat.com>
 <1529825440-9574-8-git-send-email-longman@redhat.com>
 <20180702165322.GI533219@devbig577.frc2.facebook.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <bc59aa0a-70fd-583f-452d-9a947757cb69@redhat.com>
Date:   Tue, 3 Jul 2018 08:41:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180702165322.GI533219@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 03 Jul 2018 00:41:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 03 Jul 2018 00:41:40 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 12:53 AM, Tejun Heo wrote:
> Hello, Waiman.
>
> On Sun, Jun 24, 2018 at 03:30:38PM +0800, Waiman Long wrote:
>> Because of the fact that setting the "cpuset.sched.partition" in
>> a direct child of root can remove CPUs from the root's effective CPU
>> list, it makes sense to know what CPUs are left in the root cgroup for
>> scheduling purpose. So the "cpuset.cpus.effective" control file is now
>> exposed in the v2 cgroup root.
> So, effective changing when enabling partition on a child feels wrong
> to me.  It's supposed to contain what's actually allowed to the cgroup
> from its parent and that shouldn't change regardless of how those
> resources are used.  It's still given to the cgroup from its parent.

Another way to work around this issue is to expose the reserved_cpus in
the parent for holding CPUs that can taken by a chid partition. That
will require adding one more cpuset file for those cgroups that are
partition roots.

> It's a bit different because the way partition behaves is different
> from other resource konbs in that it locks away those cpus so that
> they can't be taken back.
>
> What do people think about restricting partition to the first level
> children for now at least?  That way we aren't locked into the special
> semantics and we can figure out how to this down the hierarchy later.
> Given that we ignore the regular cpuset settings when the set goes
> empty (which also is a special condition which only exists for cpuset)
> and inherits the parent's, I think the consistent thing to do is doing
> the same for partition - if it can't be satisfied, ignore it, but
> maybe there is a better way.

I don't mind restricting that to the first level children for now. That
does restrict where we can put the container root if we want a separate
partition for a container. Let's hear if others have any objection about
that.

Cheers,
Longman



