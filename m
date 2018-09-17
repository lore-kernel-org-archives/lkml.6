Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31257ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB6220883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QhOEaPhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB6220883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbeIQVG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:06:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeIQVGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y+X4Mbwst7CdnwUHAirydkckRKgx7SrWudwi8IaIoe0=; b=QhOEaPhxifvM3kVgiCK5thPi5
        Ej1GseOBgscK186BDjoDkZtMbetWUZb2DGEsLyPechvPU4+/TrvhRL/IVwWTeqobDSu+9D1TMAcYz
        u/05z3PBYV/UA9kBqzKhGaptM8Irza0MI4ZOad8v0jcEh32U6hmNW8esxABYwDvuBdCEKrFAFAkBY
        cfjOdDCsiRD3dLinD0vCtVLhFQ4LjREEYGfRDWLrNVqUSOFv9ofQfTk5oMAXrq0Rmhzlzr/YnyDAG
        HUk/ljT/75l8tls4wJaqIRsfmezirwiGeGcPzoTuJhhyGk+ANPUYlYaF2ZVhGWmj6B13ymHfFYbLI
        bHVFVh6zw==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1vba-000693-45; Mon, 17 Sep 2018 15:38:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: move swiotlb noncoherent dma support from arm64 to generic code
Date:   Mon, 17 Sep 2018 17:38:17 +0200
Message-Id: <20180917153826.28052-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series starts with various swiotlb cleanups, then adds support for
non-cache coherent devices to the generic swiotlb support, and finally
switches arm64 to use the generic code.

Given that this series depends on patches in the dma-mapping tree, or
pending for it I've also published a git tree here:

    git://git.infradead.org/users/hch/misc.git swiotlb-noncoherent

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb-noncoherent
