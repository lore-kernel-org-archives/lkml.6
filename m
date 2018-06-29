Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14144C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A389A27DB5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="OYhJMI9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A389A27DB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754988AbeF2TtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:49:03 -0400
Received: from mail.efficios.com ([167.114.142.138]:47510 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeF2TtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:49:00 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5A45822EFFB;
        Fri, 29 Jun 2018 15:48:59 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Cvm7En3s3KKi; Fri, 29 Jun 2018 15:48:58 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A1AB522EFF7;
        Fri, 29 Jun 2018 15:48:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A1AB522EFF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530301738;
        bh=GXLKYMLqIuNqGEWAvhLHCSQc7hehgqQQh82AMITjIWY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=OYhJMI9h5MoYuMU8brqBBceWij8BEKbABQ62CfICgDi5NY0SM8oIevsiY6sQVKQIq
         m+xcmGZVONEmYObMRZCY+uzrSbeiIpHklqCKKlAD4R9c9vIzTvVD9FLYA9CfhtXm3w
         eVcyKkjBheW+ELThtX1bv714lSZy4Lv/iUbVfGfI2b6XRXdYLs3QRFPd+YHsVBttQQ
         SVW3vsmdfkUwdr01nM8tv1YjDQNXX5AQTVFR/LWlPRAC1x4D+Tv9/QfiXbe+KRWDd5
         aHzIx+1dDmZZ/IB8SZVv778SYUTaan9MASb8QkTz95juplrJXTycIJD7EPt3jlEFO/
         iWZTYRpwrQO9Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id BReCToBWlrRr; Fri, 29 Jun 2018 15:48:58 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 840B522EFEB;
        Fri, 29 Jun 2018 15:48:58 -0400 (EDT)
Date:   Fri, 29 Jun 2018 15:48:58 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Message-ID: <184287091.10022.1530301738384.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFz8KyVqFsVnp-6g+thz7vmm5nK_FSdRTPSks7gsNVNRdQ@mail.gmail.com>
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com> <1706339668.9644.1530281144560.JavaMail.zimbra@efficios.com> <CA+55aFxRJWjbgLeSQ_swi3F5nF1SYgZnC-R7QsOvZdcuSaWeaw@mail.gmail.com> <729451355.9702.1530284622326.JavaMail.zimbra@efficios.com> <CA+55aFw==YnFJn7iGnKMW=RbPT74YHNa0QDF96mEdMPA2oX9SA@mail.gmail.com> <CA+55aFwJWxsE_LL=-8WgB7uH_mYeMSu=boWF4N5KdOW673g4hA@mail.gmail.com> <247789350.9741.1530288432573.JavaMail.zimbra@efficios.com> <CA+55aFz8KyVqFsVnp-6g+thz7vmm5nK_FSdRTPSks7gsNVNRdQ@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are <
 TASK_SIZE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: validate rseq_cs fields are < TASK_SIZE
Thread-Index: xQsyvP835L4xOU7BYNQ9Rq9gb6JGrQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 29, 2018, at 1:03 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Fri, Jun 29, 2018 at 9:07 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> This code is not invoked from syscalls, but rather on return from
>> interrupt/trap after a preemption.
> 
> But when we register the rseq, we could easily check that the top bits
> of the IP is clear, no?

When a thread registers rseq, it registers a pointer to a user-space
address where a struct rseq is located.

That struct rseq is typically in a TLS area. It contains a pointer
to the current "struct rseq_cs": the content of rseq_cs describes the
current rseq critical section.

So when we register rseq, the rseq->rseq_cs pointer value is typically
NULL, because there is no currently active critical section. It's after
return from sys_rseq registration that user-space eventually sets the
pointer to a non-NULL value when it enters a critical section.

So at rseq registration, there is no point in validating the value of
the rseq_cs pointer, nor of any fields in the struct rseq_cs that would
be currently pointed to by that rseq_cs pointer, because those all change
after registration.

> Sure, user space can change it after the fact, but at that point it's
> literally "user space is being intentionally stupid".

User-space can be either stupid, or really clever and trying to attack
the kernel.

> The real worry is that 32-bit compat code never initializes those bits
> at all, no?

There are two aspects I'm concerned about here:

1) security: we don't want 32-bit user-space to feed a 64-bit value over 4GB
   as abort_ip that may end up causing OOPSes on architectures that would
   lack proper validation of those values on return to userspace.

2) behavior consistency of 32-bit userspace on both native 32-bit and 32-bit
   compat on 64-bit kernel:
   - for testing: having repeatable behavior on native and compat deployments
     ensures that testing results are the same. This is the difference between
     having "undefined behavior" when the upper bits are set or "defined behavior:
     the process is terminated with sigsegv",
   - for security: if the behavior differs between 32-bit compat and native
     32-bit, this leaks information about which specific architecture the kernel
     is running on, which facilitates attacks on the kernel.

But perhaps I'm caring too much about those aspects ? Maybe they matter less
than I presume.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
