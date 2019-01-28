Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D1DC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11ACE21736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfA1G7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:59:19 -0500
Received: from foss.arm.com ([217.140.101.70]:39828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfA1G7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:59:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDF731596;
        Sun, 27 Jan 2019 22:59:17 -0800 (PST)
Received: from a075553-lin.blr.arm.com (a075553-lin.blr.arm.com [10.162.0.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 199BF3F5AF;
        Sun, 27 Jan 2019 22:59:13 -0800 (PST)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 1/5] arm64: Add utilities to save restore pointer authentication keys
Date:   Mon, 28 Jan 2019 12:28:42 +0530
Message-Id: <1548658727-14271-2-git-send-email-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The keys can be switched either inside an assembly or such
functions which do not have pointer authentication checks, so a GCC
attribute is added to enable it.

A function ptrauth_keys_store is added which is similar to existing
function ptrauth_keys_switch but saves the key values in memory.
This may be useful for save/restore scenarios when CPU changes
privilege levels, suspend/resume etc.

Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pointer_auth.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index 15d4951..98441ce 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -11,6 +11,13 @@
 
 #ifdef CONFIG_ARM64_PTR_AUTH
 /*
+ * Compile the function without pointer authentication instructions. This
+ * allows pointer authentication to be enabled/disabled within the function
+ * (but leaves the function unprotected by pointer authentication).
+ */
+#define __no_ptrauth	__attribute__((target("sign-return-address=none")))
+
+/*
  * Each key is a 128-bit quantity which is split across a pair of 64-bit
  * registers (Lo and Hi).
  */
@@ -50,6 +57,13 @@ do {								\
 	write_sysreg_s(__pki_v.hi, SYS_ ## k ## KEYHI_EL1);	\
 } while (0)
 
+#define __ptrauth_key_save(k, v)				\
+do {								\
+	struct ptrauth_key __pki_v = (v);			\
+	__pki_v.lo = read_sysreg_s(SYS_ ## k ## KEYLO_EL1);	\
+	__pki_v.hi = read_sysreg_s(SYS_ ## k ## KEYHI_EL1);	\
+} while (0)
+
 static inline void ptrauth_keys_switch(struct ptrauth_keys *keys)
 {
 	if (system_supports_address_auth()) {
@@ -63,6 +77,19 @@ static inline void ptrauth_keys_switch(struct ptrauth_keys *keys)
 		__ptrauth_key_install(APGA, keys->apga);
 }
 
+static inline void ptrauth_keys_store(struct ptrauth_keys *keys)
+{
+	if (system_supports_address_auth()) {
+		__ptrauth_key_save(APIA, keys->apia);
+		__ptrauth_key_save(APIB, keys->apib);
+		__ptrauth_key_save(APDA, keys->apda);
+		__ptrauth_key_save(APDB, keys->apdb);
+	}
+
+	if (system_supports_generic_auth())
+		__ptrauth_key_save(APGA, keys->apga);
+}
+
 extern int ptrauth_prctl_reset_keys(struct task_struct *tsk, unsigned long arg);
 
 /*
@@ -88,6 +115,7 @@ do {									\
 	ptrauth_keys_switch(&(tsk)->thread.keys_user)
 
 #else /* CONFIG_ARM64_PTR_AUTH */
+#define __no_ptrauth
 #define ptrauth_prctl_reset_keys(tsk, arg)	(-EINVAL)
 #define ptrauth_strip_insn_pac(lr)	(lr)
 #define ptrauth_thread_init_user(tsk)
-- 
2.7.4

