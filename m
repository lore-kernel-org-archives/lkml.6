Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146FFC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4307218F0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ay3OBcjK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfBKNgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:36:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46152 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfBKNgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PXEKrNVlSwSD44MLHVfYVpXgllDl8h1AQx+K1N1fGdg=; b=ay3OBcjKrfnFrYuWalfKgKQUGs
        M7qMzn7Ynef+iX/JVSOJuErDpLeo8UZlfGl0TI28lnWbWgnQV8iX+BKm4QNYh8y6gs4ngRiO6/cal
        uZizUblwLUd+EjynLyx+rgRZMRoTM4JXM07Tncgt14AiM0FvoiOCE5xp4e8speTc+0CIlasqbKaqz
        a6i1PwT8t6m8rp62ZrnzVO5LsnBN8IixXSPSZDZbpefv3qu3qhG21FexSGBhSVPUgXCudOgf2HL8V
        k+UOBrDA/q+5/dKyqAjG0fv12f541spKtlER78+Qwfi/7vomQPcPCiy7bdMC2rp8qm+q1GzoLetJI
        YajgfT6Q==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtBkf-0008Lw-3f; Mon, 11 Feb 2019 13:36:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] mfd/sm501: depend on HAS_DMA
Date:   Mon, 11 Feb 2019 14:35:43 +0100
Message-Id: <20190211133554.30055-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
References: <20190211133554.30055-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the sm501 mfd driver can be compiled without any dependencies,
but through the use of dma_declare_coherent it really depends on
having DMA and iomem support.  Normally we don't explicitly require DMA
support as we have stubs for it if on UML, but in this case the driver
selects support for dma_declare_coherent and thus also requires
memmap support.  Guard this by an explicit dependency.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f461460a2aeb..f15f6489803d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1066,6 +1066,7 @@ config MFD_SI476X_CORE
 
 config MFD_SM501
 	tristate "Silicon Motion SM501"
+	depends on HAS_DMA
 	 ---help---
 	  This is the core driver for the Silicon Motion SM501 multimedia
 	  companion chip. This device is a multifunction device which may
-- 
2.20.1

