Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6F7ECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A912145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A912145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeJRIyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:54:36 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:46860 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726943AbeJRIyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:54:35 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 17 Oct 2018 17:55:42 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 6F09A4088A;
        Wed, 17 Oct 2018 17:56:09 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin " <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Nadav Amit <namit@vmware.com>
Subject: [RFC PATCH 5/5] x86: relpoline: disabling interface
Date:   Wed, 17 Oct 2018 17:54:20 -0700
Message-ID: <20181018005420.82993-6-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018005420.82993-1-namit@vmware.com>
References: <20181018005420.82993-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain cases it is beneficial not to use indirect branch promotion.
One such case is seccomp, which may hold multiple filters and different
ones for different processes. The interface indicates to the macro not
to add a relpoline to the the indirect branch.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/nospec-branch.h | 25 +++++++++++++++++++++++++
 kernel/seccomp.c                     |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 360caad7a890..8b10e8165069 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -246,7 +246,21 @@
 .endr
 .endm
 
+.L_DISABLE_INDIRECT_BRANCH_OPT = 0
+
+.macro disable_indirect_branch_opt
+_DISABLE_INDIRECT_BRANCH_OPT = 1
+.endm
+
+.macro enable_indirect_branch_opt
+_DISABLE_INDIRECT_BRANCH_OPT = 0
+.endm
+
 .macro call v:vararg
+.ifc _DISABLE_INDIRECT_BRANCH_OPT, "1"
+        # The pseudo-prefix is just to avoid expanding the macro
+        {disp8} call \v
+.else
 	retpoline = 0
 .irp reg_it,ARCH_REG_NAMES
 .ifc "\v", "__x86_indirect_thunk_\reg_it"
@@ -257,6 +271,7 @@
 .if retpoline == 0
 	{disp8} call \v
 .endif
+.endif
 .endm
 
 #else /* __ASSEMBLY__ */
@@ -409,6 +424,16 @@ struct relpoline_entry {
 extern const void *indirect_thunks[16];
 extern const void *save_relpoline_funcs[16];
 
+static inline void enable_relpolines(void)
+{
+       asm volatile("enable_indirect_branch_opt");
+}
+
+static inline void disable_relpolines(void)
+{
+	asm volatile("disable_indirect_branch_opt");
+}
+
 /* The Intel SPEC CTRL MSR base value cache */
 extern u64 x86_spec_ctrl_base;
 
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index fd023ac24e10..c3fbeddfa8fa 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -207,6 +207,7 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
 	 * All filters in the list are evaluated and the lowest BPF return
 	 * value always takes priority (ignoring the DATA).
 	 */
+	disable_relpolines();
 	for (; f; f = f->prev) {
 		u32 cur_ret = BPF_PROG_RUN(f->prog, sd);
 
@@ -215,6 +216,7 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
 			*match = f;
 		}
 	}
+	enable_relpolines();
 	return ret;
 }
 #endif /* CONFIG_SECCOMP_FILTER */
-- 
2.17.1

