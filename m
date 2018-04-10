Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753365AbeDJNlv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:41:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50738 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752706AbeDJNlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:41:50 -0400
From: Colin King <colin.king@canonical.com>
To: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/microcode/AMD: fix read of uninitialized data
Date: Tue, 10 Apr 2018 14:41:23 +0100
Message-Id: <20180410134123.13832-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently function __load_ucode_amd can assign an uninitialized cp to *ret
if get_builtin_microcode returns false. This could cause function
load_ucode_amd_bsp to attempt to apply the microcode if the garbage data in
cp is non-zero.  Fix this by moving the zero'ing of cp from function
load_ucode_amd_bsp to __load_ucode_amd.

Detected by CoverityScan, CID#1398332 ("Uninitialized scalar variable")

Fixes: 69f5f983001f ("x86/microcode/AMD: Remove AP scanning optimization")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/x86/kernel/cpu/microcode/amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 0624957aa068..745135699233 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -254,7 +254,7 @@ static bool get_builtin_microcode(struct cpio_data *cp, unsigned int family)
 static void __load_ucode_amd(unsigned int cpuid_1_eax, struct cpio_data *ret)
 {
 	struct ucode_cpu_info *uci;
-	struct cpio_data cp;
+	struct cpio_data cp = { };
 	const char *path;
 	bool use_pa;
 
@@ -279,7 +279,7 @@ static void __load_ucode_amd(unsigned int cpuid_1_eax, struct cpio_data *ret)
 
 void __init load_ucode_amd_bsp(unsigned int cpuid_1_eax)
 {
-	struct cpio_data cp = { };
+	struct cpio_data cp;
 
 	__load_ucode_amd(cpuid_1_eax, &cp);
 	if (!(cp.data && cp.size))
-- 
2.15.1
