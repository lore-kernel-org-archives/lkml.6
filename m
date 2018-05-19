Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeESWIf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 18:08:35 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:49444 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752575AbeESWHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 18:07:48 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/8] x86/microcode/AMD: Integrate verify_patch_size() into verify_patch()
Date: Sun, 20 May 2018 00:07:20 +0200
Message-Id: <f702095bdc483923f1090f3d75a1352128a8f459.1526767245.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1526767245.git.mail@maciej.szmigiero.name>
References: <cover.1526767245.git.mail@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the previous commit converted the late loader to do a full patch
checking via verify_patch() instead of calling verify_patch_size() directly
we can integrate the later function into the former because it was its only
user.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 72 +++++++++++------------------
 1 file changed, 27 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 3e10a5920f58..764dac82c03f 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -182,9 +182,6 @@ static bool verify_patch_section(const u8 *buf, size_t buf_size, bool early)
 	return true;
 }
 
-static unsigned int verify_patch_size(u8 family, u32 patch_size,
-				      unsigned int size);
-
 /*
  * Checks whether a microcode patch located at the beginning of a passed
  * buffer @buf of size @size is not too large for a particular @family
@@ -195,19 +192,43 @@ static unsigned int verify_patch_size(u8 family, u32 patch_size,
 static bool verify_patch(u8 family, const u8 *buf, size_t buf_size, bool early)
 {
 	const u32 *hdr = (const u32 *)buf;
-	u32 patch_size;
+	u32 patch_size, max_size;
 
 	if (!verify_patch_section(buf, buf_size, early))
 		return false;
 
 	patch_size = hdr[1];
 
+#define F1XH_MPB_MAX_SIZE 2048
+#define F14H_MPB_MAX_SIZE 1824
+#define F15H_MPB_MAX_SIZE 4096
+#define F16H_MPB_MAX_SIZE 3458
+#define F17H_MPB_MAX_SIZE 3200
+
+	switch (family) {
+	case 0x14:
+		max_size = F14H_MPB_MAX_SIZE;
+		break;
+	case 0x15:
+		max_size = F15H_MPB_MAX_SIZE;
+		break;
+	case 0x16:
+		max_size = F16H_MPB_MAX_SIZE;
+		break;
+	case 0x17:
+		max_size = F17H_MPB_MAX_SIZE;
+		break;
+	default:
+		max_size = F1XH_MPB_MAX_SIZE;
+		break;
+	}
+
 	/*
 	 * The section header length is not included in this indicated size
 	 * but is present in the leftover file length so we need to subtract
-	 * it before passing this value to the function below.
+	 * it from the leftover file length.
 	 */
-	if (!verify_patch_size(family, patch_size, buf_size - SECTION_HDR_SIZE)) {
+	if (patch_size > min_t(u32, max_size, buf_size - SECTION_HDR_SIZE)) {
 		if (!early)
 			pr_err("Patch of size %u too large.\n", patch_size);
 
@@ -612,45 +633,6 @@ static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 	return 0;
 }
 
-/*
- * Check whether the passed remaining file @size is large enough to contain a
- * patch of the indicated @patch_size (and also whether this size does not
- * exceed the per-family maximum).
- */
-static unsigned int verify_patch_size(u8 family, u32 patch_size, unsigned int size)
-{
-	u32 max_size;
-
-#define F1XH_MPB_MAX_SIZE 2048
-#define F14H_MPB_MAX_SIZE 1824
-#define F15H_MPB_MAX_SIZE 4096
-#define F16H_MPB_MAX_SIZE 3458
-#define F17H_MPB_MAX_SIZE 3200
-
-	switch (family) {
-	case 0x14:
-		max_size = F14H_MPB_MAX_SIZE;
-		break;
-	case 0x15:
-		max_size = F15H_MPB_MAX_SIZE;
-		break;
-	case 0x16:
-		max_size = F16H_MPB_MAX_SIZE;
-		break;
-	case 0x17:
-		max_size = F17H_MPB_MAX_SIZE;
-		break;
-	default:
-		max_size = F1XH_MPB_MAX_SIZE;
-		break;
-	}
-
-	if (patch_size > min_t(u32, size, max_size))
-		return 0;
-
-	return patch_size;
-}
-
 static enum ucode_state apply_microcode_amd(int cpu)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
