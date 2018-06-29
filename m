Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE0CC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF8E250A9
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="b3Oxpr4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF8E250A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936135AbeF2QHQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:07:16 -0400
Received: from mail.efficios.com ([167.114.142.138]:34608 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933911AbeF2QHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:07:14 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6947B22EF00;
        Fri, 29 Jun 2018 12:07:13 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Oedmk33_GCpB; Fri, 29 Jun 2018 12:07:12 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D5E7A22EEFA;
        Fri, 29 Jun 2018 12:07:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D5E7A22EEFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530288432;
        bh=M5i8WOF6+1fMnSeFc30wcMiksgX+5/LYFYoUAY6C/fo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=b3Oxpr4FxOCh03nuKUMk4boZJlvW4sld76/tVGnJGPqueuIkajKvut2wFYed/lpzD
         0OTPLD9BJFIffEINJfu6g78aD4qui2rQ8UQVdPJeMZF6oePAHRkwkTTIClso5m/FNO
         Y2VqAVoJAhQ+adRJ5Ej/aBpVQyC6WyXV8rKRM2YZkEOW5m+e11zk+mvDIAe9lnawkn
         4UFLOJ8kKkAE67NXTZBgpwOyzwXaZfknahEmKSJPdldLLnJbBV9bnfNbZC5bFUOTua
         uPRiJ3UeCB2f7OgrriJT1e8kxrcETFIQJwVwzqnTnMMQz69uTRpXK/2+2cbGacGlh/
         GHHnwbb+qSVDg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id W_4PiZ2fArJj; Fri, 29 Jun 2018 12:07:12 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id B9CF922EEE8;
        Fri, 29 Jun 2018 12:07:12 -0400 (EDT)
Date:   Fri, 29 Jun 2018 12:07:12 -0400 (EDT)
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
Message-ID: <247789350.9741.1530288432573.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFwJWxsE_LL=-8WgB7uH_mYeMSu=boWF4N5KdOW673g4hA@mail.gmail.com>
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com> <9200ED2A-AE4B-4094-81C9-E92240B4840F@amacapital.net> <CA+55aFzpD5xF80iiFNd+EMkJnRQdKPumM5p24Sr+LeBt8Gg=wg@mail.gmail.com> <1706339668.9644.1530281144560.JavaMail.zimbra@efficios.com> <CA+55aFxRJWjbgLeSQ_swi3F5nF1SYgZnC-R7QsOvZdcuSaWeaw@mail.gmail.com> <729451355.9702.1530284622326.JavaMail.zimbra@efficios.com> <CA+55aFw==YnFJn7iGnKMW=RbPT74YHNa0QDF96mEdMPA2oX9SA@mail.gmail.com> <CA+55aFwJWxsE_LL=-8WgB7uH_mYeMSu=boWF4N5KdOW673g4hA@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are <
 TASK_SIZE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: validate rseq_cs fields are < TASK_SIZE
Thread-Index: WiucE5TyA/5qz+mgdMTb6RCJOC0x2Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 29, 2018, at 11:54 AM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Fri, Jun 29, 2018 at 8:27 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> You simply can't have it both ways.
> 
> Put another way.
> 
> This is ok in the native path:
> 
>        if ((unsigned long) rseq_cs->abort_ip != rseq_cs->abort_ip)
>                return -EINVAL;
> 
> because it's checking that the value fits in the native register size
> (and it also ends up being a no-op if the native size is the same size
> as abort_ip).
> 
> And this is very much ok in a compat syscall:
> 
>        if (rseq_cs->abort_ip & ~(unsigned long)-1u)
>                return -EINVAL;
> 
> because it's checking that the pointer doesn't have (invalid in
> compat) high bits set.
> 
> But it is NOT OK to say "the rseq system call doesn't have any compat
> syscall, but we'll do that compat check in the native case, because we
> worry about compat issues".
> 
> See what I'm saying? Either you worry about compat issues (and have a
> compat syscall), or you don't.
> 
> The whole "let's not do a compat syscall, but then check compat issues
> at run-time in the native system call because compat processes will
> use it" is braindamage.

This code is not invoked from syscalls, but rather on return from
interrupt/trap after a preemption.

So a compat system call does not solve it. Unless we grab the "compat"
state on rseq registration, save it in a rseq_compat flag within the
task struct, and then use it on return from interrupt/trap/syscall.
Otherwise we need to figure out whether we are dealing with a compat
task when interrupt and trap context return to userspace. We had
is_compat_task() for that before, but now it has vanished from x86.
We could use user_64bit_mode(struct pt_regs *) on x86, but it does not
exist on other architectures.

One possibility is to introduce a new API that calls user_64bit_mode()
on x86, and is_compat_task() on other archs.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
