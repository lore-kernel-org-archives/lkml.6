Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74A5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFF321773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfBSCqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:46:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38993 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfBSCqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:46:43 -0500
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8680:2bb1:1b64:2c6c:6ec3:aa41])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x1J2kB1h2852107
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 18 Feb 2019 18:46:12 -0800
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To:     Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <julien.thierry@arm.com>,
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
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <3b98220d-5c2e-b769-1f55-ceb9565379a2@zytor.com>
Date:   Mon, 18 Feb 2019 18:46:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <573ACC45-4537-46D0-93D9-4091D7CB6090@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 6:20 PM, Andy Lutomirski wrote:
> 
> 
>> On Feb 18, 2019, at 4:24 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>>> On Mon, Feb 18, 2019 at 2:31 PM H. Peter Anvin <hpa@zytor.com> wrote:
>>>
>>> The question is what "fix it" means. I'm really concerned about AC escapes,
>>> and everyone else should be, too.
>>
>> I do think that it might be the right thing to do to add some kind of
>> WARN_ON_ONCE() for AC being set in various can-reschedule situations.
>>
>> We'd just have to abstract it sanely. I'm sure arm64 has the exact
>> same issue with PAN - maybe it saves properly, but the same "we
>> wouldn't want to go through the scheduler with PAN clear".
>>
>> On x86, we might as well check DF at the same time as AC.
>>
> 
> hpa is right, though — calling into tracing code with AC set is not really so good.  And calling schedule() (via preempt_enable() or whatever) is also bad because it runs all the scheduler code with AC on.  Admittedly, the scheduler is not *that* interesting of an attack surface.
> 

Not just that, but the other question is just how much code we are running
with AC open. It really should only be done in some very small regions.

	-hpa

