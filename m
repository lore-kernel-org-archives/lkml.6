Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeE0WeJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 18:34:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51088 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbeE0WeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 18:34:05 -0400
Date: Sun, 27 May 2018 23:34:03 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH][RFC] [powerpc] arch_ptrace() uses of access_ok() are
 pointless
Message-ID: <20180527223403.GT30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make it use copy_{from,to}_user(), rather than access_ok() +
__copy_...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/kernel/ptrace.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index d23cf632edf0..d8b0fd2fa3aa 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3081,27 +3081,19 @@ long arch_ptrace(struct task_struct *child, long request,
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #endif /* CONFIG_PPC_ADV_DEBUG_REGS */
 
-		if (!access_ok(VERIFY_WRITE, datavp,
-			       sizeof(struct ppc_debug_info)))
+		if (unlikely(copy_to_user(datavp, &dbginfo,
+				     sizeof(struct ppc_debug_info)))
 			return -EFAULT;
-		ret = __copy_to_user(datavp, &dbginfo,
-				     sizeof(struct ppc_debug_info)) ?
-		      -EFAULT : 0;
-		break;
+		return 0;
 	}
 
 	case PPC_PTRACE_SETHWDEBUG: {
 		struct ppc_hw_breakpoint bp_info;
 
-		if (!access_ok(VERIFY_READ, datavp,
-			       sizeof(struct ppc_hw_breakpoint)))
-			return -EFAULT;
-		ret = __copy_from_user(&bp_info, datavp,
-				       sizeof(struct ppc_hw_breakpoint)) ?
-		      -EFAULT : 0;
-		if (!ret)
-			ret = ppc_set_hwdebug(child, &bp_info);
-		break;
+		if (unlikely(copy_from_user(&bp_info, datavp,
+				       sizeof(struct ppc_hw_breakpoint)))
+		      return -EFAULT;
+		return ppc_set_hwdebug(child, &bp_info);
 	}
 
 	case PPC_PTRACE_DELHWDEBUG: {
-- 
2.11.0
