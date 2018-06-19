Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A8CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69B920661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69B920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030486AbeFSSr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:47:57 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:39770 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030320AbeFSSry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:47:54 -0400
Received: by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1fVLfH-0003Vp-S0; Tue, 19 Jun 2018 20:47:39 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/9] x86/microcode/AMD: Subtract SECTION_HDR_SIZE from file leftover length
Date:   Tue, 19 Jun 2018 20:47:31 +0200
Message-Id: <6df43f4f6a28186a13a66e8d7e61143c5e1a2324.1529424596.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529424596.git.mail@maciej.szmigiero.name>
References: <cover.1529424596.git.mail@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

verify_patch_size() verifies whether the remaining size of the microcode
container file is large enough to contain a patch of the indicated size.

However, the section header length is not included in this indicated
size but it is present in the leftover file length so it should be
subtracted from the leftover file length before passing this value to
verify_patch_size().

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Link: http://lkml.kernel.org/r/b4854b17-e3ba-54d6-488d-0e0bfffe4c71@maciej.szmigiero.name
[ Split comment. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 0624957aa068..dc8ea9a9d962 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -461,8 +461,12 @@ static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 	return 0;
 }
 
-static unsigned int verify_patch_size(u8 family, u32 patch_size,
-				      unsigned int size)
+/*
+ * Check whether the passed remaining file @size is large enough to contain a
+ * patch of the indicated @patch_size (and also whether this size does not
+ * exceed the per-family maximum).
+ */
+static unsigned int verify_patch_size(u8 family, u32 patch_size, unsigned int size)
 {
 	u32 max_size;
 
@@ -613,7 +617,12 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 		return crnt_size;
 	}
 
-	ret = verify_patch_size(family, patch_size, leftover);
+	/*
+	 * The section header length is not included in this indicated size
+	 * but is present in the leftover file length so we need to subtract
+	 * it before passing this value to the function below.
+	 */
+	ret = verify_patch_size(family, patch_size, leftover - SECTION_HDR_SIZE);
 	if (!ret) {
 		pr_err("Patch-ID 0x%08x: size mismatch.\n", mc_hdr->patch_id);
 		return crnt_size;
