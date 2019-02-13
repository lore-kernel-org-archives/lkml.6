Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860D7C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2D1222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lzx0GIEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbfBMHCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:02:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732530AbfBMHCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=27gMM6izTjHanNLOHeLDUp2exh7jNTnp61rJUKkIOmc=; b=lzx0GIEyprG9dvqBAMrERRPe55
        JuRHk7F3ciyy+vbGhGB1lSBsoGou1lwhZQwPpaxzxepVbUUK+2AzzPa54Rgd7xJD7C0YJjUVx+Gi6
        vK5wAE5tazvjxfJNj13LDv0cS0g01j/nmKDShdZCZGKho8zwhrNNU9MxaoPsCbeUVG7hgO6LUIaw+
        O3wpop6Uk4vS6wCKKegPoAHH7PdqoeDBp47xkzmWrGRYJvf24pBLs0VqeNLEXcjZmH9VYNx9yDQXa
        N6LHzM8Qi4Dm+7tTy8GZBEaeXhAsYnuectRnVJnfRcPkBZLqrnTxLE+4M5y10lSomsBqlkxn6E7px
        8ECNOrlw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtoYO-0000Hn-1S; Wed, 13 Feb 2019 07:01:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Olof Johansson <olof@lixom.net>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/32] powerpc/dart: remove dead cleanup code in iommu_init_early_dart
Date:   Wed, 13 Feb 2019 08:01:10 +0100
Message-Id: <20190213070133.11259-10-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dart_init failed we didn't have a chance to setup dma or controller
ops yet, so there is no point in resetting them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/sysdev/dart_iommu.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index a5b40d1460f1..283ce04c5844 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -428,7 +428,7 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 
 	/* Initialize the DART HW */
 	if (dart_init(dn) != 0)
-		goto bail;
+		return;
 
 	/* Setup bypass if supported */
 	if (dart_is_u4)
@@ -439,15 +439,6 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 
 	/* Setup pci_dma ops */
 	set_pci_dma_ops(&dma_iommu_ops);
-	return;
-
- bail:
-	/* If init failed, use direct iommu and null setup functions */
-	controller_ops->dma_dev_setup = NULL;
-	controller_ops->dma_bus_setup = NULL;
-
-	/* Setup pci_dma ops */
-	set_pci_dma_ops(&dma_nommu_ops);
 }
 
 #ifdef CONFIG_PM
-- 
2.20.1

