Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2855BC46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5EB208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5EB208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbeKHCds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:33:48 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46510 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731424AbeKHCdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:33:47 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZrpFoD2EVPYd; Wed,  7 Nov 2018 18:02:33 +0100 (CET)
Received: from zn.tnic (p200300EC2BCBE000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:e000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4EC9C1EC0291;
        Wed,  7 Nov 2018 18:02:33 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/16] x86/microcode/AMD: Cleanup verify_patch_size() more
Date:   Wed,  7 Nov 2018 18:02:07 +0100
Message-Id: <20181107170218.7596-6-bp@alien8.de>
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

Rename the variable which contains the patch size read out from the
section header to sh_psize for better differentiation of all the "sizes"
in that function.

Also, improve the comment above it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index bf682deb84e8..a94a15aacfe7 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -175,16 +175,18 @@ static bool verify_patch_section(const u8 *buf, size_t buf_size, bool early)
 }
 
 /*
- * Check whether the passed remaining file @size is large enough to contain a
- * patch of the indicated @patch_size (and also whether this size does not
- * exceed the per-family maximum).
+ * Check whether the passed remaining file @buf_size is large enough to contain
+ * a patch of the indicated @sh_psize (and also whether this size does not
+ * exceed the per-family maximum). @sh_psize is the size read from the section
+ * header.
  */
-static unsigned int verify_patch_size(u8 family, u32 patch_size, unsigned int size)
+static unsigned int
+verify_patch_size(u8 family, u32 sh_psize, unsigned int buf_size)
 {
 	u32 max_size;
 
 	if (family >= 0x15)
-		return min_t(u32, patch_size, size);
+		return min_t(u32, sh_psize, buf_size);
 
 #define F1XH_MPB_MAX_SIZE 2048
 #define F14H_MPB_MAX_SIZE 1824
@@ -202,12 +204,12 @@ static unsigned int verify_patch_size(u8 family, u32 patch_size, unsigned int si
 		break;
 	}
 
-	if (patch_size > min_t(u32, size, max_size)) {
+	if (sh_psize > min_t(u32, buf_size, max_size)) {
 		pr_err("patch size mismatch\n");
 		return 0;
 	}
 
-	return patch_size;
+	return sh_psize;
 }
 
 /*
@@ -693,14 +695,14 @@ static void cleanup(void)
  */
 static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 {
+	unsigned int sh_psize, crnt_size, ret;
 	struct microcode_header_amd *mc_hdr;
 	struct ucode_patch *patch;
-	unsigned int patch_size, crnt_size, ret;
 	u32 proc_fam;
 	u16 proc_id;
 
-	patch_size  = *(u32 *)(fw + 4);
-	crnt_size   = patch_size + SECTION_HDR_SIZE;
+	sh_psize    = *(u32 *)(fw + 4);
+	crnt_size   = sh_psize + SECTION_HDR_SIZE;
 	mc_hdr	    = (struct microcode_header_amd *)(fw + SECTION_HDR_SIZE);
 	proc_id	    = mc_hdr->processor_rev_id;
 
@@ -726,7 +728,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 	 * but is present in the leftover file length so we need to subtract
 	 * it before passing this value to the function below.
 	 */
-	ret = verify_patch_size(family, patch_size, leftover - SECTION_HDR_SIZE);
+	ret = verify_patch_size(family, sh_psize, leftover - SECTION_HDR_SIZE);
 	if (!ret) {
 		pr_err("Patch-ID 0x%08x: size mismatch.\n", mc_hdr->patch_id);
 		return crnt_size;
@@ -738,7 +740,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 		return -EINVAL;
 	}
 
-	patch->data = kmemdup(fw + SECTION_HDR_SIZE, patch_size, GFP_KERNEL);
+	patch->data = kmemdup(fw + SECTION_HDR_SIZE, sh_psize, GFP_KERNEL);
 	if (!patch->data) {
 		pr_err("Patch data allocation failure.\n");
 		kfree(patch);
-- 
2.19.1

