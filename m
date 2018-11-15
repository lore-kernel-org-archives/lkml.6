Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0939C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799ED2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799ED2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbeKOTfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:35:23 -0500
Received: from inva021.nxp.com ([92.121.34.21]:37368 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbeKOTfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:35:23 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7324820013D;
        Thu, 15 Nov 2018 10:28:21 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0AFE820012F;
        Thu, 15 Nov 2018 10:28:17 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5472D402AC;
        Thu, 15 Nov 2018 17:28:11 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     yinbo.zhu@nxp.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Cc:     xiaobo.xie@nxp.com, ran.wang_1@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Rajesh Bhagat <rajesh.bhagat@nxp.com>
Subject: [PATCH v1] arch: arm64: add ARM64 specific fucntions required for ehci fsl driver
Date:   Thu, 15 Nov 2018 17:23:57 +0800
Message-Id: <20181115092357.1556-1-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajesh Bhagat <rajesh.bhagat@nxp.com>

Add set/clear bits functions for ARM platform which are used by ehci fsl
driver

Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 arch/arm64/include/asm/io.h |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index e97b861..0dc4334 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -185,6 +185,35 @@ extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
 #define iowrite32be(v,p)	({ __iowmb(); __raw_writel((__force __u32)cpu_to_be32(v), p); })
 #define iowrite64be(v,p)	({ __iowmb(); __raw_writeq((__force __u64)cpu_to_be64(v), p); })
 
+/* access ports */
+#define setbits32(_addr, _v) iowrite32be(ioread32be(_addr) |  (_v), (_addr))
+#define clrbits32(_addr, _v) iowrite32be(ioread32be(_addr) & ~(_v), (_addr))
+
+#define setbits16(_addr, _v) iowrite16be(ioread16be(_addr) |  (_v), (_addr))
+#define clrbits16(_addr, _v) iowrite16be(ioread16be(_addr) & ~(_v), (_addr))
+
+#define setbits8(_addr, _v) iowrite8(ioread8(_addr) |  (_v), (_addr))
+#define clrbits8(_addr, _v) iowrite8(ioread8(_addr) & ~(_v), (_addr))
+
+/* Clear and set bits in one shot.  These macros can be used to clear and
+ * set multiple bits in a register using a single read-modify-write.  These
+ * macros can also be used to set a multiple-bit bit pattern using a mask,
+ * by specifying the mask in the 'clear' parameter and the new bit pattern
+ * in the 'set' parameter.
+ */
+
+#define clrsetbits_be32(addr, clear, set) \
+	iowrite32be((ioread32be(addr) & ~(clear)) | (set), (addr))
+#define clrsetbits_le32(addr, clear, set) \
+	iowrite32le((ioread32le(addr) & ~(clear)) | (set), (addr))
+#define clrsetbits_be16(addr, clear, set) \
+	iowrite16be((ioread16be(addr) & ~(clear)) | (set), (addr))
+#define clrsetbits_le16(addr, clear, set) \
+	iowrite16le((ioread16le(addr) & ~(clear)) | (set), (addr))
+#define clrsetbits_8(addr, clear, set) \
+	iowrite8((ioread8(addr) & ~(clear)) | (set), (addr))
+
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
-- 
1.7.1

