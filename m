Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC11C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0F120827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546964821;
	bh=64GvxRqalkwbJOhimS3MRy6tLjHfLjrlLw1hDaevgfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tx7vuxYUvWtH80qTDFgf066OftuvV5ELQCkpRRPfF9yHZ19UKkRjE0Abn0n5N/kGW
	 tj4yYZ23QVIiMCjKy+cpFLfMsURvs/Hg2/SMDtvDNDmB47SCPrXMGGxHQ1EgSJ7j2S
	 6mcMbaVSZ/SyhVn+PBTFtpcdWCL3/FMWPsYQ35ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfAHQ1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:27:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:36054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729389AbfAHQ06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:26:58 -0500
Received: from localhost.localdomain (unknown [218.0.237.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC26E214C6;
        Tue,  8 Jan 2019 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546964817;
        bh=64GvxRqalkwbJOhimS3MRy6tLjHfLjrlLw1hDaevgfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ik0Uq1AXQVkkDjwU180gQlZhzVcb3ext6eWYjmHiUGnTN3gpuqn62LWoPsd5ylwRw
         cPTOU3NuDpxSrOSxMh+sbNaksEtDZowPdJ1nbhKDTxsKBcfkFv+FTCfPOM8oWXQmK5
         BOlZfkKUOBHwfU+IWLyVBTlsqHwAdZNduHfx3kWI=
From:   guoren@kernel.org
To:     tglx@linutronix.de, marc.zyngier@arm.com, arnd@arndb.de
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, mhocko@kernel.org,
        torvalds@linux-foundation.org, linux@roeck-us.net,
        Guo Ren <ren_guo@c-sky.com>, Hui Kai <huikai@acoinfo.com>
Subject: [PATCH 2/5] csky: fixup relocation error with 807 & 860
Date:   Wed,  9 Jan 2019 00:26:35 +0800
Message-Id: <1546964798-30067-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546964798-30067-1-git-send-email-guoren@kernel.org>
References: <1546964798-30067-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

810 doesn't support jsri instruction and csky-as will leave
jsri + nop for relocation. Module-probe need replace them with
lrw + jsr.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Hui Kai <huikai@acoinfo.com>
---
 arch/csky/kernel/module.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/csky/kernel/module.c b/arch/csky/kernel/module.c
index 65abab0..0b028ee 100644
--- a/arch/csky/kernel/module.c
+++ b/arch/csky/kernel/module.c
@@ -12,7 +12,7 @@
 #include <linux/spinlock.h>
 #include <asm/pgtable.h>
 
-#if defined(__CSKYABIV2__)
+#ifdef CONFIG_CPU_CK810
 #define IS_BSR32(hi16, lo16)		(((hi16) & 0xFC00) == 0xE000)
 #define IS_JSRI32(hi16, lo16)		((hi16) == 0xEAE0)
 
@@ -25,6 +25,26 @@
 	*(uint16_t *)(addr) = 0xE8Fa;		\
 	*((uint16_t *)(addr) + 1) = 0x0000;	\
 } while (0)
+
+static void jsri_2_lrw_jsr(uint32_t *location)
+{
+	uint16_t location_tmp = (uint16_t *)location;
+
+	if (IS_BSR32(*location_tmp, *(location_tmp + 1)))
+		return;
+
+	if (IS_JSRI32(*location_tmp, *(location_tmp + 1))) {
+		/* jsri 0x...  --> lrw r26, 0x... */
+		CHANGE_JSRI_TO_LRW(location);
+		/* lsli r0, r0 --> jsr r26 */
+		SET_JSR32_R26(location + 1);
+	}
+}
+#else
+static void inline jsri_2_lrw_jsr(uint32_t *location)
+{
+	return;
+}
 #endif
 
 int apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
@@ -35,9 +55,6 @@ int apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
 	Elf32_Sym	*sym;
 	uint32_t	*location;
 	short		*temp;
-#if defined(__CSKYABIV2__)
-	uint16_t	*location_tmp;
-#endif
 
 	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
 		/* This is where to make the change */
@@ -59,18 +76,7 @@ int apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
 		case R_CSKY_PCRELJSR_IMM11BY2:
 			break;
 		case R_CSKY_PCRELJSR_IMM26BY2:
-#if defined(__CSKYABIV2__)
-			location_tmp = (uint16_t *)location;
-			if (IS_BSR32(*location_tmp, *(location_tmp + 1)))
-				break;
-
-			if (IS_JSRI32(*location_tmp, *(location_tmp + 1))) {
-				/* jsri 0x...  --> lrw r26, 0x... */
-				CHANGE_JSRI_TO_LRW(location);
-				/* lsli r0, r0 --> jsr r26 */
-				SET_JSR32_R26(location + 1);
-			}
-#endif
+			jsri_2_lrw_jsr(location);
 			break;
 		case R_CSKY_ADDR_HI16:
 			temp = ((short  *)location) + 1;
-- 
2.7.4

