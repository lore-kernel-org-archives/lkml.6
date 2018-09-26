Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5CAC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4131214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wrvYsjyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4131214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbeIZSHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:07:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46374 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbeIZSHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Xzoq3822VPftHOSX/XRMpwACoEFrdDki2itBY3y0uPM=; b=wrvYsjyJWfTDcdePZDtjYplk4h
        OgRbp5PvipKKkmFcBpXUvcVFp+R0f1TVKn+te7+BIzL3mPoDDSD06mOs8KePc2bgrpEHexpH9bwpJ
        hwlBkjc+wIQtRDJbMAWVzl4r9FP3Ip9C/nP1EDyhWgHGO6M7Bu7Km1djRMWpl76AMt+qla2MaKxsJ
        P8l2QbFyYov8VEm1yRzUvWuvB4Ju0b4UCWpHvvzdFpd8ypZrAaA/kb4jJxyGVyAOt9Ny9M7yqoEwP
        O5srcSf3yT46M/70FRdnPZ9cG2V21Mg2L3V+fY9YscU9rCc4lXS3CvpRENk0fFuDfpKpJPtH6XELp
        A7qFbUaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g58Oc-0007U6-Dz; Wed, 26 Sep 2018 11:54:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8E7C9206F180E; Wed, 26 Sep 2018 13:54:04 +0200 (CEST)
Message-ID: <20180926114800.822722731@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 26 Sep 2018 13:36:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Subject: [PATCH 06/18] asm-generic/tlb: Conditionally provide tlb_migrate_finish()
References: <20180926113623.863696043@infradead.org>
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


