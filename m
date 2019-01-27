Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEB1C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 13:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23BA2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 13:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="GqzCs9zm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfA0NMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 08:12:48 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54076 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfA0NMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 08:12:48 -0500
Received: from zn.tnic (p200300EC2BE8D900708CC781A29E26E6.dip0.t-ipconnect.de [IPv6:2003:ec:2be8:d900:708c:c781:a29e:26e6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 541E11EC02AE;
        Sun, 27 Jan 2019 14:12:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548594766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=+9jp0cJdte1N+sTYsJ0qCS5YDpddbad5pEV3Ifi9S9M=;
        b=GqzCs9zmTiEh6LcOdFhzBlo+IKP2zmrTf8ayI1NBNaLN/2manMqFEeZs+p37NjtthE3HEU
        q77idZXT31GtXYCC7KfudLYy5FXGn7MZjB178JUzg6ETKptdT4zRBreX1ShQ+ieoZ0kur6
        mdR2rpQPQHJyWRyZBa3ZUbr8z3bznk0=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] x86/hw_breakpoints, kprobes: Remove kprobes ifdeffery
Date:   Sun, 27 Jan 2019 14:12:37 +0100
Message-Id: <20190127131237.4557-1-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Remove the ifdeffery in the breakpoint parsing arch_build_bp_info() by
adding a within_kprobe_blacklist() stub for the !CONFIG_KPROBES case.

It is returning true when kprobes are not enabled to mean that any
address is within the kprobes blacklist on such kernels and thus not
allow kernel breakpoints on non-kprobes kernels.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
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
-- 
2.19.1

