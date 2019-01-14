Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA91C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7E220651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="KXSeCyeV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfANTWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:22:40 -0500
Received: from mail.efficios.com ([167.114.142.138]:44250 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANTWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:22:40 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9E104A3FE7;
        Mon, 14 Jan 2019 14:22:38 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Oj8ZeIISCiXp; Mon, 14 Jan 2019 14:22:38 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 005BCA3FDD;
        Mon, 14 Jan 2019 14:22:38 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 005BCA3FDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1547493758;
        bh=DpFoyr4ZaxTw8xyYjUlySVIEAvWzDWa4seh1yWPRLek=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=KXSeCyeVJT4UUYzNDp0gLmauP1j0a/v80b+vMEPqRGhiibHs2d4cpgWhgj0p0euwG
         CqV1AXEnQFJYB8G3Oqy5+CfMWlZTauzQUmxkS+NFvCAwEqYpYKPAxJDozhnLFiFAte
         mF1mcQC6MzDT0LhJ9jh5eCpoANkbKTcFVbO+oPeJVcx6dwL71m4qYTLhB3Pe+vc/r6
         dlvq9F1kiWVnDqDYA5D/LduAn7ibJqHdyC1ZeNAVVXr7t4zLdp21KgHPrKw8Kw+r1N
         BaIKb2csTAtD679g1dsWzHMVCLUMDiUQHTDnr1vOWRSoNzjqZoFmtXNFiQO6ugdUNU
         Q0M5DR2t3rcJA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id wSJTihXoUMft; Mon, 14 Jan 2019 14:22:37 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id D4E8CA3FD4;
        Mon, 14 Jan 2019 14:22:37 -0500 (EST)
Date:   Mon, 14 Jan 2019 14:22:37 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
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
Message-ID: <394676913.486.1547493757710.JavaMail.zimbra@efficios.com>
In-Reply-To: <87fttv9iic.fsf@oldenburg2.str.redhat.com>
References: <20181204192141.4684-1-mathieu.desnoyers@efficios.com> <87h8fkz6qx.fsf@oldenburg2.str.redhat.com> <1681283664.1380.1547152315426.JavaMail.zimbra@efficios.com> <87fttv9iic.fsf@oldenburg2.str.redhat.com>
Subject: Re: [RFC PATCH glibc 1/4] glibc: Perform rseq(2) registration at
 nptl init and thread creation (v4)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3745)
Thread-Topic: glibc: Perform rseq(2) registration at nptl init and thread creation (v4)
Thread-Index: PppMlOnTGZSxB6fe9h0t4G40nYnmpA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 14, 2019, at 10:55 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> Therefore, both symbols will end up in
>> sysdeps/unix/sysv/linux/Versions.
> 
> I'm not sure what you mean by that.  The physical location in the
> directory tree has little effect on which shared object the symbol is
> placed in; that will need other changes.

I'm currently moving the symbol definitions to csu/rseq-sym.c. On Linux,
its content is overridden by a new sysdeps/unix/sysv/linux/rseq-sym.c
which contains both __rseq_abi and __rseq_refcount symbols. On other
platforms, it is a stub file.

>>> By the way, you could avoid the need for unregistration if you allocated
>>> the rseq areas persistently, index by TID.  They are quite small, so
>>> with the typical PID range, maybe the wasted memory due to changing TIDs
>>> would be acceptable?
>>
>> Would we be able to access those __rseq_abi as normal TLS IE model
>> variables ?  The overhead of indexing an array matters for a
>> fast-path.
> 
> No, that wouldn't be possible in this case.  You would need another
> indirection.

Thanks for the clarification!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
