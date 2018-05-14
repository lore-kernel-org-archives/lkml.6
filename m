Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeENL4Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:56:16 -0400
Received: from foss.arm.com ([217.140.101.70]:40932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753075AbeENL4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:56:13 -0400
Subject: Re: [PATCH 02/18] arm64: move SCTLR_EL{1,2} assertions to
 <asm/sysreg.h>
To: Dave Martin <Dave.Martin@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        james.morse@arm.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-3-mark.rutland@arm.com>
 <20180514100053.GX7753@e103592.cambridge.arm.com>
 <20180514100858.4xjp5d3axbyy74ap@lakrids.cambridge.arm.com>
 <20180514112036.GI7753@e103592.cambridge.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8d66d231-d8a2-07c1-6c5b-24c9474c851f@arm.com>
Date: Mon, 14 May 2018 12:56:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514112036.GI7753@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/18 12:20, Dave Martin wrote:
> On Mon, May 14, 2018 at 11:08:59AM +0100, Mark Rutland wrote:
>> On Mon, May 14, 2018 at 11:00:53AM +0100, Dave Martin wrote:
>>> On Mon, May 14, 2018 at 10:46:24AM +0100, Mark Rutland wrote:
>>>> -/* Check all the bits are accounted for */
>>>> -#define SCTLR_EL2_BUILD_BUG_ON_MISSING_BITS	BUILD_BUG_ON((SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != ~0)
>>>> -
>>>> +#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xffffffff
>>>> +#error "Inconsistent SCTLR_EL2 set/clear bits"
>>>> +#endif
>>>
>>> Can we have a comment on the != 0xffffffff versus != ~0 here?
>>>
>>> The subtle differences in evaluation semantics between #if and
>>> other contexts here may well trip people up during maintenance...
>>
>> Do you have any suggestion as to the wording?
>>
>> I'm happy to add a comment, but I don't really know what to say.
> 
> 
> How about the following?
> 
> /* Watch out for #if evaluation rules: ~0 is not ~(int)0! */

Or, more formally, perhaps something even less vague like "Note that in 
preprocessor arithmetic these constants are effectively of type 
intmax_t, which is 64-bit, thus ~0 is not what we want."

Robin.
