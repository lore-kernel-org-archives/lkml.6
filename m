Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AA1C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A5820020
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A5820020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030550AbeFSSsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:48:53 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:39704 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030435AbeFSSrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:47:52 -0400
Received: by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1fVLfI-0003Vs-2y; Tue, 19 Jun 2018 20:47:40 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/9] x86/microcode/AMD: Add microcode container data checking functions
Date:   Tue, 19 Jun 2018 20:47:32 +0200
Message-Id: <3014e96c82cd90761b4601bd2cfe59c4119e46a7.1529424596.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529424596.git.mail@maciej.szmigiero.name>
References: <cover.1529424596.git.mail@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add verify_container(), verify_equivalence_table(), verify_patch_section()
and verify_patch() functions to the AMD microcode update driver.

These functions check whether a passed buffer contains the relevant
structure, whether it isn't truncated and (for actual microcode patches)
whether the size of a patch is not too large for a particular CPU family.
By adding these checks as separate functions the actual microcode loading
code won't get interspersed with a lot of checks and so will be more
readable.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 180 +++++++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index dc8ea9a9d962..120778771909 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -73,6 +73,182 @@ static u16 find_equiv_id(struct equiv_cpu_entry *equiv_table, u32 sig)
 	return 0;
 }
 
+/*
+ * Check whether there is a valid microcode container file at the beginning
+ * of a passed buffer @buf of size @buf_size.
+ * If @early is set do not print errors so this function is usable by the
+ * early microcode loader.
+ */
+static bool verify_container(const u8 *buf, size_t buf_size, bool early)
+{
+	u32 cont_magic;
+
+	if (buf_size <= CONTAINER_HDR_SZ) {
+		if (!early)
+			pr_err("Truncated microcode container header.\n");
+
+		return false;
+	}
+
+	cont_magic = *(const u32 *)buf;
+	if (cont_magic != UCODE_MAGIC) {
+		if (!early)
+			pr_err("Invalid magic value (0x%08x).\n", cont_magic);
+
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * Check whether there is a valid, non-truncated CPU equivalence table
+ * at the beginning of a passed buffer @buf of size @buf_size.
+ * If @early is set do not print errors so this function is usable by the
+ * early microcode loader.
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
+			pr_err("Wrong microcode container equivalence table type: %u.\n",
+			       cont_type);
+
+		return false;
+	}
+
+	equiv_tbl_len = hdr[2];
+	if (equiv_tbl_len < sizeof(struct equiv_cpu_entry) ||
+	    buf_size - CONTAINER_HDR_SZ < equiv_tbl_len) {
+		if (!early)
+			pr_err("Truncated equivalence table.\n");
+
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * Check whether there is a valid, non-truncated microcode patch section
+ * at the beginning of a passed buffer @buf of size @buf_size.
+ * If @early is set do not print errors so this function is usable by the
+ * early microcode loader.
+ */
+static bool verify_patch_section(const u8 *buf, size_t buf_size, bool early)
+{
+	const u32 *hdr;
+	u32 patch_type, patch_size;
+
+	if (buf_size < SECTION_HDR_SIZE) {
+		if (!early)
+			pr_err("Truncated patch section.\n");
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
+			pr_err("Invalid type field (%u) in container file section header.\n",
+				patch_type);
+
+		return false;
+	}
+
+	if (patch_size < sizeof(struct microcode_header_amd)) {
+		if (!early)
+			pr_err("Patch of size %u too short.\n", patch_size);
+
+		return false;
+	}
+
+	return true;
+}
+
+static unsigned int verify_patch_size(u8 family, u32 patch_size,
+				      unsigned int size);
+
+/*
+ * Check whether there is a valid, non-truncated microcode patch of the
+ * right size for a particular family @family at the beginning of a passed
+ * buffer @buf, buffer that is of size @buf_size.
+ * Will return the length of current patch data in @crnt_size (even on
+ * failure), so the caller knows how many bytes it should skip.
+ * If @early is set do not print errors so this function is usable by the
+ * early microcode loader.
+ */
+static bool verify_patch(u8 family, const u8 *buf, size_t buf_size,
+			 unsigned int *crnt_size, bool early)
+{
+	const u32 *hdr;
+	u32 patch_size;
+	const struct microcode_header_amd *mc_hdr;
+	u8 patch_fam;
+
+	if (!verify_patch_section(buf, buf_size, early)) {
+		*crnt_size = min_t(unsigned int, 1, buf_size);
+		return false;
+	}
+
+	hdr = (const u32 *)buf;
+	patch_size = hdr[1];
+
+	if (buf_size - SECTION_HDR_SIZE < patch_size) {
+		if (!early)
+			pr_err("Patch of size %u truncated.\n", patch_size);
+
+		*crnt_size = buf_size;
+		return false;
+	}
+
+	/*
+	 * Set a patch length limit of slightly less than U32_MAX to
+	 * prevent overflowing 32-bit variables holding the whole
+	 * patch section size.
+	 */
+	if (patch_size > U32_MAX - SECTION_HDR_SIZE) {
+		if (!early)
+			pr_err("Patch of size %u too large.\n", patch_size);
+
+		*crnt_size = SECTION_HDR_SIZE + PATCH_MAX_SIZE;
+		return false;
+	}
+
+	*crnt_size = SECTION_HDR_SIZE + patch_size;
+
+	mc_hdr = (const struct microcode_header_amd *)(buf + SECTION_HDR_SIZE);
+	patch_fam = 0xf + (mc_hdr->processor_rev_id >> 12);
+
+	/* Is the patch for the proper CPU family? */
+	if (family != patch_fam)
+		return false;
+
+	/*
+	 * The section header length is not included in this indicated size
+	 * but is present in the leftover file length so we need to subtract
+	 * it before passing this value to the function below.
+	 */
+	if (!verify_patch_size(family, patch_size, buf_size - SECTION_HDR_SIZE)) {
+		if (!early)
+			pr_err("Patch of size %u too large.\n", patch_size);
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
@@ -494,10 +670,8 @@ static unsigned int verify_patch_size(u8 family, u32 patch_size, unsigned int si
 		break;
 	}
 
-	if (patch_size > min_t(u32, size, max_size)) {
-		pr_err("patch size mismatch\n");
+	if (patch_size > min_t(u32, size, max_size))
 		return 0;
-	}
 
 	return patch_size;
 }
