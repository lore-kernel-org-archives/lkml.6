Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbeFERDq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752637AbeFERDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:03:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.4 26/37] MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs
Date: Tue,  5 Jun 2018 19:01:31 +0200
Message-Id: <20180605170110.400512984@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170108.884872354@linuxfoundation.org>
References: <20180605170108.884872354@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@mips.com>

commit c7e814628df65f424fe197dde73bfc67e4a244d7 upstream.

Use 64-bit accesses for 64-bit floating-point general registers with
PTRACE_PEEKUSR, removing the truncation of their upper halves in the
FR=1 mode, caused by commit bbd426f542cb ("MIPS: Simplify FP context
access"), which inadvertently switched them to using 32-bit accesses.

The PTRACE_POKEUSR side is fine as it's never been broken and continues
using 64-bit accesses.

Fixes: bbd426f542cb ("MIPS: Simplify FP context access")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.15+
Patchwork: https://patchwork.linux-mips.org/patch/19334/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/ptrace.c   |    2 +-
 arch/mips/kernel/ptrace32.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -841,7 +841,7 @@ long arch_ptrace(struct task_struct *chi
 				break;
 			}
 #endif
-			tmp = get_fpr32(&fregs[addr - FPR_BASE], 0);
+			tmp = get_fpr64(&fregs[addr - FPR_BASE], 0);
 			break;
 		case PC:
 			tmp = regs->cp0_epc;
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -107,7 +107,7 @@ long compat_arch_ptrace(struct task_stru
 						addr & 1);
 				break;
 			}
-			tmp = get_fpr32(&fregs[addr - FPR_BASE], 0);
+			tmp = get_fpr64(&fregs[addr - FPR_BASE], 0);
 			break;
 		case PC:
 			tmp = regs->cp0_epc;
