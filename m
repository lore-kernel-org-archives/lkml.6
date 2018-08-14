Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACD6C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF5221727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF5221727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389643AbeHNUTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:19:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53276 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387818AbeHNUTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:19:13 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 25110BDB;
        Tue, 14 Aug 2018 17:31:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.17 59/97] x86/KVM/VMX: Separate the VMX AUTOLOAD guest/host number accounting
Date:   Tue, 14 Aug 2018 19:17:11 +0200
Message-Id: <20180814171435.399743805@linuxfoundation.org>
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

commit 3190709335dd31fe1aeeebfe4ffb6c7624ef971f upstream

This allows to load a different number of MSRs depending on the context:
VMEXIT or VMENTER.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2273,12 +2273,18 @@ static void clear_atomic_switch_msr(stru
 	}
 	i = find_msr(&m->guest, msr);
 	if (i < 0)
-		return;
+		goto skip_guest;
 	--m->guest.nr;
-	--m->host.nr;
 	m->guest.val[i] = m->guest.val[m->guest.nr];
-	m->host.val[i] = m->host.val[m->host.nr];
 	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, m->guest.nr);
+
+skip_guest:
+	i = find_msr(&m->host, msr);
+	if (i < 0)
+		return;
+
+	--m->host.nr;
+	m->host.val[i] = m->host.val[m->host.nr];
 	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, m->host.nr);
 }
 
@@ -2296,7 +2302,7 @@ static void add_atomic_switch_msr_specia
 static void add_atomic_switch_msr(struct vcpu_vmx *vmx, unsigned msr,
 				  u64 guest_val, u64 host_val)
 {
-	int i;
+	int i, j;
 	struct msr_autoload *m = &vmx->msr_autoload;
 
 	switch (msr) {
@@ -2332,21 +2338,24 @@ static void add_atomic_switch_msr(struct
 	}
 
 	i = find_msr(&m->guest, msr);
-	if (i == NR_AUTOLOAD_MSRS) {
+	j = find_msr(&m->host, msr);
+	if (i == NR_AUTOLOAD_MSRS || j == NR_AUTOLOAD_MSRS) {
 		printk_once(KERN_WARNING "Not enough msr switch entries. "
 				"Can't add msr %x\n", msr);
 		return;
-	} else if (i < 0) {
+	}
+	if (i < 0) {
 		i = m->guest.nr++;
-		++m->host.nr;
 		vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, m->guest.nr);
+	}
+	if (j < 0) {
+		j = m->host.nr++;
 		vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, m->host.nr);
 	}
-
 	m->guest.val[i].index = msr;
 	m->guest.val[i].value = guest_val;
-	m->host.val[i].index = msr;
-	m->host.val[i].value = host_val;
+	m->host.val[j].index = msr;
+	m->host.val[j].value = host_val;
 }
 
 static bool update_transition_efer(struct vcpu_vmx *vmx, int efer_offset)


