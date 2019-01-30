Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911A1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6973020882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbfA3LEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:04:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35515 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfA3LEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:04:13 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0UB3sr02376186
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 30 Jan 2019 03:03:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0UB3shI2376182;
        Wed, 30 Jan 2019 03:03:54 -0800
Date:   Wed, 30 Jan 2019 03:03:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-fab940755d1d78377901450b6ee7c77356e06821@git.kernel.org>
Cc:     mingo@redhat.com, mhiramat@kernel.org, tglx@linutronix.de,
        bp@suse.de, davem@davemloft.net, naveen.n.rao@linux.ibm.com,
        frederic@kernel.org, hpa@zytor.com, anil.s.keshavamurthy@intel.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: mhiramat@kernel.org, tglx@linutronix.de, bp@suse.de,
          mingo@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          frederic@kernel.org, davem@davemloft.net,
          naveen.n.rao@linux.ibm.com, hpa@zytor.com,
          anil.s.keshavamurthy@intel.com
In-Reply-To: <20190127131237.4557-1-bp@alien8.de>
References: <20190127131237.4557-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/hw_breakpoints, kprobes: Remove kprobes
 ifdeffery
Git-Commit-ID: fab940755d1d78377901450b6ee7c77356e06821
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fab940755d1d78377901450b6ee7c77356e06821
Gitweb:     https://git.kernel.org/tip/fab940755d1d78377901450b6ee7c77356e06821
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Sun, 27 Jan 2019 14:03:57 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 30 Jan 2019 11:52:21 +0100

x86/hw_breakpoints, kprobes: Remove kprobes ifdeffery

Remove the ifdeffery in the breakpoint parsing arch_build_bp_info() by
adding a within_kprobe_blacklist() stub for the !CONFIG_KPROBES case.

It is returning true when kprobes are not enabled to mean that any
address is within the kprobes blacklist on such kernels and thus not
allow kernel breakpoints on non-kprobes kernels.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190127131237.4557-1-bp@alien8.de
---
 arch/x86/kernel/hw_breakpoint.c | 4 ----
 include/linux/kprobes.h         | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 7d6f91f2869a..ff9bfd40429e 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -261,12 +261,8 @@ static int arch_build_bp_info(struct perf_event *bp,
 		 * allow kernel breakpoints at all.
 		 */
 		if (attr->bp_addr >= TASK_SIZE_MAX) {
-#ifdef CONFIG_KPROBES
 			if (within_kprobe_blacklist(attr->bp_addr))
 				return -EINVAL;
-#else
-			return -EINVAL;
-#endif
 		}
 
 		hw->type = X86_BREAKPOINT_EXECUTE;
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e07e91daaacc..201f0f2683f2 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -442,6 +442,11 @@ static inline int enable_kprobe(struct kprobe *kp)
 {
 	return -ENOSYS;
 }
+
+static inline bool within_kprobe_blacklist(unsigned long addr)
+{
+	return true;
+}
 #endif /* CONFIG_KPROBES */
 static inline int disable_kretprobe(struct kretprobe *rp)
 {
