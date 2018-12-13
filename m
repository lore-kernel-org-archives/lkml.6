Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF719C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08A620870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08A620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbeLMRYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:24:34 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:40998 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbeLMRYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:24:34 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1384B72CC71;
        Thu, 13 Dec 2018 20:24:31 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id EE2D2964E82; Thu, 13 Dec 2018 20:24:30 +0300 (MSK)
Date:   Thu, 13 Dec 2018 20:24:30 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Oleg Nesterov <oleg@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 25/27] powerpc/ptrace: replace ptrace_report_syscall()
 with a tracehook call
Message-ID: <20181213172430.GY6024@altlinux.org>
References: <20181213171833.GA5240@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elvira Khabirova <lineprinter@altlinux.org>

Arch code should use tracehook_*() helpers, as documented in
include/linux/tracehook.h, ptrace_report_syscall() is not expected to
be used outside that file.

The patch does not look very nice, but at least it is correct
and opens the way for PTRACE_GET_SYSCALL_INFO API.

Co-authored-by: Dmitry V. Levin <ldv@altlinux.org>
Fixes: 5521eb4bca2d ("powerpc/ptrace: Add support for PTRACE_SYSEMU")
Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
[mpe: Take this as a minimal fix for 4.20, we'll rework it later]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---

Notes:
    v6: this is the fix that was taken into powerpc tree
    v5: reverted to a simple approach, compile- and run-tested
    v4: rewritten to call tracehook_report_syscall_entry() once, compile-tested
    v3: add a descriptive comment
    v2: explicitly ignore tracehook_report_syscall_entry() return code

 arch/powerpc/kernel/ptrace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index afb819f4ca68..714c3480c52d 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3266,12 +3266,17 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 	user_exit();
 
 	if (test_thread_flag(TIF_SYSCALL_EMU)) {
-		ptrace_report_syscall(regs);
 		/*
+		 * A nonzero return code from tracehook_report_syscall_entry()
+		 * tells us to prevent the syscall execution, but we are not
+		 * going to execute it anyway.
+		 *
 		 * Returning -1 will skip the syscall execution. We want to
 		 * avoid clobbering any register also, thus, not 'gotoing'
 		 * skip label.
 		 */
+		if (tracehook_report_syscall_entry(regs))
+			;
 		return -1;
 	}
 
-- 
ldv
