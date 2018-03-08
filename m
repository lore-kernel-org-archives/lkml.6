Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755540AbeCHJZf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:25:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60101 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbeCHJZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:25:32 -0500
Date: Thu, 8 Mar 2018 01:25:19 -0800
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-854857f5944c59a881ff607b37ed9ed41d031a3b@git.kernel.org>
Cc: thomas.lendacky@amd.com, ashok.raj@intel.com,
        arjan.van.de.ven@intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, bp@suse.de, mingo@kernel.org
Reply-To: thomas.lendacky@amd.com, arjan.van.de.ven@intel.com,
        ashok.raj@intel.com, linux-kernel@vger.kernel.org, bp@suse.de,
        hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20180228102846.13447-2-bp@alien8.de>
References: <20180228102846.13447-2-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/microcode: Get rid of struct apply_microcode_ctx
Git-Commit-ID: 854857f5944c59a881ff607b37ed9ed41d031a3b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  854857f5944c59a881ff607b37ed9ed41d031a3b
Gitweb:     https://git.kernel.org/tip/854857f5944c59a881ff607b37ed9ed41d031a3b
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Wed, 28 Feb 2018 11:28:40 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 10:19:25 +0100

x86/microcode: Get rid of struct apply_microcode_ctx

It is a useless remnant from earlier times. Use the ucode_state enum
directly.

No functional change.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Link: https://lkml.kernel.org/r/20180228102846.13447-2-bp@alien8.de

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
 
