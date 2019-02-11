Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C78AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CFB20855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yu/qEBFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfBKN2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:28:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37352 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfBKN2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BytYnac768iTDBBGZEe4HuJ1jhjebfyJ3owjfzziQEo=; b=Yu/qEBFIOauB368K2Knj7vU5y
        CylvB+sFeQe3T0NrEfC9fBK1QXbgZ9XBOkntuGUW5VUcQ+PkhHKpXbySRqfxrn+IH0pOPdfjKWzX2
        t+QyRmUx9CTJ/VCc9hEAuxFGE79f7pPs9cIulPhwfTJmYNaPHm9yQ55wf5IWFdqsR/B8Dksxh6m7g
        LDxe4wJsZJA1wOGKjTwDdSS2PoMCfOr9tYpT8TB/Wc8XCmvxayYXcX+AVVRlPgSJPed7gsOx25If9
        0+OdhFMIuC/QKQl2pBKsPh92iMQHHvT1rQJQVdirn7LclrUVXQbhkVEVc+W6jkC0AOgBy2gM8LdHS
        M02iu4YEw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtBdY-0004L5-CW; Mon, 11 Feb 2019 13:28:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: fbdev: don't pass a NULL struct device to DMA API functions v2
Date:   Mon, 11 Feb 2019 14:28:33 +0100
Message-Id: <20190211132836.29594-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We still have a few drivers which pass a NULL struct device pointer
to DMA API functions, which generally is a bad idea as the API
implementations rely on the device not only for ops selection, but
also the dma mask and various other attributes.

This series contains all easy conversions to pass a struct device,
besides that there also is some arch code that needs separate handling,
a driver that should not use the DMA API at all, and one that is
a complete basket case to be deal with separately.

Changes since v1:
 - split the series, this only contains the fbdev patches
