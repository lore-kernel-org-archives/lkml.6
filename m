Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE19C6778C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 02:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869F32802D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 02:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0GNDr6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869F32802D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935241AbeF3CVp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 22:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755150AbeF3CVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 22:21:43 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9386C2802D;
        Sat, 30 Jun 2018 02:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530325302;
        bh=t+jxLsG7Yt/6E8ijUsSV50MZl/1eBNADpuwNT2Nei5I=;
        h=Subject:From:To:Cc:Date:From;
        b=S0GNDr6tTt/e4KsPnWkU6qUbjkuAjOuF/IPnUPn0EsMR69z43ZnPnLnIaVqz0v+0d
         aQYntq2jBHau7B6n4+V46YDU5ttToPtdDw0ojF9RoDj6K2EAUrTdfmcIDSPrd45VZc
         dn2DFOrrjRZaNuAquA+pWBtQ9SeYWza1sPS+FdTY=
Subject: [PATCH] PCI: Make pci_get_rom_size() static
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rex Zhu <Rex.Zhu@amd.com>
Date:   Fri, 29 Jun 2018 21:21:39 -0500
Message-ID: <153032529978.134892.3376112989125005436.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_get_rom_size() is called only from pci_map_rom(), so it can be static.
Make it static and remove the declaration from include/linux/pci.h.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/rom.c   |    3 ++-
 include/linux/pci.h |    1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
index 3a33f5ce314a..137bf0cee897 100644
--- a/drivers/pci/rom.c
+++ b/drivers/pci/rom.c
@@ -80,7 +80,8 @@ EXPORT_SYMBOL_GPL(pci_disable_rom);
  * The PCI window size could be much larger than the
  * actual image size.
  */
-size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom, size_t size)
+static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
+			       size_t size)
 {
 	void __iomem *image;
 	int last_image;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b2fb38..f40d3e05ccd1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1122,7 +1122,6 @@ int pci_enable_rom(struct pci_dev *pdev);
 void pci_disable_rom(struct pci_dev *pdev);
 void __iomem __must_check *pci_map_rom(struct pci_dev *pdev, size_t *size);
 void pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom);
-size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom, size_t size);
 void __iomem __must_check *pci_platform_rom(struct pci_dev *pdev, size_t *size);
 
 /* Power management related routines */

