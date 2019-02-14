Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDD9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E2E20823
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="F62PY2Z5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407067AbfBNPHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:07:54 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:51434 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387401AbfBNPHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:07:52 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id D09C810C1460;
        Thu, 14 Feb 2019 07:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550156871; bh=+rtFQsDv1qS2JYlxqCMt0DuNEcbwFqFCv5EUH9oDx1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F62PY2Z523FGZESfUy/bzC4Cdyg4yoTWcICcAzk0AUX6Xl1hHbHbeIbOA18f2nsdR
         Nr9olQdbdKP0aRPi4ppof1qOajBWZLcX75c2/6JjNbRY8QPWSmUtZxMPcvAKP1DDEx
         W76Knh6goQgTDUXgAbhGgUVLyegs1Ofv3dyepcz88xqnR3L3zdIKMTs5gp6HwkxVGH
         1Ag1ecUAFel2+pVJGBTfWJtV+taDsXvjAcJXI6P9HtM7OuquDoDqVik+2+GE23V+KW
         RIJJppAv702m0A2itzCveOQUtKXcdJjIfi4Lm2Kh4TYCNPISwNEjMWkhK3wqjoXBZ9
         xyDlm85h6xOqA==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.62])
        by mailhost.synopsys.com (Postfix) with ESMTP id CBBA5A0091;
        Thu, 14 Feb 2019 15:07:49 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>, khilman@baylibre.com,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH v2 1/2] ARC: U-boot: check arguments paranoidly
Date:   Thu, 14 Feb 2019 18:07:44 +0300
Message-Id: <20190214150745.18773-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190214150745.18773-1-Eugeniy.Paltsev@synopsys.com>
References: <20190214150745.18773-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle U-boot arguments paranoidly:
 * don't allow to pass unknown tag.
 * try to use external device tree blob only if corresponding tag
   (TAG_DTB) is set.
 * don't check uboot_tag if kernel build with no ARC_UBOOT_SUPPORT.

NOTE:
If U-boot args are invalid we skip them and try to use embedded device
tree blob. We can't panic on invalid U-boot args as we really pass
invalid args due to bug in U-boot code.
This happens if we don't provide external DTB to U-boot and
don't set 'bootargs' U-boot environment variable (which is default
case at least for HSDK board) In that case we will pass
{r0 = 1 (bootargs in r2); r1 = 0; r2 = 0;} to linux which is invalid.

While I'm at it refactor U-boot arguments handling code.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/head.S  |  4 +--
 arch/arc/kernel/setup.c | 90 +++++++++++++++++++++++++++++++++++--------------
 2 files changed, 66 insertions(+), 28 deletions(-)

diff --git a/arch/arc/kernel/head.S b/arch/arc/kernel/head.S
index 8b90d25a15cc..d45b862be05c 100644
--- a/arch/arc/kernel/head.S
+++ b/arch/arc/kernel/head.S
@@ -93,9 +93,9 @@ ENTRY(stext)
 #ifdef CONFIG_ARC_UBOOT_SUPPORT
 	; Uboot - kernel ABI
 	;    r0 = [0] No uboot interaction, [1] cmdline in r2, [2] DTB in r2
-	;    r1 = magic number (board identity, unused as of now
+	;    r1 = magic number (always zero as of now)
 	;    r2 = pointer to uboot provided cmdline or external DTB in mem
-	; These are handled later in setup_arch()
+	; These are handled later in handle_uboot_args()
 	st	r0, [@uboot_tag]
 	st	r2, [@uboot_arg]
 #endif
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index feb90093e6b1..88a885db9bb8 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -36,7 +36,7 @@ unsigned int intr_to_DE_cnt;
 
 /* Part of U-boot ABI: see head.S */
 int __initdata uboot_tag;
-char __initdata *uboot_arg;
+unsigned int __initdata uboot_arg;
 
 const struct machine_desc *machine_desc;
 
@@ -462,43 +462,81 @@ void setup_processor(void)
 	arc_chk_core_config();
 }
 
-static inline int is_kernel(unsigned long addr)
+static inline bool uboot_arg_invalid(unsigned int addr)
 {
-	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_end)
-		return 1;
-	return 0;
+	/*
+	 * Check that it is a untranslated address (although MMU is not enabled
+	 * yet, it being a high address ensures this is not by fluke)
+	 */
+	if (addr < PAGE_OFFSET)
+		return true;
+
+	/* Check that address doesn't clobber resident kernel image */
+	return addr >= (unsigned int)_stext && addr <= (unsigned int)_end;
 }
 
-void __init setup_arch(char **cmdline_p)
+#define IGNORE_ARGS		"Ignore U-boot args: "
+
+/* uboot_tag values for U-boot - kernel ABI revision 0; see head.S */
+#define UBOOT_TAG_NONE		0
+#define UBOOT_TAG_CMDLINE	1
+#define UBOOT_TAG_DTB		2
+
+void __init handle_uboot_args(void)
 {
+	bool use_embedded_dtb = true;
+	bool append_cmdline = false;
+
 #ifdef CONFIG_ARC_UBOOT_SUPPORT
-	/* make sure that uboot passed pointer to cmdline/dtb is valid */
-	if (uboot_tag && is_kernel((unsigned long)uboot_arg))
-		panic("Invalid uboot arg\n");
+	/* check that we know this tag */
+	if (uboot_tag != UBOOT_TAG_NONE &&
+	    uboot_tag != UBOOT_TAG_CMDLINE &&
+	    uboot_tag != UBOOT_TAG_DTB) {
+		pr_warn(IGNORE_ARGS "invalid uboot tag: '%08x'\n", uboot_tag);
+		goto ignore_uboot_args;
+	}
+
+	if (uboot_tag != UBOOT_TAG_NONE && uboot_arg_invalid(uboot_arg)) {
+		pr_warn(IGNORE_ARGS "invalid uboot arg: '%08x'\n", uboot_arg);
+		goto ignore_uboot_args;
+	}
+
+	/* see if U-boot passed an external Device Tree blob */
+	if (uboot_tag == UBOOT_TAG_DTB) {
+		machine_desc = setup_machine_fdt((void *)uboot_arg);
 
-	/* See if u-boot passed an external Device Tree blob */
-	machine_desc = setup_machine_fdt(uboot_arg);	/* uboot_tag == 2 */
-	if (!machine_desc)
+		/* external Device Tree blob is invalid - use embedded one */
+		use_embedded_dtb = !machine_desc;
+	}
+
+	if (uboot_tag == UBOOT_TAG_CMDLINE)
+		append_cmdline = true;
+
+ignore_uboot_args:
 #endif
-	{
-		/* No, so try the embedded one */
+
+	if (use_embedded_dtb) {
 		machine_desc = setup_machine_fdt(__dtb_start);
 		if (!machine_desc)
 			panic("Embedded DT invalid\n");
+	}
 
-		/*
-		 * If we are here, it is established that @uboot_arg didn't
-		 * point to DT blob. Instead if u-boot says it is cmdline,
-		 * append to embedded DT cmdline.
-		 * setup_machine_fdt() would have populated @boot_command_line
-		 */
-		if (uboot_tag == 1) {
-			/* Ensure a whitespace between the 2 cmdlines */
-			strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
-			strlcat(boot_command_line, uboot_arg,
-				COMMAND_LINE_SIZE);
-		}
+	/*
+	 * If we are here, it is established that @uboot_arg points to cmdline,
+	 * which should be appended to embedded DT cmdline.
+	 * NOTE: Don't move the cmdline processing before embedded DT processing
+	 * since we rely on @boot_command_line populating by setup_machine_fdt()
+	 */
+	if (append_cmdline) {
+		/* Ensure a whitespace between the 2 cmdlines */
+		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+		strlcat(boot_command_line, (char *)uboot_arg, COMMAND_LINE_SIZE);
 	}
+}
+
+void __init setup_arch(char **cmdline_p)
+{
+	handle_uboot_args();
 
 	/* Save unparsed command line copy for /proc/cmdline */
 	*cmdline_p = boot_command_line;
-- 
2.14.5

