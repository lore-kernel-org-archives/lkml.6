Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB31DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1F721902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497507;
	bh=V9hB0YruLw2Il9UNrQSXbi77MUN2N3FtXDJ3qQsk1Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ygt5hbkrt1/5b0DviIx6y3TnlkVYClIJNeq6nPc9awZWfiQuoM6r9Ocm2uwAHXdqc
	 rz/wQhZ9elBArN9uSZAGKZzSRsc3d3J2L+JR59Ri0d9alUCR0c/dDS+PU0jhML1jqr
	 9QoY39DLvs205IYMX2C3LdwREEU2nm2Iu0xrlRYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbfBRNpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729609AbfBRNpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:45:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23DDB217F5;
        Mon, 18 Feb 2019 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497502;
        bh=V9hB0YruLw2Il9UNrQSXbi77MUN2N3FtXDJ3qQsk1Wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dMiI0RRADTVNjIk861PS5lhVNzp5O6SmGD8F0859FmUHln5AoVJ7Oi4GhslNVcEs+
         wv9gNxEHOT8eoaNfCH2wLJVOkLzWH2TvEvqzHQcVb/aLu7RzuH0e4t4z36xA71WmXn
         1z+hB5jmW5xe/zn1fxbPlKoGIB7oGfUW97tlxurQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 11/92] riscv: fix trace_sys_exit hook
Date:   Mon, 18 Feb 2019 14:42:14 +0100
Message-Id: <20190218133455.702243361@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 775800b0f1d7303d4fd8ce0e0d9eca4ff2f338f2 ]

Fix compilation error.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 60f1e02eed36..6c898d540d9d 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -172,6 +172,6 @@ void do_syscall_trace_exit(struct pt_regs *regs)
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		trace_sys_exit(regs, regs->regs[0]);
+		trace_sys_exit(regs, regs_return_value(regs));
 #endif
 }
-- 
2.19.1



