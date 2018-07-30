Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A3AC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DAD20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="SfnWOHEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DAD20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbeG3USW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 16:18:22 -0400
Received: from mail.efficios.com ([167.114.142.138]:56106 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeG3USV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 16:18:21 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7E47222D57F;
        Mon, 30 Jul 2018 14:42:02 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id fh3L8pl7HLRW; Mon, 30 Jul 2018 14:42:01 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 599EF22D56D;
        Mon, 30 Jul 2018 14:42:01 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 599EF22D56D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1532976121;
        bh=oqydiHEB4ydv63FB1UwpTqw76+YTvC57U67iII7B8XA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=SfnWOHEqXMiqFMNWGWhLxT0/LOmUXyIdtzJwXiCbeaPhMhVcVUfi0M5ehJqwS4DwK
         DP/H+WTJRKIGMwiAKzJAMJDZaIiDHO7NH5dQNpKa5TA+1axh9LjG404MRD3TvLfAYH
         Dp02geTYVoCdk8elEcdU/Dk2NloNoGzIIGdtfkV6p3rnstcN8tXDyziQns+eEpAMxC
         eblsYQfNepK1fNUn+Q7b1WU89k0GLioVPp0jZdX5qAqIBD+UL6dakVp9edLywe1Qog
         G77Oaq3WyIz7OmjhMFMaOf+FFGE905dLYYcrVFCpZiRrEAZsk0SCFiTLLFThSjuxU6
         Xi20XeMjqixLg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id ZBqBca2eaeIp; Mon, 30 Jul 2018 14:42:01 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 3B08922D55F;
        Mon, 30 Jul 2018 14:42:01 -0400 (EDT)
Date:   Mon, 30 Jul 2018 14:42:00 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Message-ID: <1005916991.7038.1532976120931.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180728141314.GA25264@amd>
References: <20180602124408.8430-1-mathieu.desnoyers@efficios.com> <20180727220115.GA18879@amd> <1210024721.6363.1532785744879.JavaMail.zimbra@efficios.com> <20180728141314.GA25264@amd>
Subject: Re: [RFC PATCH for 4.18 00/16] Restartable Sequences
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.9_GA_2055 (ZimbraWebClient - FF52 (Linux)/8.8.9_GA_2055)
Thread-Topic: Restartable Sequences
Thread-Index: MXBK7ELvS6yeEGYapqz7FvRuEMjSSg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 28, 2018, at 10:13 AM, Pavel Machek pavel@ucw.cz wrote:

> Hi!
> 
>> Documentation-wise, I have posted a rseq man page rfc here:
>> 
>> https://lkml.kernel.org/r/20180616195803.29877-1-mathieu.desnoyers@efficios.com
>> 
>> comments are welcome!
> 
> Thanks for pointer.
> 
> +Restartable sequences are atomic with respect to preemption (making
> it
> +atomic with respect to other threads running on the same CPU), as
> well
> +as signal delivery (user-space execution contexts nested over the
> same
> +thread).
> 
> So the threads are protected against sigkill when running the
> restartable sequence?

In that scenario, SIGKILL _will_ be delivered, hence execution of the
rseq critical section will never reach the commit instruction. This
follows the guarantee provided that the rseq c.s. either executes
completely "atomically" wrt preemption/signal delivery, *or* gets
aborted. In this case, sigkill will reap the entire process, so
the kernel will never actually have to return to userspace and
execute the instruction pointer at the abort_ip, but the rseq c.s.
will never reach the commit instruction.

> 
> +Restartable sequences must not perform system calls. Doing so may
> result
> +in termination of the process by a segmentation fault.
> +
> 
> "may result"? It would be nice to always catch that.

I would also like this, but unfortunately this check adds overhead to every
system call, therefore this is only enforced with CONFIG_DEBUG_RSEQ=y builds.

> 
> +Optimistic cache of the CPU number on which the current thread is
> +running. Its value is guaranteed to always be a possible CPU number,
> +even when rseq is not initialized. The value it contains should
> always
> +be confirmed by reading the cpu_id field.
> 
> I'm not sure what "optimistic cache" is...

Perhaps we can find a better wording.

It's "optimistic" in the sense that it's always guaranteed to hold a
valid CPU number within the range [ 0 .. nr_possible_cpus - 1 ]. It can
therefore be loaded by user-space and then used as an offset, without
having to check whether it is within valid bounds compared to the number
of possible CPUs in the system.

This works even if the kernel on which the application runs on does not
support rseq at all: the __rseq_abi->cpu_id_start field stays initialized at
0, which is indeed a valid CPU number. It's therefore valid to use it as an
offset in per-cpu data structures, and only validate whether it's actually the
current CPU number by comparing it with the __rseq_abi->cpu_id field
within the rseq critical section. If rseq is not available in the kernel,
that cpu_id field stays initialized at -1, so the comparison always fails,
as intended.

It's then up to user-space to use a fall-back mechanism, considering that
rseq is not available.

Advice on improved wording would be welcome.

> 
> +Flags indicating the restart behavior for the current thread. This is
> +mainly used for debugging purposes. Can be either:
> +.IP \[bu]
> +RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
> +.IP \[bu]
> +RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
> +.IP \[bu]
> 
> Flags tell me there may be more then one, but "can be either" tells me
> just one flag is allowed.

Combining them is allowed. Will fix by saying: "Can be a combination of:".

> 
> +.B Structure alignment
> +This structure is aligned on multiples of 32 bytes.
> +.TP
> +.B Structure size
> +This structure has a fixed size of 32 bytes.
> +.B Structure alignment
> +This structure is aligned on multiples of 32 bytes.
> +.TP
> +.B Structure size
> +This structure has a fixed size of 32 bytes.
> 
> I believe we normally say "is aligned on 32-bytes boundary".

OK will fix. I think it should then become:

"is aligned on 32-byte boundary." (no plural for byte)

> (Will not
> this need to be bigger on machines with bigger cache sizes?)
> 
> above it says:
> 
> +.B Structure size
> +This structure is extensible. Its size is passed as parameter to the
> +rseq system call.
> 
> I'm reading source, so maybe it refers to different structure.

It can be aligned on a larger multiple. This requirement of 32 bytes
is a minimum. Therefore, if we ever extend struct rseq, or if an
architecture shows benefit from aligning struct rseq on larger boundaries,
it is free to do so. It will still respect the requirement of alignment on
32 bytes boundaries.

Thoughts ?

Thanks,

Mathieu


> 
> Thanks,
>									Pavel
> 
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
