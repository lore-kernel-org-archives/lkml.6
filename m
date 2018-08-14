Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28121C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC99121728
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC99121728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbeHNUO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:14:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51958 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387440AbeHNUOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:14:25 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C9C16CD8;
        Tue, 14 Aug 2018 17:26:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 4.18 50/79] x86/kvm: Add static key for flush always
Date:   Tue, 14 Aug 2018 19:17:09 +0200
Message-Id: <20180814171339.168012604@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171336.799314117@linuxfoundation.org>
References: <20180814171336.799314117@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

Avoid the conditional in the L1D flush control path.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jiri Kosina <jkosina@suse.cz>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20180713142322.790914912@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -192,6 +192,7 @@ module_param(ple_window_max, uint, 0444)
 extern const ulong vmx_return;
 
 static DEFINE_STATIC_KEY_FALSE(vmx_l1d_should_flush);
+static DEFINE_STATIC_KEY_FALSE(vmx_l1d_flush_always);
 
 /* Storage for pre module init parameter parsing */
 static enum vmx_l1d_flush_state __read_mostly vmentry_l1d_flush_param = VMENTER_L1D_FLUSH_AUTO;
@@ -232,8 +233,12 @@ static int vmx_setup_l1d_flush(enum vmx_
 
 	l1tf_vmx_mitigation = l1tf;
 
-	if (l1tf != VMENTER_L1D_FLUSH_NEVER)
-		static_branch_enable(&vmx_l1d_should_flush);
+	if (l1tf == VMENTER_L1D_FLUSH_NEVER)
+		return 0;
+
+	static_branch_enable(&vmx_l1d_should_flush);
+	if (l1tf == VMENTER_L1D_FLUSH_ALWAYS)
+		static_branch_enable(&vmx_l1d_flush_always);
 	return 0;
 }
 
@@ -9687,7 +9692,6 @@ static void *vmx_l1d_flush_pages;
 static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 {
 	int size = PAGE_SIZE << L1D_CACHE_ORDER;
-	bool always;
 
 	/*
 	 * This code is only executed when the the flush mode is 'cond' or
@@ -9697,8 +9701,10 @@ static void vmx_l1d_flush(struct kvm_vcp
 	 * it. The flush bit gets set again either from vcpu_run() or from
 	 * one of the unsafe VMEXIT handlers.
 	 */
-	always = l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_ALWAYS;
-	vcpu->arch.l1tf_flush_l1d = always;
+	if (static_branch_unlikely(&vmx_l1d_flush_always))
+		vcpu->arch.l1tf_flush_l1d = true;
+	else
+		vcpu->arch.l1tf_flush_l1d = false;
 
 	vcpu->stat.l1d_flush++;
 


