Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2817C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C188720870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 02:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfA3Cks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 21:40:48 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:57615 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbfA3Cks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 21:40:48 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=svr-ies-mbx-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gofnu-0004Tv-N0 from joseph_myers@mentor.com ; Tue, 29 Jan 2019 18:40:42 -0800
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 30 Jan 2019 02:40:38 +0000
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
        (envelope-from <joseph@codesourcery.com>)
        id 1gofnp-0004Hs-OH; Wed, 30 Jan 2019 02:40:37 +0000
Date:   Wed, 30 Jan 2019 02:40:37 +0000
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
In-Reply-To: <596949707.3888.1548812359874.JavaMail.zimbra@efficios.com>
Message-ID: <alpine.DEB.2.21.1901300231210.24454@digraph.polyomino.org.uk>
References: <20190121213530.23803-1-mathieu.desnoyers@efficios.com> <632671842.3079.1548781059601.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1901292153190.24454@digraph.polyomino.org.uk> <596949707.3888.1548812359874.JavaMail.zimbra@efficios.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019, Mathieu Desnoyers wrote:

> My thinking was to put the #error in the generic header, so architectures that
> are not supported yet cannot build against rseq.h at all, so we don't end up
> in a broken upgrade scenario. I'm open to alternative ways to do it though, as
> long as we don't let not-yet-supported architectures build broken code.

Any case with #error in installed glibc headers needs special-casing in 
check-installed-headers.sh (and, thus, such errors are to be discouraged).

Cases where architectures commonly need their own bits/ headers, 
especially where those are likely to need updating for new kernel 
versions, are also discouraged.  Furthermore, a normal check for glibc 
headers updates needed for a new kernel version would only involve 
examining uapi headers (and the non-uapi linux/socket.h for new address 
families, an unfortunate existing wart in this area).  As far as I can 
see, this value isn't defined in any uapi header, which makes it 
especially likely to be missed in such a check.  Furthermore, I'm hoping 
to add more glibc tests for consistency of such constants between glibc 
and the kernel, to ensure any such updates missing are caught 
automatically through test failures - but that doesn't work if the 
constants in question aren't in a uapi header.

If this constant were in a uapi header, the glibc header could just 
include that - is the issue that it's not actually an interface between 
glibc and the kernel at all, but some kind of purely-userspace interface?

We very definitely wish to keep to a minimum the cases where updates need 
to be done separately in glibc by each architecture maintainer (that's 
just a recipe for some updates getting missed accidentally) - meaning that 
there needs to be a clear way in which someone can tell, globally for all 
architectures, whether the set of such architecture-specific headers for 
this constant in glibc is complete and current, and when it needs updating 
(and this should be as similar to possible to such checks for any other 
header constant).

-- 
Joseph S. Myers
joseph@codesourcery.com
