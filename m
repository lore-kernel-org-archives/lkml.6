Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933027AbeCOXII (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 19:08:08 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:47532 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932526AbeCOXIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 19:08:07 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v4 03/10] x86/microcode/AMD: Check equivalence table length in
 the late loader
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1521150415.git.mail@maciej.szmigiero.name>
Message-ID: <1f29f9f9-0a9e-11e2-8e61-ba7c171e2bd9@maciej.szmigiero.name>
Date: Fri, 16 Mar 2018 00:08:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1521150415.git.mail@maciej.szmigiero.name>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before loading a CPU equivalence table from a microcode container file we
need to verify whether this file is actually large enough to contain the
table of a size indicated in this file.
If it is not, there is no point of continuing with loading it since
microcode patches are located after the equivalence table anyway.

This patch adds these checks to the late loader.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 138c9fb983f2..ed24200cf936 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -551,28 +551,40 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	return UCODE_UPDATED;
 }
 
-static int install_equiv_cpu_table(const u8 *buf)
+static int install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 {
 	unsigned int *ibuf = (unsigned int *)buf;
-	unsigned int type = ibuf[1];
-	unsigned int size = ibuf[2];
+	unsigned int type, equiv_tbl_len;
 
-	if (type != UCODE_EQUIV_CPU_TABLE_TYPE || !size) {
-		pr_err("empty section/"
-		       "invalid type field in container file section header\n");
+	if (buf_size <= CONTAINER_HDR_SZ) {
+		pr_err("Truncated microcode container header.\n");
 		return -EINVAL;
 	}
 
-	equiv_cpu_table = vmalloc(size);
+	type = ibuf[1];
+	if (type != UCODE_EQUIV_CPU_TABLE_TYPE) {
+		pr_err("Wrong microcode container equivalence table type: %u.\n",
+		       type);
+		return -EINVAL;
+	}
+
+	equiv_tbl_len = ibuf[2];
+	if (equiv_tbl_len < sizeof(struct equiv_cpu_entry) ||
+	    buf_size - CONTAINER_HDR_SZ < equiv_tbl_len) {
+		pr_err("Truncated equivalence table.\n");
+		return -EINVAL;
+	}
+
+	equiv_cpu_table = vmalloc(equiv_tbl_len);
 	if (!equiv_cpu_table) {
 		pr_err("failed to allocate equivalent CPU table\n");
 		return -ENOMEM;
 	}
 
-	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ, size);
+	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ, equiv_tbl_len);
 
 	/* add header length */
-	return size + CONTAINER_HDR_SZ;
+	return equiv_tbl_len + CONTAINER_HDR_SZ;
 }
 
 static void free_equiv_cpu_table(void)
@@ -674,7 +686,7 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 	int crnt_size = 0;
 	int offset;
 
-	offset = install_equiv_cpu_table(data);
+	offset = install_equiv_cpu_table(data, size);
 	if (offset < 0) {
 		pr_err("failed to create equivalent cpu table\n");
 		return ret;
