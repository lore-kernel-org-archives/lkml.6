Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEAFC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204F521B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfBKNef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:34:35 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38829 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfBKNef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:34:35 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1BDYACB3552753
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 05:34:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1BDYA9r3552750;
        Mon, 11 Feb 2019 05:34:10 -0800
Date:   Mon, 11 Feb 2019 05:34:10 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Aubrey Li <tipbot@zytor.com>
Message-ID: <tip-2f7726f955572e587d5f50fbe9b2deed5334bd90@git.kernel.org>
Cc:     oleg@redhat.com, peterz@infradead.org,
        torvalds@linux-foundation.org, hpa@zytor.com,
        dave.hansen@intel.com, tim.c.chen@linux.intel.com, luto@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        dave.hansen@linux.intel.com, fenghua.yu@intel.com,
        aubrey.li@intel.com, aubrey.li@linux.intel.com,
        arjan@linux.intel.com, bp@alien8.de
Reply-To: luto@kernel.org, tglx@linutronix.de, peterz@infradead.org,
          oleg@redhat.com, hpa@zytor.com, torvalds@linux-foundation.org,
          dave.hansen@intel.com, tim.c.chen@linux.intel.com, bp@alien8.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          dave.hansen@linux.intel.com, fenghua.yu@intel.com,
          aubrey.li@intel.com, aubrey.li@linux.intel.com,
          arjan@linux.intel.com
In-Reply-To: <20190117183822.31333-1-aubrey.li@intel.com>
References: <20190117183822.31333-1-aubrey.li@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/fpu: Track AVX-512 usage of tasks
Git-Commit-ID: 2f7726f955572e587d5f50fbe9b2deed5334bd90
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

Commit-ID:  2f7726f955572e587d5f50fbe9b2deed5334bd90
Gitweb:     https://git.kernel.org/tip/2f7726f955572e587d5f50fbe9b2deed5334bd90
Author:     Aubrey Li <aubrey.li@intel.com>
AuthorDate: Fri, 18 Jan 2019 02:38:20 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 11 Feb 2019 14:28:56 +0100

x86/fpu: Track AVX-512 usage of tasks

User space tools which do automated task placement need information
about AVX-512 usage of tasks, because AVX-512 usage could cause core
turbo frequency drop and impact the running task on the sibling CPU.

The XSAVE hardware structure has bits that indicate when valid state
is present in registers unique to AVX-512 use.  Use these bits to
indicate when AVX-512 has been in use and add per-task AVX-512 state
timestamp tracking to context switch.

Well-written AVX-512 applications are expected to clear the AVX-512
state when not actively using AVX-512 registers, so the tracking
mechanism is imprecise and can theoretically miss AVX-512 usage during
context switch. But it has been measured to be precise enough to be
useful under real-world workloads like tensorflow and linpack.

If higher precision is required, suggest user space tools to use the
PMU-based mechanisms in combination.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: aubrey.li@intel.com
Link: http://lkml.kernel.org/r/20190117183822.31333-1-aubrey.li@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/fpu/internal.h | 7 +++++++
 arch/x86/include/asm/fpu/types.h    | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 5d536e3dcc6d..fb04a3ded7dd 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -376,6 +376,13 @@ static inline int copy_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
 		copy_xregs_to_kernel(&fpu->state.xsave);
+
+		/*
+		 * AVX512 state is tracked here because its use is
+		 * known to slow the max clock speed of the core.
+		 */
+		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
+			fpu->avx512_timestamp = jiffies;
 		return 1;
 	}
 
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 202c53918ecf..2e32e178e064 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -302,6 +302,13 @@ struct fpu {
 	 */
 	unsigned char			initialized;
 
+	/*
+	 * @avx512_timestamp:
+	 *
+	 * Records the timestamp of AVX512 use during last context switch.
+	 */
+	unsigned long			avx512_timestamp;
+
 	/*
 	 * @state:
 	 *
