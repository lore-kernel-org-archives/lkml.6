Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC0BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D222082F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfA2V4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:56:33 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:65068 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfA2V4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:56:33 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=svr-ies-mbx-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gobMk-0000De-NV from joseph_myers@mentor.com ; Tue, 29 Jan 2019 13:56:22 -0800
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Tue, 29 Jan 2019 21:56:19 +0000
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
        (envelope-from <joseph@codesourcery.com>)
        id 1gobMg-0006bP-RG; Tue, 29 Jan 2019 21:56:18 +0000
Date:   Tue, 29 Jan 2019 21:56:18 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
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
Subject: Re: [RFC PATCH glibc 1/4] glibc: Perform rseq(2) registration at C
 startup and thread creation (v6)
In-Reply-To: <632671842.3079.1548781059601.JavaMail.zimbra@efficios.com>
Message-ID: <alpine.DEB.2.21.1901292153190.24454@digraph.polyomino.org.uk>
References: <20190121213530.23803-1-mathieu.desnoyers@efficios.com> <632671842.3079.1548781059601.JavaMail.zimbra@efficios.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019, Mathieu Desnoyers wrote:

> I recalled that aarch64 defines RSEQ_SIG to a different value which maps to
> a valid trap instruction. So I plan to move the RSEQ_SIG define to per-arch
> headers like this:
> 
>  sysdeps/unix/sysv/linux/aarch64/bits/rseq.h                  |   24 ++
>  sysdeps/unix/sysv/linux/arm/bits/rseq.h                      |   24 ++
>  sysdeps/unix/sysv/linux/bits/rseq.h                          |   23 ++
>  sysdeps/unix/sysv/linux/mips/bits/rseq.h                     |   24 ++
>  sysdeps/unix/sysv/linux/powerpc/bits/rseq.h                  |   24 ++
>  sysdeps/unix/sysv/linux/s390/bits/rseq.h                     |   24 ++
>  sysdeps/unix/sysv/linux/x86/bits/rseq.h                      |   24 ++
> 
> where "bits/rseq.h" contains a #error:
> 
> # error "Architecture does not define RSEQ_SIG.
> 
> sys/rseq.h will now include <bits/rseq.h>.

We're trying to reduce the number of cases where most or all new glibc 
architecture ports need to provide a bits/ header, by making the generic 
headers handle the common case.  So a generic header with a #error, and 
lots of architecture-specific headers mostly with the same value for 
RSEQ_SIG, seems unfortunate.  I'd hope the generic header could use a 
generic value, with architecture-specific variants only for architectures 
with some reason for a different value.

-- 
Joseph S. Myers
joseph@codesourcery.com
