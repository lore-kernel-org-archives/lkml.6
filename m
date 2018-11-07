Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C3AC46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5842146E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5842146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbeKHCdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:33:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46544 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731484AbeKHCdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:33:50 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id w6oMVgTubGu6; Wed,  7 Nov 2018 18:02:37 +0100 (CET)
Received: from zn.tnic (p200300EC2BCBE000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:e000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C9BF41EC0291;
        Wed,  7 Nov 2018 18:02:36 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/16] x86/microcode/AMD: Move chipset-specific check into verify_patch()
Date:   Wed,  7 Nov 2018 18:02:11 +0100
Message-Id: <20181107170218.7596-10-bp@alien8.de>
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

... where it belongs.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index be46e1fda77f..ebac82357639 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -249,6 +249,12 @@ verify_patch(u8 family, const u8 *buf, unsigned int buf_size, bool early)
 	mc_hdr	= (struct microcode_header_amd *)(buf + SECTION_HDR_SIZE);
 	proc_id	= mc_hdr->processor_rev_id;
 
+	if (mc_hdr->nb_dev_id || mc_hdr->sb_dev_id) {
+		if (!early)
+			pr_err("Patch-ID 0x%08x: chipset-specific code unsupported.\n", mc_hdr->patch_id);
+		return 0;
+	}
+
 	patch_fam = 0xf + (proc_id >> 12);
 	if (patch_fam != family)
 		return 0;
@@ -741,12 +747,6 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 	mc_hdr	    = (struct microcode_header_amd *)(fw + SECTION_HDR_SIZE);
 	proc_id	    = mc_hdr->processor_rev_id;
 
-	if (mc_hdr->nb_dev_id || mc_hdr->sb_dev_id) {
-		pr_err("Patch-ID 0x%08x: chipset-specific code unsupported.\n",
-			mc_hdr->patch_id);
-		return crnt_size;
-	}
-
 	patch = kzalloc(sizeof(*patch), GFP_KERNEL);
 	if (!patch) {
 		pr_err("Patch allocation failure.\n");
-- 
2.19.1

