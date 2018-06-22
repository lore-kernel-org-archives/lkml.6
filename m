Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DBBC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57A324959
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57A324959
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933573AbeFVWcR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:32:17 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:48424 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754184AbeFVWcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:32:16 -0400
Received: by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1fWUbE-000650-Ni; Sat, 23 Jun 2018 00:32:12 +0200
Subject: [PATCH 1/2] x86/microcode/AMD: Integrate verify_patch_size() into
 verify_patch()
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1529424596.git.mail@maciej.szmigiero.name>
 <39d0efb50538e4a1a06da693559bb13b060ad676.1529424596.git.mail@maciej.szmigiero.name>
 <20180621083649.GC12742@zn.tnic>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Openpgp: preference=signencrypt
Autocrypt: addr=mail@maciej.szmigiero.name; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c6df0de8-c6a0-bd6e-d312-7ba97aa3c984@maciej.szmigiero.name>
Date:   Sat, 23 Jun 2018 00:32:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621083649.GC12742@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Integrating verify_patch_size() into verify_patch() will allows us to
introduce in the next commit a check whether the indicated patch size makes
sense for its indicated CPU family - for all CPU families known to the
driver.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
This is part 1/2 of a replacement for
"[PATCH v7 3/9] x86/microcode/AMD: Integrate verify_patch_size() into verify_patch()".

 arch/x86/kernel/cpu/microcode/amd.c | 82 ++++++++++-------------------
 1 file changed, 29 insertions(+), 53 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 120778771909..53820b92aabb 100644
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
 
@@ -234,12 +231,36 @@ static bool verify_patch(u8 family, const u8 *buf, size_t buf_size,
 	if (family != patch_fam)
 		return false;
 
+#define F1XH_MPB_MAX_SIZE 2048
+#define F14H_MPB_MAX_SIZE 1824
+#define F15H_MPB_MAX_SIZE 4096
+#define F16H_MPB_MAX_SIZE 3458
+#define F17H_MPB_MAX_SIZE 3200
+
+	switch (family) {
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
+		max_size = F1XH_MPB_MAX_SIZE;
+		break;
+	}
+
 	/*
 	 * The section header length is not included in this indicated size
 	 * but is present in the leftover file length so we need to subtract
-	 * it before passing this value to the function below.
+	 * it from the leftover file length.
 	 */
-	if (!verify_patch_size(family, patch_size, buf_size - SECTION_HDR_SIZE)) {
+	if (patch_size > min_t(u32, buf_size - SECTION_HDR_SIZE, max_size)) {
 		if (!early)
 			pr_err("Patch of size %u too large.\n", patch_size);
 
@@ -637,45 +658,6 @@ static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
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
@@ -765,7 +747,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 {
 	struct microcode_header_amd *mc_hdr;
 	struct ucode_patch *patch;
-	unsigned int patch_size, crnt_size, ret;
+	unsigned int patch_size, crnt_size;
 	u32 proc_fam;
 	u16 proc_id;
 
@@ -791,13 +773,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
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
-- 
2.17.0

