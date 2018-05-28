Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165048AbeE1LFB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164596AbeE1LEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:04:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Hellstrom <thellstrom@vmware.com>,
        Brian Paul <brianp@vmware.com>, Sinclair Yeh <syeh@vmware.com>
Subject: [PATCH 4.16 023/272] drm/vmwgfx: Fix 32-bit VMW_PORT_HB_[IN|OUT] macros
Date: Mon, 28 May 2018 12:00:56 +0200
Message-Id: <20180528100242.464675671@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellstrom <thellstrom@vmware.com>

commit 938ae7259c908ad031da35d551da297640bb640c upstream.

Depending on whether the kernel is compiled with frame-pointer or not,
the temporary memory location used for the bp parameter in these macros
is referenced relative to the stack pointer or the frame pointer.
Hence we can never reference that parameter when we've modified either
the stack pointer or the frame pointer, because then the compiler would
generate an incorrect stack reference.

Fix this by pushing the temporary memory parameter on a known location on
the stack before modifying the stack- and frame pointers.

Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Brian Paul <brianp@vmware.com>
Reviewed-by: Sinclair Yeh <syeh@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.h |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.h
@@ -135,17 +135,24 @@
 
 #else
 
-/* In the 32-bit version of this macro, we use "m" because there is no
- * more register left for bp
+/*
+ * In the 32-bit version of this macro, we store bp in a memory location
+ * because we've ran out of registers.
+ * Now we can't reference that memory location while we've modified
+ * %esp or %ebp, so we first push it on the stack, just before we push
+ * %ebp, and then when we need it we read it from the stack where we
+ * just pushed it.
  */
 #define VMW_PORT_HB_OUT(cmd, in_ecx, in_si, in_di,	\
 			port_num, magic, bp,		\
 			eax, ebx, ecx, edx, si, di)	\
 ({							\
-	asm volatile ("push %%ebp;"			\
-		"mov %12, %%ebp;"			\
+	asm volatile ("push %12;"			\
+		"push %%ebp;"				\
+		"mov 0x04(%%esp), %%ebp;"		\
 		"rep outsb;"				\
-		"pop %%ebp;" :				\
+		"pop %%ebp;"				\
+		"add $0x04, %%esp;" :			\
 		"=a"(eax),				\
 		"=b"(ebx),				\
 		"=c"(ecx),				\
@@ -167,10 +174,12 @@
 		       port_num, magic, bp,		\
 		       eax, ebx, ecx, edx, si, di)	\
 ({							\
-	asm volatile ("push %%ebp;"			\
-		"mov %12, %%ebp;"			\
+	asm volatile ("push %12;"			\
+		"push %%ebp;"				\
+		"mov 0x04(%%esp), %%ebp;"		\
 		"rep insb;"				\
-		"pop %%ebp" :				\
+		"pop %%ebp;"				\
+		"add $0x04, %%esp;" :			\
 		"=a"(eax),				\
 		"=b"(ebx),				\
 		"=c"(ecx),				\
