Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0630FC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47CC222D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083252;
	bh=xTRnONJ99nOxtOWbTgDgZPAppR9pBN2DokYZdHs0VgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iFllAsN3nMc11591KtvmTRI+eGDWbeQQJwK1jm1tRDFZB0S57oG+CAwmJvGRmKBco
	 D+P135ykbkMnD7oYoawzX2boCKayCpVKWKAV/YgkzABRSUtctslbuL+RFZdokZ6VV0
	 6mDlACJtCC7ZFa+lf4TUOdCnWAwGgyWX4x2iU2J4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405480AbfBMSkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:40:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:39028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405465AbfBMSkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:40:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F20EA222DB;
        Wed, 13 Feb 2019 18:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083248;
        bh=xTRnONJ99nOxtOWbTgDgZPAppR9pBN2DokYZdHs0VgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BOVcprs9+t/lXMRkWjGWc20BVfNdy/gVJ7Fyz6dJfRFwHhNubGKYjPKiVdBGM+V8o
         2fmzgoPM1cvrgKqevlDnUzzBPeON3Fu8IVYTKfelzNGzlHNtnixfzNyqtwZrnFXDjY
         SKAzlDZKn+UWyr14xQYygLMzxJawvJyhKgGCXlJA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org
Subject: [PATCH 4.14 11/35] MIPS: OCTEON: dont set octeon_dma_bar_type if PCI is disabled
Date:   Wed, 13 Feb 2019 19:38:06 +0100
Message-Id: <20190213183706.704778969@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183706.176685027@linuxfoundation.org>
References: <20190213183706.176685027@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaro Koskinen <aaro.koskinen@iki.fi>

commit dcf300a69ac307053dfb35c2e33972e754a98bce upstream.

Don't set octeon_dma_bar_type if PCI is disabled. This avoids creation
of the MSI irqchip later on, and saves a bit of memory.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: a214720cbf50 ("Disable MSI also when pcie-octeon.pcie_disable on")
Cc: stable@vger.kernel.org # v3.3+
Cc: linux-mips@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/pci/pci-octeon.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/mips/pci/pci-octeon.c
+++ b/arch/mips/pci/pci-octeon.c
@@ -572,6 +572,11 @@ static int __init octeon_pci_setup(void)
 	if (octeon_has_feature(OCTEON_FEATURE_PCIE))
 		return 0;
 
+	if (!octeon_is_pci_host()) {
+		pr_notice("Not in host mode, PCI Controller not initialized\n");
+		return 0;
+	}
+
 	/* Point pcibios_map_irq() to the PCI version of it */
 	octeon_pcibios_map_irq = octeon_pci_pcibios_map_irq;
 
@@ -583,11 +588,6 @@ static int __init octeon_pci_setup(void)
 	else
 		octeon_dma_bar_type = OCTEON_DMA_BAR_TYPE_BIG;
 
-	if (!octeon_is_pci_host()) {
-		pr_notice("Not in host mode, PCI Controller not initialized\n");
-		return 0;
-	}
-
 	/* PCI I/O and PCI MEM values */
 	set_io_port_base(OCTEON_PCI_IOSPACE_BASE);
 	ioport_resource.start = 0;


