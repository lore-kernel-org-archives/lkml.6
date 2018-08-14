Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE224C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B723208C1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B723208C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388185AbeHNU1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:27:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58412 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbeHNU1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:27:02 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 037D2CBA;
        Tue, 14 Aug 2018 17:38:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 081/104] x86/KVM/VMX: Dont set l1tf_flush_l1d to true from vmx_l1d_flush()
Date:   Tue, 14 Aug 2018 19:17:35 +0200
Message-Id: <20180814171520.489168695@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolai Stange <nstange@suse.de>

commit 379fd0c7e6a391e5565336a646f19f218fb98c6c upstream

vmx_l1d_flush() gets invoked only if l1tf_flush_l1d is true. There's no
point in setting l1tf_flush_l1d to true from there again.

Signed-off-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9166,15 +9166,15 @@ static void vmx_l1d_flush(struct kvm_vcp
 	/*
 	 * This code is only executed when the the flush mode is 'cond' or
 	 * 'always'
-	 *
-	 * If 'flush always', keep the flush bit set, otherwise clear
-	 * it. The flush bit gets set again either from vcpu_run() or from
-	 * one of the unsafe VMEXIT handlers.
 	 */
-	if (static_branch_unlikely(&vmx_l1d_flush_always))
-		vcpu->arch.l1tf_flush_l1d = true;
-	else
+	if (!static_branch_unlikely(&vmx_l1d_flush_always)) {
+		/*
+		 * Clear the flush bit, it gets set again either from
+		 * vcpu_run() or from one of the unsafe VMEXIT
+		 * handlers.
+		 */
 		vcpu->arch.l1tf_flush_l1d = false;
+	}
 
 	vcpu->stat.l1d_flush++;
 


