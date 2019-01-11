Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533F8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E5521841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217562;
	bh=k4cvmOLqTjdAD5CUhbx7g5AgZOEKXRdlIVLVbkJxOjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TcZw5ShMeDzVf8OAN9O6cKjdqyAzl0BcpP7RaDNy7H+53rnXfrEunHvFx/RAxPAGe
	 mZ+sL2D6Dngt4nXiw8X/tY336DDDiu5NVf2fhWlGCmo3JDffoEPgiu4LbAsR8qHdkN
	 wAY0NCTE49SFJFsxj7Qt0+SOaXzIJBB/S1uB9DFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390616AbfAKOjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:39:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390987AbfAKOjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:39:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC1E72063F;
        Fri, 11 Jan 2019 14:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217552;
        bh=k4cvmOLqTjdAD5CUhbx7g5AgZOEKXRdlIVLVbkJxOjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ANXvYc7/BfcKAcMx6WcE2zEB8xIs1kLgj1XURH+dxtEoWOBCXj3P0HGkCgdLKPHCE
         rTvosqnaMBue6h2zYCw7fxHJQuczP3S3dFpbhIQpQJXJq/+Ie4r/03uEjrHv1Lu0Lv
         G7LAiSnurI6+Mps5tmymH7FmvOczjzi5p3x6AB+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4.19 101/148] dma-direct: do not include SME mask in the DMA supported check
Date:   Fri, 11 Jan 2019 15:14:39 +0100
Message-Id: <20190111131118.265962167@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lendacky, Thomas <Thomas.Lendacky@amd.com>

commit c92a54cfa0257e8ffd66b2a17d49e9c0bd4b769f upstream.

The dma_direct_supported() function intends to check the DMA mask against
specific values. However, the phys_to_dma() function includes the SME
encryption mask, which defeats the intended purpose of the check. This
results in drivers that support less than 48-bit DMA (SME encryption mask
is bit 47) from being able to set the DMA mask successfully when SME is
active, which results in the driver failing to initialize.

Change the function used to check the mask from phys_to_dma() to
__phys_to_dma() so that the SME encryption mask is not part of the check.

Fixes: c1d0af1a1d5d ("kernel/dma/direct: take DMA offset into account in dma_direct_supported")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 kernel/dma/direct.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -168,7 +168,12 @@ int dma_direct_map_sg(struct device *dev
 int dma_direct_supported(struct device *dev, u64 mask)
 {
 #ifdef CONFIG_ZONE_DMA
-	if (mask < phys_to_dma(dev, DMA_BIT_MASK(ARCH_ZONE_DMA_BITS)))
+	/*
+	 * This check needs to be against the actual bit mask value, so
+	 * use __phys_to_dma() here so that the SME encryption mask isn't
+	 * part of the check.
+	 */
+	if (mask < __phys_to_dma(dev, DMA_BIT_MASK(ARCH_ZONE_DMA_BITS)))
 		return 0;
 #else
 	/*
@@ -176,8 +181,12 @@ int dma_direct_supported(struct device *
 	 * to be able to satisfy them - either by not supporting more physical
 	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
 	 * architecture needs to use an IOMMU instead of the direct mapping.
+	 *
+	 * This check needs to be against the actual bit mask value, so
+	 * use __phys_to_dma() here so that the SME encryption mask isn't
+	 * part of the check.
 	 */
-	if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
+	if (mask < __phys_to_dma(dev, DMA_BIT_MASK(32)))
 		return 0;
 #endif
 	/*


