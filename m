Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933046AbeCOXIP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 19:08:15 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:47696 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932526AbeCOXIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 19:08:11 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v4 04/10] x86/microcode/AMD: install_equiv_cpu_table() should
 not return a signed int
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1521150415.git.mail@maciej.szmigiero.name>
Message-ID: <f3bc0f83-cd93-fb0b-82b5-37cc99458b9c@maciej.szmigiero.name>
Date: Fri, 16 Mar 2018 00:08:09 +0100
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

The maximum possible value returned by install_equiv_cpu_table() is
UINT_MAX (on a 64-bit kernel).
This is more than (signed) int type currently returned by this function can
hold so this function will need to return an unsigned int instead.

In order to avoid an overflow of this type on a 64-bit kernel we'll need to
also modify this function to return only the CPU equivalence table length
(without the container header length), leaving its single caller
(__load_microcode_amd()) the job of adding the container header length to
skip to the fist patch section.

The individual (negative) error codes returned by install_equiv_cpu_table()
are of no use anyway, since they are all normalized to UCODE_ERROR by its
caller.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index ed24200cf936..8e8df37f2f1b 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -551,40 +551,39 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	return UCODE_UPDATED;
 }
 
-static int install_equiv_cpu_table(const u8 *buf, size_t buf_size)
+static unsigned int install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 {
 	unsigned int *ibuf = (unsigned int *)buf;
 	unsigned int type, equiv_tbl_len;
 
 	if (buf_size <= CONTAINER_HDR_SZ) {
 		pr_err("Truncated microcode container header.\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	type = ibuf[1];
 	if (type != UCODE_EQUIV_CPU_TABLE_TYPE) {
 		pr_err("Wrong microcode container equivalence table type: %u.\n",
 		       type);
-		return -EINVAL;
+		return 0;
 	}
 
 	equiv_tbl_len = ibuf[2];
 	if (equiv_tbl_len < sizeof(struct equiv_cpu_entry) ||
 	    buf_size - CONTAINER_HDR_SZ < equiv_tbl_len) {
 		pr_err("Truncated equivalence table.\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	equiv_cpu_table = vmalloc(equiv_tbl_len);
 	if (!equiv_cpu_table) {
 		pr_err("failed to allocate equivalent CPU table\n");
-		return -ENOMEM;
+		return 0;
 	}
 
 	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ, equiv_tbl_len);
 
-	/* add header length */
-	return equiv_tbl_len + CONTAINER_HDR_SZ;
+	return equiv_tbl_len;
 }
 
 static void free_equiv_cpu_table(void)
@@ -681,18 +680,24 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 					     size_t size)
 {
 	enum ucode_state ret = UCODE_ERROR;
-	unsigned int leftover;
+	size_t leftover;
 	u8 *fw = (u8 *)data;
 	int crnt_size = 0;
-	int offset;
+	unsigned int offset;
 
 	offset = install_equiv_cpu_table(data, size);
-	if (offset < 0) {
+	if (!offset) {
 		pr_err("failed to create equivalent cpu table\n");
 		return ret;
 	}
+
+	/*
+	 * Skip also the container header, since install_equiv_cpu_table()
+	 * returns just the raw equivalence table size without the header
+	 */
+	fw += CONTAINER_HDR_SZ;
 	fw += offset;
-	leftover = size - offset;
+	leftover = size - CONTAINER_HDR_SZ - offset;
 
 	if (*(u32 *)fw != UCODE_UCODE_TYPE) {
 		pr_err("invalid type field in container file section header\n");
