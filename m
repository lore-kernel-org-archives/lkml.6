Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5795AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A9320837
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A9320837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeKHFVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:21:15 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41908 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbeKHFVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:21:14 -0500
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gKTpF-00070Q-Di; Wed, 07 Nov 2018 20:49:17 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 12/23] x86/fpu: Make __raw_xsave_addr() use feature number instead of mask
Date:   Wed,  7 Nov 2018 20:48:47 +0100
Message-Id: <20181107194858.9380-13-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107194858.9380-1-bigeasy@linutronix.de>
References: <20181107194858.9380-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most users of __raw_xsave_addr() use a feature number, shift it to a
mask and then __raw_xsave_addr() shifts it back to the feature number.

Make __raw_xsave_addr() use the feature number as argument.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/fpu/xstate.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a2041961f3008..3dfe3627deaf6 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -805,22 +805,20 @@ void fpu__resume_cpu(void)
 }
 
 /*
- * Given an xstate feature mask, calculate where in the xsave
+ * Given an xstate feature nr, calculate where in the xsave
  * buffer the state is.  Callers should ensure that the buffer
  * is valid.
  *
  * Note: does not work for compacted buffers.
  */
-void *__raw_xsave_addr(struct xregs_state *xsave, int xstate_feature_mask)
+static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 {
-	int feature_nr = fls64(xstate_feature_mask) - 1;
-
-	if (!xfeature_enabled(feature_nr)) {
+	if (!xfeature_enabled(xfeature_nr)) {
 		WARN_ON_FPU(1);
 		return NULL;
 	}
 
-	return (void *)xsave + xstate_comp_offsets[feature_nr];
+	return (void *)xsave + xstate_comp_offsets[xfeature_nr];
 }
 /*
  * Given the xsave area and a state inside, this function returns the
@@ -842,6 +840,7 @@ void *__raw_xsave_addr(struct xregs_state *xsave, int xstate_feature_mask)
  */
 void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
 {
+	int xfeature_nr;
 	/*
 	 * Do we even *have* xsave state?
 	 */
@@ -869,7 +868,8 @@ void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
 	if (!(xsave->header.xfeatures & xstate_feature))
 		return NULL;
 
-	return __raw_xsave_addr(xsave, xstate_feature);
+	xfeature_nr = fls64(xstate_feature) - 1;
+	return __raw_xsave_addr(xsave, xfeature_nr);
 }
 EXPORT_SYMBOL_GPL(get_xsave_addr);
 
@@ -1016,7 +1016,7 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
 		 * Copy only in-use xstates:
 		 */
 		if ((header.xfeatures >> i) & 1) {
-			void *src = __raw_xsave_addr(xsave, 1 << i);
+			void *src = __raw_xsave_addr(xsave, i);
 
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
@@ -1102,7 +1102,7 @@ int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned i
 		 * Copy only in-use xstates:
 		 */
 		if ((header.xfeatures >> i) & 1) {
-			void *src = __raw_xsave_addr(xsave, 1 << i);
+			void *src = __raw_xsave_addr(xsave, i);
 
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
@@ -1159,7 +1159,7 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 		u64 mask = ((u64)1 << i);
 
 		if (hdr.xfeatures & mask) {
-			void *dst = __raw_xsave_addr(xsave, 1 << i);
+			void *dst = __raw_xsave_addr(xsave, i);
 
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
@@ -1213,7 +1213,7 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 		u64 mask = ((u64)1 << i);
 
 		if (hdr.xfeatures & mask) {
-			void *dst = __raw_xsave_addr(xsave, 1 << i);
+			void *dst = __raw_xsave_addr(xsave, i);
 
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
-- 
2.19.1

