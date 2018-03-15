Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933119AbeCOXI3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 19:08:29 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:47948 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933093AbeCOXIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 19:08:25 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v4 08/10] x86/microcode/AMD: Check microcode container file
 size before accessing it
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1521150415.git.mail@maciej.szmigiero.name>
Message-ID: <e0376cb1-3eb0-9d37-9097-558f8469e42a@maciej.szmigiero.name>
Date: Fri, 16 Mar 2018 00:08:24 +0100
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
index 4d2116d08754..dc5ed4971879 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -125,6 +125,9 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 		struct microcode_amd *mc;
 		u32 patch_size;
 
+		if (size < SECTION_HDR_SIZE)
+			break;
+
 		hdr = (u32 *)buf;
 
 		if (hdr[0] != UCODE_UCODE_TYPE)
@@ -139,6 +142,10 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 		buf  += SECTION_HDR_SIZE;
 		size -= SECTION_HDR_SIZE;
 
+		if (size < sizeof(*mc) ||
+		    size < patch_size)
+			break;
+
 		mc = (struct microcode_amd *)buf;
 		if (eq_id == mc->hdr.processor_rev_id) {
 			desc->psize = patch_size;
@@ -794,6 +801,10 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device,
 	}
 
 	ret = UCODE_ERROR;
+	if (fw->size < sizeof(u32)) {
+		pr_err("microcode container far too short\n");
+		goto fw_release;
+	}
 	if (*(u32 *)fw->data != UCODE_MAGIC) {
 		pr_err("invalid magic value (0x%08x)\n", *(u32 *)fw->data);
 		goto fw_release;
