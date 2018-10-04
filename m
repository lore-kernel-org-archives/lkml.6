Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087E4C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA4B214FA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA4B214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeJDU7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:59:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36274 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeJDU7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:59:33 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g84GP-0002ic-KC; Thu, 04 Oct 2018 16:06:01 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 03/11] x86/fpu: make __raw_xsave_addr() use feature number instead of mask
Date:   Thu,  4 Oct 2018 16:05:39 +0200
Message-Id: <20181004140547.13014-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004140547.13014-1-bigeasy@linutronix.de>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
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
 arch/x86/kernel/fpu/xstate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 87a57b7642d36..38d0b5ea40425 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -811,10 +811,8 @@ void fpu__resume_cpu(void)
  *
  * Note: does not work for compacted buffers.
  */
-void *__raw_xsave_addr(struct xregs_state *xsave, int xstate_feature_mask)
+void *__raw_xsave_addr(struct xregs_state *xsave, int feature_nr)
 {
-	int feature_nr = fls64(xstate_feature_mask) - 1;
-
 	if (!xfeature_enabled(feature_nr)) {
 		WARN_ON_FPU(1);
 		return NULL;
@@ -842,6 +840,7 @@ void *__raw_xsave_addr(struct xregs_state *xsave, int xstate_feature_mask)
  */
 void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
 {
+	int feature_nr;
 	/*
 	 * Do we even *have* xsave state?
 	 */
@@ -869,7 +868,8 @@ void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
 	if (!(xsave->header.xfeatures & xstate_feature))
 		return NULL;
 
-	return __raw_xsave_addr(xsave, xstate_feature);
+	feature_nr = fls64(xstate_feature) - 1;
+	return __raw_xsave_addr(xsave, feature_nr);
 }
 EXPORT_SYMBOL_GPL(get_xsave_addr);
 
@@ -1018,7 +1018,7 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
 		 * Copy only in-use xstates:
 		 */
 		if ((header.xfeatures >> i) & 1) {
-			void *src = __raw_xsave_addr(xsave, 1 << i);
+			void *src = __raw_xsave_addr(xsave, i);
 
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
@@ -1104,7 +1104,7 @@ int copy_xstate_to_user(void __user *ubuf, struct xregs_state *xsave, unsigned i
 		 * Copy only in-use xstates:
 		 */
 		if ((header.xfeatures >> i) & 1) {
-			void *src = __raw_xsave_addr(xsave, 1 << i);
+			void *src = __raw_xsave_addr(xsave, i);
 
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
@@ -1161,7 +1161,7 @@ int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 		u64 mask = ((u64)1 << i);
 
 		if (hdr.xfeatures & mask) {
-			void *dst = __raw_xsave_addr(xsave, 1 << i);
+			void *dst = __raw_xsave_addr(xsave, i);
 
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
@@ -1215,7 +1215,7 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 		u64 mask = ((u64)1 << i);
 
 		if (hdr.xfeatures & mask) {
-			void *dst = __raw_xsave_addr(xsave, 1 << i);
+			void *dst = __raw_xsave_addr(xsave, i);
 
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
-- 
2.19.0

