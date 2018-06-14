Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9F2AEC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC23205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 23:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC23205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965228AbeFNXyO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 19:54:14 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:54734 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965127AbeFNXyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 19:54:13 -0400
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Thu, 14 Jun 2018 23:53:52 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Thu, 14
 Jun 2018 16:53:09 -0700
Received: from pburton-laptop.mipstec.com (10.20.2.29) by
 mipsdag02.mipstec.com (10.20.40.47) with Microsoft SMTP Server id 15.1.1415.2
 via Frontend Transport; Thu, 14 Jun 2018 16:53:09 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        James Hogan <jhogan@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH 3/4] MIPS: Wire up the restartable sequences (rseq) syscall
Date:   Thu, 14 Jun 2018 16:52:09 -0700
Message-ID: <20180614235211.31357-4-paul.burton@mips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614235211.31357-1-paul.burton@mips.com>
References: <20180614235211.31357-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1529020375-321457-11388-11694-4
X-BESS-VER: 2018.7-r1806112253
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194071
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: linux-mips@linux-mips.org,peterz@infradead.org,jhogan@kernel.org,linux-kernel@vger.kernel.org,mathieu.desnoyers@efficios.com,boqun.feng@gmail.com,paulmck@linux.vnet.ibm.com,ralf@linux-mips.org
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up the restartable sequences (rseq) syscall for MIPS. This was
introduced by commit d7822b1e24f2 ("rseq: Introduce restartable
sequences system call") & MIPS now supports the prerequisites.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---

 arch/mips/include/uapi/asm/unistd.h | 15 +++++++++------
 arch/mips/kernel/scall32-o32.S      |  1 +
 arch/mips/kernel/scall64-64.S       |  1 +
 arch/mips/kernel/scall64-n32.S      |  1 +
 arch/mips/kernel/scall64-o32.S      |  1 +
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index bb05e9916a5f..170bf0b5b250 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -388,17 +388,18 @@
 #define __NR_pkey_alloc			(__NR_Linux + 364)
 #define __NR_pkey_free			(__NR_Linux + 365)
 #define __NR_statx			(__NR_Linux + 366)
+#define __NR_rseq			(__NR_Linux + 367)
 
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		366
+#define __NR_Linux_syscalls		367
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		366
+#define __NR_O32_Linux_syscalls		367
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -733,16 +734,17 @@
 #define __NR_pkey_alloc			(__NR_Linux + 324)
 #define __NR_pkey_free			(__NR_Linux + 325)
 #define __NR_statx			(__NR_Linux + 326)
+#define __NR_rseq			(__NR_Linux + 327)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		326
+#define __NR_Linux_syscalls		327
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		326
+#define __NR_64_Linux_syscalls		327
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -1081,15 +1083,16 @@
 #define __NR_pkey_alloc			(__NR_Linux + 328)
 #define __NR_pkey_free			(__NR_Linux + 329)
 #define __NR_statx			(__NR_Linux + 330)
+#define __NR_rseq			(__NR_Linux + 331)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		330
+#define __NR_Linux_syscalls		331
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		330
+#define __NR_N32_Linux_syscalls		331
 
 #endif /* _UAPI_ASM_UNISTD_H */
diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index a9a7d78803cd..842ff1612893 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -590,3 +590,4 @@ EXPORT(sys_call_table)
 	PTR	sys_pkey_alloc
 	PTR	sys_pkey_free			/* 4365 */
 	PTR	sys_statx
+	PTR	sys_rseq
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-64.S
index 65d5aeeb9bdb..558830d1e5ba 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-64.S
@@ -439,4 +439,5 @@ EXPORT(sys_call_table)
 	PTR	sys_pkey_alloc
 	PTR	sys_pkey_free			/* 5325 */
 	PTR	sys_statx
+	PTR	sys_rseq
 	.size	sys_call_table,.-sys_call_table
diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall64-n32.S
index cbf190ef9e8a..293f0b0119f3 100644
--- a/arch/mips/kernel/scall64-n32.S
+++ b/arch/mips/kernel/scall64-n32.S
@@ -434,4 +434,5 @@ EXPORT(sysn32_call_table)
 	PTR	sys_pkey_alloc
 	PTR	sys_pkey_free
 	PTR	sys_statx			/* 6330 */
+	PTR	sys_rseq
 	.size	sysn32_call_table,.-sysn32_call_table
diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall64-o32.S
index 9ebe3e2403b1..f13a08de8078 100644
--- a/arch/mips/kernel/scall64-o32.S
+++ b/arch/mips/kernel/scall64-o32.S
@@ -583,4 +583,5 @@ EXPORT(sys32_call_table)
 	PTR	sys_pkey_alloc
 	PTR	sys_pkey_free			/* 4365 */
 	PTR	sys_statx
+	PTR	sys_rseq
 	.size	sys32_call_table,.-sys32_call_table
-- 
2.17.1

