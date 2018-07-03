Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B8DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6C922544
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JlA1AKLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6C922544
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753921AbeGCCaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:30:13 -0400
Received: from mail.efficios.com ([167.114.142.138]:59960 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753706AbeGCCaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:30:11 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 459FD22FD30;
        Mon,  2 Jul 2018 22:30:10 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 1W68cIJ80Sih; Mon,  2 Jul 2018 22:30:09 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D064522FD29;
        Mon,  2 Jul 2018 22:30:09 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D064522FD29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530585009;
        bh=+KUZ1VTGTmbZBd9AREP6dWvJckviNduqiah83Zoyy8o=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=JlA1AKLU5NTZYq/O3L44voykzuvmfl94WDsL267bMeX6ZxHpXln1m0IhXFmpTcC8f
         9tt9C54Mv99qBLU+WP+DgtUhgjtqJaemPEMvCKM3S0otbJ6OPXfP64xLDsK8QxthCK
         M9diPE+EpQh8DN1r64uLcJg/B3Yyk7x05EidUOvoMLYE1oZnIIGbGOruZRUZ/BLAXL
         kQ38RrZgTMEEiI+VeJ2xjMhGbVQJoCLXc4fgPClDDH8/WHY8ZXb6ooVZxeiu2ucayl
         2l1Nvc9nmDk4f2wXmOAVdFwjNdqaTV+oguEo9ZHPe7OhFGEyBnJngdpNtjkRgjEabh
         moO8IEPBngSQQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id GSmUOubAJN4i; Mon,  2 Jul 2018 22:30:09 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id B24F022FD1F;
        Mon,  2 Jul 2018 22:30:09 -0400 (EDT)
Date:   Mon, 2 Jul 2018 22:30:09 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
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
Message-ID: <1776351430.10902.1530585009519.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFxWMjwx-4TGBHt0H6bh6FXC3NKMsjp=eKGw5cgA4wMBUA@mail.gmail.com>
References: <20180702223143.4663-1-mathieu.desnoyers@efficios.com> <CA+55aFzZYOatOtjrm7fD7878_SzCAmEoEu74n0+pgd7faH-sTQ@mail.gmail.com> <825871008.10839.1530573419561.JavaMail.zimbra@efficios.com> <1959930320.10843.1530573742647.JavaMail.zimbra@efficios.com> <8B2E4CEB-3080-4602-8B62-774E400892EB@amacapital.net> <459661281.10865.1530580742205.JavaMail.zimbra@efficios.com> <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com> <CA+55aFxWMjwx-4TGBHt0H6bh6FXC3NKMsjp=eKGw5cgA4wMBUA@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: use __u64 for rseq_cs fields, validate user inputs
Thread-Index: HFYlUXtgtR1KQGyi/tBiamfT2/dVeg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 2, 2018, at 10:18 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Mon, Jul 2, 2018 at 7:01 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> One thing to consider is how we will implement the load of that pointer
>> on the kernel side.
> 
> Use "get_user()". It works for 64-bit objects too, and it will be
> atomic in the 32-bit sub-parts on a 32-bit architecture.

Is it really ? Last time we had this discussion, not all architectures
guaranteed that reading a 64-bit integer would happen in two atomic
32-bit sub-parts. This was the main motivation for the LINUX_FIELD_u32_u64()
macro as it stands today (rather than using a union).

> 
> Again: there is no point in trying to be atomic in the full 64 bits
> (when you're running on 32-bit). The upper bits don't have to "match"
> the lower bits. They just have to be zero. So doing it as two loads is
> fine - the same way it's perfectly fine to do it as two stores (since
> the store to the upper bits will always be zero).

I'd be fine with two atomic loads, but I'd rather have a strong
confirmation about this, because last time around there were
architectures where it was not true as far as I recall.

Thanks,

Mathieu


> 
>             Linus

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
