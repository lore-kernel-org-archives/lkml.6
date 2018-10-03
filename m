Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0400C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770392089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uqwI6ycQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770392089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeJCUBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:01:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbeJCUBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WkfQxyOWBTJo0qlNDlWmD3Jz8rOqJPy8U0ahFjOFfbs=; b=uqwI6ycQmYFxg+oqyo3U/isDq
        VUG2AxVAvC0D+M1ck2XY3RZMCIi/urunbPNyo4qayc8yzGqAk1cFeW2qrXS1c2/d6cyYu0Fy3tBdW
        T386vEid90+6PUA08K7YLUzv0/K8u2yXNFBhz3LVt1n6h6GZuvGecvx/z/CEY/h6Kp7i92hVPy3TH
        P+EDG/eQkZjucEBQqGzyX/Ubhdk5SprxufVbTg91G7AQ1I1dgx3W4DIdJTpHDFS4n6mJWK0LDgYRA
        69s+Xx90GNkVjvcBcu6lxyd57ATdg0fw9P9OE5lt3iDVIdNBm+2UgfPFiGZJejc1DgrEVyU+d3HNV
        xllfnX1cQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7gxu-0003Aq-J1; Wed, 03 Oct 2018 13:13:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 12FEA202C1A14; Wed,  3 Oct 2018 15:13:15 +0200 (CEST)
Message-ID: <20181003130257.156322446@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Oct 2018 15:02:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de,
        bigeasy@linutronix.de, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 0/4] locking/qspinlock, x86: Improve determinism for x86
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back when Will did his qspinlock determinism patches, we were left with one
cmpxchg loop on x86 due to the use of atomic_fetch_or(). Will proposed a nifty
trick:

  http://lkml.kernel.org/r/20180409145409.GA9661@arm.com

While that didn't quite work, this series implements that basic idea.

Changes since v1:

 - Adjusted comments in #2, wildea01
 - 'Simplified' GEN_*_RMWcc, peterz
 - Rewrote _the_ patch to use BTS, wildea01


