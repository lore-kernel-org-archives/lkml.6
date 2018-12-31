Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E05C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A0821871
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546270433;
	bh=UJ7xDGy3ytVXMeTYzu1HJ7BMLzQvoQcDhQRlxMaTdNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uYDYRdGLhWxk9duth9IkRT6QOHmT+A9EeW/jS/prM9Tsh0CsxcHSKhJbBmXBaBxOj
	 tdPW+lF8hCQ6xVl61VjQM7dQxfLfZ3da3juIP6A6dGico9O86qKmqEsqnaeDjeLXEK
	 EVVuOH1Ggf6ijz5f9yeDEX8dY5ycK0jgMbXOtWmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeLaPdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 10:33:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:59588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbeLaPdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 10:33:52 -0500
Received: from localhost.localdomain (unknown [183.128.55.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 264872133F;
        Mon, 31 Dec 2018 15:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546270432;
        bh=UJ7xDGy3ytVXMeTYzu1HJ7BMLzQvoQcDhQRlxMaTdNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WShQW72Ir5zDt4IrDL7T3fRqsaVGahrDR9wiJjzBcBT1duW0/Gj5gUZ4P1kESMF2g
         20TGToX12M3AQTJAPaCAtqE3syuLcCxCupiADONjtnOo/ciXjoqdA6kdCjAlE1Qdi0
         Ib9DpnwtEQGmW3p7bVvjelQNJO0YwwL5X2zidEoY=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     guoren@kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com,
        linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 02/14] csky: bugfix gdb coredump error.
Date:   Mon, 31 Dec 2018 23:32:54 +0800
Message-Id: <1546270384-4590-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546270384-4590-1-git-send-email-guoren@kernel.org>
References: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

In gdb/bfd elf32-csky.c, csky_elf_grok_prstatus() use fixed size of
elf_prstatus. It's 148 for abiv1 and 220 for abiv2, the size is enough
for coredump and no need full sizeof(struct pt_regs).

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reported-by: Lu Baoquan <lu.baoquan@intellif.com>
Reported-by: Liu Mao <liu.mao@intellif.com>
---
 arch/csky/include/asm/elf.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/csky/include/asm/elf.h b/arch/csky/include/asm/elf.h
index 48b5366..d6dbc00 100644
--- a/arch/csky/include/asm/elf.h
+++ b/arch/csky/include/asm/elf.h
@@ -31,7 +31,12 @@ typedef unsigned long elf_greg_t;
 
 typedef struct user_fp elf_fpregset_t;
 
-#define ELF_NGREG (sizeof(struct pt_regs) / sizeof(elf_greg_t))
+/*
+ * In gdb/bfd elf32-csky.c, csky_elf_grok_prstatus() use fixed size of
+ * elf_prstatus. It's 148 for abiv1 and 220 for abiv2, the size is enough
+ * for coredump and no need full sizeof(struct pt_regs).
+ */
+#define ELF_NGREG ((sizeof(struct pt_regs) / sizeof(elf_greg_t)) - 2)
 
 typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 
-- 
2.7.4

