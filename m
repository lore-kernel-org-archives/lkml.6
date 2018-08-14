Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA85BC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D2921728
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D2921728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388472AbeHNUOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:14:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51996 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387947AbeHNUOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:14:34 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E99A1CD8;
        Tue, 14 Aug 2018 17:26:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 4.18 52/79] x86/kvm: Allow runtime control of L1D flush
Date:   Tue, 14 Aug 2018 19:17:11 +0200
Message-Id: <20180814171339.468224056@linuxfoundation.org>
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

All mitigation modes can be switched at run time with a static key now:

 - Use sysfs_streq() instead of strcmp() to handle the trailing new line
   from sysfs writes correctly.
 - Make the static key management handle multiple invocations properly.
 - Set the module parameter file to RW

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jiri Kosina <jkosina@suse.cz>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20180713142322.954525119@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 arch/x86/kvm/vmx.c         |   13 ++++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -639,7 +639,7 @@ void x86_spec_ctrl_setup_ap(void)
 #define pr_fmt(fmt)	"L1TF: " fmt
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
-enum vmx_l1d_flush_state l1tf_vmx_mitigation __ro_after_init = VMENTER_L1D_FLUSH_AUTO;
+enum vmx_l1d_flush_state l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_AUTO;
 EXPORT_SYMBOL_GPL(l1tf_vmx_mitigation);
 #endif
 
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -234,12 +234,15 @@ static int vmx_setup_l1d_flush(enum vmx_
 
 	l1tf_vmx_mitigation = l1tf;
 
-	if (l1tf == VMENTER_L1D_FLUSH_NEVER)
-		return 0;
+	if (l1tf != VMENTER_L1D_FLUSH_NEVER)
+		static_branch_enable(&vmx_l1d_should_flush);
+	else
+		static_branch_disable(&vmx_l1d_should_flush);
 
-	static_branch_enable(&vmx_l1d_should_flush);
 	if (l1tf == VMENTER_L1D_FLUSH_ALWAYS)
 		static_branch_enable(&vmx_l1d_flush_always);
+	else
+		static_branch_disable(&vmx_l1d_flush_always);
 	return 0;
 }
 
@@ -249,7 +252,7 @@ static int vmentry_l1d_flush_parse(const
 
 	if (s) {
 		for (i = 0; i < ARRAY_SIZE(vmentry_l1d_param); i++) {
-			if (!strcmp(s, vmentry_l1d_param[i].option))
+			if (sysfs_streq(s, vmentry_l1d_param[i].option))
 				return vmentry_l1d_param[i].cmd;
 		}
 	}
@@ -293,7 +296,7 @@ static const struct kernel_param_ops vme
 	.set = vmentry_l1d_flush_set,
 	.get = vmentry_l1d_flush_get,
 };
-module_param_cb(vmentry_l1d_flush, &vmentry_l1d_flush_ops, NULL, S_IRUGO);
+module_param_cb(vmentry_l1d_flush, &vmentry_l1d_flush_ops, NULL, 0644);
 
 struct kvm_vmx {
 	struct kvm kvm;


