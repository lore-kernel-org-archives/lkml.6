Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA57FC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FE3207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="SG28yz4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FE3207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeJWXWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 19:22:54 -0400
Received: from mail.efficios.com ([167.114.142.138]:35914 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWXWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 19:22:54 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9101F23E07D;
        Tue, 23 Oct 2018 10:59:06 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id x5C7Z4ZQXdhP; Tue, 23 Oct 2018 10:59:05 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CB33923E073;
        Tue, 23 Oct 2018 10:59:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CB33923E073
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1540306745;
        bh=NOMCHF38AR1WX7vpmcdQ8Ray7+OZHmxZVmb5jHtem80=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=SG28yz4DOdykR3jx8ieF2BRrSGRErI6Ig8+hnnaUcKK514MwzJ2rMLFCR4RIXaLrB
         e0+bGU2JyiA4/eDEhwVt/+1X9zEgFg5XHr2pP5lBTZlN1ejAS25OhJY3wfuPjwIvcn
         Dl90FNVVcRNGoygNVv+162zHnSCzZqKnawk2nE6tzMktgzYITjBRyppflEO8IsARIH
         2EAOSl8L76C5uxeONonHPn59LgYib3ZvKsKZRR51/PqViTgcQL44+Nu7Nc5LO4TO2n
         JQ6RxRUJGb7j1BQTry8kXMKOiXkrRMZ/9prqUdPCIApECW3w2GalIUhdiUrBg+TiyS
         vTZG39/Yxkdeg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id nEY9MdLBIgG9; Tue, 23 Oct 2018 10:59:05 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id A017723E06C;
        Tue, 23 Oct 2018 10:59:05 -0400 (EDT)
Date:   Tue, 23 Oct 2018 10:59:05 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
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
Message-ID: <1085544486.4156.1540306745517.JavaMail.zimbra@efficios.com>
In-Reply-To: <0dcd1e46-7007-3a99-4ada-f09ab66ab2d5@arm.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com> <38596780-30f7-0763-0c17-7517dbf0bf59@arm.com> <1917048565.2402.1539270808972.JavaMail.zimbra@efficios.com> <3896e4f5-aab1-ae79-5360-088fd15ed380@arm.com> <1680616760.2469.1539275846360.JavaMail.zimbra@efficios.com> <f22ef029-2f30-6bd9-e46a-9e7b0a1e9225@arm.com> <254339058.2585.1539286978932.JavaMail.zimbra@efficios.com> <0dcd1e46-7007-3a99-4ada-f09ab66ab2d5@arm.com>
Subject: Re: [RFC PATCH for 4.21 01/16] rseq/selftests: Add reference
 counter to coexist with glibc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3039 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Topic: rseq/selftests: Add reference counter to coexist with glibc
Thread-Index: 5BPhoa8HQwZUiongVb6S/B5Ole0GqQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 12, 2018, at 10:59 AM, Szabolcs Nagy szabolcs.nagy@arm.com wrote:

> On 11/10/18 20:42, Mathieu Desnoyers wrote:
>> ----- On Oct 11, 2018, at 1:04 PM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:
>> 
>>> On 11/10/18 17:37, Mathieu Desnoyers wrote:
>>>> ----- On Oct 11, 2018, at 12:20 PM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:
>>>>> On 11/10/18 16:13, Mathieu Desnoyers wrote:
>>>>>> ----- On Oct 11, 2018, at 6:37 AM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:
>>>>>>> On 10/10/18 20:19, Mathieu Desnoyers wrote:
>>>>>>>> +__attribute__((visibility("hidden"))) __thread
>>>>>>>> +volatile struct libc_rseq __lib_rseq_abi = {
>>>>>>> ...
>>>>> but it's in a magic struct that's called "abi" which is confusing,
>>>>> the counter is not abi, it's in a hidden object.
>>>>
>>>> No, it is really an ABI between user-space apps/libs. It's not meant to be
>>>> hidden. glibc implements its own register/unregister functions (it does not
>>>> link against librseq). librseq exposes register/unregister functions as public
>>>> APIs. Those also use the refcount. I also plan to have existing libraries, e.g.
>>>> liblttng-ust and possibly liburcu flavors, implement the
>>>> registration/unregistration and refcount handling on their own, so we don't
>>>> have to add a requirement on additional linking on librseq for pre-existing
>>>> libraries.
>>>>
>>>> So that refcount is not an ABI between kernel and user-space, but it's a
>>>> user-space ABI nevertheless (between program and shared objects).
>>>>
>>>
>>> if that's what you want, then your declaration is wrong.
>>> the object should not have hidden visibility.
>> 
>> Actually, if we look closer into my patch, it defines two symbols,
>> one of which is an alias:
>> 
>> __attribute__((visibility("hidden"))) __thread
>> volatile struct libc_rseq __lib_rseq_abi = {
>>         .cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
>> };
>> 
>> extern __attribute__((weak, alias("__lib_rseq_abi"))) __thread
>> volatile struct rseq __rseq_abi;
>> 
>> Note that the public __rseq_abi symbol is weak but does not have
>> hidden visibility. I do this to ensure I don't get prototype
>> mismatch for __rseq_abi between rseq.c and rseq.h (it is required
>> to be a struct rseq by rseq.h), but I want the space to hold the
>> extra refcount field present in struct libc_rseq.
>> 
>

I notice this email has been sitting in my inbox for a while, sorry
for the delayed reply.
 
> but that's wrong: the weak symbol might get resolved to
> a different object in another module, while you increment
> a local refcounter, so there is no coordination between
> userspace components.

Hrm, good point. I should not use the __lib_rseq_abi symbol at all
here.

> 
> this was the reason for my first question in my original mail,
> as soon as i saw the local counter i suspected this is broken.

Good catch, yes. I think I should not use the alias approach then.

> 
> and "assume there is an extra counter field" is not
> acceptable as user space abi, if the counter is relevant
> across modules then expose the entire struct.

The question that arises here is whether I should update
uapi/linux/rseq.h and add the refcount field directly in
there, even though the kernel does not care about it per se ?

> 
>>> either the struct should be public abi (extern tls
>>> symbol) or the register/unregister functions should
>>> be public abi (so when multiple implementations are
>>> present in the same process only one of them will
>>> provide definition for the public abi symbol and
>>> thus there will be one refcounter).
>> 
>> Those are two possible solutions, indeed. Considering that
>> we already need to expose the __rseq_abi symbol as a public
>> ABI in a way that ensures that multiple implementations
>> in a same process end up only using one of them, it seems
>> straightforward to simply extend that structure and hold the
>> refcount there, rather than having two extra ABI symbols
>> (register/unregister functions).
>> 
>> One very appropriate question here is whether we want to
>> expose the layout of struct libc_rseq (which includes the
>> refcount) in a public header file, and if so, which project
>> should hold it ? Or do we just want to document the layout
>> of this ABI so projects can define the structure layout
>> internally ? As my implementation currently stands, I have
>> the following structure duplicated into rseq selftests,
>> librseq, and glibc:
>> 
> 
> "not exposed" and "the counter is abi" together is not
> useful, either you want coordination in user-space or
> not, that decision should imply the userspace abi/api
> (e.g. adding a counter to the user-space struct).

I'm inclined to add the refcount to struct rseq directly,
unless anyone objects. It seems much simpler.

> 
> it is true that only modules that implement registration
> need to know about the counter and normal users don't,
> but if you want any coordination then the layout must
> be fixed and that should be exposed somewhere to avoid
> breakage.

Yep. Exposing this in uapi/linux/rseq.h is the main
location that seems to make sense to me.

> 
> (i think ideally the api would be controlled by functions
> and not object symbols with magic layout, but the rseq
> design is already full of such magic. and i think it's
> better to do the registration in libc only without
> coordination but that might not be practical if users
> want it now)

Yes, early adopters is my concern here.

> 
>> /*
>>  * linux/rseq.h defines struct rseq as aligned on 32 bytes. The kernel ABI
>>  * size is 20 bytes. For support of multiple rseq users within a process,
>>  * user-space defines an extra 4 bytes field as a reference count, for a
>>  * total of 24 bytes.
>>  */
>> struct libc_rseq {
>>         /* kernel-userspace ABI. */
>>         __u32 cpu_id_start;
>>         __u32 cpu_id;
>>         __u64 rseq_cs;
>>         __u32 flags;
>>         /* user-space ABI. */
>>         __u32 refcount;
>> } __attribute__((aligned(4 * sizeof(__u64))));
>> 
>> That duplicated structure only needs to be present in early-adopter
>> applications/libraries. Those linking on librseq or relying on newer
>> glibc to register rseq don't need to know about this extended layout:
>> all they need to care about is the layout of struct rseq (without the
>> added refcount).
> 
> please decide if you want multiple libraries to
> be able to register rseq and coordinate or not
> and document that decision in the public api.

Yes, I'll try this out and see how this goes.

Thanks for the feedback!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
