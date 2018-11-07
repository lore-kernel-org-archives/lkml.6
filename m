Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75476C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5EC208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5EC208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbeKHCdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:33:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46544 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbeKHCdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:33:50 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id skLfsSb-NW8B; Wed,  7 Nov 2018 18:02:35 +0100 (CET)
Received: from zn.tnic (p200300EC2BCBE000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:e000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 177F21EC0291;
        Wed,  7 Nov 2018 18:02:35 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/16] x86/microcode/AMD: Simplify patch family detection
Date:   Wed,  7 Nov 2018 18:02:09 +0100
Message-Id: <20181107170218.7596-8-bp@alien8.de>
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

Instead of traversing the equivalence table, compute the family a patch
is for, from the processor revision ID in the microcode header.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 8f012a7f88c4..b4450374f4b1 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -540,20 +540,6 @@ static u16 __find_equiv_id(unsigned int cpu)
 	return find_equiv_id(equiv_cpu_table, uci->cpu_sig.sig);
 }
 
-static u32 find_cpu_family_by_equiv_cpu(u16 equiv_cpu)
-{
-	int i = 0;
-
-	BUG_ON(!equiv_cpu_table);
-
-	while (equiv_cpu_table[i].equiv_cpu != 0) {
-		if (equiv_cpu == equiv_cpu_table[i].equiv_cpu)
-			return equiv_cpu_table[i].installed_cpu;
-		i++;
-	}
-	return 0;
-}
-
 /*
  * a small, trivial cache of per-family ucode patches
  */
@@ -732,7 +718,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 	struct microcode_header_amd *mc_hdr;
 	unsigned int patch_size, crnt_size;
 	struct ucode_patch *patch;
-	u32 proc_fam;
+	u8 patch_fam;
 	u16 proc_id;
 
 	patch_size = verify_patch(family, fw, leftover, false);
@@ -746,15 +732,8 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 	mc_hdr	    = (struct microcode_header_amd *)(fw + SECTION_HDR_SIZE);
 	proc_id	    = mc_hdr->processor_rev_id;
 
-	proc_fam = find_cpu_family_by_equiv_cpu(proc_id);
-	if (!proc_fam) {
-		pr_err("No patch family for equiv ID: 0x%04x\n", proc_id);
-		return crnt_size;
-	}
-
-	/* check if patch is for the current family */
-	proc_fam = ((proc_fam >> 8) & 0xf) + ((proc_fam >> 20) & 0xff);
-	if (proc_fam != family)
+	patch_fam = 0xf + (proc_id >> 12);
+	if (patch_fam != family)
 		return crnt_size;
 
 	if (mc_hdr->nb_dev_id || mc_hdr->sb_dev_id) {
-- 
2.19.1

