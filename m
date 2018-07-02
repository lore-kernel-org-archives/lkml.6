Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E7DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE6220844
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Bm0yzJwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE6220844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753499AbeGBXRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:17:03 -0400
Received: from mail.efficios.com ([167.114.142.138]:48940 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752860AbeGBXRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:17:01 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 96FF322FD71;
        Mon,  2 Jul 2018 19:17:00 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id yWHPsSq6uwkL; Mon,  2 Jul 2018 19:17:00 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E0F6122FD65;
        Mon,  2 Jul 2018 19:16:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E0F6122FD65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530573419;
        bh=KSKM7pu8Zy4OeUTC0sMdR+VnF7EzwFsiHUkZcAS6zpY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Bm0yzJwh4uN9BtB2yv2i3TjdCyR10NjGAaSGjmgvCcdSL+XO/7XX72QUrInt55Psm
         +S04JrOZcZOvGgSPnfjQL9lwnH1sb132SMUhSO10aAdjDzuj6ytBJ6xN+FdNV++doE
         r1chfXN9M0ihhpZ1wufFEXUS35UbDD+3e2pifOkU4WEfUe4G/D5skswOBQzzkXFZdk
         1h1pPF6p6chIh4dK3viHCu86TsFXNvNfg1lb2Wj4Q2RkeHSutF5utq4F9mSRyTaHfy
         2OuI8JfDRNtjXcdFsl1dycUYQS5Xnb8AjVwjwBQ506DQ/w5qIvbnjfK0esOHPX/ONZ
         IMZnl1lqqXZyA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 8i-EZ_w6V4Sc; Mon,  2 Jul 2018 19:16:59 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id BFF7122FD5F;
        Mon,  2 Jul 2018 19:16:59 -0400 (EDT)
Date:   Mon, 2 Jul 2018 19:16:59 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Message-ID: <825871008.10839.1530573419561.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFzZYOatOtjrm7fD7878_SzCAmEoEu74n0+pgd7faH-sTQ@mail.gmail.com>
References: <20180702223143.4663-1-mathieu.desnoyers@efficios.com> <CA+55aFxrX+wRoe+5HDaTrRXg1K-Qpks4jJ9Buc_OevoG8hoGFw@mail.gmail.com> <415287289.10831.1530572418907.JavaMail.zimbra@efficios.com> <CA+55aFzZYOatOtjrm7fD7878_SzCAmEoEu74n0+pgd7faH-sTQ@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: use __u64 for rseq_cs fields, validate user inputs
Thread-Index: SHiTQe7XPSOexphG2GWas6EadgayhQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 2, 2018, at 7:06 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Mon, Jul 2, 2018 at 4:00 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> Unfortunately, that rseq->rseq_cs field needs to be updated by user-space
>> with single-copy atomicity. Therefore, we want 32-bit user-space to initialize
>> the padding with 0, and only update the low bits with single-copy atomicity.
> 
> Well... It's actually still single-copy atomicity as a 64-bit value.
> 
> Why? Because it doesn't matter how you write the upper bits. You'll be
> writing the same value to them (zero) anyway.
> 
> So who cares if the write ends up being two instructions, because the
> write to the upper bits doesn't actually *do* anything.
> 
> Hmm?

Are there any kind of guarantees that a __u64 update on a 32-bit architecture
won't be torn into something daft like byte-per-byte stores when performed
from C code ?

I don't worry whether the upper bits get updated or how, but I really care
about not having store tearing of the low bits update.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
