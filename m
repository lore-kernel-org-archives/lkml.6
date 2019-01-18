Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF96C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C822086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Y084zBb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfARRls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:41:48 -0500
Received: from mail.efficios.com ([167.114.142.138]:51872 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfARRlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:41:47 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 29EEDA6DEE;
        Fri, 18 Jan 2019 12:41:46 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id FaCSFrAu-05N; Fri, 18 Jan 2019 12:41:45 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4416FA6DE0;
        Fri, 18 Jan 2019 12:41:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4416FA6DE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1547833305;
        bh=vxHNxRwrUsgH5AuaVvctZGNxnneoiXQrQlyOTKucT0w=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Y084zBb37KXnswUhAmAHU8PULv7qfOj8M/+3gRY7gC2BB/eAJIsYmzoT78PaW0o9g
         BpF71MJgJO7BxtPwlYg9//Hvww4HKl5cE9z7LuDh9tuWhUZzK1NF0JMEdPNjhkUYtr
         SVTBESwMgJLWbT5ndFou/2LP7nGqGvcRBX5BzBhuDjpKXXYqvpqk9BMKnhO7Znsp/5
         XJfNKRIcPjBuZmRXOmKed59cho8Il+TChtMcMDXHM0XIwGuETZiLUJce2EJoGj90oz
         OIZw7ctPb+P1KB4bqgcOjp1GyLPp121t2lW0Q3ogknsVkIix+3f5Kk6VZXdu5Ak/61
         Z50sz1xvl11Vw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id JZHQE7bcdD03; Fri, 18 Jan 2019 12:41:45 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 2683BA6DDA;
        Fri, 18 Jan 2019 12:41:45 -0500 (EST)
Date:   Fri, 18 Jan 2019 12:41:45 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Carlos O'Donell <carlos@redhat.com>
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
Message-ID: <1887968822.1146.1547833305059.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190115015148.32155-1-mathieu.desnoyers@efficios.com>
References: <20190115015148.32155-1-mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH glibc 1/4] glibc: Perform rseq(2) registration at C
 startup and thread creation (v5)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3745)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v5)
Thread-Index: llu+wX0M8PxIAlgKK5KtAmtbEJg5AA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 14, 2019, at 8:51 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

[...]

> diff --git a/sysdeps/unix/sysv/linux/rseq-sym.c
> b/sysdeps/unix/sysv/linux/rseq-sym.c
> new file mode 100644
> index 0000000000..6856d0388a
[...]
> +/* volatile because fields can be read/updated by the kernel.  */
> +__thread volatile struct rseq __rseq_abi = {
> +  .cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
> +};
> +
> +/* volatile because refcount can be read/updated by signal handlers.  */
> +__thread volatile uint32_t __rseq_refcount;

Back to the weak vs non-weak question about those two symbols. I understand
that tagging them as weak symbols has little effect on the dynamic loader
when it loads libc.so. However, I'm worried about that happens when
libc is statically linked into an application, and there happens to
be more than one instance of those symbols (e.g. libc and another library
define the same symbols, and both are statically linked into the same
application). Isn't it a situation where tagging those symbols as "weak"
becomes useful ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
