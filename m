Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2386C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15F420827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15F420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbeKHCe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:34:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46498 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731397AbeKHCdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:33:45 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fhsl2TsyX1D3; Wed,  7 Nov 2018 18:02:31 +0100 (CET)
Received: from zn.tnic (p200300EC2BCBE000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:e000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 852661EC0291;
        Wed,  7 Nov 2018 18:02:31 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/16] x86/microcode/AMD: Move verify_patch_size() up in the file
Date:   Wed,  7 Nov 2018 18:02:05 +0100
Message-Id: <20181107170218.7596-4-bp@alien8.de>
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

... to enable later improvements.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 82 ++++++++++++++---------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 36aeb01b3ae8..f8d60cb9bb9a 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -174,6 +174,47 @@ static bool verify_patch_section(const u8 *buf, size_t buf_size, bool early)
 	return true;
 }
 
+/*
+ * Check whether the passed remaining file @size is large enough to contain a
+ * patch of the indicated @patch_size (and also whether this size does not
+ * exceed the per-family maximum).
+ */
+static unsigned int verify_patch_size(u8 family, u32 patch_size, unsigned int size)
+{
+	u32 max_size;
+
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
+	if (patch_size > min_t(u32, size, max_size)) {
+		pr_err("patch size mismatch\n");
+		return 0;
+	}
+
+	return patch_size;
+}
+
 /*
  * This scans the ucode blob for the proper container as we can have multiple
  * containers glued together. Returns the equivalence ID from the equivalence
@@ -562,47 +603,6 @@ static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
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
-	if (patch_size > min_t(u32, size, max_size)) {
-		pr_err("patch size mismatch\n");
-		return 0;
-	}
-
-	return patch_size;
-}
-
 static enum ucode_state apply_microcode_amd(int cpu)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
-- 
2.19.1

