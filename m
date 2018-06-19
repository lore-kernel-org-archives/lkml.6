Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1849CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46BA20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46BA20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030462AbeFSSrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:47:53 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:39574 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030320AbeFSSrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:47:51 -0400
Received: by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1fVLfI-0003W1-Rh; Tue, 19 Jun 2018 20:47:40 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/9] x86/microcode/AMD: Split status from data to skip in verify_and_add_patch()
Date:   Tue, 19 Jun 2018 20:47:35 +0200
Message-Id: <84b3976f5879d7a58c3774d1f86e493b34c9759c.1529424596.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529424596.git.mail@maciej.szmigiero.name>
References: <cover.1529424596.git.mail@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
 arch/x86/kernel/cpu/microcode/amd.c | 35 +++++++++++++++--------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index c05531540b57..9e29374ce4d0 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -754,45 +754,46 @@ static void cleanup(void)
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
-	unsigned int patch_size, crnt_size;
+	unsigned int patch_size;
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
 
-	if (!verify_patch(family, fw, leftover, &crnt_size, false)) {
+	if (!verify_patch(family, fw, leftover, crnt_size, false)) {
 		pr_err("Patch-ID 0x%08x: size mismatch.\n", mc_hdr->patch_id);
-		return crnt_size;
+		return 0;
 	}
 
 	patch = kzalloc(sizeof(*patch), GFP_KERNEL);
@@ -818,7 +819,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 	/* ... and add to cache. */
 	update_cache(patch);
 
-	return crnt_size;
+	return 0;
 }
 
 static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
@@ -827,7 +828,6 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 	enum ucode_state ret = UCODE_ERROR;
 	unsigned int leftover;
 	u8 *fw = (u8 *)data;
-	int crnt_size = 0;
 	int offset;
 
 	offset = install_equiv_cpu_table(data);
@@ -845,8 +845,9 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 	}
 
 	while (leftover) {
-		crnt_size = verify_and_add_patch(family, fw, leftover);
-		if (crnt_size < 0)
+		unsigned int crnt_size;
+
+		if (verify_and_add_patch(family, fw, leftover, &crnt_size) < 0)
 			return ret;
 
 		fw	 += crnt_size;
