Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75486C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A88E2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Xh+qt6Hy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A88E2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeJ3Rq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:46:58 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:47260 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeJ3Rq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:46:58 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DB0B424E13CB;
        Tue, 30 Oct 2018 01:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1540889665; bh=HAuedeMPUolDy6DroXVPsVEUrGok5dzG1jRl67dLYRg=;
        h=From:To:Cc:Subject:Date:From;
        b=Xh+qt6HyL/NZvmkOYcfI3sHwEC3ghY0w4ahDS6VpcuXeVSUPNlqaqqZAaEPKHpYk5
         D4eRXTS8EANmMV8/ws2oGe3Mf4Xe+ZlDnjVw/8dodM79sUxBrkFjEQNivmAumrhCzW
         qFSib1yL3A8XG4vyxPWqzXRa8R2KrYjDkM8JxrwCcIkMpUiLwJQ66mwTLMr9aNfgwX
         e87OjcFJNdtCOeocCZub77/IpaHs7NxnA+9nA7BAx1PDTuTxFgo4dYHh393BsVccjX
         mdU6G4xUI7KllRmt1rzwn0Qcw7y2DJ8Rv3c/1w0e4StdeCDNF+DIj6NhohHMTUdY9P
         VKxGECvWIu1Bw==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.38])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4E8C25DF3;
        Tue, 30 Oct 2018 01:54:24 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2] ARC: IOC: panic if kernel was started with previously enabled IOC
Date:   Tue, 30 Oct 2018 11:54:21 +0300
Message-Id: <20181030085421.7657-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If IOC was already enabled (due to bootloader) it technically needs to
be reconfigured with aperture base,size corresponding to Linux memory
map which will certainly be different than uboot's. But disabling and
reenabling IOC when DMA might be potentially active is tricky business.
To avoid random memory issues later, just panic here and ask user to
upgrade bootloader to one which doesn't enable IOC.

This was actually seen as issue on some of the HSDK board with a version
of uboot which enabled IOC. There were random issues later with starting
of X or peripherals etc.

Also while I'm at it, replace hardcoded bits in ARC_REG_IO_COH_PARTIAL
and ARC_REG_IO_COH_ENABLE registers by definitions.

Inspired by: https://lkml.org/lkml/2018/1/19/557
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v1->v2:
 * Fix regression: check for IOC existence before accessing to any IOC
   register.

 arch/arc/include/asm/cache.h |  2 ++
 arch/arc/mm/cache.c          | 25 ++++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arc/include/asm/cache.h b/arch/arc/include/asm/cache.h
index ff7d3232764a..f393b663413e 100644
--- a/arch/arc/include/asm/cache.h
+++ b/arch/arc/include/asm/cache.h
@@ -113,7 +113,9 @@ extern unsigned long perip_base, perip_end;
 
 /* IO coherency related Auxiliary registers */
 #define ARC_REG_IO_COH_ENABLE	0x500
+#define ARC_IO_COH_ENABLE_BIT	BIT(0)
 #define ARC_REG_IO_COH_PARTIAL	0x501
+#define ARC_IO_COH_PARTIAL_BIT	BIT(0)
 #define ARC_REG_IO_COH_AP0_BASE	0x508
 #define ARC_REG_IO_COH_AP0_SIZE	0x509
 
diff --git a/arch/arc/mm/cache.c b/arch/arc/mm/cache.c
index f2701c13a66b..1b913c90676a 100644
--- a/arch/arc/mm/cache.c
+++ b/arch/arc/mm/cache.c
@@ -1144,6 +1144,25 @@ noinline void __init arc_ioc_setup(void)
 {
 	unsigned int ioc_base, mem_sz;
 
+	/*
+	 * Disabling and reconfiguring of IOC are quite a tricky actions because
+	 * nobody knows what happens if there're IOC-ahndled tarnsactions in
+	 * flight when we're disabling IOC.
+	 *
+	 * And the problem is external DMA masters [that were initialized and
+	 * set in a bootlaoder that was executed before we got here] might
+	 * continue to send data to memory even at this point and we have
+	 * no way to prevent that.
+	 *
+	 * That said it's much safer to not enable IOC at all anywhere before
+	 * Linux kernel.
+	 */
+	if (read_aux_reg(ARC_REG_IO_COH_ENABLE) & ARC_IO_COH_ENABLE_BIT)
+		panic("kernel was started with previously enabled IOC!\n");
+
+	if (!ioc_enable)
+		return;
+
 	/*
 	 * As for today we don't support both IOC and ZONE_HIGHMEM enabled
 	 * simultaneously. This happens because as of today IOC aperture covers
@@ -1187,8 +1206,8 @@ noinline void __init arc_ioc_setup(void)
 		panic("IOC Aperture start must be aligned to the size of the aperture");
 
 	write_aux_reg(ARC_REG_IO_COH_AP0_BASE, ioc_base >> 12);
-	write_aux_reg(ARC_REG_IO_COH_PARTIAL, 1);
-	write_aux_reg(ARC_REG_IO_COH_ENABLE, 1);
+	write_aux_reg(ARC_REG_IO_COH_PARTIAL, ARC_IO_COH_PARTIAL_BIT);
+	write_aux_reg(ARC_REG_IO_COH_ENABLE, ARC_IO_COH_ENABLE_BIT);
 
 	/* Re-enable L1 dcache */
 	__dc_enable();
@@ -1265,7 +1284,7 @@ void __init arc_cache_init_master(void)
 	if (is_isa_arcv2() && l2_line_sz && !slc_enable)
 		arc_slc_disable();
 
-	if (is_isa_arcv2() && ioc_enable)
+	if (is_isa_arcv2() && ioc_exists)
 		arc_ioc_setup();
 
 	if (is_isa_arcv2() && l2_line_sz && slc_enable) {
-- 
2.14.5

