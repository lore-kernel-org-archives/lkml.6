Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C275C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF62F2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF62F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbeJBUyX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:54:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727584AbeJBUyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:54:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1FBE23167697;
        Tue,  2 Oct 2018 14:10:49 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E58D5DD71;
        Tue,  2 Oct 2018 14:10:48 +0000 (UTC)
Subject: Re: [PATCH 4/5] locking/lockdep: Make class->ops a percpu counter
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org
References: <1538157201-29173-1-git-send-email-longman@redhat.com>
 <1538157201-29173-5-git-send-email-longman@redhat.com>
 <20181002093907.GV3439@hirez.programming.kicks-ass.net>
 <20181002095543.GA55344@gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <dbc5a70a-91bb-d365-8977-2d88049e39bb@redhat.com>
Date:   Tue, 2 Oct 2018 10:10:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20181002095543.GA55344@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 02 Oct 2018 14:10:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2018 05:55 AM, Ingo Molnar wrote:
> * Peter Zijlstra <peterz@infradead.org> wrote:
>
>> On Fri, Sep 28, 2018 at 01:53:20PM -0400, Waiman Long wrote:
>>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>>> index ca002c0..7a0ed1d 100644
>>> --- a/kernel/locking/lockdep.c
>>> +++ b/kernel/locking/lockdep.c
>>> @@ -139,6 +139,7 @@ static inline int debug_locks_off_graph_unlock(void)
>>>   */
>>>  unsigned long nr_lock_classes;
>>>  static struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
>>> +static DEFINE_PER_CPU(unsigned long [MAX_LOCKDEP_KEYS], lock_class_ops);
>>> @@ -1387,11 +1391,15 @@ static inline int usage_match(struct lock_list *entry, void *bit)
>>>  
>>>  static void print_lock_class_header(struct lock_class *class, int depth)
>>>  {
>>> -	int bit;
>>> +	int bit, cpu;
>>> +	unsigned long ops = 0UL;
>>> +
>>> +	for_each_possible_cpu(cpu)
>>> +		ops += *per_cpu(class->pops, cpu);
>>>  
>>>  	printk("%*s->", depth, "");
>>>  	print_lock_name(class);
>>> -	printk(KERN_CONT " ops: %lu", class->ops);
>>> +	printk(KERN_CONT " ops: %lu", ops);
>>>  	printk(KERN_CONT " {\n");
>>>  
>>>  	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
>> That is an aweful lot of storage for a stupid number. Some archs
>> (sparc64) are bzImage size constrained and this will hurt them.
>>
>> Ingo, do you happen to remember what that number was good for?
> Just a spur of the moment statistics to satisfy curiousity, and it's useful to see how 'busy' a 
> particular class is, right?
>
>> Can't we simply ditch it?
> We certainly could. Do we have roughly equivalent metrics to arrive at this number via other 
> methods?
>
> Thanks,
>
> 	Ingo


One alternative is to group it under CONFIG_DEBUG_LOCKDEP again. This
metric was originally under CONFIG_DEBUG_LOCKDEP, but was moved to
CONFIG_LOCKDEP when trying to make other lock debugging statistics
per-cpu counters. It was probably because this metric is per lock class
while the rests are global.

By doing so, you incur the memory cost only when CONFIG_DEBUG_LOCKDEP is
defined.

What do you think?

Cheers,
Longman


