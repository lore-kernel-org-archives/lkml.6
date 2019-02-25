Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2521C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9AD217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129535;
	bh=BCQGmIiu0/LxnhVuvAKkfDsO2+62rDXcEN24uUT2h0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fELGWxCGLvM1dM2fMx8Ss8cilBUAtkGHh0b4F0IR0DYMNl7YHE7z6b0BgRmvKFb45
	 IJ7clTzx+1h5/bi6cTAP5+tuxOxe6KVt9wHzwFETybc3ke25aeA6VWvJpVOCbny8GG
	 mbS4e+v/He4lqp7+0yiSyQ1Cp7bczahpQmzTJHU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfBYVSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:18:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:51550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730187AbfBYVSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:18:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 237FF2173C;
        Mon, 25 Feb 2019 21:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129529;
        bh=BCQGmIiu0/LxnhVuvAKkfDsO2+62rDXcEN24uUT2h0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BcmK0bC7vP+r+LYWjPuuggNZ/u1i+Qnu/boNz6hXd1LWUML0rcQ8YnYCIE9wVDOLB
         SBlbFbqQ4Y9oq9FMbfUtoBitp8DPED+t8EEEWVZTgXWNL7qB5R+F9CeDyIM0S0nhBo
         iVTYAnH/n3cv+BXPfJ0wb8IoZWITYasQ+x9kfrBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corentin LABBE <clabbe@baylibre.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 4.14 60/71] ARC: U-boot: check arguments paranoidly
Date:   Mon, 25 Feb 2019 22:12:02 +0100
Message-Id: <20190225195039.161330959@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

commit a66f2e57bd566240d8b3884eedf503928fbbe557 upstream.

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

Cc: stable@vger.kernel.org
Tested-by: Corentin LABBE <clabbe@baylibre.com>
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/kernel/head.S  |    4 +-
 arch/arc/kernel/setup.c |   89 +++++++++++++++++++++++++++++++++---------------
 2 files changed, 65 insertions(+), 28 deletions(-)

--- a/arch/arc/kernel/head.S
+++ b/arch/arc/kernel/head.S
@@ -103,9 +103,9 @@ ENTRY(stext)
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
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -414,43 +414,80 @@ void setup_processor(void)
 	arc_chk_core_config();
 }
 
-static inline int is_kernel(unsigned long addr)
+static inline bool uboot_arg_invalid(unsigned long addr)
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
+	return addr >= (unsigned long)_stext && addr <= (unsigned long)_end;
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
-
-	/* See if u-boot passed an external Device Tree blob */
-	machine_desc = setup_machine_fdt(uboot_arg);	/* uboot_tag == 2 */
-	if (!machine_desc)
+	/* check that we know this tag */
+	if (uboot_tag != UBOOT_TAG_NONE &&
+	    uboot_tag != UBOOT_TAG_CMDLINE &&
+	    uboot_tag != UBOOT_TAG_DTB) {
+		pr_warn(IGNORE_ARGS "invalid uboot tag: '%08x'\n", uboot_tag);
+		goto ignore_uboot_args;
+	}
+
+	if (uboot_tag != UBOOT_TAG_NONE &&
+            uboot_arg_invalid((unsigned long)uboot_arg)) {
+		pr_warn(IGNORE_ARGS "invalid uboot arg: '%px'\n", uboot_arg);
+		goto ignore_uboot_args;
+	}
+
+	/* see if U-boot passed an external Device Tree blob */
+	if (uboot_tag == UBOOT_TAG_DTB) {
+		machine_desc = setup_machine_fdt((void *)uboot_arg);
+
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
+	 * NOTE: @boot_command_line is populated by setup_machine_fdt() so this
+	 * append processing can only happen after.
+	 */
+	if (append_cmdline) {
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


