Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28C5C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7543820854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L1Nk69hR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7543820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbeIJLGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:06:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50164 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIJLGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LF/RVzydT85TdtMP30KdU84VHvQAajvv9eAJXw6hL6E=; b=L1Nk69hRbc4fzE5I0mCfd/s2M
        2fBeJeuffAqiekkstITjrvjPs8EB8bZZuguHy2EyLSxJ6ljC5SNdvJ9ZSwjlafVFNqut+DCm5Q4mA
        m0agG7QfJmmShn2Jd2VfFhQdnJAoTcv+0JtD4ygirZknhg3Qs+onzS0fyhADvPXZdjiI6EG87q9re
        08hnsCwrfMxALM1ZBktFCk4wbRdLnSWRlWLrhNqtuWhQrD2P8Z85+8liHBvAMLBYCVnTEdYSWxgPk
        6vfKyhtROHAy9D7UEG+zvLfwUVYw3yovmq0iCyY6nS8klIa0HnZbzmxDzKO7EjFbw2AhjggIfniCP
        4MaL/xecg==;
Received: from 213-225-3-213.nat.highway.a1.net ([213.225.3.213] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzFS2-00021r-Qi; Mon, 10 Sep 2018 06:13:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: dma_get_required_mask tidyups
Date:   Mon, 10 Sep 2018 08:13:29 +0200
Message-Id: <20180910061332.28187-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the dma_get_required_mask dma API implementation has always been a little
odd, in that we by default don't wire it up struct dma_map_ops, but
instead hard code a default implementation.  powerpc and ia64 override
this default and either call a method or otherwise duplicate the default.

This series always enabled the method and just falls back to the previous
default implementation when it is not available, as well as fixing up
a few bits in the default implementations.  This already allows removing
the ia64 override of the implementation, and will also allow to remove
the powerpc one together with a few additional cleanups in the powerpc
code, but those will be sent separately with other powerpc DMA API
patches.  Last but not least the method will allow us to return a more
sensible value for typical iommu dma_ops eventually, but that is left
to another series as well.
