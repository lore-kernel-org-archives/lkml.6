Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B969BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E0B21905
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfBSJHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:07:24 -0500
Received: from foss.arm.com ([217.140.101.70]:42216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727500AbfBSJHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:07:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30CEE1596;
        Tue, 19 Feb 2019 01:07:18 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 258213F675;
        Tue, 19 Feb 2019 01:07:02 -0800 (PST)
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190213140025.GB6346@brain-police>
 <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com>
 <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <CAHk-=wj4Ws1s3iw+w62jcFdnarWhiVxs9zCBjoo7WysxRVZAgQ@mail.gmail.com>
 <573ACC45-4537-46D0-93D9-4091D7CB6090@amacapital.net>
 <3b98220d-5c2e-b769-1f55-ceb9565379a2@zytor.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <a318033d-cf7a-8506-8ed3-3446d7c9e27d@arm.com>
Date:   Tue, 19 Feb 2019 09:07:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3b98220d-5c2e-b769-1f55-ceb9565379a2@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/02/2019 02:46, H. Peter Anvin wrote:
> On 2/18/19 6:20 PM, Andy Lutomirski wrote:
>>
>>
>>> On Feb 18, 2019, at 4:24 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>>
>>>> On Mon, Feb 18, 2019 at 2:31 PM H. Peter Anvin <hpa@zytor.com> wrote:
>>>>
>>>> The question is what "fix it" means. I'm really concerned about AC escapes,
>>>> and everyone else should be, too.
>>>
>>> I do think that it might be the right thing to do to add some kind of
>>> WARN_ON_ONCE() for AC being set in various can-reschedule situations.
>>>
>>> We'd just have to abstract it sanely. I'm sure arm64 has the exact
>>> same issue with PAN - maybe it saves properly, but the same "we
>>> wouldn't want to go through the scheduler with PAN clear".
>>>
>>> On x86, we might as well check DF at the same time as AC.
>>>
>>
>> hpa is right, though — calling into tracing code with AC set is not really so good.  And calling schedule() (via preempt_enable() or whatever) is also bad because it runs all the scheduler code with AC on.  Admittedly, the scheduler is not *that* interesting of an attack surface.
>>
> 
> Not just that, but the other question is just how much code we are running
> with AC open. It really should only be done in some very small regions.

Yes, but we don't really have a way to enforce that, as far as I'm aware.

The user_access_begin/end() is generic API, meaning any arch is free to
implement it. If they don't have the same hardware behaviour as
x86/arm64, it might be that their interrupt/exception entry code will
run with user_access open until they reach the entry code that closes it
(and entry code could potentially be a more interesting attack surface
than the scheduler). This could be the case of software emulated PAN on
arm/arm64 (although currently arm, non-64bit, doesn't have
user_access_begin/end() at the time).

So the whole "very small region" restriction sounds a bit
loose/arbitrary to me...

Thanks,

-- 
Julien Thierry
