Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971CCC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E762087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E762087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbeIJTzj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:55:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728874AbeIJTzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:55:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD2F3412CA60;
        Mon, 10 Sep 2018 15:01:07 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80107112D19F;
        Mon, 10 Sep 2018 15:01:07 +0000 (UTC)
Subject: Re: [PATCH] locking/rwsem: Make owner store task pointer of last
 owning reader
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
References: <1536265114-10842-1-git-send-email-longman@redhat.com>
 <20180910093156.GS24082@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <83b333ea-8ef2-84ea-6810-4ab1a67eef88@redhat.com>
Date:   Mon, 10 Sep 2018 11:01:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180910093156.GS24082@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 10 Sep 2018 15:01:07 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 10 Sep 2018 15:01:07 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2018 05:31 AM, Peter Zijlstra wrote:
> On Thu, Sep 06, 2018 at 04:18:34PM -0400, Waiman Long wrote:
>> Currently, when a reader acquires a lock, it only sets the
>> RWSEM_READER_OWNED bit in the owner field. The other bits are simply
>> not used. When debugging hanging cases involving rwsems and readers,
>> the owner value does not provide much useful information at all.
>>
>> This patch modifies the current behavior to always store the task_struct
>> pointer of the last rwsem-acquiring reader in a reader-owned rwsem. This
>> may be useful in debugging rwsem hanging cases especially if only one
>> reader is involved. However, the task in the owner field may not the
>> real owner or one of the real owners at all when the owner value is
>> examined, for example, in a crash dump. So it is just an additional
>> hint about the past history.
>>
>> If CONFIG_DEBUG_RWSEMS is enabled, the owner field will be checked at
>> unlock time too to make sure the task pointer value is valid. That does
>> have a slight performance cost and so is only enabled as part of that
>> debug option.
>>
>> From the performance point of view, it is expected that the changes
>> shouldn't have any noticeable performance impact. A rwsem microbenchmark
>> (with 48 worker threads and 1:1 reader/writer ratio) was ran on a
>> 2-socket 24-core 48-thread Haswell system.  The locking rates on a
>> 4.19-rc1 based kernel were as follows:
>>
>>   1) Unpatched kernel:				543.3 kops/s
>>   2) Patched kernel:				549.2 kops/s
>>   3) Patched kernel (CONFIG_DEBUG_RWSEMS on):	546.6 kops/s
>>
>> There was actually a slight increase in performance (1.1%) in this
>> particular case. Maybe it was caused by the elimination of a branch or
>> just a testing noise. Turning on the CONFIG_DEBUG_RWSEMS option also
>> had less than the expected impact on performance.
>>
>> The least significant 2 bits of the owner value are now used to designate
>> the rwsem is readers owned and the owners are anonymous.
> So no immediate objection; but I'm still hoping to some day rewrite the
> whole rwsem thing along the lines we did mutex and merge the 'count' and
> 'owner' fields into one.
>
> [ RT has something along those lines, and I have half a patch that
>   starts doing that too, but I never found enough time to really work on
>   it :-( ]
>
> Anyway, when we do something like that, this goes out the window of
> course.

That may not be the case. I have also thought about merging owner and
count. For writer, it can write its owner value to the combined
count/owner. For readers, I think we will need to keep a reader count
and so cannot store its owner value there. In that case, we could have a
debug-only field for the reader-owner value.

One major issue with a combined count/owner is that we may have to use
cmpxchg for reader lock which will certainly impact reader-heavy
workloads. I have also thought about ways to compress the task pointer
address so that it can use fewer bits and leave the rests for reader
count. It is probably doable on 64-bit systems, but likely not on 32-bit
system given that there are less bits to play around.

I would certainly like to hear your thought on how to handle these
dilemmas as I may be able to find time to work on that. I had a reader
optimistic spinning patch that was sent out a while ago. I know it won't
get serious time for review until we can resolve this combine
owner/count issue first.

Cheers,
Longman


