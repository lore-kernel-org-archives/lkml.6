Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B008CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E45820851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E45820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbeKSUie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:38:34 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40829 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeKSUie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:38:34 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAJAFD9b2524091
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Nov 2018 02:15:13 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAJAFDkd2524088;
        Mon, 19 Nov 2018 02:15:13 -0800
Date:   Mon, 19 Nov 2018 02:15:13 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-70887cb23eda6bedac73eef227b55e3eb74e0cb7@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, bp@suse.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, bp@suse.de, hpa@zytor.com
In-Reply-To: <20181107170218.7596-6-bp@alien8.de>
References: <20181107170218.7596-6-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/microcode] x86/microcode/AMD: Cleanup verify_patch_size()
 more
Git-Commit-ID: 70887cb23eda6bedac73eef227b55e3eb74e0cb7
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

Commit-ID:  70887cb23eda6bedac73eef227b55e3eb74e0cb7
Gitweb:     https://git.kernel.org/tip/70887cb23eda6bedac73eef227b55e3eb74e0cb7
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Thu, 18 Oct 2018 17:55:45 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 19 Nov 2018 10:51:05 +0100

x86/microcode/AMD: Cleanup verify_patch_size() more

Rename the variable which contains the patch size read out from the
section header to sh_psize for better differentiation of all the "sizes"
in that function.

Also, improve the comment above it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20181107170218.7596-6-bp@alien8.de
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
