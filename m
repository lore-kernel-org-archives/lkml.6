Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE82C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C436A222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392095AbfBMOYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:24:40 -0500
Received: from foss.arm.com ([217.140.101.70]:55008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731144AbfBMOYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:24:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B6B280D;
        Wed, 13 Feb 2019 06:24:39 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D0193F557;
        Wed, 13 Feb 2019 06:24:36 -0800 (PST)
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        catalin.marinas@arm.com, james.morse@arm.com, hpa@zytor.com,
        valentin.schneider@arm.com
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
 <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
 <20190213103553.GO32494@hirez.programming.kicks-ass.net>
 <1c2429a4-9df9-40a3-98e0-51577de4bd6a@arm.com>
 <20190213131720.GU32494@hirez.programming.kicks-ass.net>
 <20190213140025.GB6346@brain-police>
 <20190213141712.GV32494@hirez.programming.kicks-ass.net>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <e8ff5f65-b8df-0296-e9e7-ba627a4ef1a4@arm.com>
Date:   Wed, 13 Feb 2019 14:24:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190213141712.GV32494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/02/2019 14:17, Peter Zijlstra wrote:
> On Wed, Feb 13, 2019 at 02:00:26PM +0000, Will Deacon wrote:
>>> This; how is getting preempted fundamentally different from scheduling
>>> ourselves?
>>
>> The difference is because getting preempted in the sequence above is
>> triggered off the back of an interrupt. On arm64, and I think also on x86,
>> the user access state (SMAP or PAN) is saved and restored across exceptions
>> but not across context switch. Consequently, taking an irq in a
>> user_access_{begin,end} section and then scheduling is fine, but calling
>> schedule directly within such a section is not.
> 
> So how's this then:
> 
> 	if (user_access_begin()) {
> 
> 		preempt_disable();
> 
> 		<IRQ>
> 			set_need_resched();
> 		</IRQ no preempt>
> 
> 		preempt_enable()
> 		  __schedule();
> 
> 		user_access_end();
> 	}
> 
> That _should_ work just fine but explodes with the proposed nonsense.

AFAICT, This does not work properly because when you schedule out this
task, you won't be saving the EFLAGS.AF/PSTATE.PAN bit on the stack, and
next time you schedule the task back in, it might no longer have the
correct flag value (so an unsafe_get/put_user() will fail even though
you haven't reached user_access_end()).

One solution is to deal with this in task switching code, but so far
I've been told that calling schedule() in such a context is not expected
to be supported.

Cheers,

-- 
Julien Thierry
