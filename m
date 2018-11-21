Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452F4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C60D21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C60D21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbeKVASy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:18:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbeKVASx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:18:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C52030024F5;
        Wed, 21 Nov 2018 13:44:25 +0000 (UTC)
Received: from [10.43.17.120] (unknown [10.43.17.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93B62662D2;
        Wed, 21 Nov 2018 13:44:22 +0000 (UTC)
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
To:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        pabeni@redhat.com
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com>
 <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
From:   Denys Vlasenko <dvlasenk@redhat.com>
Message-ID: <26eff539-7de7-784c-0c88-f1d30753299d@redhat.com>
Date:   Wed, 21 Nov 2018 14:44:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 21 Nov 2018 13:44:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/2018 02:32 PM, Jens Axboe wrote:
> On 11/20/18 11:36 PM, Ingo Molnar wrote:
>> * Jens Axboe <axboe@kernel.dk> wrote:
>>> So this is a fun one... While I was doing the aio polled work, I noticed
>>> that the submitting process spent a substantial amount of time copying
>>> data to/from userspace. For aio, that's iocb and io_event, which are 64
>>> and 32 bytes respectively. Looking closer at this, and it seems that
>>> ERMS rep movsb is SLOWER for smaller copies, due to a higher startup
>>> cost.
>>>
>>> I came up with this hack to test it out, and low and behold, we now cut
>>> the time spent in copying in half. 50% less.
>>>
>>> Since these kinds of patches tend to lend themselves to bike shedding, I
>>> also ran a string of kernel compilations out of RAM. Results are as
>>> follows:
>>>
>>> Patched	: 62.86s avg, stddev 0.65s
>>> Stock	: 63.73s avg, stddev 0.67s
>>>
>>> which would also seem to indicate that we're faster punting smaller
>>> (< 128 byte) copies.
>>>
>>> CPU: Intel(R) Xeon(R) CPU E5-2650 v4 @ 2.20GHz
>>>
>>> Interestingly, text size is smaller with the patch as well?!
>>>
>>> I'm sure there are smarter ways to do this, but results look fairly
>>> conclusive. FWIW, the behaviorial change was introduced by:
>>>
>>> commit 954e482bde20b0e208fd4d34ef26e10afd194600
>>> Author: Fenghua Yu <fenghua.yu@intel.com>
>>> Date:   Thu May 24 18:19:45 2012 -0700
>>>
>>>      x86/copy_user_generic: Optimize copy_user_generic with CPU erms feature
>>>
>>> which contains nothing in terms of benchmarking or results, just claims
>>> that the new hotness is better.
>>>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>> ---
>>>
>>> diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
>>> index a9d637bc301d..7dbb78827e64 100644
>>> --- a/arch/x86/include/asm/uaccess_64.h
>>> +++ b/arch/x86/include/asm/uaccess_64.h
>>> @@ -29,16 +29,27 @@ copy_user_generic(void *to, const void *from, unsigned len)
>>>   {
>>>   	unsigned ret;
>>>   
>>> +	/*
>>> +	 * For smaller copies, don't use ERMS as it's slower.
>>> +	 */
>>> +	if (len < 128) {
>>> +		alternative_call(copy_user_generic_unrolled,
>>> +				 copy_user_generic_string, X86_FEATURE_REP_GOOD,
>>> +				 ASM_OUTPUT2("=a" (ret), "=D" (to), "=S" (from),
>>> +					     "=d" (len)),
>>> +				 "1" (to), "2" (from), "3" (len)
>>> +				 : "memory", "rcx", "r8", "r9", "r10", "r11");
>>> +		return ret;
>>> +	}
>>> +
>>>   	/*
>>>   	 * If CPU has ERMS feature, use copy_user_enhanced_fast_string.
>>>   	 * Otherwise, if CPU has rep_good feature, use copy_user_generic_string.
>>>   	 * Otherwise, use copy_user_generic_unrolled.
>>>   	 */
>>>   	alternative_call_2(copy_user_generic_unrolled,
>>> -			 copy_user_generic_string,
>>> -			 X86_FEATURE_REP_GOOD,
>>> -			 copy_user_enhanced_fast_string,
>>> -			 X86_FEATURE_ERMS,
>>> +			 copy_user_generic_string, X86_FEATURE_REP_GOOD,
>>> +			 copy_user_enhanced_fast_string, X86_FEATURE_ERMS,
>>>   			 ASM_OUTPUT2("=a" (ret), "=D" (to), "=S" (from),
>>>   				     "=d" (len)),
>>>   			 "1" (to), "2" (from), "3" (len)
>>
>> So I'm inclined to do something like yours, because clearly the changelog
>> of 954e482bde20 was at least partly false: Intel can say whatever they
>> want, it's a fact that ERMS has high setup costs for low buffer sizes -
>> ERMS is optimized for large size, cache-aligned copies mainly.
> 
> I'm actually surprised that something like that was accepted, I guess
> 2012 was a simpler time :-)
> 
>> But the result is counter-intuitive in terms of kernel text footprint,
>> plus the '128' is pretty arbitrary - we should at least try to come up
>> with a break-even point where manual copy is about as fast as ERMS - on
>> at least a single CPU ...
> 
> I did some more investigation yesterday, and found this:
> 
> commit 236222d39347e0e486010f10c1493e83dbbdfba8
> Author: Paolo Abeni <pabeni@redhat.com>
> Date:   Thu Jun 29 15:55:58 2017 +0200
> 
>      x86/uaccess: Optimize copy_user_enhanced_fast_string() for short strings
> 
> which does attempt to rectify it, but only using ERMS for >= 64 byte copies.
> At least for me, looks like the break even point is higher than that, which
> would mean that something like the below would be more appropriate.

I also tested this while working for string ops code in musl.

I think at least 128 bytes would be the minimum where "REP insn"
are more efficient. In my testing, it's more like 256 bytes...
