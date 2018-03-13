Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933069AbeCMLm1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:42:27 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:54127 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933034AbeCMLmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:42:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: fix undefined reference to 'printk'
Date: Tue, 13 Mar 2018 12:41:41 +0100
Message-Id: <20180313114202.1977512-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:U1ifi3t5oDSw750VgHRFPRs+atECevdLU7JfMLSPODKNGYOoHZ1
 1Jq4UlWF7y5GlHPlWFh47RnwS2x7YePF66P7mgEGupD0mkmeKE1/fsQppG/dihgHjB6UKCU
 plhQGvTj+hkpxGLaWvDOyEZSMIWs/AMUptzSTKzwb/khE28T8FPCLmT4fdwPEVHsbJ5aZPp
 po0M8LO5TsoSygW6u1p2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0OCtW/AB02c=:EJZgnvnyMSGbfv/jVCsY3x
 GU3wdSXP4knuNr2kpu4IEYVuoUeRwbiKYlchfqdt7yk1AC3ptt7lwru62VbDnGRih7XXLYCyV
 sVTfWiz51WXUt0ks454yAfflKtFU/JrTVFmq/78wEaaDfc/BaZlWfJ5IGVfb4oGcZ2QLxXyNh
 7hFx2vQythM5MLlR/+1/QYlndgXDl7gLTlx6k/HLdbHfVcXgd1R5mXJ2KqnAia/ZV8RCAY+Dv
 Q8CWK/3mxVP2QzP8DnoqeIVV94QteqPGQvAUycXpZfKpHV5ztx5pupqrGxhwS6pZMaTI2pDjg
 33bO/L/0vE+xP8Y38KBtJl/leDY4Z0ReYNwTiIpCGOdrrBhag3DXwokpUIw5OF1UbEsQGWsf1
 khRd+y04q63zK8WjkaWSVjJwQGJyX14MU4L4UflDrcP42JxUcjt3hVZJtncf0cnoyNgDUwkzV
 DLjLCqn1yrObtUdthKhVjHt7OgzXFoaQEgmlCBFEUjAOoayPpnHjFiNd1yopNqRmnqOWjUQkX
 L9+7g2hyB43wU0hipKk1GmKDZMmWczR61zLb0mT5OmqSjOuGV0PkQjXLaZ+THPFWwIGQlyKsD
 Xn1hkG0IuaAkdiMH12nGjQjdkd1WWV3HyKOzqzgJQxEN/NDS9ikBuTzUA+/+ZrsaYO7J1NTi8
 i2GuCifD0S5GmYeNjxnzLlEJJw1Kof6eitt04MKw0KCynRxxC+UE2VN2T4yHII3ogf1wKrWFw
 Uta8u7ZZxPb1/LBhYKA6E19NwZKWEzg9YujvGA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printk symbol was intended as a generic address that is always
exported, however that turned out to be false with CONFIG_PRINTK=n:

ERROR: "printk" [arch/arm64/kernel/arm64-reloc-test.ko] undefined!

This changes the references to memstart_addr, which should be there
regardless of configuration.

Fixes: a257e02579e4 ("arm64/kernel: don't ban ADRP to work around Cortex-A53 erratum #843419")
Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/reloc_test_core.c | 2 +-
 arch/arm64/kernel/reloc_test_syms.S | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/reloc_test_core.c b/arch/arm64/kernel/reloc_test_core.c
index a70489c584c7..5915ce5759cc 100644
--- a/arch/arm64/kernel/reloc_test_core.c
+++ b/arch/arm64/kernel/reloc_test_core.c
@@ -45,7 +45,7 @@ static struct {
 	{ "R_AARCH64_MOVW_SABS_Gn",	signed_movw, UL(SYM64_ABS_VAL) },
 	{ "R_AARCH64_MOVW_UABS_Gn",	unsigned_movw, UL(SYM64_ABS_VAL) },
 	{ "R_AARCH64_ADR_PREL_PG_HI21",	relative_adrp, (u64)&sym64_rel },
-	{ "R_AARCH64_ADR_PREL_PG_HI21",	relative_adrp_far, (u64)&printk },
+	{ "R_AARCH64_ADR_PREL_PG_HI21",	relative_adrp_far, (u64)&memstart_addr },
 	{ "R_AARCH64_ADR_PREL_LO21",	relative_adr, (u64)&sym64_rel },
 	{ "R_AARCH64_PREL64",		relative_data64, (u64)&sym64_rel },
 	{ "R_AARCH64_PREL32",		relative_data32, (u64)&sym64_rel },
diff --git a/arch/arm64/kernel/reloc_test_syms.S b/arch/arm64/kernel/reloc_test_syms.S
index f333b4b7880d..2b8d9cb8b078 100644
--- a/arch/arm64/kernel/reloc_test_syms.S
+++ b/arch/arm64/kernel/reloc_test_syms.S
@@ -54,8 +54,8 @@ ENDPROC(relative_adrp)
 	.align	12
 	.space	0xffc
 ENTRY(relative_adrp_far)
-	adrp	x0, printk
-	add	x0, x0, #:lo12:printk
+	adrp	x0, memstart_addr
+	add	x0, x0, #:lo12:memstart_addr
 	ret
 ENDPROC(relative_adrp_far)
 
-- 
2.9.0
