Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC28C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5251A20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5251A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030519AbeFSSsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:48:00 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:39782 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030463AbeFSSrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:47:55 -0400
Received: by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1fVLfI-0003Vy-Km; Tue, 19 Jun 2018 20:47:40 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/9] x86/microcode/AMD: Check microcode container data in the early loader
Date:   Tue, 19 Jun 2018 20:47:34 +0200
Message-Id: <391e063da8244b2cabd04104410f9863ed24a6e3.1529424596.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529424596.git.mail@maciej.szmigiero.name>
References: <cover.1529424596.git.mail@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the early loader in the AMD microcode update driver to use the
container data checking functions introduced by previous commits.

We have to be careful to call these functions with 'early' parameter set,
so they won't try to print errors as the early loader runs too early for
printk()-style functions to work.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 70 ++++++++++++++++-------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 67147e784c0e..c05531540b57 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -284,29 +284,35 @@ static bool verify_patch(u8 family, const u8 *buf, size_t buf_size,
  * Returns the amount of bytes consumed while scanning. @desc contains all the
  * data we're going to use in later stages of the application.
  */
-static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
+static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 {
 	struct equiv_cpu_entry *eq;
-	ssize_t orig_size = size;
+	size_t orig_size = size;
 	u32 *hdr = (u32 *)ucode;
+	u32 equiv_tbl_len;
 	u16 eq_id;
 	u8 *buf;
 
-	/* Am I looking at an equivalence table header? */
-	if (hdr[0] != UCODE_MAGIC ||
-	    hdr[1] != UCODE_EQUIV_CPU_TABLE_TYPE ||
-	    hdr[2] == 0)
-		return CONTAINER_HDR_SZ;
+	/*
+	 * Skip one byte when a container cannot be parsed successfully
+	 * so the parser will correctly skip unknown data of any size until
+	 * it hopefully arrives at something that it is able to recognize.
+	 */
+	if (!verify_equivalence_table(ucode, size, true))
+		return 1;
 
 	buf = ucode;
 
+	equiv_tbl_len = hdr[2];
 	eq = (struct equiv_cpu_entry *)(buf + CONTAINER_HDR_SZ);
 
 	/* Find the equivalence ID of our CPU in this table: */
 	eq_id = find_equiv_id(eq, desc->cpuid_1_eax);
 
-	buf  += hdr[2] + CONTAINER_HDR_SZ;
-	size -= hdr[2] + CONTAINER_HDR_SZ;
+	buf  += CONTAINER_HDR_SZ;
+	buf  += equiv_tbl_len;
+	size -= CONTAINER_HDR_SZ;
+	size -= equiv_tbl_len;
 
 	/*
 	 * Scan through the rest of the container to find where it ends. We do
@@ -314,30 +320,36 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
 	 */
 	while (size > 0) {
 		struct microcode_amd *mc;
+		unsigned int crnt_size;
 		u32 patch_size;
 
-		hdr = (u32 *)buf;
-
-		if (hdr[0] != UCODE_UCODE_TYPE)
+		/*
+		 * If this patch section hasn't got a plausible header we
+		 * probably have arrived at the beginning of a next container.
+		 * Bail out from patch processing here so this new container
+		 * can be scanned.
+		 */
+		if (!verify_patch_section(buf, size, true))
 			break;
 
-		/* Sanity-check patch size. */
+		if (!verify_patch(x86_family(desc->cpuid_1_eax),
+				  buf, size, &crnt_size, true))
+			goto next_patch;
+
+		hdr = (u32 *)buf;
 		patch_size = hdr[1];
-		if (patch_size > PATCH_MAX_SIZE)
-			break;
 
-		/* Skip patch section header: */
-		buf  += SECTION_HDR_SIZE;
-		size -= SECTION_HDR_SIZE;
+		mc = (struct microcode_amd *)(buf + SECTION_HDR_SIZE);
+		if (eq_id != mc->hdr.processor_rev_id)
+			goto next_patch;
 
-		mc = (struct microcode_amd *)buf;
-		if (eq_id == mc->hdr.processor_rev_id) {
-			desc->psize = patch_size;
-			desc->mc = mc;
-		}
+		/* We have found a matching patch! */
+		desc->psize = patch_size;
+		desc->mc = mc;
 
-		buf  += patch_size;
-		size -= patch_size;
+next_patch:
+		buf  += crnt_size;
+		size -= crnt_size;
 	}
 
 	/*
@@ -363,15 +375,13 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
  */
 static void scan_containers(u8 *ucode, size_t size, struct cont_desc *desc)
 {
-	ssize_t rem = size;
-
-	while (rem >= 0) {
-		ssize_t s = parse_container(ucode, rem, desc);
+	while (size > 0) {
+		size_t s = parse_container(ucode, size, desc);
 		if (!s)
 			return;
 
 		ucode += s;
-		rem   -= s;
+		size  -= s;
 	}
 }
 
