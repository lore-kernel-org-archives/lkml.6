Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA8CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C3021873
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZsY70gdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfA2SNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:13:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfA2SNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T9YfHn1dtYMIXjXTQ94sOHyMsDz3Y9MZiZu/lJl1X/s=; b=ZsY70gdb4z/NZVSpkwnd+Hqar
        IUq7viMj6q7nJYysghwf7IVh8sW7l04MIqCvXcaDUAaEcw6Glu08mtoj+236bF60Z2GgIe9pE6Td3
        T/cHztNJJfJQOJL0O1W8mi/k22kKa06jaG0FFeX3u4I+DiSpwfTAXez2t9sKX0Mq28EF45IFdu9jS
        R9qH1oDs3LzitwOEVy0gaPv4T6zJggpbTYzAWPR7hu3T8YlF5yTV0CCduRxRFQ+GAcO9PaEWO97lY
        CbYzDj+CtK6ID3JF2yrFzwcFfPhWNzZgG+Nnh9JoKTeNIqRoEwvV3U9Kh3WU6jcahBfv/BbUrOX57
        yOj9ZxK1w==;
Received: from 213-225-35-141.nat.highway.a1.net ([213.225.35.141] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goXsn-0007zi-Gd; Tue, 29 Jan 2019 18:13:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: DMA-related cleanups for parisc v2
Date:   Tue, 29 Jan 2019 19:13:02 +0100
Message-Id: <20190129181310.5557-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James and Helge,

this series has a couple DMA-related cleanups for parisc.  The main aim
is to move anything not required by drivers out of <asm/dma-mapping.h>,
but I noticed a few related bits and cleaned them up as well.

Changes since v1:
 - include <linux/pci.h> in drivers/parisc/iommu.h to avoid build
   failures with some configs
