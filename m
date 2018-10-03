Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B4AC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476EC2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476EC2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeJCUp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:45:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbeJCUp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:45:56 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F6103082A33;
        Wed,  3 Oct 2018 13:57:25 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E72A62016350;
        Wed,  3 Oct 2018 13:57:24 +0000 (UTC)
Subject: Re: [PATCH v2 4/5] locking/lockdep: Make class->ops a percpu counter
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org
References: <1538511560-10090-1-git-send-email-longman@redhat.com>
 <1538511560-10090-5-git-send-email-longman@redhat.com>
 <20181003074809.GJ26858@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <62801eb9-16f2-606f-d3a2-61fef5b0a704@redhat.com>
Date:   Wed, 3 Oct 2018 09:57:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181003074809.GJ26858@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 03 Oct 2018 13:57:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2018 03:48 AM, Peter Zijlstra wrote:
> On Tue, Oct 02, 2018 at 04:19:19PM -0400, Waiman Long wrote:
>> +DEFINE_PER_CPU(unsigned long [MAX_LOCKDEP_KEYS], lock_class_ops);
>> @@ -179,9 +181,30 @@ DECLARE_PER_CPU(struct lockdep_stats, lockdep_stats);
>>  	}								\
>>  	__total;							\
>>  })
>> +
>> +static inline void debug_class_ops_inc(struct lock_class *class)
>> +{
>> +	int idx;
>> +
>> +	idx = class - lock_classes;
>> +	__this_cpu_inc(lock_class_ops[idx]);
>> +}
>> +
>> +static inline unsigned long debug_class_ops_read(struct lock_class *class)
>> +{
>> +	int idx, cpu;
>> +	unsigned long ops = 0;
>> +
>> +	idx = class - lock_classes;
>> +	for_each_possible_cpu(cpu)
>> +		ops += per_cpu(lock_class_ops[idx], cpu);
>> +	return ops;
>> +}
> Would it make sense to stick that in struct lockdep_stats ?
>
> A little something like:
>
> struct lockdep_stats {
> 	/* ... */
> 	int	lock_class_ops[MAX_LOCKDEP_KEYS];
> };
>
> and then use:
>
> 	debug_atomic_inc(lock_class_ops[idx]);
>
Yes, I can certainly do that. Thanks for pointing this out. Will post an
updated patch just for this one.

Cheers,
Longman

