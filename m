Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347C5C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FCC20819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VFaNKUKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FCC20819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbeKEVjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:39:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeKEVjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aDX20y0q0VhkGrp6OlR0HtpvcLo5DGSBG4VAoCu1hNg=; b=VFaNKUKzjsijNjgfWmzwetUqo
        4oxVS6BIgpgC4WE0WF2UkIStxBFv78HUafgGLiylgAEuV/TBa5AWmRryARwU6yJ5ijv9bzB7ns7X+
        A93IthdunXLgT8pqXVi9aDjPRJ98GYw57NLnIoQTVQBXiL4rRRfojb6P3nbb/agov40kh4wTS+muz
        H4jZBzSjDS3B77lNgo/JrHo1XpBu08Q07D+pR0aPrmPUv1ebH32hGnQNG74F7TGlj/P7VTGLOYxx1
        3VTjGhYnT3z9OKo7ptLQK9f5gED4rDVC1ZMavh5cID0NQgg5IG9kzOQB6s+7NdHkUy03Ei1KWeHyn
        izBAlaiBQ==;
Received: from 213-225-37-95.nat.highway.a1.net ([213.225.37.95] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJdqx-0003HV-9M; Mon, 05 Nov 2018 12:19:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: move the arm arch_dma_alloc implementation to common code
Date:   Mon,  5 Nov 2018 13:19:22 +0100
Message-Id: <20181105121931.13481-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series moves the existing arm64 implementation of arch_dma_alloc and
arch_dma_free to common code given that it is not arm64-specific, and
then also uses it for csky.  Given how many architectures remap memory
for the DMA coherent implementation it should be usable for many more,
and the new cache flushing hook and the generic atomic pool are also
enablers for implementing the IOMMU API dma ops in common code in a
follow on series.
