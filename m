Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FECC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A04F216FB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:54:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A04F216FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390252AbeHNUaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:30:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59172 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390231AbeHNUaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:30:13 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 22C23D99;
        Tue, 14 Aug 2018 17:32:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.17 79/97] x86/KVM/VMX: Replace vmx_l1d_flush_always with vmx_l1d_flush_cond
Date:   Tue, 14 Aug 2018 19:17:31 +0200
Message-Id: <20180814171436.148363310@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171433.160434170@linuxfoundation.org>
References: <20180814171433.160434170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolai Stange <nstange@suse.de>

commit 427362a142441f08051369db6fbe7f61c73b3dca upstream

The vmx_l1d_flush_always static key is only ever evaluated if
vmx_l1d_should_flush is enabled. In that case however, there are only two
L1d flushing modes possible: "always" and "conditional".

The "conditional" mode's implementation tends to require more sophisticated
logic than the "always" mode.

Avoid inverted logic by replacing the 'vmx_l1d_flush_always' static key
with a 'vmx_l1d_flush_cond' one.

There is no change in functionality.

Signed-off-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -189,7 +189,7 @@ module_param(ple_window_max, uint, 0444)
 extern const ulong vmx_return;
 
 static DEFINE_STATIC_KEY_FALSE(vmx_l1d_should_flush);
-static DEFINE_STATIC_KEY_FALSE(vmx_l1d_flush_always);
+static DEFINE_STATIC_KEY_FALSE(vmx_l1d_flush_cond);
 static DEFINE_MUTEX(vmx_l1d_flush_mutex);
 
 /* Storage for pre module init parameter parsing */
@@ -263,10 +263,10 @@ static int vmx_setup_l1d_flush(enum vmx_
 	else
 		static_branch_disable(&vmx_l1d_should_flush);
 
-	if (l1tf == VMENTER_L1D_FLUSH_ALWAYS)
-		static_branch_enable(&vmx_l1d_flush_always);
+	if (l1tf == VMENTER_L1D_FLUSH_COND)
+		static_branch_enable(&vmx_l1d_flush_cond);
 	else
-		static_branch_disable(&vmx_l1d_flush_always);
+		static_branch_disable(&vmx_l1d_flush_cond);
 	return 0;
 }
 
@@ -9462,7 +9462,7 @@ static void vmx_l1d_flush(struct kvm_vcp
 	 * This code is only executed when the the flush mode is 'cond' or
 	 * 'always'
 	 */
-	if (!static_branch_unlikely(&vmx_l1d_flush_always)) {
+	if (static_branch_likely(&vmx_l1d_flush_cond)) {
 		/*
 		 * Clear the flush bit, it gets set again either from
 		 * vcpu_run() or from one of the unsafe VMEXIT


