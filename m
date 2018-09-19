Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19507ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C793220880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DtVnWT8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C793220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbeISOhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:37:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36962 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeISOhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=91A9fciCBGmxbV0uIZxgOcPgo1ar9tPeZjxqVOG2OtQ=; b=DtVnWT8zuPdl801VN6OaaU98l
        v3K/RspGTRp+GRl/Maqh/mkWUvaG8JJksZpkulZu0/h2QmdcWE8u5uVddzuSDqyRjb2dPWhVN5ai2
        KDKPI0fSVSUUeunXTJbMrCvDwaLOATIoWhFCR6g5mwCpfADT94rdA0kgz85rnuPdF3FB8puo2oejJ
        N2RaOoIZ/h4bhRPi0MEca1qEH3a5DHaWnnJkJw7hemQXPoNUlCs6oKf+aS0da3HycyzQTA1QN9I8J
        QXqYds5yiLCj//3dlHGbQrSxLgk9sacI3zHW+WK7dK4QJDFvcaRy+Ryk7wa7J1wsaMeUPMAyBRRqZ
        dcJaGLj2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2YLR-0007ce-6d; Wed, 19 Sep 2018 09:00:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9880F202C1A3D; Wed, 19 Sep 2018 11:00:14 +0200 (CEST)
Message-ID: <20180919085016.164552924@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Sep 2018 10:50:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>
Subject: [PATCH 0/8] x86/mm/cpa: Further optimizations
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas' CPA patches made me look at the tlb invalidate crud around there. These
patches are the result of cleaning some of that up a bit. They are based on top
of Thomas' patches.

Dave, can you have a wee look at the Atom errata thing; this does grow the
amount of code between the page-table update and the TLB flush a bit, but all
that PTI crud we did a while back already made it a non-trivial amount of code.

---
 pageattr.c |  128 ++++++++++++++++++++++---------------------------------------
 1 file changed, 48 insertions(+), 80 deletions(-)

