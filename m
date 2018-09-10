Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE86C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DB420854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iRGTeGUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DB420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeIJK6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 06:58:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49214 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeIJK6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 06:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rl9VsC8YtoqxZDi65X5wq6sAbW8snqOj8zWTPGtWDoU=; b=iRGTeGUrZQwDzsEssdzH505tP
        QBRnpWl4YEG4Bi79ypCil93pjusfWtRZncpV5D1c5PpczCbE1iMlmPi1ocfaMCKIY1DHgXbN9dwtO
        cN7BmkYLIVPhm49cL7Mp4WI7hpijfIgTsOK19OKi4aOTsW0tZv2wqeTMXFF3bWqxjsQPmC40KPyYz
        BO5SjRXeMHPySefWkaClf2rY7/EpADDMEyYgf6XiXHAQvMK9goaZ+V4iOnxkUNMkxD4vA7Tlflh7y
        QyMC7SEkXnV5fcLMebwaxDBPqBXuPkw2ynQaqPOpWrywM2mpJOU3kYpGVbysK40guBG6MvV+gYBvb
        2Xo3zAdZw==;
Received: from 213-225-3-213.nat.highway.a1.net ([213.225.3.213] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzFKK-0007xA-3M; Mon, 10 Sep 2018 06:05:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: merge dma_direct_ops and dma_noncoherent_ops v2
Date:   Mon, 10 Sep 2018 08:05:28 +0200
Message-Id: <20180910060533.27172-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While most architectures are either always or never dma coherent for a
given build, the arm, arm64, mips and soon arc architectures can have
different dma coherent settings on a per-device basis.  Additionally
some mips builds can decide at boot time if dma is coherent or not.

I've started to look into handling noncoherent dma in swiotlb, and
moving the dma-iommu ops into common code [1], and for that we need a
generic way to check if a given device is coherent or not.  Moving
this flag into struct device also simplifies the conditionally coherent
architecture implementations.

These patches are also available in a git tree given that they have
a few previous posted dependencies:

    git://git.infradead.org/users/hch/misc.git dma-direct-noncoherent-merge

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct-noncoherent-merge

Changes since v1:
 - rebased to the latest Linus' tree which includes coherent dma support
   for arc
 - a couple tidyups suggested by Paul Burton
