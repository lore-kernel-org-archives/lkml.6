Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933101AbeCOXIZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 19:08:25 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:47824 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933085AbeCOXIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 19:08:22 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v4 07/10] x86/microcode/AMD: Verify patch section type for
 every such section
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1521150415.git.mail@maciej.szmigiero.name>
Message-ID: <712833d8-3468-a590-b92c-711e3bb9dff7@maciej.szmigiero.name>
Date: Fri, 16 Mar 2018 00:08:20 +0100
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

We should check whether the patch section currently being processed is
actually a patch section for each of them (not just the first one) in the
late loader verify_and_add_patch() function, just like the early loader
already does in parse_container() function.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 096cb58a563f..4d2116d08754 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -613,13 +613,19 @@ static int verify_and_add_patch(u8 family, u8 *fw, size_t leftover)
 {
 	struct microcode_header_amd *mc_hdr;
 	struct ucode_patch *patch;
-	unsigned int patch_size, crnt_size, ret;
+	unsigned int patch_type, patch_size, crnt_size, ret;
 	u32 proc_fam;
 	u16 proc_id;
 
 	if (leftover < SECTION_HDR_SIZE + sizeof(*mc_hdr))
 		return leftover;
 
+	patch_type = *(u32 *)fw;
+	if (patch_type != UCODE_UCODE_TYPE) {
+		pr_err("invalid type field in container file section header\n");
+		return -EINVAL;
+	}
+
 	patch_size  = *(u32 *)(fw + 4);
 	if (patch_size > PATCH_MAX_SIZE) {
 		pr_err("patch size %u too large\n", patch_size);
@@ -711,12 +717,6 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 	fw += offset;
 	leftover = size - CONTAINER_HDR_SZ - offset;
 
-	if (*(u32 *)fw != UCODE_UCODE_TYPE) {
-		pr_err("invalid type field in container file section header\n");
-		free_equiv_cpu_table();
-		return ret;
-	}
-
 	while (leftover) {
 		crnt_size = verify_and_add_patch(family, fw, leftover);
 		if (crnt_size < 0)
