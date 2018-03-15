Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933009AbeCOXHy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 19:07:54 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:47298 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932526AbeCOXHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 19:07:52 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v4 02/10] x86/microcode/AMD: Check equivalence table length in
 the early loader
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1521150415.git.mail@maciej.szmigiero.name>
Message-ID: <fe4fe465-b114-ffa5-7c2a-3ccb5b9ba38c@maciej.szmigiero.name>
Date: Fri, 16 Mar 2018 00:07:50 +0100
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

This patch adds these checks to the early loader.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 6a93be0f771c..138c9fb983f2 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -80,20 +80,33 @@ static u16 find_equiv_id(struct equiv_cpu_entry *equiv_table, u32 sig)
  * Returns the amount of bytes consumed while scanning. @desc contains all the
  * data we're going to use in later stages of the application.
  */
-static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
+static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 {
 	struct equiv_cpu_entry *eq;
-	ssize_t orig_size = size;
+	size_t orig_size = size;
 	u32 *hdr = (u32 *)ucode;
+	unsigned int cont_magic, cont_type;
+	size_t equiv_tbl_len;
 	u16 eq_id;
 	u8 *buf;
 
+	if (size < CONTAINER_HDR_SZ)
+		return 0;
+
+	cont_magic	= hdr[0];
+	cont_type	= hdr[1];
+	equiv_tbl_len	= hdr[2];
+
 	/* Am I looking at an equivalence table header? */
-	if (hdr[0] != UCODE_MAGIC ||
-	    hdr[1] != UCODE_EQUIV_CPU_TABLE_TYPE ||
-	    hdr[2] == 0)
+	if (cont_magic != UCODE_MAGIC ||
+	    cont_type != UCODE_EQUIV_CPU_TABLE_TYPE ||
+	    equiv_tbl_len == 0)
 		return CONTAINER_HDR_SZ;
 
+	if (equiv_tbl_len < sizeof(*eq) ||
+	    size - CONTAINER_HDR_SZ < equiv_tbl_len)
+		return size;
+
 	buf = ucode;
 
 	eq = (struct equiv_cpu_entry *)(buf + CONTAINER_HDR_SZ);
@@ -101,8 +114,8 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
 	/* Find the equivalence ID of our CPU in this table: */
 	eq_id = find_equiv_id(eq, desc->cpuid_1_eax);
 
-	buf  += hdr[2] + CONTAINER_HDR_SZ;
-	size -= hdr[2] + CONTAINER_HDR_SZ;
+	buf  += equiv_tbl_len + CONTAINER_HDR_SZ;
+	size -= equiv_tbl_len + CONTAINER_HDR_SZ;
 
 	/*
 	 * Scan through the rest of the container to find where it ends. We do
@@ -159,15 +172,13 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
  */
 static void scan_containers(u8 *ucode, size_t size, struct cont_desc *desc)
 {
-	ssize_t rem = size;
-
-	while (rem >= 0) {
-		ssize_t s = parse_container(ucode, rem, desc);
+	while (size > 0) {
+		size_t s = parse_container(ucode, size, desc);
 		if (!s)
 			return;
 
 		ucode += s;
-		rem   -= s;
+		size  -= s;
 	}
 }
 
