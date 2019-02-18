Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54232C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FC821903
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497513;
	bh=52jguU2lIT+tC5hQHCWzPFW4Jjo5ulyjtyV6HaEyWmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=adUmvoQYVH+gyeNJdBZ/FkvcHAudMrkitCcZvWvIF3UJsxZt7O4XApnOtYvuHJ08v
	 EQxvscCrIhm4aS0zvPwOu2oUQQV8Z+w/bNq3aat5k682PpLtDU8j8DTpJsjPXFnDDH
	 4vy3QK3vxXoMepne+HGCt65dEYUw2SNMe2iF6tV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfBRNpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:45:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731243AbfBRNpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:45:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17EBE21900;
        Mon, 18 Feb 2019 13:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497508;
        bh=52jguU2lIT+tC5hQHCWzPFW4Jjo5ulyjtyV6HaEyWmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ttjAfd4KyllCXYwkVHDDV/3EiPf+vumI3g4rqhlpRSOlodQiDQeVr5jYKZCPtgx4H
         VHHB/LsNQ4Kr2LPFUP7TC4nc0i3oE0oL4w8ESMAELpeY4hJGShg1mREAUHTdA5lzkF
         SWK4+GzG7FqM78rQPrsySjSHH/fhHy591/UAjOzQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>,
        Hui Kai <huikai@acoinfo.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 13/92] csky: fixup relocation error with 807 & 860
Date:   Mon, 18 Feb 2019 14:42:16 +0100
Message-Id: <20190218133455.892331522@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



