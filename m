Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADE4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA92626C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA92626C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965893AbeFZOQp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:16:45 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:57926 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934518AbeFZOQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:16:43 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie3.idc.renesas.com with ESMTP; 26 Jun 2018 23:16:42 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id 1911E84C91;
        Tue, 26 Jun 2018 23:16:42 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,274,1526310000"; 
   d="scan'208";a="283643696"
Received: from unknown (HELO fabrizio-dev.ree.adwin.renesas.com) ([10.226.36.229])
  by relmlii1.idc.renesas.com with ESMTP; 26 Jun 2018 23:16:39 +0900
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] ARM: Debug kernel copy by printing
Date:   Tue, 26 Jun 2018 15:16:35 +0100
Message-Id: <1530022595-6806-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It may happen that when we relocate the kernel we corrupt other
sensible memory (e.g. the memory needed by U-Boot for dealing
with bootm command) while copying the kernel. If we overwrite
the content of the memory area used by U-Boot's command bootm
(described by U-Boot's parameters bootm_low and bootm_size),
the kernel won't be able to boot. Troubleshooting the problem
then is not straightforward.

This commit allows the user to easily print information on
where the kernel gets copied from/to in order to help with the
design of the system memory map (e.g. bootm_low and bootm_size)
at boot up.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Acked-by: Biju Das <biju.das@bp.renesas.com>
---
Dear All,

shmobile_defconfig doesn't use kernel modules, everything gets
built-in. iwg20d and iwg22d platforms from iWave use uImage
to boot, DRAM starts at address 0x40000000, the kernel gets
loaded up in memory at address 0x40007fc0, bootm_low is
0x40e00000, and bootm_size is 0x100000.

The kernel is getting larger and larger, so much so that during
the relocation the kernel is copying itself right where the
bootm memory area lives, preventing Linux from booting.
Here is what this patch prints when applied on top of tag
next-20180625 and running on the iwg22d:

C:0x400080C0-0x404922A0->0x40E90800-0x4131A9E0

The designer then has to pick up a suitable memory range for
bootm memory area to fix this, but the only way to successfully
achieve this is by knowing where the kernel is going to copy
itself in memory, so that he can stay clear of it.

Other platforms that use the same defconfig suffer from the same
issue (e.g. Koelsch et al.) as they have been designed some time
ago or the original BSP was based on an LTS kernel.

Debugging this basically requires a JTAG debugger at this stage.

Do you think this patch could be considered acceptable? If not,
what would be the best way to get useful/sensible/debug
information out of the kernel when the problem occours?

Comments welcome!

Thanks,
Fab

 arch/arm/boot/compressed/head.S | 43 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 517e0e1..6c7ccb4 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -114,6 +114,35 @@
 #endif
 		.endm
 
+		/*
+		 * Debug kernel copy by printing the memory addresses involved
+		 */
+		.macro dbgkc, begin, end, cbegin, cend
+#ifdef DEBUG
+		kputc   #'\n'
+		kputc   #'C'
+		kputc   #':'
+		kputc   #'0'
+		kputc   #'x'
+		kphex   \begin, 8	/* Start of compressed kernel */
+		kputc	#'-'
+		kputc	#'0'
+		kputc	#'x'
+		kphex	\end, 8		/* End of compressed kernel */
+		kputc	#'-'
+		kputc	#'>'
+		kputc   #'0'
+		kputc   #'x'
+		kphex   \cbegin, 8	/* Start of kernel copy */
+		kputc	#'-'
+		kputc	#'0'
+		kputc	#'x'
+		kphex	\cend, 8	/* End of kernel copy */
+		kputc	#'\n'
+		kputc	#'\r'
+#endif
+		.endm
+
 		.section ".start", #alloc, #execinstr
 /*
  * sort out different calling conventions
@@ -450,6 +479,20 @@ dtb_check_done:
 		add	r6, r9, r5
 		add	r9, r9, r10
 
+#ifdef DEBUG
+		sub     r10, r6, r5
+		sub     r10, r9, r10
+		/*
+		 * We are about to copy the kernel to a new memory area.
+		 * The boundaries of the new memory area can be found in
+		 * r10 and r9, whilst r5 and r6 contain the boundaries
+		 * of the memory we are going to copy.
+		 * Calling dbgkc will help with the printing of this
+		 * information.
+		 */
+		dbgkc	r5, r6, r10, r9
+#endif
+
 1:		ldmdb	r6!, {r0 - r3, r10 - r12, lr}
 		cmp	r6, r5
 		stmdb	r9!, {r0 - r3, r10 - r12, lr}
-- 
2.7.4

