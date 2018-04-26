Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756492AbeDZLzw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 07:55:52 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41266 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756335AbeDZLzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 07:55:46 -0400
X-Google-Smtp-Source: AB8JxZrK0wQm38Bqyl5xcbKVOVuIc0MzXt34PK5lDpXKqDfnnvIPIdjReYspVJR5a2z88y5P6Js3Nw==
From: Niklas Cassel <niklas.cassel@linaro.org>
To: andy.gross@linaro.org, david.brown@linaro.org
Cc: bjorn.andersson@linaro.org, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH RESEND] firmware: qcom: scm: Fix crash in qcom_scm_call_atomic1()
Date: Thu, 26 Apr 2018 13:55:34 +0200
Message-Id: <20180426115534.20971-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcom_scm_call_atomic1() can crash with a NULL pointer dereference at
qcom_scm_call_atomic1+0x30/0x48.

disassembly of qcom_scm_call_atomic1():
...
<0xc08d73b0 <+12>: ldr r3, [r12]
... (no instruction explicitly modifies r12)
0xc08d73cc <+40>: smc 0
... (no instruction explicitly modifies r12)
0xc08d73d4 <+48>: ldr r3, [r12] <- crashing instruction
...

Since the first ldr is successful, and since r12 isn't explicitly
modified by any instruction between the first and the second ldr,
it must have been modified by the smc call, which is ok,
since r12 is caller save according to the AAPCS.

Add r12 to the clobber list so that the compiler knows that the
callee potentially overwrites the value in r12.
Clobber descriptions may not in any way overlap with an input or
output operand.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/firmware/qcom_scm-32.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index dfbd894d5bb7..4e24e591ae74 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -147,7 +147,7 @@ static u32 smc(u32 cmd_addr)
 			"smc	#0	@ switch to secure world\n"
 			: "=r" (r0)
 			: "r" (r0), "r" (r1), "r" (r2)
-			: "r3");
+			: "r3", "r12");
 	} while (r0 == QCOM_SCM_INTERRUPTED);
 
 	return r0;
@@ -263,7 +263,7 @@ static s32 qcom_scm_call_atomic1(u32 svc, u32 cmd, u32 arg1)
 			"smc    #0      @ switch to secure world\n"
 			: "=r" (r0)
 			: "r" (r0), "r" (r1), "r" (r2)
-			: "r3");
+			: "r3", "r12");
 	return r0;
 }
 
@@ -298,7 +298,7 @@ static s32 qcom_scm_call_atomic2(u32 svc, u32 cmd, u32 arg1, u32 arg2)
 			"smc    #0      @ switch to secure world\n"
 			: "=r" (r0)
 			: "r" (r0), "r" (r1), "r" (r2), "r" (r3)
-			);
+			: "r12");
 	return r0;
 }
 
@@ -328,7 +328,7 @@ u32 qcom_scm_get_version(void)
 			"smc	#0	@ switch to secure world\n"
 			: "=r" (r0), "=r" (r1)
 			: "r" (r0), "r" (r1)
-			: "r2", "r3");
+			: "r2", "r3", "r12");
 	} while (r0 == QCOM_SCM_INTERRUPTED);
 
 	version = r1;
-- 
2.14.3
