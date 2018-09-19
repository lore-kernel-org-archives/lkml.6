Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB2DECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843F42150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 16:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843F42150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732641AbeISWQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:16:23 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:49215 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeISWQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:16:23 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=svr-ies-mbx-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g2fTr-0003g7-HT from joseph_myers@mentor.com ; Wed, 19 Sep 2018 09:37:35 -0700
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 19 Sep 2018 17:37:32 +0100
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
        (envelope-from <joseph@codesourcery.com>)
        id 1g2fTn-0007qw-G1; Wed, 19 Sep 2018 16:37:31 +0000
Date:   Wed, 19 Sep 2018 16:37:31 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        <libc-alpha@sourceware.org>, <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH] glibc: Perform rseq(2) registration at nptl init
 and thread creation
In-Reply-To: <20180919144438.1066-1-mathieu.desnoyers@efficios.com>
Message-ID: <alpine.DEB.2.21.1809191630260.26757@digraph.polyomino.org.uk>
References: <20180919144438.1066-1-mathieu.desnoyers@efficios.com>
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

On Wed, 19 Sep 2018, Mathieu Desnoyers wrote:

> Here is a rough prototype registering rseq(2) TLS for each thread
> (including main), and unregistering for each thread (excluding
> main). "rseq" stands for Restartable Sequences.

A final patch would need to add documentation and tests and a NEWS entry 
and fix various coding style issues.

> diff --git a/nptl/Versions b/nptl/Versions
> index e7f691da7a..7316c2815d 100644
> --- a/nptl/Versions
> +++ b/nptl/Versions
> @@ -275,6 +275,7 @@ libpthread {
>      mtx_init; mtx_lock; mtx_timedlock; mtx_trylock; mtx_unlock; mtx_destroy;
>      call_once; cnd_broadcast; cnd_destroy; cnd_init; cnd_signal;
>      cnd_timedwait; cnd_wait; tss_create; tss_delete; tss_get; tss_set;
> +    __rseq_abi; __rseq_refcount;

That's the GLIBC_2.28 section, but 2.28 is already out.  New symbols would 
need to go in GLIBC_2.29 or later (and the ABI test baselines would all 
need updating).

> diff --git a/sysdeps/unix/sysv/linux/rseq.h b/sysdeps/unix/sysv/linux/rseq.h

This looks like it's coming from the Linux kernel.  Can't the relevant 
uapi header just be used directly without copying into glibc (with due 
care to ensure that glibc still builds if the kernel headers used for the 
build are too old - you need such conditionals anyway if they don't define 
the relevant syscall number)?

-- 
Joseph S. Myers
joseph@codesourcery.com
