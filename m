Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D917C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086A020651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfAGMyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:54:50 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:37698 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbfAGMyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:54:46 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2584C72CC71;
        Mon,  7 Jan 2019 15:54:44 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id F17DA8E5C3E; Mon,  7 Jan 2019 15:54:43 +0300 (MSK)
Date:   Mon, 7 Jan 2019 15:54:43 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] nds32: fix asm/syscall.h
Message-ID: <20190107125443.GA8489@altlinux.org>
References: <20190107025455.GU1207@altlinux.org>
 <201901071430.4jk67u0s%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201901071430.4jk67u0s%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All syscall_get_* and syscall_set_* functions must be defined as
static inline.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 1932fbe36e02 ("nds32: System calls handling")
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: stable@vger.kernel.org # v4.17+
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/nds32/include/asm/syscall.h | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/syscall.h
index f7e5e86765fe..6b131202d0e9 100644
--- a/arch/nds32/include/asm/syscall.h
+++ b/arch/nds32/include/asm/syscall.h
@@ -25,7 +25,8 @@ struct pt_regs;
  *
  * It's only valid to call this when @task is known to be blocked.
  */
-int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
+static inline int
+syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
 {
 	return regs->syscallno;
 }
@@ -46,7 +47,8 @@ int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
  * system call instruction.  This may not be the same as what the
  * register state looked like at system call entry tracing.
  */
-void syscall_rollback(struct task_struct *task, struct pt_regs *regs)
+static inline void
+syscall_rollback(struct task_struct *task, struct pt_regs *regs)
 {
 	regs->uregs[0] = regs->orig_r0;
 }
@@ -61,7 +63,8 @@ void syscall_rollback(struct task_struct *task, struct pt_regs *regs)
  * It's only valid to call this when @task is stopped for tracing on exit
  * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
-long syscall_get_error(struct task_struct *task, struct pt_regs *regs)
+static inline long
+syscall_get_error(struct task_struct *task, struct pt_regs *regs)
 {
 	unsigned long error = regs->uregs[0];
 	return IS_ERR_VALUE(error) ? error : 0;
@@ -78,7 +81,8 @@ long syscall_get_error(struct task_struct *task, struct pt_regs *regs)
  * It's only valid to call this when @task is stopped for tracing on exit
  * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
-long syscall_get_return_value(struct task_struct *task, struct pt_regs *regs)
+static inline long
+syscall_get_return_value(struct task_struct *task, struct pt_regs *regs)
 {
 	return regs->uregs[0];
 }
@@ -98,8 +102,9 @@ long syscall_get_return_value(struct task_struct *task, struct pt_regs *regs)
  * It's only valid to call this when @task is stopped for tracing on exit
  * from a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  */
-void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
-			      int error, long val)
+static inline void
+syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
+			 int error, long val)
 {
 	regs->uregs[0] = (long)error ? error : val;
 }
@@ -122,8 +127,9 @@ void syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
  * taking up to 6 arguments.
  */
 #define SYSCALL_MAX_ARGS 6
-void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
-			   unsigned int i, unsigned int n, unsigned long *args)
+static inline void
+syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
+		      unsigned int i, unsigned int n, unsigned long *args)
 {
 	if (n == 0)
 		return;
@@ -163,9 +169,10 @@ void syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
  * It's invalid to call this with @i + @n > 6; we only support system calls
  * taking up to 6 arguments.
  */
-void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
-			   unsigned int i, unsigned int n,
-			   const unsigned long *args)
+static inline void
+syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
+		      unsigned int i, unsigned int n,
+		      const unsigned long *args)
 {
 	if (n == 0)
 		return;
-- 
ldv
