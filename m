Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA851ECE560
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9171D214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZrkbPvtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9171D214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeIZRmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:42:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45796 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeIZRma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=baB+J5gLj1leR4uQaVDv/KYJW8CzReNCm/OTHsByQho=; b=ZrkbPvtMkvJUGN/8cn15m8Bk3
        jL+pAvpYChwciHMlKUmK3KvO7Twd3zTECsaC+Aci/78hWufZ1TUEed+nYJHInnUmCzTIIR6lftZ+T
        rxbqL8uP/Eou5fygZ113zGUeJ+EzUl2jrm89BwUUFpDnEiNfT1W74ZfbSJbRkRXrLgp883fvFYRwp
        J5WcLwMfmsoiP6Qdra4bV2Dpk3hIiJWKpqn9Oaa+2R35mVy+1y/m+blF7abyxfs6kbAspPE21j9zV
        AfSPLSvwKEZVYZM0LawDvq+jNG4MJUBs4pS1wHU67/Cd+vGrlQYf8vTV2da74oc+L47Tk12Vm5+2E
        npJgZwkZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g580Y-0007Jy-Ej; Wed, 26 Sep 2018 11:29:50 +0000
Received: by worktop (Postfix, from userid 0)
        id B38446E08A6; Wed, 26 Sep 2018 13:29:27 +0200 (CEST)
Message-Id: <20180926110117.405325143@infradead.org>
User-Agent: quilt/0.61-1
Date:   Wed, 26 Sep 2018 13:01:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 0/3] locking/qspinlock: Improve determinism for x86
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back when Will did his qspinlock determinism patches, we were left with one
cmpxchg loop on x86 due to the use of atomic_fetch_or(). Will proposed a nifty
trick:

  http://lkml.kernel.org/r/20180409145409.GA9661@arm.com

But at the time we didn't pursue it. This series implements that and argues for
its correctness. In particular it places an smp_mb__after_atomic() in
between the two operations, which forces the load to come after the
store (which is free on x86 anyway).

In particular this ordering ensures a concurrent unlock cannot trigger
the uncontended handoff. Also it ensures that if the xchg() happens
after a (successful) trylock, we must observe that LOCKED bit.

