Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D662C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0452085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="NKeFabsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0452085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeJKWlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:41:07 -0400
Received: from mail.efficios.com ([167.114.142.138]:42290 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbeJKWlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:41:06 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 090CE184696;
        Thu, 11 Oct 2018 11:13:30 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id QBaOBQJGua9E; Thu, 11 Oct 2018 11:13:29 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3730A18468F;
        Thu, 11 Oct 2018 11:13:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3730A18468F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539270809;
        bh=jZl6RJBTFwDpfJqpg4a5HCcVh083m1o+4WZeZmAN5xc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=NKeFabsjCCUwl2p6qSNTB6ZfWjHSUJM0RTtNwe37Er7vRaSJ9AlYcqKdzJ5p5+89M
         iSyVDosLdSGU9WAAtpCPEFA0CukPj1UmQvJrHR1pddAIMrjZixjvL/gWTuJZ4ibJ0T
         1hktveLh1NRagbMu+591oFkCfZJL/JhKvmt6zfNyzxaRbOaTDk2gqAUb35tUp3xRhf
         PY6Slzzum1sFuzDvABgVYYkbaXw3muJqKGcNpXvExt+t/4sCRKJaaAD+NVFRNYb9o2
         7zS31/+wQRihu7gMPKZ8STiLIowWP4zc6YNQ7FfSsEZylUatI+GTeJSg5+SAN8pxvE
         6U1rZN+OpOaBA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id n9GXWo8Z0Uur; Thu, 11 Oct 2018 11:13:29 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 0FC49184687;
        Thu, 11 Oct 2018 11:13:29 -0400 (EDT)
Date:   Thu, 11 Oct 2018 11:13:28 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>, nd <nd@arm.com>,
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
Message-ID: <1917048565.2402.1539270808972.JavaMail.zimbra@efficios.com>
In-Reply-To: <38596780-30f7-0763-0c17-7517dbf0bf59@arm.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com> <20181010191936.7495-2-mathieu.desnoyers@efficios.com> <38596780-30f7-0763-0c17-7517dbf0bf59@arm.com>
Subject: Re: [RFC PATCH for 4.21 01/16] rseq/selftests: Add reference
 counter to coexist with glibc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3039 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3039)
Thread-Topic: rseq/selftests: Add reference counter to coexist with glibc
Thread-Index: AQHUYM5AJL7p/dPuu0ud+WbMPMG0kKUZ2yOAKFv1Zy4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 11, 2018, at 6:37 AM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:

> On 10/10/18 20:19, Mathieu Desnoyers wrote:
>> In order to integrate rseq into user-space applications, add a reference
>> counter field after the struct rseq TLS ABI so many rseq users can be
>> linked into the same application (e.g. librseq and glibc). The
>> reference count ensures that rseq syscall registration/unregistration
>> happens only for the most early/late user for each thread, thus ensuring
>> that rseq is registered across the lifetime of all rseq users for a
>> given thread.
> ...
>> +__attribute__((visibility("hidden"))) __thread
>> +volatile struct libc_rseq __lib_rseq_abi = {
> ...
>> +extern __attribute__((weak, alias("__lib_rseq_abi"))) __thread
>> +volatile struct rseq __rseq_abi;
> ...
>> @@ -70,7 +86,7 @@ int rseq_register_current_thread(void)
>>  	sigset_t oldset;
>>  
>>  	signal_off_save(&oldset);
>> -	if (refcount++)
>> +	if (__lib_rseq_abi.refcount++)
>>  		goto end;
>>  	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq), 0, RSEQ_SIG);
> 
> why do you use a local refcounter instead of the __rseq_abi one?

There is no refcount in struct rseq (the ABI between kernel and user-space).
The registration refcount was part of an earlier version of the rseq system call,
but we decided against keeping it in the kernel.

So I'm adding one _after_ struct rseq, purely to allow interaction between
various user-space components (program/libraries).

> 
> what prevents calling rseq_register_current_thread more than 4G times?

Nothing. It would indeed be cleaner to error out if we detect that refcount is at
INT_MAX. Is that what you have in mind ?

> 
> why cant the kernel see that the same address is registered again and succeed?

It can, and it does. However, refcounting at user-level is needed to ensure
the registration "lifetime" for rseq covers its entire use. If we have two libraries
using rseq, we end up with the following scenario:

Thread 1

  libA registers rseq
  libB registers rseq
  libB unregisters rseq
  libA uses rseq -> bug! it's been unregistered by libB.
  libA unregisters rseq -> unexpected, it's already been unregistered.
 
same applies if libA unregisters rseq before libB (and libB try to use rseq
after libA has unregistered).

The refcount in user-space fixes this.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
