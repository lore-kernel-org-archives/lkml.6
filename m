Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8442C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FBC2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FBC2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeJRQ4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:56:01 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:23757 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727360AbeJRQ4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:56:00 -0400
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id w9I8ajq4003392
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 16:36:45 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9I8abWi003370;
        Thu, 18 Oct 2018 16:36:37 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 18 Oct 2018
 16:34:41 +0800
From:   Nickhu <nickhu@andestech.com>
To:     <greentime@andestech.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <deanbo422@gmail.com>, <zong@andestech.com>,
        <ebiederm@xmission.com>
CC:     Nickhu <nickhu@andestech.com>, <green.hu@gmail.com>
Subject: [PATCH 1/3] nds32: Fix instruction simulator bug for unaligned access handler.
Date:   Thu, 18 Oct 2018 16:34:32 +0800
Message-ID: <342d2fa512844702edca74f048fcb99b1710e034.1539654056.git.nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1539654056.git.nickhu@andestech.com>
References: <cover.1539654056.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9I8abWi003370
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	When emulating the 16 bits instructions, the mapping of general
purpose registers is not the same as 32 bits instructions.

	Example:
		'LWI450 r16, [r15]' 16-bit instruction will be decoded as
'1011010110001110', the target register field is decode as index=12.

    But the index of target register should be 16. So the mapping of
register in unaligned access handler is wrong.

Signed-off-by: Nickhu <nickhu@andestech.com>
---
 arch/nds32/mm/alignment.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/nds32/mm/alignment.c b/arch/nds32/mm/alignment.c
index e1aed9dc692d..66a556befd05 100644
--- a/arch/nds32/mm/alignment.c
+++ b/arch/nds32/mm/alignment.c
@@ -152,12 +152,16 @@ extern int va_writable(struct pt_regs *regs, unsigned long addr);
 
 int unalign_access_mode = 0, unalign_access_debug = 0;
 
-static inline unsigned long *idx_to_addr(struct pt_regs *regs, int idx)
+static inline unsigned long *idx_to_addr(struct pt_regs *regs, int idx,
+				int idx_mode)
 {
 	/* this should be consistent with ptrace.h */
-	if (idx >= 0 && idx <= 25)	/* R0-R25 */
-		return &regs->uregs[0] + idx;
-	else if (idx >= 28 && idx <= 30)	/* FP, GP, LP */
+	if (idx >= 0 && idx <= 25) {	/* R0-R25 */
+		if (idx_mode == 4 && idx > 11)
+			return &regs->uregs[0] + idx + 4;
+		else
+			return &regs->uregs[0] + idx;
+	} else if (idx >= 28 && idx <= 30)	/* FP, GP, LP */
 		return &regs->fp + (idx - 28);
 	else if (idx == 31)	/* SP */
 		return &regs->sp;
@@ -270,10 +274,10 @@ static inline int do_16(unsigned long inst, struct pt_regs *regs)
 	}
 
 	if (addr_mode == 3) {
-		unaligned_addr = *idx_to_addr(regs, RA3(inst));
+		unaligned_addr = *idx_to_addr(regs, RA3(inst), addr_mode);
 		source_idx = RA3(inst);
 	} else {
-		unaligned_addr = *idx_to_addr(regs, RA5(inst));
+		unaligned_addr = *idx_to_addr(regs, RA5(inst), addr_mode);
 		source_idx = RA5(inst);
 	}
 
@@ -293,16 +297,17 @@ static inline int do_16(unsigned long inst, struct pt_regs *regs)
 			return -EACCES;
 
 		get_data(unaligned_addr, &target_val, len);
-		*idx_to_addr(regs, target_idx) = target_val;
+		*idx_to_addr(regs, target_idx, idx_mode) = target_val;
 	} else {
 		if (!access_ok(VERIFY_WRITE, (void *)unaligned_addr, len))
 			return -EACCES;
-		target_val = *idx_to_addr(regs, target_idx);
+		target_val = *idx_to_addr(regs, target_idx, idx_mode);
 		set_data((void *)unaligned_addr, target_val, len);
 	}
 
 	if (!regular)
-		*idx_to_addr(regs, source_idx) = unaligned_addr + shift;
+		*idx_to_addr(regs, source_idx, idx_mode) =
+			unaligned_addr + shift;
 	regs->ipc += 2;
 
 	return 0;
@@ -312,10 +317,10 @@ static inline int do_16(unsigned long inst, struct pt_regs *regs)
 
 static inline int do_32(unsigned long inst, struct pt_regs *regs)
 {
-	int imm, regular, load, len, sign_ext;
+	int imm, regular, load, len, sign_ext, idx_mode = 5;
 	unsigned long unaligned_addr, target_val, shift;
 
-	unaligned_addr = *idx_to_addr(regs, RA(inst));
+	unaligned_addr = *idx_to_addr(regs, RA(inst), idx_mode);
 
 	switch ((inst >> 25) << 1) {
 
@@ -472,7 +477,7 @@ static inline int do_32(unsigned long inst, struct pt_regs *regs)
 	if (imm)
 		shift = GET_IMMSVAL(IMM(inst)) * len;
 	else
-		shift = *idx_to_addr(regs, RB(inst)) << SV(inst);
+		shift = *idx_to_addr(regs, RB(inst), idx_mode) << SV(inst);
 
 	if (regular)
 		unaligned_addr += shift;
@@ -485,21 +490,21 @@ static inline int do_32(unsigned long inst, struct pt_regs *regs)
 		get_data(unaligned_addr, &target_val, len);
 
 		if (sign_ext)
-			*idx_to_addr(regs, RT(inst)) =
+			*idx_to_addr(regs, RT(inst), idx_mode) =
 			    sign_extend(target_val, len);
 		else
-			*idx_to_addr(regs, RT(inst)) = target_val;
+			*idx_to_addr(regs, RT(inst), idx_mode) = target_val;
 	} else {
 
 		if (!access_ok(VERIFY_WRITE, (void *)unaligned_addr, len))
 			return -EACCES;
 
-		target_val = *idx_to_addr(regs, RT(inst));
+		target_val = *idx_to_addr(regs, RT(inst), idx_mode);
 		set_data((void *)unaligned_addr, target_val, len);
 	}
 
 	if (!regular)
-		*idx_to_addr(regs, RA(inst)) = unaligned_addr + shift;
+		*idx_to_addr(regs, RA(inst), idx_mode) = unaligned_addr + shift;
 
 	regs->ipc += 4;
 
-- 
2.17.0

