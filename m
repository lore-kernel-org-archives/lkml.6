Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A590CC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B4020643
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738648;
	bh=gcET8lgoXkRG/uBMnL6wtuieGKpVKv8Z3yBvaczgZ/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N+y1tdZxUuNjm4g7CVrbhevgRiNKeiNiUfgFeXBNrc90WqynVMjhMZpinC1lIrIHP
	 9F32uJJTvUv6YoKbfMVXmPIrkBSFShYv7X6rSIN02gl5VV9NQ4wqRBT2ktvrJ0NQcA
	 jFkUKQrsR2vGzvm/jHpN5vFf5zrd7mKZH7ppP00Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfBIS51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:57:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:60370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727375AbfBISrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:47:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 697E921919;
        Sat,  9 Feb 2019 18:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738066;
        bh=gcET8lgoXkRG/uBMnL6wtuieGKpVKv8Z3yBvaczgZ/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYmhmsw9PY0+GBBqIO5mpVQInCQJsQXwe7OeVFU1Z1I3sSPxpUmZJLdUVHVQTvDyQ
         VpjH3W1cAuEUttopK45a4JrOcdnz8HQ0HsuTK29KC+ngKR9+mDTAHzZrec+izIIRK5
         svGM3UPCibvwfwGg7q0qzRs2IQY2HStpG+PBPEnU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guo Ren <ren_guo@c-sky.com>, Hui Kai <huikai@acoinfo.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 10/42] csky: fixup relocation error with 807 & 860
Date:   Sat,  9 Feb 2019 13:47:02 -0500
Message-Id: <20190209184734.125935-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

[ Upstream commit f553aa1c13cbc29aaf420349a28fc33ca98440e5 ]

810 doesn't support jsri instruction and csky-as will leave
jsri + nop for relocation. Module-probe need replace them with
lrw + jsr.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Hui Kai <huikai@acoinfo.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/kernel/module.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/csky/kernel/module.c b/arch/csky/kernel/module.c
index 65abab0c7a47..0b028ee3c764 100644
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
2.19.1

