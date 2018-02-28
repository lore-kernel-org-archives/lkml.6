Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752543AbeB1K3W (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:29:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37112 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752289AbeB1K3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:29:16 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] x86/microcode: Get rid of struct apply_microcode_ctx
Date: Wed, 28 Feb 2018 11:28:40 +0100
Message-Id: <20180228102846.13447-2-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180228102846.13447-1-bp@alien8.de>
References: <20180228102846.13447-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

It is a useless remnant from earlier times. Use the ucode_state enum
directly.

No functionality change.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/core.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index aa1b9a422f2b..63370651e376 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -373,26 +373,23 @@ static int collect_cpu_info(int cpu)
 	return ret;
 }
 
-struct apply_microcode_ctx {
-	enum ucode_state err;
-};
-
 static void apply_microcode_local(void *arg)
 {
-	struct apply_microcode_ctx *ctx = arg;
+	enum ucode_state *err = arg;
 
-	ctx->err = microcode_ops->apply_microcode(smp_processor_id());
+	*err = microcode_ops->apply_microcode(smp_processor_id());
 }
 
 static int apply_microcode_on_target(int cpu)
 {
-	struct apply_microcode_ctx ctx = { .err = 0 };
+	enum ucode_state err;
 	int ret;
 
-	ret = smp_call_function_single(cpu, apply_microcode_local, &ctx, 1);
-	if (!ret)
-		ret = ctx.err;
-
+	ret = smp_call_function_single(cpu, apply_microcode_local, &err, 1);
+	if (!ret) {
+		if (err == UCODE_ERROR)
+			ret = 1;
+	}
 	return ret;
 }
 
-- 
2.13.0
