Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5D9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2064208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2064208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbeHWMWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:22:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbeHWMWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:22:20 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9A7E249B;
        Thu, 23 Aug 2018 08:53:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Wilson <jimw@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 186/324] RISC-V: Fix PTRACE_SETREGSET bug.
Date:   Thu, 23 Aug 2018 09:54:12 +0200
Message-Id: <20180823075005.494264766@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Wilson <jimw@sifive.com>

[ Upstream commit 1db9b80980d26fe95c942e0bb8bde2ca715029ad ]

In riscv_gpr_set, pass regs instead of &regs to user_regset_copyin to fix
gdb segfault.

Signed-off-by: Jim Wilson <jimw@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/kernel/ptrace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -50,7 +50,7 @@ static int riscv_gpr_set(struct task_str
 	struct pt_regs *regs;
 
 	regs = task_pt_regs(target);
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &regs, 0, -1);
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, regs, 0, -1);
 	return ret;
 }
 


