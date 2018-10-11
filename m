Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14B4C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3812821476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kOLh4v77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3812821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbeJLAF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:05:28 -0400
Received: from mail.efficios.com ([167.114.142.138]:41256 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbeJLAF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:05:28 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4F122183B7A;
        Thu, 11 Oct 2018 12:37:27 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id f9zoMzMOUWaY; Thu, 11 Oct 2018 12:37:26 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C25D5183B66;
        Thu, 11 Oct 2018 12:37:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C25D5183B66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539275846;
        bh=VYHXmLhD2LLzZiYP0N/xM+/O28CIERqJCBqA5KhIOqI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=kOLh4v77j2id3fezNP3CgK/rCmvtJRKnNjaQGONeJ4lbLwGbh9W2i8iUFM5Y058/k
         UcILg8z5aYp056d5Zd4KtLcimf+r8VEeDNYvt4sb8BpjdfNoOxHGL7X+JNmgeCasLa
         8fHFtoK46n2z8TP1FnGxVujBGcclVg6oppZkZsjJaATHwZjm7q7zdnb7zw2TickDTp
         8zrBKQ49Swj7TwBEns86ZoIiwVUFaem/12WFmz4QLgN1DmrgH+xhuA1R6p63IM9L3l
         YmiZQxK99WrJF68GViRm3MMbPkPztd40nv9o9lWRc8NzXXbjAfIKVhWtwIOqlBY1s6
         jlwu/8wcf7vOA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id HgEKkwrBb7Og; Thu, 11 Oct 2018 12:37:26 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 98667183B5B;
        Thu, 11 Oct 2018 12:37:26 -0400 (EDT)
Date:   Thu, 11 Oct 2018 12:37:26 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     nd <nd@arm.com>, Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>, shuah <shuah@kernel.org>,
        carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>
Message-ID: <1680616760.2469.1539275846360.JavaMail.zimbra@efficios.com>
In-Reply-To: <3896e4f5-aab1-ae79-5360-088fd15ed380@arm.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com> <20181010191936.7495-2-mathieu.desnoyers@efficios.com> <38596780-30f7-0763-0c17-7517dbf0bf59@arm.com> <1917048565.2402.1539270808972.JavaMail.zimbra@efficios.com> <3896e4f5-aab1-ae79-5360-088fd15ed380@arm.com>
Subject: Re: [RFC PATCH for 4.21 01/16] rseq/selftests: Add reference
 counter to coexist with glibc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3039 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3039)
Thread-Topic: rseq/selftests: Add reference counter to coexist with glibc
Thread-Index: AQHUYM5AJL7p/dPuu0ud+WbMPMG0kKUZ6+eAgAA8aQCAABKZANa4sq5Z
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 11, 2018, at 12:20 PM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:

> On 11/10/18 16:13, Mathieu Desnoyers wrote:
>> ----- On Oct 11, 2018, at 6:37 AM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:
>> 
>>> On 10/10/18 20:19, Mathieu Desnoyers wrote:
>>>> In order to integrate rseq into user-space applications, add a reference
>>>> counter field after the struct rseq TLS ABI so many rseq users can be
>>>> linked into the same application (e.g. librseq and glibc). The
>>>> reference count ensures that rseq syscall registration/unregistration
>>>> happens only for the most early/late user for each thread, thus ensuring
>>>> that rseq is registered across the lifetime of all rseq users for a
>>>> given thread.
>>> ...
>>>> +__attribute__((visibility("hidden"))) __thread
>>>> +volatile struct libc_rseq __lib_rseq_abi = {
>>> ...
>>>> +extern __attribute__((weak, alias("__lib_rseq_abi"))) __thread
>>>> +volatile struct rseq __rseq_abi;
>>> ...
>>>> @@ -70,7 +86,7 @@ int rseq_register_current_thread(void)
>>>>  	sigset_t oldset;
>>>>  
>>>>  	signal_off_save(&oldset);
>>>> -	if (refcount++)
>>>> +	if (__lib_rseq_abi.refcount++)
>>>>  		goto end;
>>>>  	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq), 0, RSEQ_SIG);
>>>
>>> why do you use a local refcounter instead of the __rseq_abi one?
>> 
>> There is no refcount in struct rseq (the ABI between kernel and user-space).
>> The registration refcount was part of an earlier version of the rseq system
>> call,
>> but we decided against keeping it in the kernel.
>> 
>> So I'm adding one _after_ struct rseq, purely to allow interaction between
>> various user-space components (program/libraries).
> 
> then all those components must use the same
> 
>  rseq_register_current_thread
>  rseq_unregister_current_thread
> 
> functions and not call the syscall on their own.

Not quite. Each user (programs and shared objects) must handle the refcount in a
similar way if they wish to invoke the syscall by themselves. They can
alternately use the librseq APIs if they do not wish to have a local implementation
of the reference counting and syscall registration/unregistration.

> 
> in which case the refcount could be a static __thread variable.

Yes, but I want to limit the number of symbols we need to export
from glibc by appending the refcount field at the end of struct rseq.

> 
> but it's in a magic struct that's called "abi" which is confusing,
> the counter is not abi, it's in a hidden object.

No, it is really an ABI between user-space apps/libs. It's not meant to be
hidden. glibc implements its own register/unregister functions (it does not
link against librseq). librseq exposes register/unregister functions as public
APIs. Those also use the refcount. I also plan to have existing libraries, e.g.
liblttng-ust and possibly liburcu flavors, implement the
registration/unregistration and refcount handling on their own, so we don't
have to add a requirement on additional linking on librseq for pre-existing
libraries.

So that refcount is not an ABI between kernel and user-space, but it's a
user-space ABI nevertheless (between program and shared objects).

> 
>>> what prevents calling rseq_register_current_thread more than 4G times?
>> 
>> Nothing. It would indeed be cleaner to error out if we detect that refcount is
>> at
>> INT_MAX. Is that what you have in mind ?
> 
> yes

Allright, will fix.

> 
>>> why cant the kernel see that the same address is registered again and succeed?
>> 
>> It can, and it does. However, refcounting at user-level is needed to ensure
>> the registration "lifetime" for rseq covers its entire use. If we have two
>> libraries
>> using rseq, we end up with the following scenario:
>> 
>> Thread 1
>> 
>>   libA registers rseq
>>   libB registers rseq
>>   libB unregisters rseq
>>   libA uses rseq -> bug! it's been unregistered by libB.
>>   libA unregisters rseq -> unexpected, it's already been unregistered.
>>  
>> same applies if libA unregisters rseq before libB (and libB try to use rseq
>> after libA has unregistered).
>> 
>> The refcount in user-space fixes this.
> 
> i see.

Thanks for the feedback!

Mathieu

> 
>> Thoughts ?
>> 
>> Thanks,
>> 
>> Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
