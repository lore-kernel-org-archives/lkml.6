Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2EAC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6754E2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfBCOU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:57 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55618 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730252AbfBCOU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:56 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdj-0006ND-2h; Sun, 03 Feb 2019 14:20:55 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9m-0007JS-TK; Sun, 03 Feb 2019 14:49:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Max Filippov" <jcmvbkbc@gmail.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.301350733@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 239/305] xtensa: fix coprocessor part of
 ptrace_{get,set}xregs
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit 38a35a78c5e270cbe53c4fef6b0d3c2da90dd849 upstream.

Layout of coprocessor registers in the elf_xtregs_t and
xtregs_coprocessor_t may be different due to alignment. Thus it is not
always possible to copy data between the xtregs_coprocessor_t structure
and the elf_xtregs_t and get correct values for all registers.
Use a table of offsets and sizes of individual coprocessor register
groups to do coprocessor context copying in the ptrace_getxregs and
ptrace_setxregs.
This fixes incorrect coprocessor register values reading from the user
process by the native gdb on an xtensa core with multiple coprocessors
and registers with high alignment requirements.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/xtensa/kernel/ptrace.c | 42 +++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -124,12 +124,37 @@ int ptrace_setregs(struct task_struct *c
 }
 
 
+#if XTENSA_HAVE_COPROCESSORS
+#define CP_OFFSETS(cp) \
+	{ \
+		.elf_xtregs_offset = offsetof(elf_xtregs_t, cp), \
+		.ti_offset = offsetof(struct thread_info, xtregs_cp.cp), \
+		.sz = sizeof(xtregs_ ## cp ## _t), \
+	}
+
+static const struct {
+	size_t elf_xtregs_offset;
+	size_t ti_offset;
+	size_t sz;
+} cp_offsets[] = {
+	CP_OFFSETS(cp0),
+	CP_OFFSETS(cp1),
+	CP_OFFSETS(cp2),
+	CP_OFFSETS(cp3),
+	CP_OFFSETS(cp4),
+	CP_OFFSETS(cp5),
+	CP_OFFSETS(cp6),
+	CP_OFFSETS(cp7),
+};
+#endif
+
 int ptrace_getxregs(struct task_struct *child, void __user *uregs)
 {
 	struct pt_regs *regs = task_pt_regs(child);
 	struct thread_info *ti = task_thread_info(child);
 	elf_xtregs_t __user *xtregs = uregs;
 	int ret = 0;
+	int i __maybe_unused;
 
 	if (!access_ok(VERIFY_WRITE, uregs, sizeof(elf_xtregs_t)))
 		return -EIO;
@@ -137,8 +162,13 @@ int ptrace_getxregs(struct task_struct *
 #if XTENSA_HAVE_COPROCESSORS
 	/* Flush all coprocessor registers to memory. */
 	coprocessor_flush_all(ti);
-	ret |= __copy_to_user(&xtregs->cp0, &ti->xtregs_cp,
-			      sizeof(xtregs_coprocessor_t));
+
+	for (i = 0; i < ARRAY_SIZE(cp_offsets); ++i)
+		ret |= __copy_to_user((char __user *)xtregs +
+				      cp_offsets[i].elf_xtregs_offset,
+				      (const char *)ti +
+				      cp_offsets[i].ti_offset,
+				      cp_offsets[i].sz);
 #endif
 	ret |= __copy_to_user(&xtregs->opt, &regs->xtregs_opt,
 			      sizeof(xtregs->opt));
@@ -154,6 +184,7 @@ int ptrace_setxregs(struct task_struct *
 	struct pt_regs *regs = task_pt_regs(child);
 	elf_xtregs_t *xtregs = uregs;
 	int ret = 0;
+	int i __maybe_unused;
 
 	if (!access_ok(VERIFY_READ, uregs, sizeof(elf_xtregs_t)))
 		return -EFAULT;
@@ -163,8 +194,11 @@ int ptrace_setxregs(struct task_struct *
 	coprocessor_flush_all(ti);
 	coprocessor_release_all(ti);
 
-	ret |= __copy_from_user(&ti->xtregs_cp, &xtregs->cp0,
-				sizeof(xtregs_coprocessor_t));
+	for (i = 0; i < ARRAY_SIZE(cp_offsets); ++i)
+		ret |= __copy_from_user((char *)ti + cp_offsets[i].ti_offset,
+					(const char __user *)xtregs +
+					cp_offsets[i].elf_xtregs_offset,
+					cp_offsets[i].sz);
 #endif
 	ret |= __copy_from_user(&regs->xtregs_opt, &xtregs->opt,
 				sizeof(xtregs->opt));

