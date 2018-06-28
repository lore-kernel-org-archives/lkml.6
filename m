Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A73C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB502279FC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="AtoCL+gY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB502279FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935869AbeF1W3W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:29:22 -0400
Received: from mail.efficios.com ([167.114.142.138]:55972 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932522AbeF1W3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:29:21 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 19CE222ECB4;
        Thu, 28 Jun 2018 18:29:20 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id nBjt-Rf-398N; Thu, 28 Jun 2018 18:29:19 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 55F1F22ECAD;
        Thu, 28 Jun 2018 18:29:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 55F1F22ECAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530224959;
        bh=YckiZvn5wBuACqA+RRhpifkE73IH1S7cDe+V0Iqhaqw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=AtoCL+gYlUo8KkqhJyJKtvYmuVouIw3xNYrgGp8MYZlU3l5TWq9/NyFooXSW9zchs
         VK46h6ICcr1Mul5f/LjoCLAcU5gvl7J3a/Z2DEu5wFXPttU4+HbR28PtbJ4+hQ0IgA
         wN+9HXZH8fFErK7LWxPM2zleK4IWNRnYcWK0M8vqwsOIZUs4XOtFQ+SDNCwg2dRaRQ
         ZbwlL297JAEtX5qDk99SRs70ZIAYhrrtp2SSInmr52YowgnlJsFbjJ2rLfLECz3JLu
         ZDqQmbrhzXyNT06bP7rsbCLmTnG/FndhIgwLRd1lpJAD95VR8iaI3KxldjXUYtGXWk
         iwz63fQ0zfHTg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id ub1kI70s2xVN; Thu, 28 Jun 2018 18:29:19 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 37ABF22ECA4;
        Thu, 28 Jun 2018 18:29:19 -0400 (EDT)
Date:   Thu, 28 Jun 2018 18:29:18 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <1821591223.9479.1530224958939.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFxZrv9koOGKNzpBjcpzwaKQBg9ybqcvQ9u=5d94y1F+mQ@mail.gmail.com>
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com> <CALCETrULo_VP4XHbXcZTevWY5d-6PdHUtrDS8DEF_OaozQOaNg@mail.gmail.com> <CA+55aFxZrv9koOGKNzpBjcpzwaKQBg9ybqcvQ9u=5d94y1F+mQ@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are <
 TASK_SIZE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: validate rseq_cs fields are < TASK_SIZE
Thread-Index: 11XCFtdD9OAfrodbawODhQ2jv3dcYg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 28, 2018, at 5:22 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Thu, Jun 28, 2018 at 1:23 PM Andy Lutomirski <luto@kernel.org> wrote:
>>
>> This is okay with me for a fix outside the merge window.  Can you do a
>> followup for the next merge window that fixes it better, though?  In
>> particular, TASK_SIZE is generally garbage.  I think a better fix
>> would be something like adding a new arch-overridable helper like:
>>
>> static inline unsigned long current_max_user_addr(void) { return TASK_SIZE; }
> 
> We already have that. It's called "user_addr_max()".
> 
> It's the limit we use for user accesses.

Good point. I will simply replace TASK_SIZE with user_addr_max() then.

> That said, I don't see why we should even check the IP. It's not like
> that's done by signal handling either.

The goal stated by Andy and Thomas is to design rseq so it
does not need any compat syscall whatsoever. Considering
that this is a new system call, we should be able to do that.
One thing we want is to provide a consistent behavior when
a 32-bit binary is executed on native 32-bit kernel or on
64-bit kernel in compat mode, even if userspace chooses to
put garbage in the upper 32-bit of padding within 64-bit
fields.

Now let's look at the comparison with signals. If we look
at ia32_setup_frame() for instance, it sets:

  regs->ip = (unsigned long) ksig->ka.sa.sa_handler;

where the sa_handler pointer has been received as input
as a 32-bit pointer by the compat syscall rt_sigaction
through struct compat_sigaction. I agree with you that
it does not appear to validate that it's below
user_addr_max(), but at least it's guaranteed to never be
over 32-bit.

The first big difference between rseq and signals: rseq
does not have a compat structure. The layout is the same
for both 32-bit and 64-bit userspace (see include/uapi/linux/rseq.h).

Another difference between rseq and signals is that rseq
only registers the TLS struct rseq for each thread. Then,
it's up to user-space to update the rseq_cs field of
struct rseq to indicate that it enters a critical section.

So the actual content of (struct rseq *)->rseq_cs is updated
with single-copy atomicity after registration of rseq.
Therefore, the current critical section pointed to by the current
rseq_cs user-space pointer also changes after registration. So we
cannot validate the content of the rseq_cs field, nor of the fields
contained within every possible struct rseq_cs descriptor when
registering rseq through sys_rseq: those need to be read when
returning to user-space. Not just on return from system call, but
also on return from interrupt/trap after a preemption.

This is very much different from registering a sigaction,
where the kernel can validate or truncate the content of
sa_handler at will.

Without validation of the content of e.g. rseq_cs->abort_ip
(read as a 64-bit integer by a 64-bit kernel), we end up setting
the return IP to that address on abort, even though user-space may
have put garbage in the high bits:

   instruction_pointer_set(regs, (unsigned long)rseq_cs.abort_ip);

without any validation or truncation whatsoever.

I'm concerned that some architecture code may not deal so well without
prior validation or truncation of the IP register content upper 32 bits
when returning to a 32-bit compat task.

This is why I'm considering comparison of abort_ip against user_addr_max()
to ensure we're not provided with an incorrect user input.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
