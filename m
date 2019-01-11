Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC5BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6CD2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ite1Juyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfAKBMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:12:00 -0500
Received: from mail.efficios.com ([167.114.142.138]:56002 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfAKBL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:11:59 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A40F6B13DC;
        Thu, 10 Jan 2019 20:11:57 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id CBRuKlDCqMWY; Thu, 10 Jan 2019 20:11:56 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D16B0B13D7;
        Thu, 10 Jan 2019 20:11:56 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D16B0B13D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1547169116;
        bh=5bxH1y6PYC+dPfcY7T5ddmGiLf8DM/EUNZcq2rbSLkI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ite1JuyrZvmIbG0QhMIRqedvQj4P7hNV1Dht6ZcAZRRsm2h5fgElteZYnSutck9lI
         m1di0JaaG33UCFh5cFZ73LjmWjwsrNPawP6N0iEne/9bQzKvdd/oL6POA/+t4PlF9S
         6hbzLDY3oP2maMcGQGfZlcu/6Klqx3jG8wyoZWDwJXcu/e4QFnMCZfYrgEhGCQbfA6
         jhAdcq1hS0kdKys7WS3UR5vXSWRXqy+sw7HhcMiAOEOd+SgVVec1+ShuZK9OqopP3z
         ziC7mpnIQDV/qduaevBjzfmZEttbK7GqvKk//IaQcBwQtFT9gvQ/qFU/QEGrJvmuTF
         X4/1IZE5GfUgQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 5-b0uS4sn0i3; Thu, 10 Jan 2019 20:11:56 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id B2E76B13D0;
        Thu, 10 Jan 2019 20:11:56 -0500 (EST)
Date:   Thu, 10 Jan 2019 20:11:56 -0500 (EST)
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
Message-ID: <1488546469.1564.1547169116539.JavaMail.zimbra@efficios.com>
In-Reply-To: <1681283664.1380.1547152315426.JavaMail.zimbra@efficios.com>
References: <20181204192141.4684-1-mathieu.desnoyers@efficios.com> <87h8fkz6qx.fsf@oldenburg2.str.redhat.com> <1681283664.1380.1547152315426.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH glibc 1/4] glibc: Perform rseq(2) registration at
 nptl init and thread creation (v4)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3745)
Thread-Topic: glibc: Perform rseq(2) registration at nptl init and thread creation (v4)
Thread-Index: u/41c6UxqVERQfSwYTdc9PnhxGpO1ktalziy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 10, 2019, at 12:31 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Dec 11, 2018, at 2:40 AM, Florian Weimer fweimer@redhat.com wrote:
[...]
>> 
>>> diff --git a/nptl/Versions b/nptl/Versions
>>> index e7f691da7a..f7890f73fc 100644
>>> --- a/nptl/Versions
>>> +++ b/nptl/Versions
>>> @@ -277,6 +277,10 @@ libpthread {
>>>      cnd_timedwait; cnd_wait; tss_create; tss_delete; tss_get; tss_set;
>>>    }
>>>  
>>> +  GLIBC_2.29 {
>>> +    __rseq_refcount;
>>> +  }
>> 
>> Why put this into libpthread, and __rseq_abi into libc?
> 
> The __rseq_abi symbol should be available to the glibc memory allocator.
> I plan to move the __rseq_abi to sysdeps/unix/sysv/linux/Versions instead
> so it becomes Linux-specific.
> 
> The __rseq_refcount symbol only needs to be made available to applications
> and libraries linking against libpthread, because only libpthread actually
> handles the rseq registration/unregistration at thread start/exit and
> library initialization.
> 
> However, considering that we want this to be Linux-specific as well,
> I could move it to sysdeps/unix/sysv/linux/Versions too.
> 
> Then it would make sense to move the __rseq_refcount symbol defined in
> nptl/rseq.c to sysdeps/unix/sysv/linux/rseq.c as well and group
> everything together.
> 
> Therefore, both symbols will end up in sysdeps/unix/sysv/linux/Versions.

Now that I think about it, it's important to move the rseq registration
done at nptl init (in my current code) to some lower-level csu initialiation,
so applications that happen _not_ to link against libpthread also get
registered rseq for the main thread.

Does it make sense ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
