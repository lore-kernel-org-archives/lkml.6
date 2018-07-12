Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4882EC476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D07121471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D07121471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbeGLQFC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:05:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726725AbeGLQFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:05:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 299CB40122CD;
        Thu, 12 Jul 2018 15:54:52 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7114A1102E23;
        Thu, 12 Jul 2018 15:54:51 +0000 (UTC)
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
 <18c5cbfe-403b-bb2b-1d11-19d324ec6234@redhat.com>
 <1531336913.3260.18.camel@HansenPartnership.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <4d49a270-23c9-529f-f544-65508b6b53cc@redhat.com>
Date:   Thu, 12 Jul 2018 11:54:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1531336913.3260.18.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 12 Jul 2018 15:54:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 12 Jul 2018 15:54:52 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 03:21 PM, James Bottomley wrote:
> On Wed, 2018-07-11 at 15:07 -0400, Waiman Long wrote:
>> On 07/11/2018 01:42 PM, James Bottomley wrote:
>>> On Wed, 2018-07-11 at 11:13 -0400, Waiman Long wrote:
>>>> On 07/11/2018 06:21 AM, Michal Hocko wrote:
>>>>> On Tue 10-07-18 12:09:17, Waiman Long wrote:
>>> [...]
>>>>>> I am going to reduce the granularity of each unit to 1/1000
>>>>>> of the total system memory so that for large system with TB
>>>>>> of memory, a smaller amount of memory can be specified.
>>>>> It is just a matter of time for this to be too coarse as well.
>>>> The goal is to not have too much memory being consumed by
>>>> negative
>>>> dentries and also the limit won't be reached by regular daily
>>>> activities. So a limit of 1/1000 of the total system memory will
>>>> be good enough on large memory system even if the absolute number
>>>> is really big.
>>> OK, I think the reason we're going round and round here without
>>> converging is that one of the goals of the mm subsystem is to
>>> manage all of our cached objects and to it the negative (and
>>> positive) dentries simply look like a clean cache of
>>> objects.  Right at the moment mm manages them in the same way it
>>> manages all the other caches, a lot of which suffer from the "you
>>> can cause lots of allocations to artificially grow them"
>>> problem.  So the main question is why doesn't the current mm
>>> control of the caches work well enough for dentries? 
>>> What are the problems you're seeing that mm should be catching?  If
>>> you can answer this, then we could get on to whether a separate
>>> shrinker, cache separation or some fix in mm itself is the right
>>> answer.
>>>
>>> What you say above is based on a conclusion: limiting dentries
>>> improves the system performance.  What we're asking for is evidence
>>> for that conclusion so we can explore whether the same would go for
>>> any of our other system caches (so do we have a global cache
>>> management problem or is it only the dentry cache?)
>>>
>>> James
>>>
>> I am not saying that limiting dentries will improve performance. I am
>> just saying that unlimited growth in the number of negative dentries
>> will reduce the amount of memory available to other applications and
>> hence will have an impact on performance. Normally the amount of
>> memory consumed by dentries is a very small portion of the system
>> memory.
> OK, can we poke on only this point for a while?  Linux never really has
> any "available memory": pretty much as soon as you boot up the system
> will consume all your free memory for some type of cache (usually the
> page cache which got filled during boot).  The expectation is that in a
> steady, running, state the system is using almost all available memory
> for caching something ... if it's not negative dentries it will be
> something else.  The mm assumption is that clean cache is so cheap to
> recover that it's almost equivalent to free memory and your patch is
> saying this isn't so and we have a problem dumping the dentry cache.
>
> So, why can't we treat the dentry cache as equivalent to free memory? 
> What in your tests is making it harder to recover the memory in the
> dentry cache?
>
> James

It is not that dentry cache is harder to get rid of than the other
memory. It is that the ability of generate unlimited number of negative
dentries that will displace other useful memory from the system. What
the patch is trying to do is to have a warning or notification system in
place to spot unusual activities in regard to the number of negative
dentries in the system. The system administrators can then decide on
what to do next.

For many user activities, there are ways to audit what the users are
doing and what resources they are consuming. I don't think that is the
case for negative dentries. The closest I can think of is the use of
memory controller to limit the amount of kernel memory use. This
patchset will provide more visibility about the memory consumption of
negative dentries for the system as a whole, though it won't go into the
per-user level. We just don't want a disproportionate amount of memory
to be used up by negative dentries.

Cheers,
Longman

Cheers,
Longman

