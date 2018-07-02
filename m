Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEF2C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA92624CA2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="tZwAcedc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA92624CA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753614AbeGBXZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:25:56 -0400
Received: from mail.efficios.com ([167.114.142.138]:49410 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753342AbeGBXZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:25:54 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C28A522F0CB;
        Mon,  2 Jul 2018 19:25:53 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id I4QQgmYMT-iX; Mon,  2 Jul 2018 19:25:53 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 69BB122F0C8;
        Mon,  2 Jul 2018 19:25:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 69BB122F0C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530573953;
        bh=XvSr0vIdhKoWrNh1Ln6YdEFDz//AISB11KCyotqURwA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=tZwAcedcvsVlSMq5gWZAOpURCsNeRZaBgzqFzz+il4sFX4MswUHAmgUVrHGmLArBi
         fea2L85eP91tod1pMxu6tSg5ZNupHTwdbnKhXcsPdb2A0bjAVv4CclVeBaJY+F4/Vk
         LI51EHKdS43sPIxF9Np80N/QLv4YuMC41DRqA0Xjfk1DP96DkDipgYgtaUY0pBFFex
         etSYbYE6H/NbMqN8aDtxSQFhyIH2ZrjyH7H6bwjmt5L9aEC4wVEwpRAtswG6Q4Z4/4
         2W6PV79WmnKQT7ro3VUXVPm6v1dG/99mOocDw0M58Z3itD/V6Uo+B6GNM4Jwx7dqAZ
         xJDyoVm77B9Ug==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id bZ6GhQomaV3h; Mon,  2 Jul 2018 19:25:53 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 4F63D22F0C1;
        Mon,  2 Jul 2018 19:25:53 -0400 (EDT)
Date:   Mon, 2 Jul 2018 19:25:53 -0400 (EDT)
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
Message-ID: <321013411.10852.1530573953298.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFyQwfXxMnx2WQadfZKAnEfkoT+zomrRRToZz8-uWzUccQ@mail.gmail.com>
References: <20180702223143.4663-1-mathieu.desnoyers@efficios.com> <CA+55aFxrX+wRoe+5HDaTrRXg1K-Qpks4jJ9Buc_OevoG8hoGFw@mail.gmail.com> <415287289.10831.1530572418907.JavaMail.zimbra@efficios.com> <CA+55aFzZYOatOtjrm7fD7878_SzCAmEoEu74n0+pgd7faH-sTQ@mail.gmail.com> <825871008.10839.1530573419561.JavaMail.zimbra@efficios.com> <CA+55aFyQwfXxMnx2WQadfZKAnEfkoT+zomrRRToZz8-uWzUccQ@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: use __u64 for rseq_cs fields, validate user inputs
Thread-Index: 5yY1eXdGH2Vutk85uxDq25+e1DocAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 2, 2018, at 7:22 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Mon, Jul 2, 2018 at 4:17 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> Are there any kind of guarantees that a __u64 update on a 32-bit architecture
>> won't be torn into something daft like byte-per-byte stores when performed
>> from C code ?
> 
> Guarantees? No. Not that there are any guarantees that the same won't
> happen for a plain 32-bit value either.
> 
> Will compilers generate that kind of code? I guess some crazy compiler
> could simply be really bad at handling 64-bit values, and just happen
> to handle 32-bit values better. So in that sense a 64-bit entity is
> certainly a bit riskier. But that would be a really bad compiler, I
> have to say.

Given that the only C code updating that field is rseq_prepare_unload()
(the rest is only ever updated from assembly), we could perhaps mandate
that user-space always update it from assembly, and therefore implement
rseq_prepare_unload as an inline asm which clears rseq->rseq_cs.

Does it sound better than the LINUX_FIELD_u32_u64 macro ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
