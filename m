Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1BBC4151A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29EA20844
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FtSVRlxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbfBAIvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:51:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbfBAIsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l3DOgCmu34NqZKnulcp3vGWxIiN/v8w0KyW6Do+gkok=; b=FtSVRlxtfJotCCF5iySwft2MRE
        EmQtssDlmFitwgtxHgjDJuhNlKlu1/n86S5ZrJJIF3Zqo7THN83AHxEdL9Hy2IoIrn8GGYUio7mQv
        ZrGv1lT+lUpm91/4cPzbJ4FFJozlzjPW3Z9zNt3qSV9GkCmu6E8ze4FpEAJfikfG7DA2elWRNXyc3
        UIXvaZcevaWhL3dNM8I0NO5WAPU75X+ihtow5zV97kbXy0Dg7XIU57FfwFToqZwKTPKl02PqLUoAH
        WWMc8EOvcbo+7O280I2w+zzYRKHoYCPZmUWKYXDBBhNyqJAr4GX2sOQ0Ay71zssw74oijWlRijI9G
        AzYUo5Bw==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpUUX-0001Mb-R2; Fri, 01 Feb 2019 08:48:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     iommu@lists.linux-foundation.org
Subject: [PATCH 01/18] MIPS: lantiq: pass struct device to DMA API functions
Date:   Fri,  1 Feb 2019 09:47:44 +0100
Message-Id: <20190201084801.10983-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201084801.10983-1-hch@lst.de>
References: <20190201084801.10983-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA API generally relies on a struct device to work properly, and
only barely works without one for legacy reasons.  Pass the easily
available struct device from the platform_device to remedy this.

Also use GFP_KERNEL instead of GFP_ATOMIC as the gfp_t for the memory
allocation, as we aren't in interrupt context or under a lock.

Note that this whole function looks somewhat bogus given that we never
even look at the returned dma address, and the CPHYSADDR magic on
a returned noncached mapping looks "interesting".  But I'll leave
that to people more familiar with the code to sort out.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/lantiq/xway/vmmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/lantiq/xway/vmmc.c b/arch/mips/lantiq/xway/vmmc.c
index 577ec81b557d..3deab9a77718 100644
--- a/arch/mips/lantiq/xway/vmmc.c
+++ b/arch/mips/lantiq/xway/vmmc.c
@@ -31,8 +31,8 @@ static int vmmc_probe(struct platform_device *pdev)
 	dma_addr_t dma;
 
 	cp1_base =
-		(void *) CPHYSADDR(dma_alloc_coherent(NULL, CP1_SIZE,
-						    &dma, GFP_ATOMIC));
+		(void *) CPHYSADDR(dma_alloc_coherent(&pdev->dev, CP1_SIZE,
+						    &dma, GFP_KERNEL));
 
 	gpio_count = of_gpio_count(pdev->dev.of_node);
 	while (gpio_count > 0) {
-- 
2.20.1

