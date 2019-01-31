Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40ADC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B749218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548918175;
	bh=s4CaE8psmKGL/uMXQ0ERjCNJpjSktaYbVaR1plhdlyM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Mi5xbMnYSDb7XnlSDVugNdwhNOsFntb1li9dByJ7na3rX/d+jmozSulfJsR6IJMzj
	 M78FvCFtF203v294AnJ/7Qo68Bfd1wIyAabuwA61q17t/bJnJoxxrxCcuScMXM1m2j
	 Ih2+GROoMbIprGM8OxHXXoXq2p/BHg0WgKnL5QSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbfAaHCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:02:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfAaHCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:02:53 -0500
Received: from localhost.localdomain (unknown [60.186.218.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9889D218AC;
        Thu, 31 Jan 2019 07:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548918173;
        bh=s4CaE8psmKGL/uMXQ0ERjCNJpjSktaYbVaR1plhdlyM=;
        h=From:To:Cc:Subject:Date:From;
        b=2LYOPeXxIAYQPu5DFb4wHhhBxxrJBCAffNR1l5niUGlFBByxhs1FokNpj6niY1ni9
         8t96dKV3xXPsFAatqzXzk5cu7dm4Jzxkt+chhZ3IlMUi0VEHCANj54tfw3v2A8a058
         +jjPu1PrWbx4h9gIZnOcNv4ZYBaWRPQgmIvLPoew=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-arch@vger.kernel.org, lu.baoquan@intellif.com,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH] csky: fixup dead loop in show_stack
Date:   Thu, 31 Jan 2019 15:02:42 +0800
Message-Id: <1548918162-2728-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

When STACKTRACE is enabled, we must pass fp as stack for unwind,
otherwise random value in stack will casue a dead loop.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reported-by: Lu Baoquan <lu.baoquan@intellif.com>
---
 arch/csky/kernel/dumpstack.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/csky/kernel/dumpstack.c b/arch/csky/kernel/dumpstack.c
index 659253e..d67f977 100644
--- a/arch/csky/kernel/dumpstack.c
+++ b/arch/csky/kernel/dumpstack.c
@@ -38,7 +38,11 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 		if (task)
 			stack = (unsigned long *)thread_saved_fp(task);
 		else
+#ifdef CONFIG_STACKTRACE
+			asm volatile("mov %0, r8\n":"=r"(stack)::"memory");
+#else
 			stack = (unsigned long *)&stack;
+#endif
 	}
 
 	show_trace(stack);
-- 
2.7.4

