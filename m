Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935869AbeEXMgT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:36:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43684 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935296AbeEXMgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:36:17 -0400
Subject: Re: [PATCH 09/14] arm64: ssbd: Introduce thread flag to control
 userspace mitigation
To: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180522150648.28297-1-marc.zyngier@arm.com>
 <20180522150648.28297-10-marc.zyngier@arm.com>
 <20180524120121.pjdw7qaybcsbf4fl@lakrids.cambridge.arm.com>
 <833776ac-2b8c-b0f7-dcff-9c55afd67c65@arm.com>
 <20180524121944.GC8689@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <bc285971-70fb-b3ec-43a1-8721b9067c42@arm.com>
Date: Thu, 24 May 2018 13:36:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524121944.GC8689@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/18 13:19, Will Deacon wrote:
> On Thu, May 24, 2018 at 01:16:38PM +0100, Marc Zyngier wrote:
>> On 24/05/18 13:01, Mark Rutland wrote:
>>> On Tue, May 22, 2018 at 04:06:43PM +0100, Marc Zyngier wrote:
>>>> In order to allow userspace to be mitigated on demand, let's
>>>> introduce a new thread flag that prevents the mitigation from
>>>> being turned off when exiting to userspace, and doesn't turn
>>>> it on on entry into the kernel (with the assumtion that the
>>>
>>> Nit: s/assumtion/assumption/
>>>
>>>> mitigation is always enabled in the kernel itself).
>>>>
>>>> This will be used by a prctl interface introduced in a later
>>>> patch.
>>>>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>
>>> On the assumption that this flag cannot be flipped while a task is in
>>> userspace:
>>
>> Well, that's the case unless you get into the seccomp thing, which does
>> change TIF_SSBD on all threads of the task, without taking it to the
>> kernel first. That nicely breaks the state machine, and you end-up
>> running non-mitigated in the kernel. Oops.
>>
>> I have a couple of patches fixing that, using a second flag
>> (TIF_SSBD_PENDING) that gets turned into the real thing on exit to
>> userspace. It's pretty ugly though.
> 
> ... which introduces the need for atomics on the entry path too :(

Oh, I'm not saying it is nice. It would hit us on the exception return
to userspace for all tasks (and not only the mitigated ones). I'd rather
not have this at all.

> I would /much/ rather kill the seccomp implicit enabling of the mitigation,
> or at least have a way to opt-out per arch since it doesn't seem to be
> technically justified imo.
I agree. The semantics are really odd (the thread still runs unmitigated
until it traps into the kernel), and I don't really get why seccomp
tasks should get a special treatment compared to the rest of the userspace.

But 4.17 is only something like 10 days away, so whatever we decide,
we'd better decide it soon.


	M.
-- 
Jazz is not dead. It just smells funny...
