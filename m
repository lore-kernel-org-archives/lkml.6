Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28FEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8763220661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8763220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030567AbeFSSt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:49:28 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:39578 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030283AbeFSSrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:47:51 -0400
Received: by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1fVLfI-0003Vv-Bg; Tue, 19 Jun 2018 20:47:40 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/9] x86/microcode/AMD: Integrate verify_patch_size() into verify_patch()
Date:   Tue, 19 Jun 2018 20:47:33 +0200
Message-Id: <39d0efb50538e4a1a06da693559bb13b060ad676.1529424596.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529424596.git.mail@maciej.szmigiero.name>
References: <cover.1529424596.git.mail@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Integrating verify_patch_size() into verify_patch() allows us to check
whether the indicated patch size makes sense for its indicated CPU family -
for all CPU families known to the driver.

If we spot a patch that is longer than expected for its family we'll
carefully skip over only the expected length to make sure we don't miss
good patches in case the indicated patch size was something nonsensically
huge.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 131 ++++++++++++----------------
 1 file changed, 57 insertions(+), 74 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 120778771909..67147e784c0e 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -176,9 +176,6 @@ static bool verify_patch_section(const u8 *buf, size_t buf_size, bool early)
 	return true;
 }
 
-static unsigned int verify_patch_size(u8 family, u32 patch_size,
-				      unsigned int size);
-
 /*
  * Check whether there is a valid, non-truncated microcode patch of the
  * right size for a particular family @family at the beginning of a passed
@@ -192,7 +189,7 @@ static bool verify_patch(u8 family, const u8 *buf, size_t buf_size,
 			 unsigned int *crnt_size, bool early)
 {
 	const u32 *hdr;
-	u32 patch_size;
+	u32 patch_size, max_size;
 	const struct microcode_header_amd *mc_hdr;
 	u8 patch_fam;
 
@@ -204,48 +201,79 @@ static bool verify_patch(u8 family, const u8 *buf, size_t buf_size,
 	hdr = (const u32 *)buf;
 	patch_size = hdr[1];
 
-	if (buf_size - SECTION_HDR_SIZE < patch_size) {
+	if (buf_size - SECTION_HDR_SIZE < sizeof(*mc_hdr)) {
 		if (!early)
-			pr_err("Patch of size %u truncated.\n", patch_size);
+			pr_err("Truncated patch header.\n");
 
 		*crnt_size = buf_size;
 		return false;
 	}
 
+	mc_hdr = (const struct microcode_header_amd *)(buf + SECTION_HDR_SIZE);
+	patch_fam = 0xf + (mc_hdr->processor_rev_id >> 12);
+
 	/*
-	 * Set a patch length limit of slightly less than U32_MAX to
-	 * prevent overflowing 32-bit variables holding the whole
-	 * patch section size.
+	 * Check whether patch_size isn't something nonsensically huge so
+	 * we don't skip over good patches by mistake.
 	 */
-	if (patch_size > U32_MAX - SECTION_HDR_SIZE) {
-		if (!early)
-			pr_err("Patch of size %u too large.\n", patch_size);
+#define F1XH_MPB_MAX_SIZE 2048
+#define F14H_MPB_MAX_SIZE 1824
+#define F15H_MPB_MAX_SIZE 4096
+#define F16H_MPB_MAX_SIZE 3458
+#define F17H_MPB_MAX_SIZE 3200
 
-		*crnt_size = SECTION_HDR_SIZE + PATCH_MAX_SIZE;
-		return false;
+	switch (patch_fam) {
+	case 0x10 ... 0x13:
+		max_size = F1XH_MPB_MAX_SIZE;
+		break;
+	case 0x14:
+		max_size = F14H_MPB_MAX_SIZE;
+		break;
+	case 0x15:
+		max_size = F15H_MPB_MAX_SIZE;
+		break;
+	case 0x16:
+		max_size = F16H_MPB_MAX_SIZE;
+		break;
+	case 0x17:
+		max_size = F17H_MPB_MAX_SIZE;
+		break;
+	default:
+		/*
+		 * Don't know the max size for future families...
+		 * Set a patch length limit of slightly less than U32_MAX to
+		 * prevent overflowing 32-bit variables holding the whole
+		 * patch section size.
+		 */
+		max_size = U32_MAX - SECTION_HDR_SIZE;
+		break;
 	}
 
-	*crnt_size = SECTION_HDR_SIZE + patch_size;
-
-	mc_hdr = (const struct microcode_header_amd *)(buf + SECTION_HDR_SIZE);
-	patch_fam = 0xf + (mc_hdr->processor_rev_id >> 12);
+	if (patch_size > max_size) {
+		if (!early)
+			pr_err("Patch of size %u exceeds family maximum.\n",
+			       patch_size);
 
-	/* Is the patch for the proper CPU family? */
-	if (family != patch_fam)
+		*crnt_size = min_t(unsigned int,
+				   SECTION_HDR_SIZE + max_size,
+				   buf_size);
 		return false;
+	}
 
-	/*
-	 * The section header length is not included in this indicated size
-	 * but is present in the leftover file length so we need to subtract
-	 * it before passing this value to the function below.
-	 */
-	if (!verify_patch_size(family, patch_size, buf_size - SECTION_HDR_SIZE)) {
+	if (buf_size - SECTION_HDR_SIZE < patch_size) {
 		if (!early)
-			pr_err("Patch of size %u too large.\n", patch_size);
+			pr_err("Patch of size %u truncated.\n", patch_size);
 
+		*crnt_size = buf_size;
 		return false;
 	}
 
+	*crnt_size = SECTION_HDR_SIZE + patch_size;
+
+	/* Is the patch for the proper CPU family? */
+	if (family != patch_fam)
+		return false;
+
 	return true;
 }
 
@@ -637,45 +665,6 @@ static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 	return 0;
 }
 
-/*
- * Check whether the passed remaining file @size is large enough to contain a
- * patch of the indicated @patch_size (and also whether this size does not
- * exceed the per-family maximum).
- */
-static unsigned int verify_patch_size(u8 family, u32 patch_size, unsigned int size)
-{
-	u32 max_size;
-
-#define F1XH_MPB_MAX_SIZE 2048
-#define F14H_MPB_MAX_SIZE 1824
-#define F15H_MPB_MAX_SIZE 4096
-#define F16H_MPB_MAX_SIZE 3458
-#define F17H_MPB_MAX_SIZE 3200
-
-	switch (family) {
-	case 0x14:
-		max_size = F14H_MPB_MAX_SIZE;
-		break;
-	case 0x15:
-		max_size = F15H_MPB_MAX_SIZE;
-		break;
-	case 0x16:
-		max_size = F16H_MPB_MAX_SIZE;
-		break;
-	case 0x17:
-		max_size = F17H_MPB_MAX_SIZE;
-		break;
-	default:
-		max_size = F1XH_MPB_MAX_SIZE;
-		break;
-	}
-
-	if (patch_size > min_t(u32, size, max_size))
-		return 0;
-
-	return patch_size;
-}
-
 static enum ucode_state apply_microcode_amd(int cpu)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
@@ -765,7 +754,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 {
 	struct microcode_header_amd *mc_hdr;
 	struct ucode_patch *patch;
-	unsigned int patch_size, crnt_size, ret;
+	unsigned int patch_size, crnt_size;
 	u32 proc_fam;
 	u16 proc_id;
 
@@ -791,13 +780,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 		return crnt_size;
 	}
 
-	/*
-	 * The section header length is not included in this indicated size
-	 * but is present in the leftover file length so we need to subtract
-	 * it before passing this value to the function below.
-	 */
-	ret = verify_patch_size(family, patch_size, leftover - SECTION_HDR_SIZE);
-	if (!ret) {
+	if (!verify_patch(family, fw, leftover, &crnt_size, false)) {
 		pr_err("Patch-ID 0x%08x: size mismatch.\n", mc_hdr->patch_id);
 		return crnt_size;
 	}
