Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753208AbeCMVHG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:07:06 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:47638 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752611AbeCMVHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:07:03 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v3 6/9] x86/microcode/AMD: verify patch section type for every
 such section
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1520973389.git.mail@maciej.szmigiero.name>
Message-ID: <c22d8453-e72a-4708-7aa1-3c19256881b1@maciej.szmigiero.name>
Date: Tue, 13 Mar 2018 22:07:01 +0100
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

We should check whether the patch section currently being processed is
actually a patch section for each of them (not just the first one) in the
late loader verify_and_add_patch() function, just like the early loader
already does in parse_container() function.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 0f78200f2f6c..3ad23e72c2b0 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -627,6 +627,11 @@ static int verify_and_add_patch(u8 family, u8 *fw, size_t leftover)
 	if (leftover < SECTION_HDR_SIZE + sizeof(*mc_hdr))
 		return leftover;
 
+	if (*(u32 *)fw != UCODE_UCODE_TYPE) {
+		pr_err("invalid type field in container file section header\n");
+		return -EINVAL;
+	}
+
 	patch_size  = *(u32 *)(fw + 4);
 	if (patch_size > PATCH_MAX_SIZE) {
 		pr_err("patch size %u too large\n", patch_size);
@@ -704,12 +709,6 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 	fw += offset;
 	leftover = size - offset;
 
-	if (*(u32 *)fw != UCODE_UCODE_TYPE) {
-		pr_err("invalid type field in container file section header\n");
-		free_equiv_cpu_table();
-		return ret;
-	}
-
 	while (leftover) {
 		crnt_size = verify_and_add_patch(family, fw, leftover);
 		if (crnt_size < 0)
