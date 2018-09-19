Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27667C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E3B2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9zX9L4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E3B2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732284AbeISULV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:11:21 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34788 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbeISULU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:11:20 -0400
Received: by mail-qt0-f196.google.com with SMTP id m13-v6so5309592qth.1;
        Wed, 19 Sep 2018 07:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Tps4s77D23i3fxKoeF6dPhKuUaEwXZQhu6RTBKsY3Q=;
        b=g9zX9L4TawPVaK0YzSox8YB+x+ct5iD9mIvHFYybGnpR33u0gqEd2UOQudYG85camN
         Cx7+EXRNbZ6eHeigZFjjGvLB0N4PZzuvoX1Mj7r1hmvMS7TGND3uMUJngMJ8gq4vRJae
         UHd49aMvIpAzAHUutSS1b+F4zimhEumQsd4Jm0Ok339EhweMKe8Y7qBy3b21IN6ykVbP
         EgIXdekqa4leU6khqF7T1l+8aJU9aKQfm5tjQqQt4n1xa43U9zGFUSaxaMfhAkJmPhgk
         x1pSKwu4I/LVTcdqMMgGPB5gYS00Qi7sF1uP3CIGatW8DDvxzRhYswE/Bc64K9gR4ecF
         ZK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Tps4s77D23i3fxKoeF6dPhKuUaEwXZQhu6RTBKsY3Q=;
        b=YXTKaSywIh2USmb5zE4YSrauVHbK898FkBi0LB+o8hCQIUQfnU0o/6Ob8b0RXqL6Ua
         wuBngjl7j7MzP4OO27ehddrrp2Fw5FALRuoqjEIUtBqcQqEHQgvJnF8dLw+qlTcMh95d
         12j9axcAcTmoALu/Kh57Ex1aKiFbpTVmv4xugOLC2577MH0eBdgVosRRtwBBwncFTIgI
         16KZQAZEeBNYFoTxKegl3FEHcmNEQ2Hq89fUhjZp9FVgbmHHGxAiIDyaTVI28Q6SnCCl
         vnEHLmwO05U+Z5n3FN8z+BrwS+YHm6E4zP7MgkK9jy+X3wS20BxELR1hNDN/rhG/vRmS
         CsuA==
X-Gm-Message-State: APzg51DVX23qDEc+2Lu3IN8An5yyIgJDVJnm2Ffo7tkX/p0KjEGJqLmw
        /cOw+FgYkM2Q4whUWQxVj9DmOq+Q
X-Google-Smtp-Source: ANB0VdZWEaFuArm9yR6P9tSrGkSsNGQWEsFlKiiurX0rfbtQn8V05GJJL5BNMXv88Hw35aRVffzFSA==
X-Received: by 2002:aed:2ec6:: with SMTP id k64-v6mr25044676qtd.177.1537367587181;
        Wed, 19 Sep 2018 07:33:07 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 17-v6sm2104051qkf.74.2018.09.19.07.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 07:33:06 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 06/12] MIPS: BMIPS: add dma remap for BrcmSTB PCIe
Date:   Wed, 19 Sep 2018 10:32:01 -0400
Message-Id: <1537367527-20773-7-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The design of the Broadcom PCIe RC controller requires us to remap its
DMA addresses for inbound traffic.  We do this by modifying the
definitions of __phys_to_dma() and __dma_to_phys().

In arch/mips/bmips/dma.c, these functions are already in use to remap
DMA addresses for the 338x SOC chips.  We leave this code alone -- and
give its mapping priority -- but if it is not in use, the PCIe DMA
mapping is in effect.

One might think that the two DMA remapping systems of dma.c could be
combined, but they cannot: one governs only DMA addresses for the PCIe
controller of BrcmSTB ARM/ARM64/MIPs chips, while the other governs
the PCIe controller *and* other peripherals for only MIPs 338x
chips.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/bmips/dma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/bmips/dma.c b/arch/mips/bmips/dma.c
index 3d13c77..292994f 100644
--- a/arch/mips/bmips/dma.c
+++ b/arch/mips/bmips/dma.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <asm/bmips.h>
+#include <soc/brcmstb/common.h>
 
 /*
  * BCM338x has configurable address translation windows which allow the
@@ -44,6 +45,10 @@ dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t pa)
 {
 	struct bmips_dma_range *r;
 
+#ifdef CONFIG_PCIE_BRCMSTB
+	if (!bmips_dma_ranges)
+		return brcm_phys_to_dma(dev, pa);
+#endif
 	for (r = bmips_dma_ranges; r && r->size; r++) {
 		if (pa >= r->child_addr &&
 		    pa < (r->child_addr + r->size))
@@ -56,6 +61,10 @@ phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
 {
 	struct bmips_dma_range *r;
 
+#ifdef CONFIG_PCIE_BRCMSTB
+	if (!bmips_dma_ranges)
+		return (unsigned long)brcm_dma_to_phys(dev, dma_addr);
+#endif
 	for (r = bmips_dma_ranges; r && r->size; r++) {
 		if (dma_addr >= r->parent_addr &&
 		    dma_addr < (r->parent_addr + r->size))
-- 
1.9.0.138.g2de3478

