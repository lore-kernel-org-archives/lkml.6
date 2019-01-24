Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B22C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249CE218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548342349;
	bh=VN6bdg6QEyzWBIM+O/N4jYotTpzKEB9mwd9gp/52DHU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=labNU8+aGvKMOAe7UwnQakcJWZXHx56Uqn7U7l34g5qKYKcQGHuUPeS2pmGRnrLOE
	 yOtnctivlJsww7HOmqUT5w1YGeQsc/4HEsC0rplETCqN2y6qAR8TP82emEjrMnmxLr
	 +gtAmghlIDDLgWeAGP+YSyoX92P0ZAqz9TVncsJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfAXPFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:05:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbfAXPFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:05:47 -0500
Received: from localhost.localdomain (unknown [60.186.138.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1384521872;
        Thu, 24 Jan 2019 15:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548342346;
        bh=VN6bdg6QEyzWBIM+O/N4jYotTpzKEB9mwd9gp/52DHU=;
        h=From:To:Cc:Subject:Date:From;
        b=hlYBEiK1CoPYKvhIZQvS0mTwj7rsfk8MreKFQeMT7x3Ckmnly7XgD4b0EVNeS1p5B
         Ttxn5yLeqRTgJliv4wKlaRfeB8fHDyjepCnYPAbxeIM5+J2O5MNX/G4Y+orvaCJqKb
         XNPCxCGm+z6FvHZVBc70L0ocCooze3flw3aOeqDU=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 1/2] csky: fixup wrong pt_regs size
Date:   Thu, 24 Jan 2019 23:05:27 +0800
Message-Id: <1548342328-25268-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

The bug is from commit 2054f4af1957 ("csky: bugfix gdb coredump error.")

We change the ELF_NGREG to ELF_NGREG - 2 to fit gdb define, but forgot
modify ptrace regset. Now coredump use ELF_NRGEG to fit gdb and
gcc-csky.c define and ptrace use pt_regs as regset, there are two
different output regs styles.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index 57f1afe..f2f12ff 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -8,6 +8,7 @@
 #include <linux/ptrace.h>
 #include <linux/regset.h>
 #include <linux/sched.h>
+#include <linux/sched/task_stack.h>
 #include <linux/signal.h>
 #include <linux/smp.h>
 #include <linux/uaccess.h>
@@ -159,7 +160,7 @@ static int fpr_set(struct task_struct *target,
 static const struct user_regset csky_regsets[] = {
 	[REGSET_GPR] = {
 		.core_note_type = NT_PRSTATUS,
-		.n = ELF_NGREG,
+		.n = sizeof(struct pt_regs) / sizeof(u32),
 		.size = sizeof(u32),
 		.align = sizeof(u32),
 		.get = &gpr_get,
-- 
2.7.4

