Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CF6ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094302154C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gzK5pDHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094302154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389702AbeIUSJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:09:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33890 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbeIUSJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9UjvAUTQUgqFx8GwnwHC8ESLZjSakdChu/DzRxkh1N4=; b=gzK5pDHLa8Lr2WTzOPjEay0gY
        ixcgoezxLIfGj3VtbeJb00vN/yqVqP58SFbKwd9UQjinvzdKiqQBwFGNoSZrvrt1PUi5dViJVSY5n
        gtk+ni6ZTk4Dlohz4M1ngzSZHyXVgtdrgz+r2Sw/xIKKBGo+LNu0TeijirOZR3XXqtNnSP5/jUM0R
        cU634pSCAveZZc0SzkOCDuuYFET29OrByQ9PLqJYlWiJGnqnuNs5FMmVIT860PrXWIkN0G3e28p4E
        2EzOUnJ5jZPGbZykju0E0A5pYA+vbFB63TpFiuPOu7OEYMnOAqqeKEgdTzkSDqXKLZtS3zhEwUKD2
        +AVPkZaNg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g3KQh-0005ZC-IT; Fri, 21 Sep 2018 12:21:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C14E22024E449; Fri, 21 Sep 2018 14:20:58 +0200 (CEST)
Date:   Fri, 21 Sep 2018 14:20:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [Problem] Cache line starvation
Message-ID: <20180921122058.GB24124@hirez.programming.kicks-ass.net>
References: <20180921120226.6xjgr4oiho22ex75@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921120226.6xjgr4oiho22ex75@linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 02:02:26PM +0200, Sebastian Andrzej Siewior wrote:
> We reproducibly observe cache line starvation on a Core2Duo E6850 (2
> cores), a i5-6400 SKL (4 cores) and on a NXP LS2044A ARM Cortex-A72 (4
> cores).
> 
> The problem can be triggered with a v4.9-RT kernel by starting

> Daniel reported that disabling ticket locks on 4.4 makes the problem go
> away, but he hasn't run a long time test yet and as we saw with 4.14 it can
> take quite a while.

On 4.4 and 4.9 ARM64 still uses ticket locks. So I'm very interested to
know if the ticket locks on x86 really fix or just make it harder.

I've been looking at qspinlock in the light of this and there is indeed
room for improvement. The ticket lock certainly is much simpler.
