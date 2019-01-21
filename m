Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9964EC37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BFC20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lFDhDYgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfAUVX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:23:59 -0500
Received: from mail.efficios.com ([167.114.142.138]:56070 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfAUVX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:23:59 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0A15AB4D52;
        Mon, 21 Jan 2019 16:23:57 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id c85f-9a2i-Wd; Mon, 21 Jan 2019 16:23:56 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 29D6CB4D4A;
        Mon, 21 Jan 2019 16:23:56 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 29D6CB4D4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1548105836;
        bh=fSU2JRLPtR/56gZe4r2TAeNx6cGq1OoI4zlPdI8inB8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=lFDhDYgfNVwHUsu0rb1mb3Gxq+ySCvfwyvHmlxWY3QsBfOL7Zp3WlArxdaz4ebc25
         j2fuxxMszI6khkoLFJkyqWIX2MayGszAky2Bp7wrkV6P3sMTXvkImRCcliDQUgiaSK
         2M3jfqxxQaX8wEYvSULp0njMsIKZ3lJ8BElfLXQc9DgaKBu1x7FoI9HDy3c9ztdRN/
         WrYbqlzFfllWd8kopUzPGXcRHQHaznDvM/Obte0p6m47PohUc/YJv9SCTgaQ+WBlzu
         vQo+j5gIxatTf07/YlAL+iKVgdIirIAm67N1OIDIkTv0u1+cRtk41i9WkGQFFeHI3y
         KfszM5Kum9uQA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id dQb3Yasfzdyl; Mon, 21 Jan 2019 16:23:56 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 06783B4D44;
        Mon, 21 Jan 2019 16:23:56 -0500 (EST)
Date:   Mon, 21 Jan 2019 16:23:55 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     carlos <carlos@redhat.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1189519139.464.1548105835783.JavaMail.zimbra@efficios.com>
In-Reply-To: <1887968822.1146.1547833305059.JavaMail.zimbra@efficios.com>
References: <20190115015148.32155-1-mathieu.desnoyers@efficios.com> <1887968822.1146.1547833305059.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH glibc 1/4] glibc: Perform rseq(2) registration at C
 startup and thread creation (v5)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3745)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v5)
Thread-Index: llu+wX0M8PxIAlgKK5KtAmtbEJg5APmkjqtG
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 18, 2019, at 12:41 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Jan 14, 2019, at 8:51 PM, Mathieu Desnoyers
> mathieu.desnoyers@efficios.com wrote:
> 
> [...]
> 
>> diff --git a/sysdeps/unix/sysv/linux/rseq-sym.c
>> b/sysdeps/unix/sysv/linux/rseq-sym.c
>> new file mode 100644
>> index 0000000000..6856d0388a
> [...]
>> +/* volatile because fields can be read/updated by the kernel.  */
>> +__thread volatile struct rseq __rseq_abi = {
>> +  .cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
>> +};
>> +
>> +/* volatile because refcount can be read/updated by signal handlers.  */
>> +__thread volatile uint32_t __rseq_refcount;
> 
> Back to the weak vs non-weak question about those two symbols. I understand
> that tagging them as weak symbols has little effect on the dynamic loader
> when it loads libc.so. However, I'm worried about that happens when
> libc is statically linked into an application, and there happens to
> be more than one instance of those symbols (e.g. libc and another library
> define the same symbols, and both are statically linked into the same
> application). Isn't it a situation where tagging those symbols as "weak"
> becomes useful ?

Testing shows that it seems fine to statically link two archives within an
executable in a scenario where each .a defines the same symbol, without
using "weak", so I won't worry about this further.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
