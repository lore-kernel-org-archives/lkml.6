Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A7EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2000C21A4C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fqIKzCx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfBOOqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:46:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34764 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfBOOqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r8G03LgrF5xsPbw0IizLF7d6LIB5NmOjr3dY3ocUbcQ=; b=fqIKzCx0Nrm0gK6a5CDiE2mm2
        dVPMbOcy5YPiSfJ249GeSpmkzX7K3TrcdRcdyOlNYsbLIQGuY9qKss7U8+v580kBG6jvc2KRGup3P
        blC7vhlvb9dmjY4R+UVE5Jr+RFiuiIVj64PXGXoc3JtqVMB0AemPUeG1PrYMv/spXVfFJqA93KlIQ
        XivSCb0c9q++kgSfOfYXlDPtLDnNpPvGVrREAA7TLwZvthIZ1vNIKEC767DgBUySaIA/zTescRopi
        3wRz8SLwbVcuxeuradbV3KGqmPtqXR9i9P7pR+11r1ZaZnTrw9bJzL1gKEa50sGAxkO7baz6mH+Yx
        VUhSb9TYA==;
Received: from [91.112.108.175] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guekb-0005PD-Od; Fri, 15 Feb 2019 14:46:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, sparclinux@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: allow larger than require DMA masks
Date:   Fri, 15 Feb 2019 15:45:54 +0100
Message-Id: <20190215144559.8777-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series finishes off converting our dma mask model to split between
device capabilities (dev->dma_mask and dev->coherent_dma_mask) and system
limitations (dev->bus_dma_mask).  We already accept larger than required
masks in most dma_map_ops implementation, in case of x86 and
implementations based on it since the dawn of time.  Only one parisc
and two sparc64 instances failed larger than required DMA masks, and
this series fixes that up and updates the documentation that devices
don't need to handle DMA mask fallbacks.

