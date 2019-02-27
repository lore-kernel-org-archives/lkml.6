Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED8DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7B62133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfB0ORu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:17:50 -0500
Received: from relay.sw.ru ([185.231.240.75]:50984 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728462AbfB0ORt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:17:49 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gz01l-0004gy-02; Wed, 27 Feb 2019 17:17:41 +0300
Subject: Re: [PATCH 5/6] objtool: Add UACCESS validation
To:     Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com
Cc:     linux-kernel@vger.kernel.org, glider@google.com, dvyukov@google.com
References: <20190225124330.613028745@infradead.org>
 <20190225125232.191698923@infradead.org>
 <20190227140830.GP32494@hirez.programming.kicks-ass.net>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <19b35cb1-9527-2e15-6deb-9ce7c1ef1d66@virtuozzo.com>
Date:   Wed, 27 Feb 2019 17:17:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190227140830.GP32494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/19 5:08 PM, Peter Zijlstra wrote:
> On Mon, Feb 25, 2019 at 01:43:35PM +0100, Peter Zijlstra wrote:
>> It is important that UACCESS regions are as small as possible;
>> furthermore the UACCESS state is not scheduled, so doing anything that
>> might directly call into the scheduler will cause random code to be
>> ran with UACCESS enabled.
>>
>> Teach objtool too track UACCESS state and warn about any CALL made
>> while UACCESS is enabled. This very much includes the __fentry__()
>> tracing calls and __preempt_schedule() calls.
>>
>> Note that exceptions _do_ save/restore the UACCESS state, and therefore
>> they can drive preemption. This also means that all exception handlers
>> must have an otherwise dedundant UACCESS disable instruction;
>> therefore ignore this warning for !STT_FUNC code (exception handlers
>> are not normal functions).
>>
>> It also provides a UACCESS_SAFE() annotation which allows explicit
>> annotation. This is meant to be used for future things like:
>> unsafe_copy_{to,from}_user().
>>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> So KASAN is wildly unhappy..
> 
> I can't actually find any definitions of those functions, so I can't
> very well mark the safe, even if we wanted to.
> 

They are macro-generated. Use 'git grep DEFINE_ASAN'

> ---
> 
>>> arch/x86/kernel/signal.o: warning: objtool: restore_sigcontext()+0x59: call to __asan_store8_noabort() with UACCESS enabled

