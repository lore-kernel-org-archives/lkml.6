Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B337ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AB02146E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHxO46RK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AB02146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbeJYWwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730432AbeJYWwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:16 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7F172086D;
        Thu, 25 Oct 2018 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477158;
        bh=F+bZd7Y0JabhHZR332foEkryzsTYDF16P2v4NpaFO3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pHxO46RKoaVMkNZ8YyZ+XZevb3DhZnZEBi7D17MnwB8FqSf71OOQBwVGjhP+yoHng
         DRRU9oMI27JzkZdbtoIzv+pnb3sKE79z57EKhDgB8SQR/EdNgmhpMHaNm/ynj3QFpK
         Pha6RVcBqFBMsK88rQmQkCakAdX5W4lD09DlY/V4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 14/98] ARM: shmobile: r8a7740: Instantiate GIC from C board code in legacy builds
Date:   Thu, 25 Oct 2018 10:17:29 -0400
Message-Id: <20181025141853.214051-14-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit d034f53cc6c5c09a4e10cb9716986f3844c58514 ]

As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
domain."), armadillo-legacy hangs during boot with:

     sh-tmu.0: ch0: used for clock events
     sh-tmu.0: ch0: used for periodic clock events
     sh-tmu.0: ch0: failed to request irq 230
     sh-tmu.0: ch1: used as clock source
     sh-cmt-48.1: ch0: failed to request irq 90
     sh-cmt-48.1: ch0: registration failed
    earlytimer: unable to probe sh-cmt-48 early.
    Calibrating delay loop...

This happens because the IRQ numbers of the GIC are now virtual, and no
longer match the hardcoded hardware IRQ numbers in the platform board
code.
To fix this, instantiate the GIC from platform board code when compiling
a legacy kernel, like is done on sh73a0 for kzm9g-legacy.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 8894e1b7ab0e..6ccdc4574c89 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -792,7 +792,14 @@ void __init r8a7740_init_irq_of(void)
 	void __iomem *intc_msk_base = ioremap_nocache(0xe6900040, 0x10);
 	void __iomem *pfc_inta_ctrl = ioremap_nocache(0xe605807c, 0x4);
 
+#ifdef CONFIG_ARCH_SHMOBILE_LEGACY
+	void __iomem *gic_dist_base = ioremap_nocache(0xc2800000, 0x1000);
+	void __iomem *gic_cpu_base = ioremap_nocache(0xc2000000, 0x1000);
+
+	gic_init(0, 29, gic_dist_base, gic_cpu_base);
+#else
 	irqchip_init();
+#endif
 
 	/* route signals to GIC */
 	iowrite32(0x0, pfc_inta_ctrl);
-- 
2.17.1

