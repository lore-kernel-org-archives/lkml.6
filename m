Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370A4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2032147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfBSIx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:53:29 -0500
Received: from foss.arm.com ([217.140.101.70]:41932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbfBSIx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:53:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E26AEBD;
        Tue, 19 Feb 2019 00:53:28 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A3693F675;
        Tue, 19 Feb 2019 00:53:25 -0800 (PST)
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
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
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <8a3f9094-63a7-7fe2-bb4d-6deb5c022596@arm.com>
Date:   Tue, 19 Feb 2019 08:53:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj4Ws1s3iw+w62jcFdnarWhiVxs9zCBjoo7WysxRVZAgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/02/2019 00:24, Linus Torvalds wrote:
> On Mon, Feb 18, 2019 at 2:31 PM H. Peter Anvin <hpa@zytor.com> wrote:
>>
>> The question is what "fix it" means. I'm really concerned about AC escapes,
>> and everyone else should be, too.
> 
> I do think that it might be the right thing to do to add some kind of
> WARN_ON_ONCE() for AC being set in various can-reschedule situations.
> 
> We'd just have to abstract it sanely. I'm sure arm64 has the exact
> same issue with PAN - maybe it saves properly, but the same "we
> wouldn't want to go through the scheduler with PAN clear".
> 

As of right now, we have the same issue on arm64 as on x86. We don't
currently save the PAN bit on task switch, but I have a patch to do that.

Unless we decide to go down the route of warning against uses of
schedule() inside.

As for the abstraction, I had this patch[1] that added another primitive
for the user_access API (although this might not be suited for x86 if
you also want to check DF). However, an issue that appears is where to
perform the check to cover enough ground.

Checking inside the schedule() code you only cover cases where things
have already gone wrong, and not the use of functions that are unsafe to
call inside a user_access region.

[1]
http://lists.infradead.org/pipermail/linux-arm-kernel/2019-January/625385.html

Cheers,

-- 
Julien Thierry
