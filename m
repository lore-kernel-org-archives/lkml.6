Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A57C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E26820989
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E26820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbeKHCdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:33:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46482 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbeKHCdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:33:45 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n508EH8XCJfM; Wed,  7 Nov 2018 18:02:30 +0100 (CET)
Received: from zn.tnic (p200300EC2BCBE000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:e000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0F0C1EC0291;
        Wed,  7 Nov 2018 18:02:30 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/16] x86/microcode/AMD: Add microcode container verification
Date:   Wed,  7 Nov 2018 18:02:04 +0100
Message-Id: <20181107170218.7596-3-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107170218.7596-1-bp@alien8.de>
References: <20181107170218.7596-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>

Add container and patch verification functions to the AMD microcode
update driver.

These functions check whether a passed buffer contains the relevant
structure, whether it isn't truncated and (for actual microcode patches)
whether the size of a patch is not too large for a particular CPU family.
By adding these checks as separate functions the actual microcode loading
code won't get interspersed with a lot of checks and so will be more
readable.

 [ bp: Make all pr_err() calls into pr_debug(). ]

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/3014e96c82cd90761b4601bd2cfe59c4119e46a7.1529424596.git.mail@maciej.szmigiero.name
[ Drop the verify_patch() bits. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 101 ++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index b44c9029860c..36aeb01b3ae8 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -73,6 +73,107 @@ static u16 find_equiv_id(struct equiv_cpu_entry *equiv_table, u32 sig)
 	return 0;
 }
 
+/*
+ * Check whether there is a valid microcode container file at the beginning
+ * of @buf of size @buf_size. Set @early to use this function in the early path.
+ */
+static bool verify_container(const u8 *buf, size_t buf_size, bool early)
+{
+	u32 cont_magic;
+
+	if (buf_size <= CONTAINER_HDR_SZ) {
+		if (!early)
+			pr_debug("Truncated microcode container header.\n");
+
+		return false;
+	}
+
+	cont_magic = *(const u32 *)buf;
+	if (cont_magic != UCODE_MAGIC) {
+		if (!early)
+			pr_debug("Invalid magic value (0x%08x).\n", cont_magic);
+
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * Check whether there is a valid, non-truncated CPU equivalence table at the
+ * beginning of @buf of size @buf_size. Set @early to use this function in the
+ * early path.
+ */
+static bool verify_equivalence_table(const u8 *buf, size_t buf_size, bool early)
+{
+	const u32 *hdr = (const u32 *)buf;
+	u32 cont_type, equiv_tbl_len;
+
+	if (!verify_container(buf, buf_size, early))
+		return false;
+
+	cont_type = hdr[1];
+	if (cont_type != UCODE_EQUIV_CPU_TABLE_TYPE) {
+		if (!early)
+			pr_debug("Wrong microcode container equivalence table type: %u.\n",
+			       cont_type);
+
+		return false;
+	}
+
+	buf_size -= CONTAINER_HDR_SZ;
+
+	equiv_tbl_len = hdr[2];
+	if (equiv_tbl_len < sizeof(struct equiv_cpu_entry) ||
+	    buf_size < equiv_tbl_len) {
+		if (!early)
+			pr_debug("Truncated equivalence table.\n");
+
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * Check whether there is a valid, non-truncated microcode patch section at the
+ * beginning of @buf of size @buf_size. Set @early to use this function in the
+ * early path.
+ */
+static bool verify_patch_section(const u8 *buf, size_t buf_size, bool early)
+{
+	const u32 *hdr;
+	u32 patch_type, patch_size;
+
+	if (buf_size < SECTION_HDR_SIZE) {
+		if (!early)
+			pr_debug("Truncated patch section.\n");
+
+		return false;
+	}
+
+	hdr = (const u32 *)buf;
+	patch_type = hdr[0];
+	patch_size = hdr[1];
+
+	if (patch_type != UCODE_UCODE_TYPE) {
+		if (!early)
+			pr_debug("Invalid type field (0x%x) in container file section header.\n",
+				patch_type);
+
+		return false;
+	}
+
+	if (patch_size < sizeof(struct microcode_header_amd)) {
+		if (!early)
+			pr_debug("Patch of size %u too short.\n", patch_size);
+
+		return false;
+	}
+
+	return true;
+}
+
 /*
  * This scans the ucode blob for the proper container as we can have multiple
  * containers glued together. Returns the equivalence ID from the equivalence
-- 
2.19.1

