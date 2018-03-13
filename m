Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbeCMVHO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:07:14 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:47966 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752611AbeCMVHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:07:12 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v3 7/9] x86/microcode/AMD: check microcode container file size
 before accessing it
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1520973389.git.mail@maciej.szmigiero.name>
Message-ID: <4acc25d2-cd24-d445-2bd8-50512f0e8a39@maciej.szmigiero.name>
Date: Tue, 13 Mar 2018 22:07:10 +0100
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

The early loader parse_container() function should check whether the
microcode container file is actually large enough to contain the patch of
an indicated size, just like the late loader does.

Also, the request_microcode_amd() function should check whether the
container file is actually large enough to contain the header magic value.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 3ad23e72c2b0..63bd1a63f98a 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -137,6 +137,9 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 		struct microcode_amd *mc;
 		u32 patch_size;
 
+		if (size < SECTION_HDR_SIZE)
+			break;
+
 		hdr = (u32 *)buf;
 
 		if (hdr[0] != UCODE_UCODE_TYPE)
@@ -151,6 +154,10 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 		buf  += SECTION_HDR_SIZE;
 		size -= SECTION_HDR_SIZE;
 
+		if (size < sizeof(*mc) ||
+		    size < patch_size)
+			break;
+
 		mc = (struct microcode_amd *)buf;
 		if (eq_id == mc->hdr.processor_rev_id) {
 			desc->psize = patch_size;
@@ -786,6 +793,10 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device,
 	}
 
 	ret = UCODE_ERROR;
+	if (fw->size < sizeof(u32)) {
+		pr_err("microcode container far too short\n");
+		goto fw_release;
+	}
 	if (*(u32 *)fw->data != UCODE_MAGIC) {
 		pr_err("invalid magic value (0x%08x)\n", *(u32 *)fw->data);
 		goto fw_release;
