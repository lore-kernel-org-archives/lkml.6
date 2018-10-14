Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1888C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B480420645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B480420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeJNXlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:41:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35826 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727351AbeJNXLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:48 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0004cg-Re; Sun, 14 Oct 2018 16:30:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLZ-0000gB-7F; Sun, 14 Oct 2018 16:30:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Maciej W. Rozycki" <macro@mips.com>,
        "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "James Hogan" <jhogan@kernel.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.166439063@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 308/366] MIPS: Fix ptrace(2) PTRACE_PEEKUSR and
 PTRACE_POKEUSR accesses to o32 FGRs
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@mips.com>

commit 9a3a92ccfe3620743d4ae57c987dc8e9c5f88996 upstream.

Check the TIF_32BIT_FPREGS task setting of the tracee rather than the
tracer in determining the layout of floating-point general registers in
the floating-point context, correcting access to odd-numbered registers
for o32 tracees where the setting disagrees between the two processes.

Fixes: 597ce1723e0f ("MIPS: Support for 64-bit FP with O32 binaries")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/ptrace.c   | 4 ++--
 arch/mips/kernel/ptrace32.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -741,7 +741,7 @@ long arch_ptrace(struct task_struct *chi
 			fregs = get_fpu_regs(child);
 
 #ifdef CONFIG_32BIT
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
@@ -830,7 +830,7 @@ long arch_ptrace(struct task_struct *chi
 
 			init_fp_ctx(child);
 #ifdef CONFIG_32BIT
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -97,7 +97,7 @@ long compat_arch_ptrace(struct task_stru
 				break;
 			}
 			fregs = get_fpu_regs(child);
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even
@@ -203,7 +203,7 @@ long compat_arch_ptrace(struct task_stru
 				       sizeof(child->thread.fpu));
 				child->thread.fpu.fcr31 = 0;
 			}
-			if (test_thread_flag(TIF_32BIT_FPREGS)) {
+			if (test_tsk_thread_flag(child, TIF_32BIT_FPREGS)) {
 				/*
 				 * The odd registers are actually the high
 				 * order bits of the values stored in the even

