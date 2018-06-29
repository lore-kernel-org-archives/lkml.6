Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4612BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEFF23F5F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="QC6WYXSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFEFF23F5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755000AbeF2PDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:03:45 -0400
Received: from mail.efficios.com ([167.114.142.138]:59274 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbeF2PDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:03:44 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2868122E12E;
        Fri, 29 Jun 2018 11:03:43 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id gpnq8R2I-HDg; Fri, 29 Jun 2018 11:03:42 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8D45122E12B;
        Fri, 29 Jun 2018 11:03:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8D45122E12B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530284622;
        bh=w05eFY5rnMPGj5O1M8/fJQ4zfWBnrc69oILpkjgvdE0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=QC6WYXSPFOr8ZuONZ5WSK9QkUZN2ip/fw60hlKM+7rpU1/xtSEmde3kkeGeRbbE8Q
         SI9/TvUNL4VadLxEW1Xa9G9pPirzFg6+BGcK2y4Hp8qxRx/qRx96rt3epWDo7343VF
         ZfIpU1luVYjJptry2iKhlRSjulwRHQB/igz0JOEOjisdKO6DqE/SYXA+BjDLSjAQw2
         Pvz43fpOG9GeOo4k5G9Lk5bxjAybmsfcJgA1XOWm7HPa9uflAAsQYi45bIv6iGCsVD
         VXvlzhGy73ppKmxT0it72fBydonFjQsyVwNFYIVKn/MML1IkqQOebDJEDyF8Q/T9Jx
         OkL1NPdkUPZ4A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id ufvYFjg0wDHn; Fri, 29 Jun 2018 11:03:42 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 701AA22E124;
        Fri, 29 Jun 2018 11:03:42 -0400 (EDT)
Date:   Fri, 29 Jun 2018 11:03:42 -0400 (EDT)
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
Message-ID: <729451355.9702.1530284622326.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFxRJWjbgLeSQ_swi3F5nF1SYgZnC-R7QsOvZdcuSaWeaw@mail.gmail.com>
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com> <CA+55aFxZrv9koOGKNzpBjcpzwaKQBg9ybqcvQ9u=5d94y1F+mQ@mail.gmail.com> <CALCETrUrXk3wRg8SKhWf98v8jK=HwX9XLvP+Ypi+TktZoNx_Jg@mail.gmail.com> <CA+55aFzxCjkSbfRUeX3W_oXSJ6LMUdRVYB=DR2b3rUNkiixM1A@mail.gmail.com> <9200ED2A-AE4B-4094-81C9-E92240B4840F@amacapital.net> <CA+55aFzpD5xF80iiFNd+EMkJnRQdKPumM5p24Sr+LeBt8Gg=wg@mail.gmail.com> <1706339668.9644.1530281144560.JavaMail.zimbra@efficios.com> <CA+55aFxRJWjbgLeSQ_swi3F5nF1SYgZnC-R7QsOvZdcuSaWeaw@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are <
 TASK_SIZE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: validate rseq_cs fields are < TASK_SIZE
Thread-Index: kIsgy3CL9A5lysZdCVTFSg6LbqNpWQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 29, 2018, at 10:17 AM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Fri, Jun 29, 2018 at 7:05 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> What I'm worried about is setting regs->ip of a compat 32-bit task to
>> addresses in the range 0x100000000-0xFFFFFFFFFFFFFFFF.
> 
> Well, they won't have anything mapped in that range, so it really
> shouldn't matter.

It appears that arm64 simply clears the top bits of regs->ip when
returning to 32-bit compat userspace. So this would be inconsistent
between 32-bit kernel and 64-bit kernel with a 32-bit compat task:
a 32-bit kernel would kill the process, but a 64-bit kernel would
silently clear the top bits.

Considering those inconsistencies between architectures (either
the task gets killed, or the top bits are silently cleared), I'm
very much tempted to be restrictive in the inputs accepted by
rseq, and not rely on architectures as providing consistent
validation of the return IP.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
