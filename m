Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F22AC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA72208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA72208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934463AbeGJQJX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:09:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934322AbeGJQJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:09:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC8DE814F0A5;
        Tue, 10 Jul 2018 16:09:19 +0000 (UTC)
Received: from llong.remote.csb (ovpn-122-125.rdu2.redhat.com [10.10.122.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 107882156889;
        Tue, 10 Jul 2018 16:09:17 +0000 (UTC)
Subject: Re: [PATCH v6 0/7] fs/dcache: Track & limit # of negative dentries
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>
References: <1530905572-817-1-git-send-email-longman@redhat.com>
 <20180709081920.GD22049@dhcp22.suse.cz>
 <62275711-e01d-7dbe-06f1-bf094b618195@redhat.com>
 <20180710142740.GQ14284@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a2794bcc-9193-cbca-3a54-47420a2ab52c@redhat.com>
Date:   Tue, 10 Jul 2018 12:09:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180710142740.GQ14284@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 10 Jul 2018 16:09:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 10 Jul 2018 16:09:20 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 10:27 AM, Michal Hocko wrote:
> On Mon 09-07-18 12:01:04, Waiman Long wrote:
>> On 07/09/2018 04:19 AM, Michal Hocko wrote:
> [...]
>>> later needs a special treatment while the first one is ok? There are
>>> quite some resources which allow a non privileged user to consume a lot
>>> of memory and the memory controller is the only reliable way to mitigate
>>> the risk.
>> Yes, memory controller is the only reliable way to mitigate the risk,
>> but not all tasks are under the control of a memory controller with
>> kernel memory limit.
> But those which you do not trust should. So why do we need yet another
> mechanism for the reclaim?

Sometimes it could be a programming error in the code. I had seen a
customer report about the negative dentries because of a bug in their
code that generated a lot of negative dentries causing problem. In such
a controlled environment, they may not want to run their applications
under a memory cgroup as there is overhead involved in that. So a
mechanism to highlight and notify the problem is probably good to have.

>
> [...]
>>>> Patch 1 tracks the number of negative dentries present in the LRU
>>>> lists and reports it in /proc/sys/fs/dentry-state.
>>> If anything I _think_ vmstat would benefit from this because behavior of
>>> the memory reclaim does depend on the amount of neg. dentries.
>>>
>>>> Patch 2 adds a "neg-dentry-pc" sysctl parameter that can be used to to
>>>> specify a soft limit on the number of negative allowed as a percentage
>>>> of total system memory. This parameter is 0 by default which means no
>>>> negative dentry limiting will be performed.
>>> percentage has turned out to be a really wrong unit for many tunables
>>> over time. Even 1% can be just too much on really large machines.
>> Yes, that is true. Do you have any suggestion of what kind of unit
>> should be used? I can scale down the unit to 0.1% of the system memory.
>> Alternatively, one unit can be 10k/cpu thread, so a 20-thread system
>> corresponds to 200k, etc.
> I simply think this is a strange user interface. How much is a
> reasonable number? How can any admin figure that out?

Without the optional enforcement, the limit is essentially just a
notification mechanism where the system signals that there is something
wrong going on and the system administrator need to take a look. So it
is perfectly OK if the limit is sufficiently high that normally we won't
need to use that many negative dentries. The goal is to prevent negative
dentries from consuming a significant portion of the system memory.

I am going to reduce the granularity of each unit to 1/1000 of the total
system memory so that for large system with TB of memory, a smaller
amount of memory can be specified.

>>>> Patch 3 enables automatic pruning of least recently used negative
>>>> dentries when the total number is close to the preset limit.
>>> Please explain why this cannot be done in a standard dcache shrinking
>>> way. I strongly suspect that you are developing yet another reclaim with
>>> its own sets of tunable and bypassing the existing infrastructure. I
>>> haven't read patches yet but the cover letter doesn't really explain
>>> design much so I am only guessing.
>> The standard dcache shrinking happens when the system is almost running
>> out of free memory.
> Well, the standard reclaim happens when somebody needs memory. We are
> usually quite far away from "almost running out of memory". We do
> reclaim fs metadata including dentries so I really do not see why
> negative ones should be any special here.

That is fine. I can certainly live without the new reclaim mechanism.

>
>> This new shrinker will be turned on when the number
>> of negative dentries is closed to the limit even when there are still
>> plenty of free memory left. It will stop when the number of negative
>> dentries is lowered to a safe level. The new shrinker is designed to
>> impose as little overhead to the currently running tasks. That is not
>> true for the standard shrinker which will have a rather significant
>> performance impact to the currently running tasks.
> Do you have any numbers to back your claim? The memory reclaim is
> usually quite lightweight. Especially when we have a lot of clean
> fs {meta}data

In the case of dentries, it is the lock hold time of the LRU list that
can impact the normal filesystem operation. The new shrinker that I add
purposely limit the lock hold time whereas the standard shrinker can
hold the LRU for quite a long time if there are a lot of dentries to get
rid of. I have some performance numbers in the cover letter of this
patch about this.

>> I can remove the new shrinker if people really don't want to add a new
>> one as long as I can keep the option to kill off newly created negative
>> dentries when the limit is exceeded.
> Please let's not add yet another memory reclaim mechanism. It will just
> backfire sooner or later.

As said above, I am going to remove the new shrinker in the next version
of the patch. We can always add it back later on if we feel there is a
need to do it.

Cheers,
Longman


