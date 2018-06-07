Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MYz8JJcIGVt6UwAAmS7hNA
	; Thu, 07 Jun 2018 10:27:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 84556607E7; Thu,  7 Jun 2018 10:27:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 023F5602FC;
	Thu,  7 Jun 2018 10:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 023F5602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932673AbeFGK1c (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:27:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:60296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932118AbeFGK13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:27:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F36F5ADF5;
        Thu,  7 Jun 2018 10:27:27 +0000 (UTC)
From: Andreas Schwab <schwab@suse.de>
To: linux-riscv@lists.infradead.org
Subject: [PATCH] RISC-V: Handle R_RISCV_32 in modules
CC: linux-kernel@vger.kernel.org
X-Yow: There's a little picture of ED MCMAHON doing BAD THINGS to JOAN RIVERS
 in a $200,000 MALIBU BEACH HOUSE!!
Date: Thu, 07 Jun 2018 12:27:27 +0200
Message-ID: <mvm7enaki28.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_MODVERSIONS=y the R_RISCV_32 relocation is used by the
__kcrctab section.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 arch/riscv/kernel/module.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 5dddba301d..1d5e9b934b 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -17,6 +17,17 @@
 #include <linux/errno.h>
 #include <linux/moduleloader.h>
 
+static int apply_r_riscv_32_rela(struct module *me, u32 *location, Elf_Addr v)
+{
+	if (v != (u32)v) {
+		pr_err("%s: value %016llx out of range for 32-bit field\n",
+		       me->name, v);
+		return -EINVAL;
+	}
+	*location = v;
+	return 0;
+}
+
 static int apply_r_riscv_64_rela(struct module *me, u32 *location, Elf_Addr v)
 {
 	*(u64 *)location = v;
@@ -265,6 +276,7 @@ static int apply_r_riscv_sub32_rela(struct module *me, u32 *location,
 
 static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
 				Elf_Addr v) = {
+	[R_RISCV_32]			= apply_r_riscv_32_rela,
 	[R_RISCV_64]			= apply_r_riscv_64_rela,
 	[R_RISCV_BRANCH]		= apply_r_riscv_branch_rela,
 	[R_RISCV_JAL]			= apply_r_riscv_jal_rela,
-- 
2.17.1


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
