Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5727C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9143D20825
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9143D20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbeKJNEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 08:04:14 -0500
Received: from air.basealt.ru ([194.107.17.39]:57604 "EHLO air.basealt.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728228AbeKJNEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 08:04:14 -0500
Received: by air.basealt.ru (Postfix, from userid 490)
        id 357AF589A99; Sat, 10 Nov 2018 03:20:45 +0000 (UTC)
Received: from akathisia (ip4-83-240-49-150.cust.nbox.cz [83.240.49.150])
        by air.basealt.ru (Postfix) with ESMTPSA id 23AB2589A97;
        Sat, 10 Nov 2018 03:20:42 +0000 (UTC)
Date:   Sat, 10 Nov 2018 04:20:40 +0100
From:   Elvira Khabirova <lineprinter@altlinux.org>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        leitao@debian.org, oleg@redhat.com, luto@kernel.org,
        ldv@altlinux.org
Subject: [PATCH] powerpc/ptrace: replace ptrace_report_syscall() with a
 tracehook call
Message-ID: <20181110042040.68ed3ac8@akathisia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arch code should use tracehook_*() helpers, as documented
in include/linux/tracehook.h.

Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
---
 arch/powerpc/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index afb819f4ca68..f73f8ea402e9 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3266,7 +3266,7 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 	user_exit();
 
 	if (test_thread_flag(TIF_SYSCALL_EMU)) {
-		ptrace_report_syscall(regs);
+		tracehook_report_syscall_entry(regs);
 		/*
 		 * Returning -1 will skip the syscall execution. We want to
 		 * avoid clobbering any register also, thus, not 'gotoing'
-- 
2.19.1

