Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A3BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2D320820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hzgBm4/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2D320820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395349AbeKWAnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:43:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395332AbeKWAnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3BX9PqqvdLeVCRuhSYQhRsSK98r6Q7dJCk6jBNHa5mM=; b=hzgBm4/p3vtzP8FZdwn1Q2ZB9
        MLX5WXygMyev/k7ITTFniBPCEVmHAa7AJfMIE/Kd9XgPtsNjH0W/axrJf7GAed1P0R9i49N/eEY8o
        tSYWqeUJ3TQigvk9WagHWWONlWeo4sAHhaIOiOopLrSabTTai/6oDgGmO7bj9TpOtmjBDFh3veHTo
        QMpMNdwrXLpYBG5XyrsxSrykxByRDyRXc5Es5b6bQ34/xxXi0wjbiFcfMABXwGtQ/RkaH+rn0hG4u
        E7l8B7J4qPzOvjuK2aBKz84Y+pIMRbJa9Jj5kTSVsS9W5r8DweN/wk2zxefdqQwOVioPH0Fqr3zeB
        kYcNHjPDA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPpZj-0007Wa-Vj; Thu, 22 Nov 2018 14:03:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jon Mason <jdmason@kudzu.us>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: remove the ->mapping_error method from dma_map_ops V2
Date:   Thu, 22 Nov 2018 15:02:56 +0100
Message-Id: <20181122140320.24080-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error reporting for the dma_map_single and dma_map_page operations is
currently a mess.  Both APIs directly return the dma_addr_t to be used for
the DMA, with a magic error escape that is specific to the instance and
checked by another method provided.  This has a few downsides:

 - the error check is easily forgotten and a __must_check marker doesn't
   help as the value always is consumed anyway
 - the error checking requires another indirect call, which have gotten
   incredibly expensive
 - a lot of code is wasted on implementing these methods

The historical reason for this is that people thought DMA mappings would
not fail when the API was created, which sounds like a really bad
assumption in retrospective, and then we tried to cram error handling
onto it later on.

There basically are two variants:  the error code is 0 because the
implementation will never return 0 as a valid DMA address, or the error
code is all-F as the implementation won't ever return an address that
high.  The old AMD GART is the only one not falling into these two camps
as it picks sort of a relative zero relative to where it is mapped.

The 0 return doesn't work for direct mappings that have ram at address
zero and a lot of IOMMUs that start allocating bus space from address
zero, so we can't consolidate on that, but I think we can move everyone
to all-Fs, which the patch here does.  The reason for that is that
there is only one way to ever get this address: by doing a 1-byte long,
1-byte aligned mapping, but all our mappings are not only longer but
generally aligned, and the mappings have to keep at least the basic
alignment.

Note that the first two patches are queued up for 4.20 and included
for reference.

A git tree is also available here:

    git://git.infradead.org/users/hch/misc.git dma-mapping-error.2

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-mapping-error.2

Changes since v1:
 - dropped the signature change
 - split into multiple patches
 - fixed the iova allocator return check in amd-iommu
 - remove EMERGENCY_PAGES in amd_gart and calgary
