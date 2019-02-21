Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BADC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6CE2148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfBULxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:53:00 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45657 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbfBULup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:50:45 -0500
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gwmsA-0001RC-KD; Thu, 21 Feb 2019 12:50:38 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 10/22] x86/fpu: Make __raw_xsave_addr() use feature number instead of mask
Date:   Thu, 21 Feb 2019 12:50:08 +0100
Message-Id: <20190221115020.12385-11-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221115020.12385-1-bigeasy@linutronix.de>
References: <20190221115020.12385-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most users of __raw_xsave_addr() use a feature number, shift it to a
mask and then __raw_xsave_addr() shifts it back to the feature number.

Make __raw_xsave_addr() use the feature number as an argument.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/fpu/xstate.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 914d9886c6ee8..0e759a032c1c7 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -805,20 +805,18 @@ void fpu__resume_cpu(void)
 }
 
 /*
- * Given an xstate feature mask, calculate where in the xsave
+ * Given an xstate feature nr, calculate where in the xsave
  * buffer the state is.  Callers should ensure that the buffer
  * is valid.
  */
-static void *__raw_xsave_addr(struct xregs_state *xsave, int xstate_feature_mask)
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
@@ -840,6 +838,7 @@ static void *__raw_xsave_addr(struct xregs_state *xsave, int xstate_feature_mask
  */
 void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
 {
+	int xfeature_nr;
 	/*
 	 * Do we even *have* xsave state?
 	 */
@@ -867,7 +866,8 @@ void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
 	if (!(xsave->header.xfeatures & xstate_feature))
 		return NULL;
 
-	return __raw_xsave_addr(xsave, xstate_feature);
+	xfeature_nr = fls64(xstate_feature) - 1;
+	return __raw_xsave_addr(xsave, xfeature_nr);
 }
 EXPORT_SYMBOL_GPL(get_xsave_addr);
 
@@ -1014,7 +1014,7 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
 		 * Copy only in-use xstates:
 		 */
 		if ((header.xfeatures >> i) & 1) {
-			void *src = __raw_xsave_addr(xsave, 1 << i);
+			void *src = __raw_xsave_addr(xsave, i);
 
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
@@ -1100,7 +1100,7 @@ int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned i
 		 * Copy only in-use xstates:
 		 */
 		if ((header.xfeatures >> i) & 1) {
-			void *src = __raw_xsave_addr(xsave, 1 << i);
+			void *src = __raw_xsave_addr(xsave, i);
 
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
@@ -1157,7 +1157,7 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 		u64 mask = ((u64)1 << i);
 
 		if (hdr.xfeatures & mask) {
-			void *dst = __raw_xsave_addr(xsave, 1 << i);
+			void *dst = __raw_xsave_addr(xsave, i);
 
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
@@ -1211,7 +1211,7 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 		u64 mask = ((u64)1 << i);
 
 		if (hdr.xfeatures & mask) {
-			void *dst = __raw_xsave_addr(xsave, 1 << i);
+			void *dst = __raw_xsave_addr(xsave, i);
 
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
-- 
2.20.1

