Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D25FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFE32082F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kLNSdCBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbfBKRJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:09:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBKRJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZoJZvyqaunGugZQrlPllDdS2IYsDjPUH/LXW74sxwhw=; b=kLNSdCBG+4Qlf4U1qfkUD5xkV8
        Jm9PEoy6CnvFr3AwrrAAkbpaymxDLMS7eSEGT2skgfROZBYO4FoP8QUHXOwfSqD7ik+HxihcCKiP1
        pZc+n3KnhT3LARTmW32CExwVjbF3HSC+EY/tQ1QpSnOuGB39KlxDtN2eInkuygVmISHOLwcB77Gpx
        KmIthp56tPpa7RCpzQgivxrsHUlLTM1mOiu78gPk36gk0ALwxxGSribR/Rq8co1u0mEVk5tZre4Dx
        knTIvRzyB0JxBxYpz2BRsja/YLIcQDgVizSHmbZqV3Y/5CoCvLh8DH7/LqGcGAReq3YO6zZapr7si
        g00/+PFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtF5V-0006FK-1g; Mon, 11 Feb 2019 17:09:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 534FA20D0E3C8; Mon, 11 Feb 2019 18:09:43 +0100 (CET)
Date:   Mon, 11 Feb 2019 18:09:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/atomic_t: Clarify signed vs unsigned
Message-ID: <20190211170943.GP32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Clarify the whole signed vs unsigned issue for atomic_t.

There has been enough confusion on this topic to warrant a few explicit
words I feel.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Documentation/atomic_t.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index 913396ac5824..dca3fb0554db 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -56,6 +56,23 @@ The 'full' API consists of (atomic64_ and atomic_long_ prefixes omitted for
   smp_mb__{before,after}_atomic()
 
 
+TYPES (signed vs unsigned)
+-----
+
+While atomic_t, atomic_long_t and atomic64_t use int, long and s64
+respectively (for hysterical raisins), the kernel uses -fno-strict-overflow
+(which implies -fwrapv) and defines signed overflow to behave like
+2s-complement.
+
+Therefore, an explicitly unsigned variant of the atomic ops is strictly
+unnecessary and we can simply cast, there is no UB.
+
+There was a bug in UBSAN prior to GCC-8 that would generate UB warnings for
+signed types.
+
+With this we also conform to the C/C++ _Atomic behaviour and things like
+P1236R1.
+
 
 SEMANTICS
 ---------
