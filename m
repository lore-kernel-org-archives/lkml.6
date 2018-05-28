Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165011AbeE1LEi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164596AbeE1LEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:04:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.16 006/272] MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR accesses to o32 FGRs
Date: Mon, 28 May 2018 12:00:39 +0200
Message-Id: <20180528100240.720957781@linuxfoundation.org>
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

From: Maciej W. Rozycki <macro@mips.com>

commit 9a3a92ccfe3620743d4ae57c987dc8e9c5f88996 upstream.

Check the TIF_32BIT_FPREGS task setting of the tracee rather than the
tracer in determining the layout of floating-point general registers in
the floating-point context, correcting access to odd-numbered registers
for o32 tracees where the setting disagrees between the two processes.

Fixes: 597ce1723e0f ("MIPS: Support for 64-bit FP with O32 binaries")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.14+
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/ptrace.c   |    4 ++--
 arch/mips/kernel/ptrace32.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -807,7 +807,7 @@ long arch_ptrace(struct task_struct *chi
 			fregs = get_fpu_regs(child);
 
 #ifdef CONFIG_32BIT
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
@@ -902,7 +902,7 @@ long arch_ptrace(struct task_struct *chi
 
 			init_fp_ctx(child);
 #ifdef CONFIG_32BIT
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -99,7 +99,7 @@ long compat_arch_ptrace(struct task_stru
 				break;
 			}
 			fregs = get_fpu_regs(child);
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
@@ -212,7 +212,7 @@ long compat_arch_ptrace(struct task_stru
 				       sizeof(child->thread.fpu));
 				child->thread.fpu.fcr31 = 0;
 			}
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
