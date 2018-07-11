Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BFBC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E73D20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E73D20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389387AbeGKTNp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:13:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726785AbeGKTNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:13:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7492A818BAF8;
        Wed, 11 Jul 2018 19:08:02 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3BEA2026D6B;
        Wed, 11 Jul 2018 19:07:59 +0000 (UTC)
Subject: Re: [PATCH v6 0/7] fs/dcache: Track & limit # of negative dentries
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Michal Hocko <mhocko@kernel.org>
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
        "Wangkai (Kevin C)" <wangkai86@huawei.com>
References: <1530905572-817-1-git-send-email-longman@redhat.com>
 <20180709081920.GD22049@dhcp22.suse.cz>
 <62275711-e01d-7dbe-06f1-bf094b618195@redhat.com>
 <20180710142740.GQ14284@dhcp22.suse.cz>
 <a2794bcc-9193-cbca-3a54-47420a2ab52c@redhat.com>
 <20180711102139.GG20050@dhcp22.suse.cz>
 <9f24c043-1fca-ee86-d609-873a7a8f7a64@redhat.com>
 <1531330947.3260.13.camel@HansenPartnership.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <18c5cbfe-403b-bb2b-1d11-19d324ec6234@redhat.com>
Date:   Wed, 11 Jul 2018 15:07:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1531330947.3260.13.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 11 Jul 2018 19:08:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 11 Jul 2018 19:08:02 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 01:42 PM, James Bottomley wrote:
> On Wed, 2018-07-11 at 11:13 -0400, Waiman Long wrote:
>> On 07/11/2018 06:21 AM, Michal Hocko wrote:
>>> On Tue 10-07-18 12:09:17, Waiman Long wrote:
> [...]
>>>> I am going to reduce the granularity of each unit to 1/1000 of
>>>> the total system memory so that for large system with TB of
>>>> memory, a smaller amount of memory can be specified.
>>> It is just a matter of time for this to be too coarse as well.
>> The goal is to not have too much memory being consumed by negative
>> dentries and also the limit won't be reached by regular daily
>> activities. So a limit of 1/1000 of the total system memory will be
>> good enough on large memory system even if the absolute number is
>> really big.
> OK, I think the reason we're going round and round here without
> converging is that one of the goals of the mm subsystem is to manage
> all of our cached objects and to it the negative (and positive)
> dentries simply look like a clean cache of objects.  Right at the
> moment mm manages them in the same way it manages all the other caches,
> a lot of which suffer from the "you can cause lots of allocations to
> artificially grow them" problem.  So the main question is why doesn't
> the current mm control of the caches work well enough for dentries? 
> What are the problems you're seeing that mm should be catching?  If you
> can answer this, then we could get on to whether a separate shrinker,
> cache separation or some fix in mm itself is the right answer.
>
> What you say above is based on a conclusion: limiting dentries improves
> the system performance.  What we're asking for is evidence for that
> conclusion so we can explore whether the same would go for any of our
> other system caches (so do we have a global cache management problem or
> is it only the dentry cache?)
>
> James
>
I am not saying that limiting dentries will improve performance. I am
just saying that unlimited growth in the number of negative dentries
will reduce the amount of memory available to other applications and
hence will have an impact on performance. Normally the amount of memory
consumed by dentries is a very small portion of the system memory.
Depending on memory size, it could be less than 1% or so. In such case,
doubling or even tripling the number of dentries probably won't have
much performance impact.

Unlike positive dentries which are constrained by the # of files in the
filesystems, the growth of negative dentries can be unlimited. A program
bug or a rogue application can easily generate a lot of negative
dentries consuming 10% or more system memory available if it is not
under the control of a memory controller limiting kernel memory.

The purpose of this patchset is to add a mechanism to track and
optionally limit the number of negative dentries that can be created in
a system. A new shrinker is added to round out the package, but it is
not an essential part of the patchset. The default memory shrinker will
be activated when the amount of free memory is low. I am going to drop
that in the next version of the patchset.

This patchset does change slightly the way dentries are handled in the
vfs layer. I will certainly welcome feedback as to whether those changes
are reasonable or not.

Cheers,
Longman



