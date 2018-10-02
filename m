Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE18CC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD812064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD812064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbeJBUlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:41:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727690AbeJBUlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:41:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B4D5E88313;
        Tue,  2 Oct 2018 13:57:30 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CABE26DC4;
        Tue,  2 Oct 2018 13:57:29 +0000 (UTC)
Subject: Re: [PATCH 0/5] locking/lockdep: Improve lockdep performance
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <1538157201-29173-1-git-send-email-longman@redhat.com>
 <20181002090652.GC116695@gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <25661edf-2882-7019-1ef4-d79393f239ce@redhat.com>
Date:   Tue, 2 Oct 2018 09:57:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181002090652.GC116695@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 02 Oct 2018 13:57:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2018 05:06 AM, Ingo Molnar wrote:
> * Waiman Long <longman@redhat.com> wrote:
>
>> Enabling CONFIG_LOCKDEP and other related debug options will greatly
>> reduce system performance. This patchset aims to reduce the performance
>> slowdown caused by the lockdep code.
>>
>> Patch 1 just removes an inline function that wasn't used.
>>
>> Patches 2 and 3 are minor twists to optimize the code.
>>
>> Patch 4 makes class->ops a per-cpu counter.
>>
>> Patch 5 moves the lock_release() call outside of a lock critical section.
>>
>> Parallel kernel compilation tests (make -j <#cpu>) were performed on
>> 2 different systems:
>>
>>  1) an 1-socket 22-core 44-thread Skylake system
>>  2) a 4-socket 72-core 144-thread Broadwell system
>>
>> The build times with pre-patch and post-patch debug kernels were:
>>
>>    System      Pre-patch     Post-patch    %Change
>>    ------      ---------     ----------    -------
>>   1-socket      8m53.9s        8m41.2s      -2.4%
>>   4-socket      7m27.0s        5m31.0s      -26%
>>
>> I think it is the last 2 patches that yield most of the performance
>> improvement.
> Impressive speedup!
>
> Mind including the non-lockdep numbers as well, for reference?
>
> Thanks,
>
> 	Ingo

OK, I will include the non lockdep number for comparison. However the
debug kernel has other debugging code enabled as well so the slowdown
won't be just for the enabling of lockdep.

-Longman

