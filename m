Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550ACECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE8420671
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE8420671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbeISWtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:49:04 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:53322 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731247AbeISWtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:49:04 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=svr-ies-mbx-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g2fzQ-00029t-E3 from joseph_myers@mentor.com ; Wed, 19 Sep 2018 10:10:12 -0700
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 19 Sep 2018 18:10:08 +0100
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
        (envelope-from <joseph@codesourcery.com>)
        id 1g2fzM-0008Kr-G0; Wed, 19 Sep 2018 17:10:08 +0000
Date:   Wed, 19 Sep 2018 17:10:08 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH] glibc: Perform rseq(2) registration at nptl init
 and thread creation
In-Reply-To: <67473000.8399.1537375994645.JavaMail.zimbra@efficios.com>
Message-ID: <alpine.DEB.2.21.1809191706090.26757@digraph.polyomino.org.uk>
References: <20180919144438.1066-1-mathieu.desnoyers@efficios.com> <alpine.DEB.2.21.1809191630260.26757@digraph.polyomino.org.uk> <67473000.8399.1537375994645.JavaMail.zimbra@efficios.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018, Mathieu Desnoyers wrote:

> > This looks like it's coming from the Linux kernel.  Can't the relevant
> > uapi header just be used directly without copying into glibc (with due
> > care to ensure that glibc still builds if the kernel headers used for the
> > build are too old - you need such conditionals anyway if they don't define
> > the relevant syscall number)?
> 
> This is indeed in the list of "things to consider" I've put in the patch
> commit message. If the usual practice is to build against uapi kernel headers
> outside of the glibc tree, I'm fine with that.

We build with, currently, 3.2 or later headers (since 3.2 is EOL there's a 
case for updating the minimum in glibc for both compile time and runtime, 
but I haven't proposed that since there isn't much cleanup that would 
enable and there's the open question of Carlos's proposal to eliminate the 
runtime check on the kernel version and just let things try to run anyway 
even if it's older than the configured minimum).  Functions depending on 
new syscalls may return ENOSYS errors if the headers used to build glibc 
were too old.  Since this patch is providing a data interface rather than 
functions that can set errno to ENOSYS, presumably you have some other way 
of signalling unavailability which would apply both with a too-old kernel 
at runtime and too-old headers at compile time.

-- 
Joseph S. Myers
joseph@codesourcery.com
