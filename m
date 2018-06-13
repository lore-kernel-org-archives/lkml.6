Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A4B8AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644C7208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644C7208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754587AbeFMIVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:21:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754495AbeFMIVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:21:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6068401EF36;
        Wed, 13 Jun 2018 08:21:34 +0000 (UTC)
Received: from oldenburg.str.redhat.com (dhcp-192-212.str.redhat.com [10.33.192.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5113320244E0;
        Wed, 13 Jun 2018 08:21:33 +0000 (UTC)
Subject: Re: Restartable Sequences system call merged into Linux
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     carlos <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
References: <1084280721.10859.1528746558696.JavaMail.zimbra@efficios.com>
 <31fc101a-295b-067b-1a82-7e9e509fc92f@redhat.com>
 <305409897.10888.1528747473727.JavaMail.zimbra@efficios.com>
 <091061df-3482-8762-30e4-feaf3417be11@redhat.com>
 <417742741.11550.1528821084084.JavaMail.zimbra@efficios.com>
From:   Florian Weimer <fweimer@redhat.com>
Message-ID: <fbab73d4-7d92-fb79-182c-8863fd882ab2@redhat.com>
Date:   Wed, 13 Jun 2018 10:21:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <417742741.11550.1528821084084.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 13 Jun 2018 08:21:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 13 Jun 2018 08:21:34 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'fweimer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 06:31 PM, Mathieu Desnoyers wrote:
> ----- On Jun 12, 2018, at 9:11 AM, Florian Weimer fweimer@redhat.com wrote:
> 
>> On 06/11/2018 10:04 PM, Mathieu Desnoyers wrote:
>>> ----- On Jun 11, 2018, at 3:55 PM, Florian Weimer fweimer@redhat.com wrote:
>>>
>>>> On 06/11/2018 09:49 PM, Mathieu Desnoyers wrote:
>>>>> It should be noted that there can be only one rseq TLS area registered per
>>>>> thread,
>>>>> which can then be used by many libraries and by the executable, so this is a
>>>>> process-wide (per-thread) resource that we need to manage carefully.
>>>>
>>>> Is it possible to resize the area after thread creation, perhaps even
>>>> from other threads?
>>>
>>> I'm not sure why we would want to resize it. The per-thread area is fixed-size.
>>> Its layout is here: include/uapi/linux/rseq.h: struct rseq
>>
>> Looks I was mistaken and this is very similar to the robust mutex list.
>>
>> Should we treat it the same way?  Always allocate it for each new thread
>> and register it with the kernel?
> 
> That would be an efficient way to do it, indeed. There is very little
> performance overhead to have rseq registered for all threads, whether or
> not they intend to run rseq critical sections.
> 
>>
>>> The ABI is designed so that all users (program and libraries) can interact
>>> through this per-thread TLS area.
>>
>> Then the user code needs just the address of the structure.
> 
> Yes.

So we'd add

   struct rseq *rseq_location (void);

and be done with it?  It would return the address of the thread-local 
variable, similar to __errno_location.

Or we could add something like this:

   extern __thread struct rseq pthread_rseq_area_np
     __attribute__ ((__tls_model__ ("initial-exec")));

But of course only for recent-enough GNU compilers (and Clang, which 
identifies itself as GNU).

The advantage of the function call is that it often results in more 
compact code.  Making the initial-exec nature part of the ABI has the 
advantage that the applications could use the fact of the constant 
offset to the thread pointer if they desire to do so.

Would we need to document which glibc functions use 
pthread_rseq_area_np, so that applications do not call them when they 
itself use the area?

Do we actually need to use RSEQ_FLAG_UNREGISTER prior to thread exit? 
Why can't the kernel do it for us?

>     - requires all rseq users to upgrade to newer glibc. Early rseq users
>       (libs and applications) registering their own rseq TLS will conflict
>       with newer glibc.

We will need to do something about stack unwinding and longjmp anyway (I 
assume the kernel already handles signals for us), so it may not be 
possible to use restartable sequences in any substantial way with a 
system upgrade anyway.

> B) librseq.so exposes a strong __rseq_abi symbol:
> 
>     - should ideally *not* be global-dynamic for performance reasons, but
>       testing shows that using initial-exec causes issues in situations where
>       librseq.so ends up being dlopen'd (e.g. java virtual machine dlopening
>       the lttng-ust tracer linked against librseq.so),

Just an aside:

You can work around that using preloading.  On the glibc side, we could 
also make the initial reserve configurable.  On 64-bit, there really is 
no reason not to use a different TCB allocation scheme which would allow 
you to create a few threads before the initial-exec TLS area cannot be 
extended.

The existing approach dates back to LinuxThreads and its TCB collocated 
with the the stack.  But changes in the next few months are not very likely.

> C) __rseq_abi symbol declared weak within each user (application, librseq,
>     other libraries, glibc):

We can multiple two non-weak definitions for the symbol.  It should work 
as long as only the definition in glibc has a symbol version.

__rseq_abi as a name is problematic because it's in the internal namespace.

Thanks,
Florian
