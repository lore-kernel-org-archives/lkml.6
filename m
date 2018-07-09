Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BAEC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891E020878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891E020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933933AbeGIQBK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:01:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932795AbeGIQBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:01:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D78CE7D84D;
        Mon,  9 Jul 2018 16:01:05 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0708D7C4A;
        Mon,  9 Jul 2018 16:01:05 +0000 (UTC)
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
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <62275711-e01d-7dbe-06f1-bf094b618195@redhat.com>
Date:   Mon, 9 Jul 2018 12:01:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180709081920.GD22049@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 09 Jul 2018 16:01:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 09 Jul 2018 16:01:05 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 04:19 AM, Michal Hocko wrote:
> On Fri 06-07-18 15:32:45, Waiman Long wrote:
> [...]
>> A rogue application can potentially create a large number of negative
>> dentries in the system consuming most of the memory available if it
>> is not under the direct control of a memory controller that enforce
>> kernel memory limit.
> How does this differ from other untracked allocations for untrusted
> tasks in general? E.g. nothing really prevents a task to create a long
> chain of unreclaimable dentries and even go to OOM potentially. Negative
> dentries should be easily reclaimable on the other hand. So why does the

I think all dentries are reclaimable. Yes, a rogue application or user
can create million of new files and hence dentries or consuming buffer
cache. The major difference here is the other attack can be very
noticeable and traceable. Filesystem limits may also be hit first before
the system is running out of memory. The negative dentry attack,
however, is more hidden and not easily traceable. So you won't know the
system is in trouble until it is almost running out of free memory.


> later needs a special treatment while the first one is ok? There are
> quite some resources which allow a non privileged user to consume a lot
> of memory and the memory controller is the only reliable way to mitigate
> the risk.

Yes, memory controller is the only reliable way to mitigate the risk,
but not all tasks are under the control of a memory controller with
kernel memory limit.

>> This patchset introduces changes to the dcache subsystem to track and
>> optionally limit the number of negative dentries allowed to be created by
>> background pruning of excess negative dentries or even kill it after use.
>> This capability will help to limit the amount of memory that can be
>> consumed by negative dentries.
> How are you going to balance that between workload? What prevents a
> rogue application to simply consume the limit and force all others in
> the system to go slow path?

With the current patchset, it is possible for a rogue application to
force every one else to go to slow path. One possible solution to this
is to go to the slowpath only for the newly created neg dentries, not
for those that have been created previously and reused again. Patch 5 of
the current series track which negative dentry is newly created and
handle it differently. I can move this up the series and use that
information to decide if we should go to the slowpath.

>> Patch 1 tracks the number of negative dentries present in the LRU
>> lists and reports it in /proc/sys/fs/dentry-state.
> If anything I _think_ vmstat would benefit from this because behavior of
> the memory reclaim does depend on the amount of neg. dentries.
>
>> Patch 2 adds a "neg-dentry-pc" sysctl parameter that can be used to to
>> specify a soft limit on the number of negative allowed as a percentage
>> of total system memory. This parameter is 0 by default which means no
>> negative dentry limiting will be performed.
> percentage has turned out to be a really wrong unit for many tunables
> over time. Even 1% can be just too much on really large machines.

Yes, that is true. Do you have any suggestion of what kind of unit
should be used? I can scale down the unit to 0.1% of the system memory.
Alternatively, one unit can be 10k/cpu thread, so a 20-thread system
corresponds to 200k, etc.

>
>> Patch 3 enables automatic pruning of least recently used negative
>> dentries when the total number is close to the preset limit.
> Please explain why this cannot be done in a standard dcache shrinking
> way. I strongly suspect that you are developing yet another reclaim with
> its own sets of tunable and bypassing the existing infrastructure. I
> haven't read patches yet but the cover letter doesn't really explain
> design much so I am only guessing.

The standard dcache shrinking happens when the system is almost running
out of free memory. This new shrinker will be turned on when the number
of negative dentries is closed to the limit even when there are still
plenty of free memory left. It will stop when the number of negative
dentries is lowered to a safe level. The new shrinker is designed to
impose as little overhead to the currently running tasks. That is not
true for the standard shrinker which will have a rather significant
performance impact to the currently running tasks.

I can remove the new shrinker if people really don't want to add a new
one as long as I can keep the option to kill off newly created negative
dentries when the limit is exceeded.

Cheers,
Longman


