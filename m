Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2967BECDFC1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D803F20833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D803F20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeILVDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:03:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61622 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbeILVDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:03:35 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 429RJx3lXWz9ttRm;
        Wed, 12 Sep 2018 17:58:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZvVqrt3cUyht; Wed, 12 Sep 2018 17:58:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 429RJx3DBCz9ttBm;
        Wed, 12 Sep 2018 17:58:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0C7C98B858;
        Wed, 12 Sep 2018 17:58:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wx3EmMB7XWTX; Wed, 12 Sep 2018 17:58:24 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4D0F08B86F;
        Wed, 12 Sep 2018 17:58:24 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 05DA571913; Wed, 12 Sep 2018 15:58:23 +0000 (UTC)
Message-Id: <18d5b7489e75dfa504010bc8939f97cd4463d229.1536692743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1536692743.git.christophe.leroy@c-s.fr>
References: <cover.1536692743.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 05/24] powerpc: don't use ioremap_prot() nor __ioremap()
 unless really needed.
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Geoff Levand <geoff@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date:   Wed, 12 Sep 2018 15:58:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In many places, ioremap_prot() and __ioremap() can be replaced with
higher level functions like ioremap(), ioremap_coherent(),
ioremap_cache(), ioremap_wc() ...

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/btext.c               | 2 +-
 arch/powerpc/kernel/crash_dump.c          | 2 +-
 arch/powerpc/platforms/85xx/smp.c         | 4 ++--
 arch/powerpc/platforms/pasemi/dma_lib.c   | 2 +-
 arch/powerpc/platforms/ps3/spu.c          | 3 +--
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c | 8 ++++----
 6 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
index b2072d5bbf2b..b4241ed1456e 100644
--- a/arch/powerpc/kernel/btext.c
+++ b/arch/powerpc/kernel/btext.c
@@ -163,7 +163,7 @@ void btext_map(void)
 	offset = ((unsigned long) dispDeviceBase) - base;
 	size = dispDeviceRowBytes * dispDeviceRect[3] + offset
 		+ dispDeviceRect[0];
-	vbase = __ioremap(base, size, pgprot_val(pgprot_noncached_wc(__pgprot(0))));
+	vbase = ioremap_wc(base, size);
 	if (!vbase)
 		return;
 	logicalDisplayBase = vbase + offset;
diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index d10ad258d41a..bbdc4706c159 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -110,7 +110,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 		vaddr = __va(paddr);
 		csize = copy_oldmem_vaddr(vaddr, buf, csize, offset, userbuf);
 	} else {
-		vaddr = __ioremap(paddr, PAGE_SIZE, 0);
+		vaddr = ioremap_cache(paddr, PAGE_SIZE);
 		csize = copy_oldmem_vaddr(vaddr, buf, csize, offset, userbuf);
 		iounmap(vaddr);
 	}
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 7e966f4cf19a..fff72425727a 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -216,8 +216,8 @@ static int smp_85xx_start_cpu(int cpu)
 
 	/* Map the spin table */
 	if (ioremappable)
-		spin_table = ioremap_prot(*cpu_rel_addr,
-			sizeof(struct epapr_spin_table), _PAGE_COHERENT);
+		spin_table = ioremap_coherent(*cpu_rel_addr,
+					      sizeof(struct epapr_spin_table));
 	else
 		spin_table = phys_to_virt(*cpu_rel_addr);
 
diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
index c80f72c370ae..53384eb42a76 100644
--- a/arch/powerpc/platforms/pasemi/dma_lib.c
+++ b/arch/powerpc/platforms/pasemi/dma_lib.c
@@ -576,7 +576,7 @@ int pasemi_dma_init(void)
 		res.start = 0xfd800000;
 		res.end = res.start + 0x1000;
 	}
-	dma_status = __ioremap(res.start, resource_size(&res), 0);
+	dma_status = ioremap_cache(res.start, resource_size(&res));
 	pci_dev_put(iob_pdev);
 
 	for (i = 0; i < MAX_TXCH; i++)
diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
index b54850845466..7746c2a3c509 100644
--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -215,8 +215,7 @@ static int __init setup_areas(struct spu *spu)
 		goto fail_ioremap;
 	}
 
-	spu->local_store = (__force void *)ioremap_prot(spu->local_store_phys,
-		LS_SIZE, pgprot_val(pgprot_noncached_wc(__pgprot(0))));
+	spu->local_store = (__force void *)ioremap_wc(spu->local_store_phys, LS_SIZE);
 
 	if (!spu->local_store) {
 		pr_debug("%s:%d: ioremap local_store failed\n",
diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
index 00ccf3e4fcb4..15cbdd4fde06 100644
--- a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
+++ b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
@@ -107,11 +107,11 @@ int __init instantiate_cache_sram(struct platform_device *dev,
 		goto out_free;
 	}
 
-	cache_sram->base_virt = ioremap_prot(cache_sram->base_phys,
-				cache_sram->size, _PAGE_COHERENT | PAGE_KERNEL);
+	cache_sram->base_virt = ioremap_coherent(cache_sram->base_phys,
+						 cache_sram->size);
 	if (!cache_sram->base_virt) {
-		dev_err(&dev->dev, "%pOF: ioremap_prot failed\n",
-				dev->dev.of_node);
+		dev_err(&dev->dev, "%pOF: ioremap_coherent failed\n",
+			dev->dev.of_node);
 		ret = -ENOMEM;
 		goto out_release;
 	}
-- 
2.13.3

