Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10A4C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B77B250BC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="EzI8zLM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B77B250BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753159AbeGCAf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 20:35:28 -0400
Received: from a9-99.smtp-out.amazonses.com ([54.240.9.99]:38516 "EHLO
        a9-99.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752636AbeGCAf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 20:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1530578125;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=q4lGPsxt4kFIB0g3gkQh3a9z+a/UOjP3YKDTx0DABQI=;
        b=EzI8zLM3/aFbaJWsjR6R722OYFdZh07kcWwSxv6MvOcbBPPKug5jbBWszmICfArz
        BwHx4f/fyLeWYBS6j1dFYB0irllgk9kOTHRooyKG+wQLLUPWFMqPiVbZvngpLl4huJv
        P0+Us7+TKeLXKPXIQVvyRVmmen2ITNd1pYp4IBHs=
Date:   Tue, 3 Jul 2018 00:35:25 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields, validate
 user inputs
In-Reply-To: <1020760632.10855.1530577391822.JavaMail.zimbra@efficios.com>
Message-ID: <010001645d90c295-71d0a2e6-d5ce-4b8a-a60d-5d66fe17c8b3-000000@email.amazonses.com>
References: <20180702223143.4663-1-mathieu.desnoyers@efficios.com> <CA+55aFxrX+wRoe+5HDaTrRXg1K-Qpks4jJ9Buc_OevoG8hoGFw@mail.gmail.com> <415287289.10831.1530572418907.JavaMail.zimbra@efficios.com> <CA+55aFzZYOatOtjrm7fD7878_SzCAmEoEu74n0+pgd7faH-sTQ@mail.gmail.com>
 <825871008.10839.1530573419561.JavaMail.zimbra@efficios.com> <010001645d81f652-8a506dd2-cd49-47f9-950a-24ef52bda9f7-000000@email.amazonses.com> <1020760632.10855.1530577391822.JavaMail.zimbra@efficios.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.07.03-54.240.9.99
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018, Mathieu Desnoyers wrote:

> >
> > Platforms with 32 bit word size only guarantee atomicity of a 32 bit
> > write or RMV instruction.
> >
> > Special instructions may exist on a platform to perform 64 bit atomic
> > updates. We use cmpxchg64 f.e. on Intel 32 bit platforms to guarantee
> > atomicity8.
> >
> > So use the macros that we have to guarantee 64 bit ops and you should be
> > fine. See linux/arch/x86/include/asm/atomic64_32.h
>
> We are talking about user-space here. What we need is a single instruction
> atomic store, similar to what WRITE_ONCE() does in the kernel. The discussion
> is about whether doing the user-space equivalent of a WRITE_ONCE() to a u64
> on a 32-bit architecture should be considered to provide single-copy atomicity
> on the low 32 bits.

Right. You would need to make this work for userspace. atomic64_32.h is a
good reference as to which instructions provide 64 bit atomicity on 32
bit platforms.

