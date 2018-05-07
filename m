Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeEGGym (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 02:54:42 -0400
Received: from exmail.andestech.com ([59.124.169.137]:57471 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbeEGGyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 02:54:37 -0400
From: Nickhu <nickhu@andestech.com>
To: <greentime@andestech.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <green.hu@gmail.com>, <vincentc@andestech.com>
CC: Nickhu <nickhu@andestech.com>
Subject: [PATCH 2/2] nds32: Fix the unaligned access handler
Date: Mon, 7 May 2018 14:45:02 +0800
Message-ID: <737baa062b19428816afc1fccf3bca03210b45c5.1525673368.git.nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1525673368.git.nickhu@andestech.com>
References: <cover.1525673368.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w476bYCY068190
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kernel config 'CONFIG_ALIGNMENT_TRAP' and the file
'/proc/sys/nds32/unaligned_access/enable' are set, the kernel
unaligned access handler does not handle correctly when the
value of immediate field is negative. This commit fixes the
unaligned access handler in kernel.

Signed-off-by: Nickhu <nickhu@andestech.com>
---
 arch/nds32/mm/alignment.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/nds32/mm/alignment.c b/arch/nds32/mm/alignment.c
index e515f6f3d247..e1aed9dc692d 100644
--- a/arch/nds32/mm/alignment.c
+++ b/arch/nds32/mm/alignment.c
@@ -19,7 +19,7 @@
 #define RA(inst)	(((inst) >> 15) & 0x1FUL)
 #define RB(inst)	(((inst) >> 10) & 0x1FUL)
 #define SV(inst)	(((inst) >> 8) & 0x3UL)
-#define IMM(inst)	(((inst) >> 0) & 0x3FFFUL)
+#define IMM(inst)	(((inst) >> 0) & 0x7FFFUL)
 
 #define RA3(inst)	(((inst) >> 3) & 0x7UL)
 #define RT3(inst)	(((inst) >> 6) & 0x7UL)
@@ -28,6 +28,9 @@
 #define RA5(inst)	(((inst) >> 0) & 0x1FUL)
 #define RT4(inst)	(((inst) >> 5) & 0xFUL)
 
+#define GET_IMMSVAL(imm_value) \
+	(((imm_value >> 14) & 0x1) ? (imm_value - 0x8000) : imm_value)
+
 #define __get8_data(val,addr,err)	\
 	__asm__(					\
 	"1:	lbi.bi	%1, [%2], #1\n"			\
@@ -467,7 +470,7 @@ static inline int do_32(unsigned long inst, struct pt_regs *regs)
 	}
 
 	if (imm)
-		shift = IMM(inst) * len;
+		shift = GET_IMMSVAL(IMM(inst)) * len;
 	else
 		shift = *idx_to_addr(regs, RB(inst)) << SV(inst);
 
-- 
2.17.0
