Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752968AbeCMVGw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:06:52 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:46596 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeCMVGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:06:50 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v3 4/9] x86/microcode/AMD: automatically compute the
 PATCH_MAX_SIZE macro
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1520973389.git.mail@maciej.szmigiero.name>
Message-ID: <de9e4416-0afa-ef07-2c0d-77aa7252a6ea@maciej.szmigiero.name>
Date: Tue, 13 Mar 2018 22:06:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1520973389.git.mail@maciej.szmigiero.name>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PATCH_MAX_SIZE macro should contain the maximum of all family patch
sizes, computed automatically so that future changes there don't cause an
inconsistency.

Unfortunately, we can't use a standard max{,3} macros for this since they
only work inside a function (they use a compound statement as an
expression) and we have a static array using this macro value as its
length.

This macro is specific to amd.c file so let's move it there (the max sizes
for families are in this file already).

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/include/asm/microcode_amd.h |  2 --
 arch/x86/kernel/cpu/microcode/amd.c  | 22 ++++++++++++++++------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index 209492849566..365bfa85a06b 100644
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -41,8 +41,6 @@ struct microcode_amd {
 	unsigned int			mpb[0];
 };
 
-#define PATCH_MAX_SIZE PAGE_SIZE
-
 #ifdef CONFIG_MICROCODE_AMD
 extern void __init load_ucode_amd_bsp(unsigned int family);
 extern void load_ucode_amd_ap(unsigned int family);
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index d20c327c960b..b9f6c06bdc16 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -40,6 +40,22 @@
 
 static struct equiv_cpu_entry *equiv_cpu_table;
 
+/* Maximum patch size for a particular family */
+#define F1XH_MPB_MAX_SIZE 2048
+#define F14H_MPB_MAX_SIZE 1824
+#define F15H_MPB_MAX_SIZE 4096
+#define F16H_MPB_MAX_SIZE 3458
+#define F17H_MPB_MAX_SIZE 3200
+
+/* Can't use a standard max{,3} since they only work inside a function */
+#define SIMPLE_MAX(x, y) ((x) > (y) ? (x) : (y))
+#define SIMPLE_MAX3(x, y, z) SIMPLE_MAX(SIMPLE_MAX(x, y), z)
+
+/* Maximum of all the above families */
+#define PATCH_MAX_SIZE SIMPLE_MAX3(F1XH_MPB_MAX_SIZE, F14H_MPB_MAX_SIZE, \
+		       SIMPLE_MAX3(F15H_MPB_MAX_SIZE, F16H_MPB_MAX_SIZE, \
+				   F17H_MPB_MAX_SIZE))
+
 /*
  * This points to the current valid container of microcode patches which we will
  * save from the initrd/builtin before jettisoning its contents. @mc is the
@@ -473,12 +489,6 @@ static unsigned int verify_patch_size(u8 family, u32 patch_size,
 {
 	u32 max_size;
 
-#define F1XH_MPB_MAX_SIZE 2048
-#define F14H_MPB_MAX_SIZE 1824
-#define F15H_MPB_MAX_SIZE 4096
-#define F16H_MPB_MAX_SIZE 3458
-#define F17H_MPB_MAX_SIZE 3200
-
 	switch (family) {
 	case 0x14:
 		max_size = F14H_MPB_MAX_SIZE;
