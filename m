Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D4DC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7562221730
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7562221730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388653AbeHNUPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:15:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52398 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388032AbeHNUPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:15:12 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EB300CBB;
        Tue, 14 Aug 2018 17:27:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.18 63/79] x86/KVM/VMX: Move the l1tf_flush_l1d test to vmx_l1d_flush()
Date:   Tue, 14 Aug 2018 19:17:22 +0200
Message-Id: <20180814171340.315167477@linuxfoundation.org>
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

From: Nicolai Stange <nstange@suse.de>

Currently, vmx_vcpu_run() checks if l1tf_flush_l1d is set and invokes
vmx_l1d_flush() if so.

This test is unncessary for the "always flush L1D" mode.

Move the check to vmx_l1d_flush()'s conditional mode code path.

Notes:
- vmx_l1d_flush() is likely to get inlined anyway and thus, there's no
  extra function call.

- This inverts the (static) branch prediction, but there hadn't been any
  explicit likely()/unlikely() annotations before and so it stays as is.

Signed-off-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9729,12 +9729,16 @@ static void vmx_l1d_flush(struct kvm_vcp
 	 * 'always'
 	 */
 	if (static_branch_likely(&vmx_l1d_flush_cond)) {
+		bool flush_l1d = vcpu->arch.l1tf_flush_l1d;
+
 		/*
 		 * Clear the flush bit, it gets set again either from
 		 * vcpu_run() or from one of the unsafe VMEXIT
 		 * handlers.
 		 */
 		vcpu->arch.l1tf_flush_l1d = false;
+		if (!flush_l1d)
+			return;
 	}
 
 	vcpu->stat.l1d_flush++;
@@ -10264,10 +10268,8 @@ static void __noclone vmx_vcpu_run(struc
 	evmcs_rsp = static_branch_unlikely(&enable_evmcs) ?
 		(unsigned long)&current_evmcs->host_rsp : 0;
 
-	if (static_branch_unlikely(&vmx_l1d_should_flush)) {
-		if (vcpu->arch.l1tf_flush_l1d)
-			vmx_l1d_flush(vcpu);
-	}
+	if (static_branch_unlikely(&vmx_l1d_should_flush))
+		vmx_l1d_flush(vcpu);
 
 	asm(
 		/* Store host registers */


