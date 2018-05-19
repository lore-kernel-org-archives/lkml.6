Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752629AbeESWHu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 18:07:50 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:49434 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752553AbeESWHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 18:07:48 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/8] x86/microcode/AMD: Split status from data to skip in verify_and_add_patch()
Date: Sun, 20 May 2018 00:07:18 +0200
Message-Id: <b7df362a30edb464015e91f8c90ed163879d2ff4.1526767245.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1526767245.git.mail@maciej.szmigiero.name>
References: <cover.1526767245.git.mail@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

verify_and_add_patch() returned a single "int" value which encoded both
this function error status and also a length of microcode container data to
skip.

Unfortunately, ranges of these two values collide: the length of data to
skip can be any value between 1 and UINT_MAX, so, for example, error status
of -EINVAL maps to a valid return value of 4294967274 bytes.
That's why these two values need to be split.

Let's keep the common convention that a function zero return value means
success while a negative value means an error while moving the returned
length of microcode container data to skip to a separate output parameter.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 33 +++++++++++++++--------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index f4c7479a961c..f8bd74341ed8 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -730,40 +730,41 @@ static void cleanup(void)
 }
 
 /*
- * We return the current size even if some of the checks failed so that
- * we can skip over the next patch. If we return a negative value, we
- * signal a grave error like a memory allocation has failed and the
- * driver cannot continue functioning normally. In such cases, we tear
- * down everything we've used up so far and exit.
+ * We return zero (success) and the current patch data size in @crnt_size
+ * even if some of the checks failed so that we can skip over the next patch.
+ * If we return a negative value, we signal a grave error like a memory
+ * allocation has failed and the driver cannot continue functioning normally.
+ * In such cases, we tear down everything we've used up so far and exit.
  */
-static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
+static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover,
+				unsigned int *crnt_size)
 {
 	struct microcode_header_amd *mc_hdr;
 	struct ucode_patch *patch;
-	unsigned int patch_size, crnt_size, ret;
+	unsigned int patch_size, ret;
 	u32 proc_fam;
 	u16 proc_id;
 
 	patch_size  = *(u32 *)(fw + 4);
-	crnt_size   = patch_size + SECTION_HDR_SIZE;
+	*crnt_size  = patch_size + SECTION_HDR_SIZE;
 	mc_hdr	    = (struct microcode_header_amd *)(fw + SECTION_HDR_SIZE);
 	proc_id	    = mc_hdr->processor_rev_id;
 
 	proc_fam = find_cpu_family_by_equiv_cpu(proc_id);
 	if (!proc_fam) {
 		pr_err("No patch family for equiv ID: 0x%04x\n", proc_id);
-		return crnt_size;
+		return 0;
 	}
 
 	/* check if patch is for the current family */
 	proc_fam = ((proc_fam >> 8) & 0xf) + ((proc_fam >> 20) & 0xff);
 	if (proc_fam != family)
-		return crnt_size;
+		return 0;
 
 	if (mc_hdr->nb_dev_id || mc_hdr->sb_dev_id) {
 		pr_err("Patch-ID 0x%08x: chipset-specific code unsupported.\n",
 			mc_hdr->patch_id);
-		return crnt_size;
+		return 0;
 	}
 
 	/*
@@ -774,7 +775,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 	ret = verify_patch_size(family, patch_size, leftover - SECTION_HDR_SIZE);
 	if (!ret) {
 		pr_err("Patch-ID 0x%08x: size mismatch.\n", mc_hdr->patch_id);
-		return crnt_size;
+		return 0;
 	}
 
 	patch = kzalloc(sizeof(*patch), GFP_KERNEL);
@@ -800,7 +801,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 	/* ... and add to cache. */
 	update_cache(patch);
 
-	return crnt_size;
+	return 0;
 }
 
 static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
@@ -809,7 +810,6 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 	enum ucode_state ret = UCODE_ERROR;
 	unsigned int leftover;
 	u8 *fw = (u8 *)data;
-	int crnt_size = 0;
 	int offset;
 
 	offset = install_equiv_cpu_table(data);
@@ -827,8 +827,9 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 	}
 
 	while (leftover) {
-		crnt_size = verify_and_add_patch(family, fw, leftover);
-		if (crnt_size < 0)
+		unsigned int crnt_size;
+
+		if (verify_and_add_patch(family, fw, leftover, &crnt_size) < 0)
 			return ret;
 
 		fw	 += crnt_size;
