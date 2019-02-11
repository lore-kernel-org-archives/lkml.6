Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B69C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB95121B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uvaquqUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfBKNhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:37:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46920 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbfBKNgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vaPM4/bccvT+rZroXv0xEoOTtwzsa4y66Qg+Go48al4=; b=uvaquqUSh2Ow37z544oSsbI9Qk
        EfPePoMUoj+/DV9tKyCa4QeCLCkNLS/+T+QUVK1nNF/2lUflB31xsjHyJ8kCd488elcmH/949whOo
        9w5i+Upp2RHuOHDJlc3j/oxO+P00+Sx7RF2LHKQWPtF7lmlfa/KTf6QiQi0V6Lae7FEJR7tXZ8heJ
        qpwA+rWeakUvJkzpS1y891++4AKg74/x2BdZXm2UHRBa1sId8PuoiTUpvX8FB/xwihNunBI2ZQ50p
        yn8hM6cXvYB7Ieh8Dxq6Cdlk3oPwgMzSzJYA0kHj9IRZY2ZfIG5yC4mQMcIlG7uaKVMO6an7QYgUf
        +Huk1hRA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtBko-0008UY-6H; Mon, 11 Feb 2019 13:36:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] of: select OF_RESERVED_MEM automatically
Date:   Mon, 11 Feb 2019 14:35:46 +0100
Message-Id: <20190211133554.30055-5-hch@lst.de>
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

The OF_RESERVED_MEM can be used if we have either CMA or the generic
declare coherent code built and we support the early flattened DT.

So don't bother making it a user visible options that is selected
by most configs that fit the above category, but just select it when
the requirements are met.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/Kconfig     | 1 -
 arch/arm/Kconfig     | 1 -
 arch/arm64/Kconfig   | 1 -
 arch/csky/Kconfig    | 1 -
 arch/powerpc/Kconfig | 1 -
 arch/xtensa/Kconfig  | 1 -
 drivers/of/Kconfig   | 5 ++---
 7 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 376366a7db81..4103f23b6cea 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -44,7 +44,6 @@ config ARC
 	select MODULES_USE_ELF_RELA
 	select OF
 	select OF_EARLY_FLATTREE
-	select OF_RESERVED_MEM
 	select PCI_SYSCALL if PCI
 	select PERF_USE_VMALLOC if ARC_CACHE_VIPT_ALIASING
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..9395f138301a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -101,7 +101,6 @@ config ARM
 	select MODULES_USE_ELF_REL
 	select NEED_DMA_MAP_STATE
 	select OF_EARLY_FLATTREE if OF
-	select OF_RESERVED_MEM if OF
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND3
 	select PCI_SYSCALL if PCI
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..1d22e969bdcb 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -163,7 +163,6 @@ config ARM64
 	select NEED_SG_DMA_LENGTH
 	select OF
 	select OF_EARLY_FLATTREE
-	select OF_RESERVED_MEM
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_ECAM if (ACPI && PCI)
 	select PCI_SYSCALL if PCI
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 398113c845f5..0a9595afe9be 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -42,7 +42,6 @@ config CSKY
 	select MODULES_USE_ELF_RELA if MODULES
 	select OF
 	select OF_EARLY_FLATTREE
-	select OF_RESERVED_MEM
 	select PERF_USE_VMALLOC if CPU_CK610
 	select RTC_LIB
 	select TIMER_OF
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2890d36eb531..5cc4eea362c6 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -233,7 +233,6 @@ config PPC
 	select NEED_SG_DMA_LENGTH
 	select OF
 	select OF_EARLY_FLATTREE
-	select OF_RESERVED_MEM
 	select OLD_SIGACTION			if PPC32
 	select OLD_SIGSUSPEND
 	select PCI_DOMAINS			if PCI
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 20a0756f27ef..e242a405151e 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -447,7 +447,6 @@ config USE_OF
 	bool "Flattened Device Tree support"
 	select OF
 	select OF_EARLY_FLATTREE
-	select OF_RESERVED_MEM
 	help
 	  Include support for flattened device tree machine descriptions.
 
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index ad3fcad4d75b..3607fd2810e4 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -81,10 +81,9 @@ config OF_MDIO
 	  OpenFirmware MDIO bus (Ethernet PHY) accessors
 
 config OF_RESERVED_MEM
-	depends on OF_EARLY_FLATTREE
 	bool
-	help
-	  Helpers to allow for reservation of memory regions
+	depends on OF_EARLY_FLATTREE
+	default y if HAVE_GENERIC_DMA_COHERENT || DMA_CMA
 
 config OF_RESOLVE
 	bool
-- 
2.20.1

