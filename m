Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753801AbeEONux (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 09:50:53 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:32869 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbeEONuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 09:50:52 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, Guenter Roeck <linux@roeck-us.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: [PATCH -next] signal/mips: Report FPE_FLTUNK for undiagnosed floating point exceptions
Date: Tue, 15 May 2018 06:50:47 -0700
Message-Id: <1526392247-25512-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most mips builds fail with

arch/mips/kernel/traps.c: In function ‘force_fcr31_sig’:
arch/mips/kernel/traps.c:732:2: error:
	‘si_code’ may be used uninitialized in this function

Fix the problem by initializing si_code with FPE_FLTUNK (undiagnosed
floating point exception).

Fixes: f43a54a0d916 ("signal/mips: Use force_sig_fault where appropriate")
Cc: linux-mips@linux-mips.org
Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Feel free to merge into the patch introducing the problem.

 arch/mips/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 66ec4b0b484d..d67fa74622ee 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -716,7 +716,7 @@ asmlinkage void do_ov(struct pt_regs *regs)
 void force_fcr31_sig(unsigned long fcr31, void __user *fault_addr,
 		     struct task_struct *tsk)
 {
-	int si_code;
+	int si_code = FPE_FLTUNK;
 
 	if (fcr31 & FPU_CSR_INV_X)
 		si_code = FPE_FLTINV;
-- 
2.7.4
