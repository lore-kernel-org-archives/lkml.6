Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D89C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA0B2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Tg5gqsIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfA2Q5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:57:42 -0500
Received: from mail.efficios.com ([167.114.142.138]:35744 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728320AbfA2Q5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:57:42 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 59DEAB6A39;
        Tue, 29 Jan 2019 11:57:40 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id iA9W34uR6KZ9; Tue, 29 Jan 2019 11:57:39 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D1380B6A31;
        Tue, 29 Jan 2019 11:57:39 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D1380B6A31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1548781059;
        bh=/mLGXBEw15sPdC/1KH33gvyLGHL2j1EclIJBevc7VFw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Tg5gqsIVSm1SRobSj1pszZd+I83Q1bHlRgmYmrWrHrKzctA5b7SCRG0TFJiWTvYXX
         ZZG6z/4W0hUSYjZ49GjTCefDyzSbbIEz9akpahFhsO32vIcEnIPYWl3kfsgize0kOZ
         SwZgQqCtEyXN2PaM6+wVFShadQZRt8jDzZq5ZVHRjq4TBZmjPMuT+4friH5phHVANS
         K7matTGFNo/iLRqxF/aA36MDEpGuHQOUAOY4FZd/b2QByX+oMnpvqUukj6eQyggUCa
         Wmvj5Lk4JTxOrY12NRhdL8x0dBXyxh1B3ZNiugutwlLGvFD1Zc2SR8vdHbO0f9MkQl
         Pt9+MgTlCqIsw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id xmH-GMnQh6mQ; Tue, 29 Jan 2019 11:57:39 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id B2165B6A29;
        Tue, 29 Jan 2019 11:57:39 -0500 (EST)
Date:   Tue, 29 Jan 2019 11:57:39 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>
Cc:     Joseph Myers <joseph@codesourcery.com>,
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
Message-ID: <632671842.3079.1548781059601.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190121213530.23803-1-mathieu.desnoyers@efficios.com>
References: <20190121213530.23803-1-mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH glibc 1/4] glibc: Perform rseq(2) registration at C
 startup and thread creation (v6)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3716 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3745)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v6)
Thread-Index: 2b8tBioo7eVHDlsBfrjcSFANsUdHiA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 21, 2019, at 4:35 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
[...]

> diff --git a/sysdeps/unix/sysv/linux/sys/rseq.h
> b/sysdeps/unix/sysv/linux/sys/rseq.h
> new file mode 100644
> index 0000000000..61937fb193
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/sys/rseq.h
> @@ -0,0 +1,64 @@

[...]
> +
> +#ifndef _SYS_RSEQ_H
> +#define _SYS_RSEQ_H	1
> +
> +/* We use the structures declarations from the kernel headers.  */
> +#include <linux/rseq.h>
> +#include <stdint.h>
> +
> +/* Signature required before each abort handler code.  */
> +#define RSEQ_SIG 0x53053053

I recalled that aarch64 defines RSEQ_SIG to a different value which maps to
a valid trap instruction. So I plan to move the RSEQ_SIG define to per-arch
headers like this:

 sysdeps/unix/sysv/linux/aarch64/bits/rseq.h                  |   24 ++
 sysdeps/unix/sysv/linux/arm/bits/rseq.h                      |   24 ++
 sysdeps/unix/sysv/linux/bits/rseq.h                          |   23 ++
 sysdeps/unix/sysv/linux/mips/bits/rseq.h                     |   24 ++
 sysdeps/unix/sysv/linux/powerpc/bits/rseq.h                  |   24 ++
 sysdeps/unix/sysv/linux/s390/bits/rseq.h                     |   24 ++
 sysdeps/unix/sysv/linux/x86/bits/rseq.h                      |   24 ++

where "bits/rseq.h" contains a #error:

# error "Architecture does not define RSEQ_SIG.

sys/rseq.h will now include <bits/rseq.h>.


> +
> +enum rseq_register_state
> +{
> +  /* Value RSEQ_REGISTER_ALLOWED means it is allowed to update
> +     the refcount field and to register/unregister rseq.  */
> +  RSEQ_REGISTER_ALLOWED = 0,
> +  /* Value RSEQ_REGISTER_NESTED means it is temporarily forbidden
> +     to update the refcount field or to register/unregister rseq.  */
> +  RSEQ_REGISTER_NESTED = 1,

I plan to rename "RSEQ_REGISTER_NESTED" to "RSEQ_REGISTER_ONGOING" which
seems to better represent the current registration state.

Please let me know if anything is wrong with those changes.

Thanks,

Mathieu


> +  /* Value RSEQ_REGISTER_EXITING means it is forbidden to update the
> +     refcount field or to register/unregister rseq for the rest of the
> +     thread's lifetime.  */
> +  RSEQ_REGISTER_EXITING = 2,
> +};
-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
