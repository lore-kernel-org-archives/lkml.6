Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F33C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C9524CE7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 00:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JsyKSSMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C9524CE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbeGCAXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 20:23:15 -0400
Received: from mail.efficios.com ([167.114.142.138]:52544 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752686AbeGCAXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 20:23:13 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 97AA522F2A1;
        Mon,  2 Jul 2018 20:23:12 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id qCX1u_7Lva5O; Mon,  2 Jul 2018 20:23:12 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0A58222F29A;
        Mon,  2 Jul 2018 20:23:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0A58222F29A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530577392;
        bh=Mekz8bfQ386HfKn0lhl8BNLWDIFW6+GBcrYLrBOufXs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=JsyKSSMM864b3jX6zDTZyUlmiF8DxuMzyKX3UjsLy3DoqdwrvoilgCbGhamrY0PfG
         ZSdtz769VYUeLTfok5+CWK7yXVYrm7QAo2lzJYW3gm5F0eJK64LJ+hmvRyOXbMPwe5
         xjRv2IUlHRDg6qPxbZc+0RsXI7I83ZKEKHe48aHLYjG+TJNWNeF04ZgB3xoagBGWli
         fQKA9eKV22hU/1PuJNPHR1utPO9k7VsWUIOkJG0rDq3s1RQZmgRwI5QTZNk+8kzOhp
         LwSRiKpcE6/nxITZRQ/Tkyb7hvY/eIeO2PyKtltOI/kJACPHQc5hjwrcCgYax8Tf3s
         MlhyPTWYmojVQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id RATme5mK_nh1; Mon,  2 Jul 2018 20:23:11 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id E2B5F22F287;
        Mon,  2 Jul 2018 20:23:11 -0400 (EDT)
Date:   Mon, 2 Jul 2018 20:23:11 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Chris Lameter <cl@linux.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <1020760632.10855.1530577391822.JavaMail.zimbra@efficios.com>
In-Reply-To: <010001645d81f652-8a506dd2-cd49-47f9-950a-24ef52bda9f7-000000@email.amazonses.com>
References: <20180702223143.4663-1-mathieu.desnoyers@efficios.com> <CA+55aFxrX+wRoe+5HDaTrRXg1K-Qpks4jJ9Buc_OevoG8hoGFw@mail.gmail.com> <415287289.10831.1530572418907.JavaMail.zimbra@efficios.com> <CA+55aFzZYOatOtjrm7fD7878_SzCAmEoEu74n0+pgd7faH-sTQ@mail.gmail.com> <825871008.10839.1530573419561.JavaMail.zimbra@efficios.com> <010001645d81f652-8a506dd2-cd49-47f9-950a-24ef52bda9f7-000000@email.amazonses.com>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: use __u64 for rseq_cs fields, validate user inputs
Thread-Index: Qfic5CuPU8u4f935Vywe9GGxSdDRDA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 2, 2018, at 8:19 PM, Chris Lameter cl@linux.com wrote:

> On Mon, 2 Jul 2018, Mathieu Desnoyers wrote:
> 
>> Are there any kind of guarantees that a __u64 update on a 32-bit architecture
>> won't be torn into something daft like byte-per-byte stores when performed
>> from C code ?
>>
>> I don't worry whether the upper bits get updated or how, but I really care
>> about not having store tearing of the low bits update.
> 
> Platforms with 32 bit word size only guarantee atomicity of a 32 bit
> write or RMV instruction.
> 
> Special instructions may exist on a platform to perform 64 bit atomic
> updates. We use cmpxchg64 f.e. on Intel 32 bit platforms to guarantee
> atomicity8.
> 
> So use the macros that we have to guarantee 64 bit ops and you should be
> fine. See linux/arch/x86/include/asm/atomic64_32.h

We are talking about user-space here. What we need is a single instruction
atomic store, similar to what WRITE_ONCE() does in the kernel. The discussion
is about whether doing the user-space equivalent of a WRITE_ONCE() to a u64
on a 32-bit architecture should be considered to provide single-copy atomicity
on the low 32 bits.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
