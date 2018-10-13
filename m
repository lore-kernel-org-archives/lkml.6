Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10123C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2F7206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pWS0Ahd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2F7206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJMWyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:54:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeJMWyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ziiRYizZMZmi2VbrUVcIg1fZxYyxOx0sdmJuBSbv7M0=; b=pWS0Ahd40FJCHgeezIoY+wuP0
        BwXH6FBZkjPBUMmESQFP12Gs/Yt/8saGKb0t4ORD35irOCoqdcCopVrh/AIUBqK89nVtwMJjZQt1H
        usrPGfksYjyvxGArrEd6mhkYrPkGMwZE2NvJ7oCokwyrrAY1pyBDnyNQVv/dzyfqL5QNf45m+0GVp
        7DBpyokLZ3rDEUpFsuIAfWd33ctNi3xj/kCV4k6nkJ5n1H+nPNVIIvcbyncvq4K6GevP3dypD07aJ
        5ExRdZP35nKpJVNu0j/SzLK+Op+/wqx/oAe0XerkFt6308ksxg5wjXTZuglN9MBFw8EzsKFJoptxn
        7ZUlIObkg==;
Received: from 089144199123.atnat0008.highway.a1.net ([89.144.199.123] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBLfB-0004zP-Lv; Sat, 13 Oct 2018 15:17:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: remove bogus GFP_DMA32 flags for dma allocations
Date:   Sat, 13 Oct 2018 17:16:59 +0200
Message-Id: <20181013151707.32210-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_alloc_* internally selects the zone to allocate from based on the
DMA mask.  Remove all explicit uses of GFP_DMA32 with dma_alloc_*.
