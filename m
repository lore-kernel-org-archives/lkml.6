Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143C1C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2AC21727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2AC21727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389628AbeHNUTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:19:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53268 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387818AbeHNUTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:19:09 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B1FBE40B;
        Tue, 14 Aug 2018 17:31:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.17 58/97] x86/KVM/VMX: Add find_msr() helper function
Date:   Tue, 14 Aug 2018 19:17:10 +0200
Message-Id: <20180814171435.361318059@linuxfoundation.org>
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

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit ca83b4a7f2d068da79a029d323024aa45decb250 upstream

.. to help find the MSR on either the guest or host MSR list.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2237,9 +2237,20 @@ static void clear_atomic_switch_msr_spec
 	vm_exit_controls_clearbit(vmx, exit);
 }
 
+static int find_msr(struct vmx_msrs *m, unsigned int msr)
+{
+	unsigned int i;
+
+	for (i = 0; i < m->nr; ++i) {
+		if (m->val[i].index == msr)
+			return i;
+	}
+	return -ENOENT;
+}
+
 static void clear_atomic_switch_msr(struct vcpu_vmx *vmx, unsigned msr)
 {
-	unsigned i;
+	int i;
 	struct msr_autoload *m = &vmx->msr_autoload;
 
 	switch (msr) {
@@ -2260,11 +2271,8 @@ static void clear_atomic_switch_msr(stru
 		}
 		break;
 	}
-	for (i = 0; i < m->guest.nr; ++i)
-		if (m->guest.val[i].index == msr)
-			break;
-
-	if (i == m->guest.nr)
+	i = find_msr(&m->guest, msr);
+	if (i < 0)
 		return;
 	--m->guest.nr;
 	--m->host.nr;
@@ -2288,7 +2296,7 @@ static void add_atomic_switch_msr_specia
 static void add_atomic_switch_msr(struct vcpu_vmx *vmx, unsigned msr,
 				  u64 guest_val, u64 host_val)
 {
-	unsigned i;
+	int i;
 	struct msr_autoload *m = &vmx->msr_autoload;
 
 	switch (msr) {
@@ -2323,16 +2331,13 @@ static void add_atomic_switch_msr(struct
 		wrmsrl(MSR_IA32_PEBS_ENABLE, 0);
 	}
 
-	for (i = 0; i < m->guest.nr; ++i)
-		if (m->guest.val[i].index == msr)
-			break;
-
+	i = find_msr(&m->guest, msr);
 	if (i == NR_AUTOLOAD_MSRS) {
 		printk_once(KERN_WARNING "Not enough msr switch entries. "
 				"Can't add msr %x\n", msr);
 		return;
-	} else if (i == m->guest.nr) {
-		++m->guest.nr;
+	} else if (i < 0) {
+		i = m->guest.nr++;
 		++m->host.nr;
 		vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, m->guest.nr);
 		vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, m->host.nr);


