Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932555AbeCMVGR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:06:17 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:45186 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753075AbeCMVGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:06:12 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v3 1/9] x86/microcode/AMD: subtract SECTION_HDR_SIZE from file
 leftover length
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1520973389.git.mail@maciej.szmigiero.name>
Message-ID: <27607e8b-68bc-13f2-a2e6-8f77c8381f48@maciej.szmigiero.name>
Date: Tue, 13 Mar 2018 22:06:10 +0100
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

verify_patch_size() function verifies whether the microcode container file
remaining size is large enough to contain a patch of the indicated size.

However, the section header length is not included in this indicated size
but it is present in the leftover file length so it should be subtracted
from the leftover file length before passing this value to
verify_patch_size().

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index a998e1a7d46f..ffe0d0ce57fc 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -613,7 +613,8 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 		return crnt_size;
 	}
 
-	ret = verify_patch_size(family, patch_size, leftover);
+	ret = verify_patch_size(family, patch_size,
+				leftover - SECTION_HDR_SIZE);
 	if (!ret) {
 		pr_err("Patch-ID 0x%08x: size mismatch.\n", mc_hdr->patch_id);
 		return crnt_size;
