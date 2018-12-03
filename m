Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E24CC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EFF20881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c2aMma4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EFF20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeLCROc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:14:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbeLCROc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Gr+aMfeREs3LG/OJC+F0EFnw+JEYQgnYaAeUVezE/7I=; b=c2aMma4y5ANoVKKmWE7I67kjj
        h1TPeCNjn0o25xJmbrYINTJanMxhD9hWHO9hO8sH92Cd0xGMCvoWLRTlc1ljLMD4Giz+jtK2VOHd/
        bUhzWxkUsUeDgt3oqx2VmXmckRH3ahR3of/GJhLwcHPPLHxeqCjEzuyL/jzmQKU5kbkGgiKK9MjL2
        rzXj7pFJMZDoKoT2dnKOrze+hWbELnjPQgPRWEI6W6IR8NwFI8qTxUkmX2sDUZciZeqJ+CDULPHt9
        /7tExPzk2zD/wq7LoFOVFaDiARKBIkGS9nfziyxpksg072gJv7eZlyVaefdTRRzZ3z3knSiwEy8EE
        rM9R21O6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTrng-0001xN-H2; Mon, 03 Dec 2018 17:14:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 09C202029FD58; Mon,  3 Dec 2018 18:14:26 +0100 (CET)
Message-Id: <20181203170343.054618965@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 03 Dec 2018 18:03:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, Tom.StDenis@amd.com, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 00/10] x86/mm/cpa: Various fixes and improvements
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With exception of the very first patch, this whole series is probablt RFC at this point.

(and thanks to sending that earlier email saying that I was stumped by this crap,
 I instantly spotted my problem)

Dave, I didn't address that tlbinv(0) point you made, mostly because I didn't
have a good answer.

These patches get rid of around ~40 lines of pageattr.c while adding smarts and
removing a few (IMO) warts. The total LoC improvement not quite as impressive
because of the additional lines of selftest.

---
 arch/x86/mm/mm_internal.h   |   2 +
 arch/x86/mm/pageattr-test.c |  31 +++--
 arch/x86/mm/pageattr.c      | 267 +++++++++++++++++++-------------------------
 arch/x86/mm/tlb.c           |   4 +-
 4 files changed, 143 insertions(+), 161 deletions(-)

