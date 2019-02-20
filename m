Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2801C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747B220880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfBTW4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:56:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37897 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfBTW4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:56:36 -0500
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8680:2bb1:1b64:2c6c:6ec3:aa41])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x1KMu5t23732554
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 20 Feb 2019 14:56:05 -0800
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To:     Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Julien Thierry <julien.thierry@arm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com,
        torvalds@linux-foundation.org, tglx@linutronix.de
References: <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net>
 <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
Date:   Wed, 20 Feb 2019 14:55:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190219124808.GG8501@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/19 4:48 AM, Will Deacon wrote:
> 
> I think you'll still hate this, but could we not disable preemption during
> the uaccess-enabled region, re-enabling it on the fault path after we've
> toggled uaccess off and disable it again when we return back to the
> uaccess-enabled region? Doesn't help with tracing, but it should at least
> handle the common case.
> 

There is a worse problem with this, I still realize: this would mean blocking
preemption across what could possibly be a *very* large copy_from_user(), for
example.

Exceptions *have* to handle this; there is no way around it. Perhaps the
scheduler isn't the right place to put these kinds of asserts, either.

Now, __fentry__ is kind of a special beast; in some ways it is an "exception
implemented as a function call"; on x86 one could even consider using an INT
instruction in order to reduce the NOP footprint in the unarmed case.  Nor is
__fentry__ a C function; it has far more of an exception-like ABI.
*Regardless* of what else we do, I believe __fentry__ ought to
save/disable/restore AC, just like an exception does.

The idea of using s/a gcc plugin/objtool/ for this isn't really a bad idea.
Obviously the general problem is undecidable :) but the enforcement of some
simple, fairly draconian rules ("as tight as possible, but no tighter")
shouldn't be a huge problem.

An actual gcc plugin -- which would probably be quite complex -- could make
gcc itself aware of user space accesses and be able to rearrange them to
minimize STAC/CLAC and avoid kernel-space accesses inside those brackets.

Finally, of course, there is the option of simply outlawing this practice as a
matter of policy and require that all structures be accessed through a limited
set of APIs. As I recall, the number of places where there were
performance-critical regions which could not use the normal accessors are
fairly small (signal frames being the main one.) Doing bulk copy to/from
kernel memory and then accessing them from there would have some performance
cost, but would eliminate the need for this complexity entirely.

	-hpa
