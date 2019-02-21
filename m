Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3F5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA822083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="nbAm42HY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfBUWnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:43:22 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40396 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfBUWnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1550788999; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=AoP52D/tICJ3bRLNmIOxk1RnsAknvX4p09ko1Ac3Izs=;
        b=nbAm42HYVX5FH97/NBS1ukdFDS/X+yTHyHrGIAryjH64c4PuvbmfRfwUGvaCZ5VE9BW3Q9
        DjVCSKlipH0sZ5LppTjiY8FAgp1FIaKuIgX3lQ8nmDcbGVjahzzEDZ9qJzNg8nkU5Ctam7
        ZjuSJ5aGQrGwrhP6L+lKOKAOJImHjYc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2] MIPS: ingenic: Add support for appended devicetree
Date:   Thu, 21 Feb 2019 19:43:10 -0300
Message-Id: <20190221224310.9507-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for booting the kernel from an externally-appended
devicetree, if no devicetree was built-in.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: Use fw_passed_dtb instead of __appended_dtb

 arch/mips/Kconfig        |  2 +-
 arch/mips/jz4740/setup.c | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index a84c24d894aa..8b7ea9062198 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -391,7 +391,7 @@ config MACH_INGENIC
 	select GPIOLIB
 	select COMMON_CLK
 	select GENERIC_IRQ_CHIP
-	select BUILTIN_DTB
+	select BUILTIN_DTB if MIPS_NO_APPENDED_DTB
 	select USE_OF
 	select LIBFDT
 
diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
index afb40f8bce96..7e63c54eb8d2 100644
--- a/arch/mips/jz4740/setup.c
+++ b/arch/mips/jz4740/setup.c
@@ -31,7 +31,6 @@
 
 #define JZ4740_EMC_SDRAM_CTRL 0x80
 
-
 static void __init jz4740_detect_mem(void)
 {
 	void __iomem *jz_emc_base;
@@ -66,15 +65,22 @@ static unsigned long __init get_board_mach_type(const void *fdt)
 void __init plat_mem_setup(void)
 {
 	int offset;
+	void *dtb;
 
 	jz4740_reset_init();
-	__dt_setup_arch(__dtb_start);
 
-	offset = fdt_path_offset(__dtb_start, "/memory");
+	if (__dtb_start != __dtb_end)
+		dtb = __dtb_start;
+	else
+		dtb = (void *)fw_passed_dtb;
+
+	__dt_setup_arch(dtb);
+
+	offset = fdt_path_offset(dtb, "/memory");
 	if (offset < 0)
 		jz4740_detect_mem();
 
-	mips_machtype = get_board_mach_type(__dtb_start);
+	mips_machtype = get_board_mach_type(dtb);
 }
 
 void __init device_tree_init(void)
-- 
2.11.0

