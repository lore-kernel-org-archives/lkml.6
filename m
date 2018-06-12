Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2EF5EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD5A208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w8QEHmCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD5A208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935285AbeFLQym (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933574AbeFLQyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:54:38 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 079A2208B4;
        Tue, 12 Jun 2018 16:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822477;
        bh=HSd/qak5V+249pubFaor+BtSwo4ksfdI5oEsOwALkNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w8QEHmCpvoKYxqpMpwRIhn8RHyCtEs0kmyhzXU+D2BdXW5tihm+EjYQllHwLEA3/V
         f/50yqhuaaY1WJkLsiGRFdUod/AuwSsQlnQsVUDE5wkMTF7p1Sa30haS0Jt8NLU5aJ
         Q5X2PQAP+SK6NSvLsAhqg1FWNRALAt9qfMXdG5ag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 3.18 05/21] MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs
Date:   Tue, 12 Jun 2018 18:52:02 +0200
Message-Id: <20180612164825.623493095@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164825.401145490@linuxfoundation.org>
References: <20180612164825.401145490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@mips.com>

commit c7e814628df65f424fe197dde73bfc67e4a244d7 upstream.

Use 64-bit accesses for 64-bit floating-point general registers with
PTRACE_PEEKUSR, removing the truncation of their upper halves in the
FR=1 mode, caused by commit bbd426f542cb ("MIPS: Simplify FP context
access"), which inadvertently switched them to using 32-bit accesses.

The PTRACE_POKEUSR side is fine as it's never been broken and continues
using 64-bit accesses.

Fixes: bbd426f542cb ("MIPS: Simplify FP context access")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.15+
Patchwork: https://patchwork.linux-mips.org/patch/19334/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/ptrace.c   |    2 +-
 arch/mips/kernel/ptrace32.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -713,7 +713,7 @@ long arch_ptrace(struct task_struct *chi
 				break;
 			}
 #endif
-			tmp = get_fpr32(&fregs[addr - FPR_BASE], 0);
+			tmp = get_fpr64(&fregs[addr - FPR_BASE], 0);
 			break;
 		case PC:
 			tmp = regs->cp0_epc;
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -107,7 +107,7 @@ long compat_arch_ptrace(struct task_stru
 						addr & 1);
 				break;
 			}
-			tmp = get_fpr32(&fregs[addr - FPR_BASE], 0);
+			tmp = get_fpr64(&fregs[addr - FPR_BASE], 0);
 			break;
 		case PC:
 			tmp = regs->cp0_epc;


