Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7200C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58E62145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58E62145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeK3VlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:41:14 -0500
Received: from verein.lst.de ([213.95.11.211]:49455 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbeK3VlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:41:14 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 964A868BDF; Fri, 30 Nov 2018 11:32:22 +0100 (CET)
Date:   Fri, 30 Nov 2018 11:32:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     hch@lst.de, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20181130103222.GA23393@lst.de>
References: <CALjTZvZzHSZ=s0W0Pd-MVd7OA0hYxu0LzsZ+GxYybXKoUQQR6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjTZvZzHSZ=s0W0Pd-MVd7OA0hYxu0LzsZ+GxYybXKoUQQR6Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui,

can you check if the patch below fixes the issue for you?

diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 2e24fc87ed84..809797dbe169 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -392,7 +392,9 @@ static void pci_dma_dev_setup_dart(struct pci_dev *dev)
 
 static bool iommu_bypass_supported_dart(struct pci_dev *dev, u64 mask)
 {
-	return dart_is_u4 && dart_device_on_pcie(&dev->dev);
+	return dart_is_u4 &&
+		dart_device_on_pcie(&dev->dev) &&
+		mask >= DMA_BIT_MASK(40);
 }
 
 void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
