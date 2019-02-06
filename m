Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C46C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285492081B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TJWNLa2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfBFRWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:22:40 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:39474 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfBFRWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:22:39 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id C627D24E0823;
        Wed,  6 Feb 2019 09:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549473758; bh=KuLUmrRIpDBisiiey89ewnqfovSewf7V3Z8GihPSOCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TJWNLa2sU+cE82Zo94Bx9D5nfaPxe8kedLfCacRcbqZ2B/9tcw51KGFngMrwz670N
         dCw6c1h8sq2jM+k5HhDI+aLwROJD0EVXgSpvRSheSb+AymkBDx+kHEAYl1T6uV5jt8
         kOkhAw+hJ0wW5veHQ/84kzXEJvhHlfmMGiro7rkvlUqomPp7g2xg3sBMcr0i5/MX0N
         s+WX5QkDs0MquhJB9iL5lXtdoN9gUhpryHLKqRHCquHRP8xFHD1DHmevIudhK7U7qa
         84gH+G8qC/24uWJM0W7839uIhBr0T6toJnXpDr+mJ1wuZzqUAdkHe0BFe5CTbEzBav
         dNabOAPW5Gqug==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id EE403A0090;
        Wed,  6 Feb 2019 17:22:35 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>, khilman@baylibre.com,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [RFC 1/2] ARC: U-boot: check arguments paranoidly
Date:   Wed,  6 Feb 2019 20:22:27 +0300
Message-Id: <20190206172228.9261-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190206172228.9261-1-Eugeniy.Paltsev@synopsys.com>
References: <20190206172228.9261-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle U-boot arguments paranoidly:
 * don't allow to pass unknown tag.
 * try to use external device tree blob only if corresponding tag
   (TAG_DTB) is set.
 * don't check: uboot_tag if kernel build with no ARC_UBOOT_SUPPORT.

While I'm at it refactor U-boot arguments handling code.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/head.S  |  2 +-
 arch/arc/kernel/setup.c | 65 ++++++++++++++++++++++++++++++++-----------------
 2 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/arch/arc/kernel/head.S b/arch/arc/kernel/head.S
index 8b90d25a15cc..7095055bb874 100644
--- a/arch/arc/kernel/head.S
+++ b/arch/arc/kernel/head.S
@@ -95,7 +95,7 @@ ENTRY(stext)
 	;    r0 = [0] No uboot interaction, [1] cmdline in r2, [2] DTB in r2
 	;    r1 = magic number (board identity, unused as of now
 	;    r2 = pointer to uboot provided cmdline or external DTB in mem
-	; These are handled later in setup_arch()
+	; These are handled later in handle_uboot_args()
 	st	r0, [@uboot_tag]
 	st	r2, [@uboot_arg]
 #endif
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index feb90093e6b1..7edb35c26322 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -462,43 +462,64 @@ void setup_processor(void)
 	arc_chk_core_config();
 }
 
-static inline int is_kernel(unsigned long addr)
+static inline bool is_kernel(unsigned long addr)
 {
-	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_end)
-		return 1;
-	return 0;
+	return addr >= (unsigned long)_stext && addr <= (unsigned long)_end;
 }
 
-void __init setup_arch(char **cmdline_p)
+/* uboot_tag values for U-boot - kernel ABI revisions 0+; see head.S */
+#define UBOOT_REV0P_TAG_NONE		0
+#define UBOOT_REV0P_TAG_CMDLINE		1
+#define UBOOT_REV0P_TAG_DTB		2
+
+void __init handle_uboot_args(void)
 {
+	bool append_boot_cmdline = false;
+	bool use_embedded_dtb = true;
+
 #ifdef CONFIG_ARC_UBOOT_SUPPORT
+	/* check that we know this tag */
+	if (uboot_tag != UBOOT_REV0P_TAG_NONE &&
+	    uboot_tag != UBOOT_REV0P_TAG_CMDLINE &&
+	    uboot_tag != UBOOT_REV0P_TAG_DTB)
+		panic("Invalid uboot tag: '%08x'\n", uboot_tag);
+
 	/* make sure that uboot passed pointer to cmdline/dtb is valid */
-	if (uboot_tag && is_kernel((unsigned long)uboot_arg))
+	if (uboot_tag != UBOOT_REV0P_TAG_NONE && is_kernel((unsigned long)uboot_arg))
 		panic("Invalid uboot arg\n");
 
 	/* See if u-boot passed an external Device Tree blob */
-	machine_desc = setup_machine_fdt(uboot_arg);	/* uboot_tag == 2 */
-	if (!machine_desc)
+	if (uboot_tag == UBOOT_REV0P_TAG_DTB) {
+		machine_desc = setup_machine_fdt(uboot_arg);
+
+		/* external Device Tree blob is invalid - use embedded one */
+		use_embedded_dtb = !machine_desc;
+	}
+
+	if (uboot_tag == UBOOT_REV0P_TAG_CMDLINE)
+		append_boot_cmdline = true;
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
+	 * If we are here, U-boot says that @uboot_arg is cmdline, so append it
+	 * to embedded DT cmdline.
+	 */
+	if (append_boot_cmdline) {
+		/* Ensure a whitespace between the 2 cmdlines */
+		strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+		strlcat(boot_command_line, uboot_arg, COMMAND_LINE_SIZE);
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

