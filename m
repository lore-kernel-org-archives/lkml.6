Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754885AbeEaLXE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:23:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8175 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754856AbeEaLWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:22:53 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <andy.shevchenko@gmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 20/21] powerpc/xmon: use match_string() helper
Date: Thu, 31 May 2018 19:11:25 +0800
Message-ID: <1527765086-19873-21-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used instead of open coded variant.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 arch/powerpc/xmon/xmon.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a0842f1..872ac8c 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3161,7 +3161,7 @@ static void proccall(void)
 }
 
 #define N_PTREGS	44
-static char *regnames[N_PTREGS] = {
+static const char *regnames[N_PTREGS] = {
 	"r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
 	"r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
 	"r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
@@ -3196,18 +3196,17 @@ static void proccall(void)
 			regname[i] = c;
 		}
 		regname[i] = 0;
-		for (i = 0; i < N_PTREGS; ++i) {
-			if (strcmp(regnames[i], regname) == 0) {
-				if (xmon_regs == NULL) {
-					printf("regs not available\n");
-					return 0;
-				}
-				*vp = ((unsigned long *)xmon_regs)[i];
-				return 1;
-			}
+		i = match_string(regnames, N_PTREGS, regname);
+		if (i < 0) {
+			printf("invalid register name '%%%s'\n", regname);
+			return 0;
 		}
-		printf("invalid register name '%%%s'\n", regname);
-		return 0;
+		if (xmon_regs == NULL) {
+			printf("regs not available\n");
+			return 0;
+		}
+		*vp = ((unsigned long *)xmon_regs)[i];
+		return 1;
 	}
 
 	/* skip leading "0x" if any */
-- 
1.7.12.4
