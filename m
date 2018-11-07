Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61951ECDE47
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25521208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25521208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbeKHCdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:33:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46530 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731449AbeKHCdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:33:49 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OKyDOkRbYRiQ; Wed,  7 Nov 2018 18:02:34 +0100 (CET)
Received: from zn.tnic (p200300EC2BCBE000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:e000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3025A1EC0291;
        Wed,  7 Nov 2018 18:02:34 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/16] x86/microcode/AMD: Concentrate patch verification
Date:   Wed,  7 Nov 2018 18:02:08 +0100
Message-Id: <20181107170218.7596-7-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107170218.7596-1-bp@alien8.de>
References: <20181107170218.7596-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Add a verify_patch() function which tries to sanity-check many aspects
of a microcode patch supplied by an outside container before attempting
a load.

Prepend all sub-functions' names which verify an aspect of a microcode
patch with "__".

Call it in verify_and_add_patch() *before* looking at the microcode
header.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 79 ++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index a94a15aacfe7..8f012a7f88c4 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -139,11 +139,15 @@ static bool verify_equivalence_table(const u8 *buf, size_t buf_size, bool early)
  * Check whether there is a valid, non-truncated microcode patch section at the
  * beginning of @buf of size @buf_size. Set @early to use this function in the
  * early path.
+ *
+ * On success, @sh_psize returns the patch size according to the section header,
+ * to the caller.
  */
-static bool verify_patch_section(const u8 *buf, size_t buf_size, bool early)
+static bool
+__verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize, bool early)
 {
+	u32 p_type, p_size;
 	const u32 *hdr;
-	u32 patch_type, patch_size;
 
 	if (buf_size < SECTION_HDR_SIZE) {
 		if (!early)
@@ -153,24 +157,26 @@ static bool verify_patch_section(const u8 *buf, size_t buf_size, bool early)
 	}
 
 	hdr = (const u32 *)buf;
-	patch_type = hdr[0];
-	patch_size = hdr[1];
+	p_type = hdr[0];
+	p_size = hdr[1];
 
-	if (patch_type != UCODE_UCODE_TYPE) {
+	if (p_type != UCODE_UCODE_TYPE) {
 		if (!early)
 			pr_debug("Invalid type field (0x%x) in container file section header.\n",
-				patch_type);
+				p_type);
 
 		return false;
 	}
 
-	if (patch_size < sizeof(struct microcode_header_amd)) {
+	if (p_size < sizeof(struct microcode_header_amd)) {
 		if (!early)
-			pr_debug("Patch of size %u too short.\n", patch_size);
+			pr_debug("Patch of size %u too short.\n", p_size);
 
 		return false;
 	}
 
+	*sh_psize = p_size;
+
 	return true;
 }
 
@@ -181,7 +187,7 @@ static bool verify_patch_section(const u8 *buf, size_t buf_size, bool early)
  * header.
  */
 static unsigned int
-verify_patch_size(u8 family, u32 sh_psize, unsigned int buf_size)
+__verify_patch_size(u8 family, u32 sh_psize, unsigned int buf_size)
 {
 	u32 max_size;
 
@@ -212,6 +218,34 @@ verify_patch_size(u8 family, u32 sh_psize, unsigned int buf_size)
 	return sh_psize;
 }
 
+static unsigned int
+verify_patch(u8 family, const u8 *buf, unsigned int buf_size, bool early)
+{
+	u32 sh_psize;
+
+	if (!__verify_patch_section(buf, buf_size, &sh_psize, early))
+		return 0;
+	/*
+	 * The section header length is not included in this indicated size
+	 * but is present in the leftover file length so we need to subtract
+	 * it before passing this value to the function below.
+	 */
+	buf_size -= SECTION_HDR_SIZE;
+
+	/*
+	 * Check if the remaining buffer is big enough to contain a patch of
+	 * size sh_psize, as the section claims.
+	 */
+	if (buf_size < sh_psize) {
+		if (!early)
+			pr_debug("Patch of size %u truncated.\n", sh_psize);
+
+		return 0;
+	}
+
+	return __verify_patch_size(family, sh_psize, buf_size);
+}
+
 /*
  * This scans the ucode blob for the proper container as we can have multiple
  * containers glued together. Returns the equivalence ID from the equivalence
@@ -687,7 +721,7 @@ static void cleanup(void)
 }
 
 /*
- * We return the current size even if some of the checks failed so that
+ * Return a non-negative value even if some of the checks failed so that
  * we can skip over the next patch. If we return a negative value, we
  * signal a grave error like a memory allocation has failed and the
  * driver cannot continue functioning normally. In such cases, we tear
@@ -695,14 +729,20 @@ static void cleanup(void)
  */
 static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 {
-	unsigned int sh_psize, crnt_size, ret;
 	struct microcode_header_amd *mc_hdr;
+	unsigned int patch_size, crnt_size;
 	struct ucode_patch *patch;
 	u32 proc_fam;
 	u16 proc_id;
 
-	sh_psize    = *(u32 *)(fw + 4);
-	crnt_size   = sh_psize + SECTION_HDR_SIZE;
+	patch_size = verify_patch(family, fw, leftover, false);
+	if (!patch_size) {
+		pr_debug("Patch size mismatch.\n");
+		return 1;
+	}
+
+	/* If initial rough pokes pass, we can start looking at the header. */
+	crnt_size   = patch_size + SECTION_HDR_SIZE;
 	mc_hdr	    = (struct microcode_header_amd *)(fw + SECTION_HDR_SIZE);
 	proc_id	    = mc_hdr->processor_rev_id;
 
@@ -723,24 +763,13 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 		return crnt_size;
 	}
 
-	/*
-	 * The section header length is not included in this indicated size
-	 * but is present in the leftover file length so we need to subtract
-	 * it before passing this value to the function below.
-	 */
-	ret = verify_patch_size(family, sh_psize, leftover - SECTION_HDR_SIZE);
-	if (!ret) {
-		pr_err("Patch-ID 0x%08x: size mismatch.\n", mc_hdr->patch_id);
-		return crnt_size;
-	}
-
 	patch = kzalloc(sizeof(*patch), GFP_KERNEL);
 	if (!patch) {
 		pr_err("Patch allocation failure.\n");
 		return -EINVAL;
 	}
 
-	patch->data = kmemdup(fw + SECTION_HDR_SIZE, sh_psize, GFP_KERNEL);
+	patch->data = kmemdup(fw + SECTION_HDR_SIZE, patch_size, GFP_KERNEL);
 	if (!patch->data) {
 		pr_err("Patch data allocation failure.\n");
 		kfree(patch);
-- 
2.19.1

