Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C497C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221CE2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221CE2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbeKTH1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:27:07 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:37280 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730755AbeKTH1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:27:07 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A348372CA5E;
        Tue, 20 Nov 2018 00:01:39 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 956EB7CD1FF; Tue, 20 Nov 2018 00:01:39 +0300 (MSK)
Date:   Tue, 20 Nov 2018 00:01:39 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Breno Leitao <leitao@debian.org>,
        Andy Lutomirski <luto@kernel.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] powerpc/ptrace: replace ptrace_report_syscall() with a
 tracehook call
Message-ID: <20181119210139.GA8360@altlinux.org>
References: <20181116121701.14359da0@akathisia>
 <87ftw12nyn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftw12nyn.fsf@concordia.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elvira Khabirova <lineprinter@altlinux.org>

Arch code should use tracehook_*() helpers as documented
in include/linux/tracehook.h,
ptrace_report_syscall() is not expected to be used outside that file.

Co-authored-by: Dmitry V. Levin <ldv@altlinux.org>
Fixes: 5521eb4bca2d ("powerpc/ptrace: Add support for PTRACE_SYSEMU")
Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

v3: add a descriptive comment
v2: explicitly ignore tracehook_report_syscall_entry() return code

 arch/powerpc/kernel/ptrace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index afb819f4ca68..e84220d91bbd 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3266,7 +3266,12 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 	user_exit();
 
 	if (test_thread_flag(TIF_SYSCALL_EMU)) {
-		ptrace_report_syscall(regs);
+		/*
+		 * A nonzero return code from tracehook_report_syscall_entry()
+		 * tells us to prevent the syscall execution, but we are not
+		 * going to execute it anyway.
+		 */
+		(void) tracehook_report_syscall_entry(regs);
 		/*
 		 * Returning -1 will skip the syscall execution. We want to
 		 * avoid clobbering any register also, thus, not 'gotoing'
-- 
ldv
