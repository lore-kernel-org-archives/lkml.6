Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1DFC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D44E2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TilB8SNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfBFRWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:22:44 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:39480 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfBFRWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:22:42 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 1252724E01E4;
        Wed,  6 Feb 2019 09:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549473762; bh=Y/iatXLwSHYSQr3Aro3fvmipnWzxbGhc11jlmvHQz/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TilB8SNvVQ3f5sSylI9sINuJZYBDatCKoxKsGbOVFzxUE+wWldYLV/rfTu053CR8c
         CdJ80WWCXsj3quADItwocQx8DaHOpakn6iP5ltDopC8352MuKhfkzCSJEiLb732KMT
         xuEc7ZHi5D/72YojIT4MvBM9KHkYf/ZFwqIJmSzmPJC7l53DrNMMChxvEjjlD7mtsn
         d1sgSdvR/J25Z5IRqoEhgMyQpK52ZyX1Eeo/At/50uYJwg6a3OjIW1gLJ9H1qvtGdm
         xlNWi1vThLX+ojD4VZ90ZIuZHZd3cJbEU2NBDC5eAZsM9DdZwEhvGikGH75TAVr5XV
         och84dR6Q9YqA==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5B197A0090;
        Wed,  6 Feb 2019 17:22:39 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>, khilman@baylibre.com,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [RFC 2/2] ARC: U-boot: check magic number passed from u-boot
Date:   Wed,  6 Feb 2019 20:22:28 +0300
Message-Id: <20190206172228.9261-3-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190206172228.9261-1-Eugeniy.Paltsev@synopsys.com>
References: <20190206172228.9261-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of devboards we really often disable bootloader and load
Linux image in memory via JTAG. In case of using kernel with
CONFIG_ARC_UBOOT_SUPPORT enabled we may crash as we will try to
interpret some junk in a registers as a pointers to bootargs/etc
which aren't set by anyone in case of JTAG using.

Try to make it much less possible by check magic number and
'U-boot - kernel' ABI revision number passed from U-boot.
Ignore U-boot arguments if we got wrong magic number or unknown
ABI revision.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/head.S  |  5 ++++-
 arch/arc/kernel/setup.c | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arc/kernel/head.S b/arch/arc/kernel/head.S
index 7095055bb874..3fb88ec62bc7 100644
--- a/arch/arc/kernel/head.S
+++ b/arch/arc/kernel/head.S
@@ -92,10 +92,13 @@ ENTRY(stext)
 
 #ifdef CONFIG_ARC_UBOOT_SUPPORT
 	; Uboot - kernel ABI
+	;    r1 = bits [31:8] magic number, bits [7:0] uboot-kernel ABI revision
+	; ABI revision 0:
 	;    r0 = [0] No uboot interaction, [1] cmdline in r2, [2] DTB in r2
-	;    r1 = magic number (board identity, unused as of now
 	;    r2 = pointer to uboot provided cmdline or external DTB in mem
 	; These are handled later in handle_uboot_args()
+	st      r1, [@uboot_rev_magic]
+	mov	r1, 0			; errase magic from the register
 	st	r0, [@uboot_tag]
 	st	r2, [@uboot_arg]
 #endif
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 7edb35c26322..868dda3d4b43 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -36,6 +36,7 @@ unsigned int intr_to_DE_cnt;
 
 /* Part of U-boot ABI: see head.S */
 int __initdata uboot_tag;
+int __initdata uboot_rev_magic;
 char __initdata *uboot_arg;
 
 const struct machine_desc *machine_desc;
@@ -467,6 +468,10 @@ static inline bool is_kernel(unsigned long addr)
 	return addr >= (unsigned long)_stext && addr <= (unsigned long)_end;
 }
 
+#define UBOOT_MAGIC_VALUE		0x567890
+#define UBOOT_MAGIC_GET(x)		(((x) & GENMASK(31, 8)) >> 8)
+#define UBOOT_REVISION_GET(x)		((x) & GENMASK(7, 0))
+
 /* uboot_tag values for U-boot - kernel ABI revisions 0+; see head.S */
 #define UBOOT_REV0P_TAG_NONE		0
 #define UBOOT_REV0P_TAG_CMDLINE		1
@@ -478,6 +483,25 @@ void __init handle_uboot_args(void)
 	bool use_embedded_dtb = true;
 
 #ifdef CONFIG_ARC_UBOOT_SUPPORT
+	/* check that we got correct magic */
+	if (UBOOT_MAGIC_GET(uboot_rev_magic) != UBOOT_MAGIC_VALUE) {
+		pr_warn("Invalid magic '%06lx' is passed from uboot, uboot args ingnored\n",
+			UBOOT_MAGIC_GET(uboot_rev_magic));
+
+		goto ignore_uboot_args;
+	}
+
+	/*
+	 * check that we know this U-boot args ABI revision.
+	 * as for today we only have one revision - '0'.
+	 */
+	if (UBOOT_REVISION_GET(uboot_rev_magic) != 0) {
+		pr_warn("Unknown args revision '%02lx' is passed from uboot, uboot args ingnored\n",
+			UBOOT_REVISION_GET(uboot_rev_magic));
+
+		goto ignore_uboot_args;
+	}
+
 	/* check that we know this tag */
 	if (uboot_tag != UBOOT_REV0P_TAG_NONE &&
 	    uboot_tag != UBOOT_REV0P_TAG_CMDLINE &&
@@ -498,6 +522,8 @@ void __init handle_uboot_args(void)
 
 	if (uboot_tag == UBOOT_REV0P_TAG_CMDLINE)
 		append_boot_cmdline = true;
+
+ignore_uboot_args:
 #endif
 
 	if (use_embedded_dtb) {
-- 
2.14.5

