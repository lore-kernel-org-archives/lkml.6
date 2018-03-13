Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932637AbeCMVGj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:06:39 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:46158 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeCMVGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:06:36 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v3 3/9] x86/microcode/AMD: install_equiv_cpu_table() should
 not return (signed) int
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1520973389.git.mail@maciej.szmigiero.name>
Message-ID: <cf57ed15-df47-087e-c98f-527e4ce1e0f8@maciej.szmigiero.name>
Date: Tue, 13 Mar 2018 22:06:34 +0100
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

The maximum possible value returned by install_equiv_cpu_table() is
UINT_MAX + CONTAINER_HDR_SZ (on a 64-bit kernel).
This is more than (signed) int type currently returned by this function can
hold so this function will need to return a size_t instead.

The individual (negative) error codes returned by this function are of no
use anyway, since they are all normalized to UCODE_ERROR by its caller
(__load_microcode_amd()).

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index ac06e2819f26..d20c327c960b 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -547,37 +547,38 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	return UCODE_UPDATED;
 }
 
-static int install_equiv_cpu_table(const u8 *buf, size_t buf_size)
+static size_t install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 {
 	unsigned int *ibuf = (unsigned int *)buf;
-	unsigned int type, size;
+	unsigned int type;
+	size_t size;
 
 	if (buf_size < CONTAINER_HDR_SZ) {
 		pr_err("no container header\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	type = ibuf[1];
 	if (type != UCODE_EQUIV_CPU_TABLE_TYPE) {
 		pr_err("invalid type field in container file section header\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	size = ibuf[2];
 	if (size < sizeof(struct equiv_cpu_entry)) {
 		pr_err("equivalent CPU table too short\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	if (buf_size - CONTAINER_HDR_SZ < size) {
 		pr_err("equivalent CPU table truncated\n");
-		return -EINVAL;
+		return 0;
 	}
 
 	equiv_cpu_table = vmalloc(size);
 	if (!equiv_cpu_table) {
 		pr_err("failed to allocate equivalent CPU table\n");
-		return -ENOMEM;
+		return 0;
 	}
 
 	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ, size);
@@ -672,13 +673,13 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 					     size_t size)
 {
 	enum ucode_state ret = UCODE_ERROR;
-	unsigned int leftover;
+	size_t leftover;
 	u8 *fw = (u8 *)data;
 	int crnt_size = 0;
-	int offset;
+	size_t offset;
 
 	offset = install_equiv_cpu_table(data, size);
-	if (offset < 0) {
+	if (!offset) {
 		pr_err("failed to create equivalent cpu table\n");
 		return ret;
 	}
