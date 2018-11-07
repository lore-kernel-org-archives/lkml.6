Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEBAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933FA20892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933FA20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbeKHCdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:33:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46544 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731484AbeKHCdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:33:53 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WFlPtErpJfNk; Wed,  7 Nov 2018 18:02:39 +0100 (CET)
Received: from zn.tnic (p200300EC2BCBE000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:e000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 907CF1EC0291;
        Wed,  7 Nov 2018 18:02:38 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/16] x86/microcode/AMD: Convert early parser to the new verification routines
Date:   Wed,  7 Nov 2018 18:02:13 +0100
Message-Id: <20181107170218.7596-12-bp@alien8.de>
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

Now that they have the required functionality, use them to verify the
equivalence table and each patch, thus making parse_container() more
readable.

Based on a patch by "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 46 +++++++++++++++--------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 79216cfb9f72..5775dc996df3 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -293,17 +293,18 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
 	u16 eq_id;
 	u8 *buf;
 
-	/* Am I looking at an equivalence table header? */
-	if (hdr[0] != UCODE_MAGIC ||
-	    hdr[1] != UCODE_EQUIV_CPU_TABLE_TYPE ||
-	    hdr[2] == 0)
-		return CONTAINER_HDR_SZ;
+	if (!verify_equivalence_table(ucode, size, true))
+		return 0;
 
 	buf = ucode;
 
 	eq = (struct equiv_cpu_entry *)(buf + CONTAINER_HDR_SZ);
 
-	/* Find the equivalence ID of our CPU in this table: */
+	/*
+	 * Find the equivalence ID of our CPU in this table. Even if this table
+	 * doesn't contain a patch for the CPU, scan through the whole container
+	 * so that it can be skipped in case there are other containers appended.
+	 */
 	eq_id = find_equiv_id(eq, desc->cpuid_1_eax);
 
 	buf  += hdr[2] + CONTAINER_HDR_SZ;
@@ -316,29 +317,29 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
 	while (size > 0) {
 		struct microcode_amd *mc;
 		u32 patch_size;
+		int ret;
 
-		hdr = (u32 *)buf;
-
-		if (hdr[0] != UCODE_UCODE_TYPE)
-			break;
-
-		/* Sanity-check patch size. */
-		patch_size = hdr[1];
-		if (patch_size > PATCH_MAX_SIZE)
-			break;
-
-		/* Skip patch section header: */
-		buf  += SECTION_HDR_SIZE;
-		size -= SECTION_HDR_SIZE;
+		ret = verify_patch(x86_family(desc->cpuid_1_eax), buf, size, &patch_size, true);
+		if (ret < 0) {
+			/*
+			 * Patch verification failed, skip to the next
+			 * container, if there's one:
+			 */
+			goto out;
+		} else if (ret > 0) {
+			goto skip;
+		}
 
-		mc = (struct microcode_amd *)buf;
+		mc = (struct microcode_amd *)(buf + SECTION_HDR_SIZE);
 		if (eq_id == mc->hdr.processor_rev_id) {
 			desc->psize = patch_size;
 			desc->mc = mc;
 		}
 
-		buf  += patch_size;
-		size -= patch_size;
+skip:
+		/* Skip patch section header too: */
+		buf  += patch_size + SECTION_HDR_SIZE;
+		size -= patch_size + SECTION_HDR_SIZE;
 	}
 
 	/*
@@ -355,6 +356,7 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
 		return 0;
 	}
 
+out:
 	return orig_size - size;
 }
 
-- 
2.19.1

