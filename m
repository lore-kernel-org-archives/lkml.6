Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933082AbeCOXIW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 19:08:22 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:47782 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933051AbeCOXIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 19:08:19 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v4 06/10] x86/microcode/AMD: Check patch size in
 verify_and_add_patch()
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1521150415.git.mail@maciej.szmigiero.name>
Message-ID: <30562911-7fde-782b-d1b2-03e30b6987c5@maciej.szmigiero.name>
Date: Fri, 16 Mar 2018 00:08:17 +0100
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

We should verify the indicated size of a patch in a microcode container
file (whether it does not exceed the PATCH_MAX_SIZE value) and also whether
this file is actually large enough to contain it in the late loader
verify_and_add_patch() function.

The early loader already does the PATCH_MAX_SIZE check in parse_container()
function.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index eba9e3c8aa17..096cb58a563f 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -473,7 +473,7 @@ static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 }
 
 static unsigned int verify_patch_size(u8 family, u32 patch_size,
-				      unsigned int size)
+				      size_t size)
 {
 	u32 max_size;
 
@@ -505,7 +505,7 @@ static unsigned int verify_patch_size(u8 family, u32 patch_size,
 		break;
 	}
 
-	if (patch_size > min_t(u32, size, max_size)) {
+	if (patch_size > min_t(size_t, size, max_size)) {
 		pr_err("patch size mismatch\n");
 		return 0;
 	}
@@ -609,7 +609,7 @@ static void cleanup(void)
  * driver cannot continue functioning normally. In such cases, we tear
  * down everything we've used up so far and exit.
  */
-static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
+static int verify_and_add_patch(u8 family, u8 *fw, size_t leftover)
 {
 	struct microcode_header_amd *mc_hdr;
 	struct ucode_patch *patch;
@@ -617,7 +617,15 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 	u32 proc_fam;
 	u16 proc_id;
 
+	if (leftover < SECTION_HDR_SIZE + sizeof(*mc_hdr))
+		return leftover;
+
 	patch_size  = *(u32 *)(fw + 4);
+	if (patch_size > PATCH_MAX_SIZE) {
+		pr_err("patch size %u too large\n", patch_size);
+		return -EINVAL;
+	}
+
 	crnt_size   = patch_size + SECTION_HDR_SIZE;
 	mc_hdr	    = (struct microcode_header_amd *)(fw + SECTION_HDR_SIZE);
 	proc_id	    = mc_hdr->processor_rev_id;
