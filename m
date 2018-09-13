Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99F3C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2CC20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZxYzhuzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2CC20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeIMOjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:39:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbeIMOiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Xzoq3822VPftHOSX/XRMpwACoEFrdDki2itBY3y0uPM=; b=ZxYzhuzvrDDduAl8V41DdphEPe
        7gQUO268fFWSFv4b6wSRjFZSH5JTeGOdHMN8GwTlu4l7kiHcYjTOKwGFz49KAi3FUezNSRUFsj8Mr
        qpUV2uUysHzZe7iuL8j2+sHTTPsyd1qFAD4XATJVweOZLMcBKrRWzkAZ+/53fA+QWiyobrfeR752B
        c//tTV19aeA6uJdUgUyY9ccIcFxemTGIvZttUk1ck6haC+1z00fg59B3nkm9h3P4amFhKm95HNAdi
        JOyF83B64RtMyx7JM5moBjaqaPgHYAZeHnVzrZp1AtvFig0gmyroDUVDTr7kJBLY79lDn+DVgbWzQ
        mDvgk70Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0Nw2-0000vo-Ek; Thu, 13 Sep 2018 09:29:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4F58420587E55; Thu, 13 Sep 2018 11:29:10 +0200 (CEST)
Message-ID: <20180913092812.190579217@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 13 Sep 2018 11:21:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com
Subject: [RFC][PATCH 06/11] asm-generic/tlb: Conditionally provide tlb_migrate_finish()
References: <20180913092110.817204997@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Needed for ia64 -- alternatively we drop the entire hook.

Cc: Will Deacon <will.deacon@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -539,6 +539,8 @@ static inline void tlb_end_vma(struct mm
 
 #endif /* CONFIG_MMU */
 
+#ifndef tlb_migrate_finish
 #define tlb_migrate_finish(mm) do {} while (0)
+#endif
 
 #endif /* _ASM_GENERIC__TLB_H */


