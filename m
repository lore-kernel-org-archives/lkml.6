Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3F4C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821D220878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y9Pu92SJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821D220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJHPNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:13:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55332 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeJHPNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MkATRytt1o27C6gRI0itOe9E4UzR9J8U6ekKA3iWefY=; b=Y9Pu92SJkMmg4LEzN9xU95lI4
        501h0ywi+E4hoSszkvlIebkiVGJRI3nQsYOWqGeJcP5OidsCza/HEeq3WXcEe5CTLwI4z76d8VB9S
        ZeGwxlEJsa1plYMAdPTCYpm4MPi+MVPsb9jb4uV+HZrlYbqOyJjjv88ICGN2A/g9fsXctNOU/nO4D
        b0T0vIL6STM6Pcdnz30FJgQ+LOSEZ70ju+LdHcWR/SIIog/7xs6JtI5ozmE8QngsxcIVpUgT/TMiG
        erAUwb4RhOvstA1/CkWDjhXG9q8tw0h2LArYKj5mQM3x14vcU/zb5R1XgOEPfRywAmfTCjttq5hX/
        +F5uZNBEw==;
Received: from 089144207060.atnat0016.highway.bob.at ([89.144.207.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9QV8-000252-Tu; Mon, 08 Oct 2018 08:02:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: move swiotlb noncoherent dma support from arm64 to generic code V2
Date:   Mon,  8 Oct 2018 10:02:36 +0200
Message-Id: <20181008080246.20543-1-hch@lst.de>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

    git://git.infradead.org/users/hch/misc.git swiotlb-noncoherent.2

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb-noncoherent.2

Changes since v1:
 - make sure arm64 always calls dma_direct_alloc_pages to avoid
   circular calling conventions
 - add a patch in to stop dipping into the swiotlb pool for coherent
   allocations - this just depletes the swiotlb pool for no good reason
