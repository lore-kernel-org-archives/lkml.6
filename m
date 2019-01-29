Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20673C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57AC20870
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548764712;
	bh=W5NutnjzmOYCmG0/Pxg45GvbwmpPla6pBxKPgExQ/kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iFafjsFAp+Wt6vo6qqik0fYjir1cSooed+B0rU9LVXlUFexGvwA+Pa+s90mce5BJF
	 S02rweVfztkMqE3Ewld7nPFMiPaXxbDDdJZI2zPLqSNdLggDd32n4kJaeT/6iYM55g
	 MIxCX1b6YiCL6G1wEk2LMuoD42FRO4TcXgom6CTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfA2MZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:25:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728890AbfA2MZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:25:09 -0500
Received: from localhost.localdomain (unknown [60.186.218.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 633C920870;
        Tue, 29 Jan 2019 12:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548764709;
        bh=W5NutnjzmOYCmG0/Pxg45GvbwmpPla6pBxKPgExQ/kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qPKG3HcZ7vIY/Tsv28zWlVpTR3PNWnSO3ZrtzFuQCy2W1uDM66M2evO0OaBSYpaLf
         exqBpNUPR1o5Tgnb889wV1YFkvPv1uiDhOwfuZrV6ItQhCrtuFxzpXqBqY6GMDFTML
         LOvYM/ZnRYmMFhx38myZwpnwXHQqKyHSkKZWiol0=
From:   guoren@kernel.org
To:     arnd@arndb.de, robh+dt@kernel.org, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 07/10] csky: Fixup wrong pt_regs size
Date:   Tue, 29 Jan 2019 20:24:26 +0800
Message-Id: <1548764669-16656-7-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548764669-16656-1-git-send-email-guoren@kernel.org>
References: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

The bug is from commit 2054f4af1957 ("csky: bugfix gdb coredump error.")

We change the ELF_NGREG to ELF_NGREG - 2 to fit gdb&gcc define, but forgot
modify ptrace regset.
Now coredump use ELF_NRGEG to parse GPRs and ptrace use pt_regs_regset, so
there are two different reg_sets for userspace.

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

