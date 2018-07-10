Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C756CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840E0208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C9xZmfaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840E0208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933382AbeGJMSH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:18:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57760 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933313AbeGJMSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MZFMTH6VlIXUlqaq37dPcLaeB4xCIapawCih6xTygmM=; b=C9xZmfaLAs1iNq7PDUQvpKXI8A
        lBf7D3KnZC38ML2oaua9ln6txGbw6GeJrawXQ3np5y3DHF/JF8gtVs26nyJJTGm815qRqWy/EjtOi
        aDzVcJvsmaepDCC/PFRTj4GOxPU/Pgnzndw7YYHGIvNOeIoX+EKv5EgDECdms1LitLhaQtOHg17R6
        XhnczB3eQm+m5Ix3kGMW5poANODskX/7EFsj6+ufZm7oTHQ01x891vDfeVgQ7NEtNco8Tq4A7XcEm
        SO05OR/5ha/QhWCQEWw7LZATQSMs36Aq0k+a0mxHyduN9HN16WNGURBPD63L1HuXwROcNRgVTAdK/
        3g6EtDyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fcraC-0004N6-SV; Tue, 10 Jul 2018 12:17:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 791372016798C; Tue, 10 Jul 2018 14:17:27 +0200 (CEST)
Date:   Tue, 10 Jul 2018 14:17:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] MIPS: implement smp_cond_load_acquire() for Loongson-3
Message-ID: <20180710121727.GK2476@hirez.programming.kicks-ass.net>
References: <1531103198-16764-1-git-send-email-chenhc@lemote.com>
 <20180709164939.uhqsvcv4a7jlbhvp@pburton-laptop>
 <CAAhV-H7bqhz+dzgPk0_tTAN6y_k_8Ds9heF0p5uPHsHNg0v4Rg@mail.gmail.com>
 <20180710093637.GF2476@hirez.programming.kicks-ass.net>
 <20180710105437.GT2512@hirez.programming.kicks-ass.net>
 <tencent_26F8B9E004D4512B2225FCE1@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_26F8B9E004D4512B2225FCE1@qq.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please!! Learn to use email.

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

Also, wrap non-quoted lines to 78 characters.

On Tue, Jul 10, 2018 at 07:45:22PM +0800, 陈华才 wrote:
> I'm afraid that you have missing something......
> 
> Firstly, our previous conclusion (READ_ONCE need a barrier to avoid
> 'reads prioritised over writes') is totally wrong. So define
> cpu_relax() to smp_mb() like ARM11MPCore is incorrect, even if it can
> 'solve' Loongson's problem.  Secondly, I think the real problem is
> like this:

>  1, CPU0 set the lock to 0, then do something;
>  2, While CPU0 is doing something, CPU1 set the flag to 1 with
>     WRITE_ONCE(), and then wait the lock become to 1 with a READ_ONCE()
>     loop;
>  3, After CPU0 complete its work, it wait the flag become to 1, and if
>     so then set the lock to 1;
>  4, If the lock becomes to 1, CPU1 will leave the READ_ONCE() loop.

> If without SFB, everything is OK. But with SFB in step 2, a
> READ_ONCE() loop is right after WRITE_ONCE(), which makes the flag
> cached in SFB (so be invisible by other CPUs) for ever, then both CPU0
> and CPU1 wait for ever.

Sure.. we all got that far. And no, this isn't the _real_ problem. This
is a manifestation of the problem.

The problem is that your SFB is broken (per the Linux requirements). We
require that stores will become visible. That is, they must not
indefinitely (for whatever reason) stay in the store buffer.

> I don't think this is a hardware bug, in design, SFB will flushed to
> L1 cache in three cases:

> 1, data in SFB is full (be a complete cache line);
> 2, there is a subsequent read access in the same cache line;
> 3, a 'sync' instruction is executed.

And I think this _is_ a hardware bug. You just designed the bug instead
of it being by accident.

> In this case, there is no other memory access (read or write) between
> WRITE_ONCE() and READ_ONCE() loop. So Case 1 and Case 2 will not
> happen, and the only way to make the flag be visible is wbflush
> (wbflush is sync in Loongson's case).
>
> I think this problem is not only happens on Loongson, but will happen
> on other CPUs which have write buffer (unless the write buffer has a
> 4th case to be flushed).

It doesn't happen an _any_ other architecture except that dodgy
ARM11MPCore part. Linux hard relies on stores to become available
_eventually_.

Still, even with the rules above, the best work-around is still the very
same cpu_relax() hack.

