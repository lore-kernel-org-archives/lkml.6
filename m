Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C74C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FECE206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FECE206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeKSUlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:41:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34149 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeKSUlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:41:25 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAJAI7P92524662
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Nov 2018 02:18:07 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAJAI7VD2524659;
        Mon, 19 Nov 2018 02:18:07 -0800
Date:   Mon, 19 Nov 2018 02:18:07 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-d430a305b7f8127d992e79e90b6fac00f99d23b3@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, bp@suse.de,
        linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, bp@suse.de, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20181107170218.7596-11-bp@alien8.de>
References: <20181107170218.7596-11-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/microcode] x86/microcode/AMD: Change verify_patch()'s
 return value
Git-Commit-ID: d430a305b7f8127d992e79e90b6fac00f99d23b3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d430a305b7f8127d992e79e90b6fac00f99d23b3
Gitweb:     https://git.kernel.org/tip/d430a305b7f8127d992e79e90b6fac00f99d23b3
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Fri, 19 Oct 2018 14:27:24 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 19 Nov 2018 10:51:06 +0100

x86/microcode/AMD: Change verify_patch()'s return value

Have it return 0 on success, positive value when the current patch
should be skipped and negative on error.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20181107170218.7596-11-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/amd.c | 91 +++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index ebac82357639..79216cfb9f72 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -210,24 +210,32 @@ __verify_patch_size(u8 family, u32 sh_psize, unsigned int buf_size)
 		break;
 	}
 
-	if (sh_psize > min_t(u32, buf_size, max_size)) {
-		pr_err("patch size mismatch\n");
+	if (sh_psize > min_t(u32, buf_size, max_size))
 		return 0;
-	}
 
 	return sh_psize;
 }
 
-static unsigned int
-verify_patch(u8 family, const u8 *buf, unsigned int buf_size, bool early)
+/*
+ * Verify the patch in @buf.
+ *
+ * Returns:
+ * negative: on error
+ * positive: patch is not for this family, skip it
+ * 0: success
+ */
+static int
+verify_patch(u8 family, const u8 *buf, size_t buf_size, u32 *patch_size, bool early)
 {
 	struct microcode_header_amd *mc_hdr;
+	unsigned int ret;
 	u32 sh_psize;
 	u16 proc_id;
 	u8 patch_fam;
 
 	if (!__verify_patch_section(buf, buf_size, &sh_psize, early))
-		return 0;
+		return -1;
+
 	/*
 	 * The section header length is not included in this indicated size
 	 * but is present in the leftover file length so we need to subtract
@@ -243,23 +251,31 @@ verify_patch(u8 family, const u8 *buf, unsigned int buf_size, bool early)
 		if (!early)
 			pr_debug("Patch of size %u truncated.\n", sh_psize);
 
-		return 0;
+		return -1;
 	}
 
-	mc_hdr	= (struct microcode_header_amd *)(buf + SECTION_HDR_SIZE);
-	proc_id	= mc_hdr->processor_rev_id;
+	ret = __verify_patch_size(family, sh_psize, buf_size);
+	if (!ret) {
+		if (!early)
+			pr_debug("Per-family patch size mismatch.\n");
+		return -1;
+	}
+
+	*patch_size = sh_psize;
 
+	mc_hdr	= (struct microcode_header_amd *)(buf + SECTION_HDR_SIZE);
 	if (mc_hdr->nb_dev_id || mc_hdr->sb_dev_id) {
 		if (!early)
 			pr_err("Patch-ID 0x%08x: chipset-specific code unsupported.\n", mc_hdr->patch_id);
-		return 0;
+		return -1;
 	}
 
+	proc_id	= mc_hdr->processor_rev_id;
 	patch_fam = 0xf + (proc_id >> 12);
 	if (patch_fam != family)
-		return 0;
+		return 1;
 
-	return __verify_patch_size(family, sh_psize, buf_size);
+	return 0;
 }
 
 /*
@@ -729,23 +745,17 @@ static void cleanup(void)
  * driver cannot continue functioning normally. In such cases, we tear
  * down everything we've used up so far and exit.
  */
-static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
+static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover,
+				unsigned int *patch_size)
 {
 	struct microcode_header_amd *mc_hdr;
-	unsigned int patch_size, crnt_size;
 	struct ucode_patch *patch;
 	u16 proc_id;
+	int ret;
 
-	patch_size = verify_patch(family, fw, leftover, false);
-	if (!patch_size) {
-		pr_debug("Patch size mismatch.\n");
-		return 1;
-	}
-
-	/* If initial rough pokes pass, we can start looking at the header. */
-	crnt_size   = patch_size + SECTION_HDR_SIZE;
-	mc_hdr	    = (struct microcode_header_amd *)(fw + SECTION_HDR_SIZE);
-	proc_id	    = mc_hdr->processor_rev_id;
+	ret = verify_patch(family, fw, leftover, patch_size, false);
+	if (ret)
+		return ret;
 
 	patch = kzalloc(sizeof(*patch), GFP_KERNEL);
 	if (!patch) {
@@ -753,13 +763,16 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 		return -EINVAL;
 	}
 
-	patch->data = kmemdup(fw + SECTION_HDR_SIZE, patch_size, GFP_KERNEL);
+	patch->data = kmemdup(fw + SECTION_HDR_SIZE, *patch_size, GFP_KERNEL);
 	if (!patch->data) {
 		pr_err("Patch data allocation failure.\n");
 		kfree(patch);
 		return -EINVAL;
 	}
 
+	mc_hdr      = (struct microcode_header_amd *)(fw + SECTION_HDR_SIZE);
+	proc_id     = mc_hdr->processor_rev_id;
+
 	INIT_LIST_HEAD(&patch->plist);
 	patch->patch_id  = mc_hdr->patch_id;
 	patch->equiv_cpu = proc_id;
@@ -770,39 +783,39 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 	/* ... and add to cache. */
 	update_cache(patch);
 
-	return crnt_size;
+	return 0;
 }
 
 static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 					     size_t size)
 {
-	enum ucode_state ret = UCODE_ERROR;
-	unsigned int leftover;
 	u8 *fw = (u8 *)data;
-	int crnt_size = 0;
 	int offset;
 
 	offset = install_equiv_cpu_table(data);
 	if (offset < 0) {
 		pr_err("failed to create equivalent cpu table\n");
-		return ret;
+		return UCODE_ERROR;
 	}
-	fw += offset;
-	leftover = size - offset;
+	fw   += offset;
+	size -= offset;
 
 	if (*(u32 *)fw != UCODE_UCODE_TYPE) {
 		pr_err("invalid type field in container file section header\n");
 		free_equiv_cpu_table();
-		return ret;
+		return UCODE_ERROR;
 	}
 
-	while (leftover) {
-		crnt_size = verify_and_add_patch(family, fw, leftover);
-		if (crnt_size < 0)
-			return ret;
+	while (size > 0) {
+		unsigned int crnt_size = 0;
+		int ret;
+
+		ret = verify_and_add_patch(family, fw, size, &crnt_size);
+		if (ret < 0)
+			return UCODE_ERROR;
 
-		fw	 += crnt_size;
-		leftover -= crnt_size;
+		fw   +=  crnt_size + SECTION_HDR_SIZE;
+		size -= (crnt_size + SECTION_HDR_SIZE);
 	}
 
 	return UCODE_OK;
