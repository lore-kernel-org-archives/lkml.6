Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0806C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3E02075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="iDn7Oawq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3E02075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeJLDLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:11:44 -0400
Received: from mail.efficios.com ([167.114.142.138]:51028 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeJLDLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:11:44 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4EB2E1841C4;
        Thu, 11 Oct 2018 15:43:00 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 8fSkdUKaf8fQ; Thu, 11 Oct 2018 15:42:59 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5011B1841BD;
        Thu, 11 Oct 2018 15:42:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5011B1841BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539286979;
        bh=C/s3/yYjSDXFFmpjk6K1Jgx3rDuTwCtKwxb2YT0FyzU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=iDn7OawqJ8/ANW7CU5f3vR3e05j0k6t/ks82ayHtBakervITP7m0GNjGJQ87BMXoE
         X5yVDjXiNnX26PZdeZ+uY2sM6pVvjNhko+BIWfpukv6JqqE7iAmuUZ0tf0PCrUOzgm
         9wz7P1FKVMvC2gwbGZBvhiWGZlZXZZHNqQi5V68w6rsmMxWjPeEHOvQoK6cy5nF5Vk
         pbZlMH5h2oAKbhPzhmW4M8/bBVAxrsf370cyNhPdpUM6V5zcIuaupDmS5ZQX4Utg1W
         1PNAmwgIxlD70o4UTh8vq6TsEbfVqxgpAVkACXEZsCtFYqShYMcEu36FB4n1X06j86
         sMU/kwAF+Yt9w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id eocud70sL8AW; Thu, 11 Oct 2018 15:42:59 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 293B71841B3;
        Thu, 11 Oct 2018 15:42:59 -0400 (EDT)
Date:   Thu, 11 Oct 2018 15:42:58 -0400 (EDT)
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
Message-ID: <254339058.2585.1539286978932.JavaMail.zimbra@efficios.com>
In-Reply-To: <f22ef029-2f30-6bd9-e46a-9e7b0a1e9225@arm.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com> <20181010191936.7495-2-mathieu.desnoyers@efficios.com> <38596780-30f7-0763-0c17-7517dbf0bf59@arm.com> <1917048565.2402.1539270808972.JavaMail.zimbra@efficios.com> <3896e4f5-aab1-ae79-5360-088fd15ed380@arm.com> <1680616760.2469.1539275846360.JavaMail.zimbra@efficios.com> <f22ef029-2f30-6bd9-e46a-9e7b0a1e9225@arm.com>
Subject: Re: [RFC PATCH for 4.21 01/16] rseq/selftests: Add reference
 counter to coexist with glibc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3039 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3039)
Thread-Topic: rseq/selftests: Add reference counter to coexist with glibc
Thread-Index: AQHUYM5AJL7p/dPuu0ud+WbMPMG0kKUZ6+eAgAA8aQCAABKZANa4sq5ZqUdZuAC8InNuTg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 11, 2018, at 1:04 PM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:

> On 11/10/18 17:37, Mathieu Desnoyers wrote:
>> ----- On Oct 11, 2018, at 12:20 PM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:
>>> On 11/10/18 16:13, Mathieu Desnoyers wrote:
>>>> ----- On Oct 11, 2018, at 6:37 AM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:
>>>>> On 10/10/18 20:19, Mathieu Desnoyers wrote:
>>>>>> +__attribute__((visibility("hidden"))) __thread
>>>>>> +volatile struct libc_rseq __lib_rseq_abi = {
>>>>> ...
>>> but it's in a magic struct that's called "abi" which is confusing,
>>> the counter is not abi, it's in a hidden object.
>> 
>> No, it is really an ABI between user-space apps/libs. It's not meant to be
>> hidden. glibc implements its own register/unregister functions (it does not
>> link against librseq). librseq exposes register/unregister functions as public
>> APIs. Those also use the refcount. I also plan to have existing libraries, e.g.
>> liblttng-ust and possibly liburcu flavors, implement the
>> registration/unregistration and refcount handling on their own, so we don't
>> have to add a requirement on additional linking on librseq for pre-existing
>> libraries.
>> 
>> So that refcount is not an ABI between kernel and user-space, but it's a
>> user-space ABI nevertheless (between program and shared objects).
>> 
> 
> if that's what you want, then your declaration is wrong.
> the object should not have hidden visibility.

Actually, if we look closer into my patch, it defines two symbols,
one of which is an alias:

__attribute__((visibility("hidden"))) __thread
volatile struct libc_rseq __lib_rseq_abi = {
        .cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
};

extern __attribute__((weak, alias("__lib_rseq_abi"))) __thread
volatile struct rseq __rseq_abi;

Note that the public __rseq_abi symbol is weak but does not have
hidden visibility. I do this to ensure I don't get prototype
mismatch for __rseq_abi between rseq.c and rseq.h (it is required
to be a struct rseq by rseq.h), but I want the space to hold the
extra refcount field present in struct libc_rseq.


> 
> then each library (glibc etc) will have its own separate
> tls object with their own separate refcounter (and they
> will unregister when their own refcounter hits 0)

Given they all interact with the public __rseq_abi symbol,
at field refcount offset, they all effectively use the same
refcount field per thread, which serves the intended purpose.

> 
> either the struct should be public abi (extern tls
> symbol) or the register/unregister functions should
> be public abi (so when multiple implementations are
> present in the same process only one of them will
> provide definition for the public abi symbol and
> thus there will be one refcounter).

Those are two possible solutions, indeed. Considering that
we already need to expose the __rseq_abi symbol as a public
ABI in a way that ensures that multiple implementations
in a same process end up only using one of them, it seems
straightforward to simply extend that structure and hold the
refcount there, rather than having two extra ABI symbols
(register/unregister functions).

One very appropriate question here is whether we want to
expose the layout of struct libc_rseq (which includes the
refcount) in a public header file, and if so, which project
should hold it ? Or do we just want to document the layout
of this ABI so projects can define the structure layout
internally ? As my implementation currently stands, I have
the following structure duplicated into rseq selftests,
librseq, and glibc:

/*
 * linux/rseq.h defines struct rseq as aligned on 32 bytes. The kernel ABI
 * size is 20 bytes. For support of multiple rseq users within a process,
 * user-space defines an extra 4 bytes field as a reference count, for a
 * total of 24 bytes.
 */
struct libc_rseq {
        /* kernel-userspace ABI. */
        __u32 cpu_id_start;
        __u32 cpu_id;
        __u64 rseq_cs;
        __u32 flags;
        /* user-space ABI. */
        __u32 refcount;
} __attribute__((aligned(4 * sizeof(__u64))));

That duplicated structure only needs to be present in early-adopter
applications/libraries. Those linking on librseq or relying on newer
glibc to register rseq don't need to know about this extended layout:
all they need to care about is the layout of struct rseq (without the
added refcount). 

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
