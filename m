Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933144AbeCOXIf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 19:08:35 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:48098 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933122AbeCOXIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 19:08:32 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v4 10/10] x86/microcode/AMD: Be more tolerant of late parse
 failures in late loader
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1521150415.git.mail@maciej.szmigiero.name>
Message-ID: <a3f9d308-eaed-7544-b7a8-789df98daaf6@maciej.szmigiero.name>
Date: Fri, 16 Mar 2018 00:08:30 +0100
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

The early loader just ends its microcode container file processing when it
is unable to parse some patch section, but keeps the already read patches
from this file for their eventual application.

We can do the same in the late loader - we'll just return an error if we
are unable to parse any patches.
Note that we already do silently skip patches in the late loader for
smaller issues like lack of an equivalence table entry, family-size
mismatch or an unsupported chipset match type.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 6e25a63a0a3d..f9278d9a2f9b 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -738,13 +738,15 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 	while (leftover) {
 		crnt_size = verify_and_add_patch(family, fw, leftover);
 		if (crnt_size < 0)
-			return ret;
+			break;
 
 		fw	 += crnt_size;
 		leftover -= crnt_size;
+
+		ret = UCODE_OK;
 	}
 
-	return UCODE_OK;
+	return ret;
 }
 
 static enum ucode_state
