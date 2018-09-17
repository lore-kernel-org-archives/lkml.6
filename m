Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7004CECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3114B2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3114B2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbeIREhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:37:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49818 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeIREhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:37:22 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 604A5C49;
        Mon, 17 Sep 2018 23:07:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 4.18 025/158] KVM: x86: SVM: Set EMULTYPE_NO_REEXECUTE for RSM emulation
Date:   Tue, 18 Sep 2018 00:40:55 +0200
Message-Id: <20180917211712.121524124@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 35be0aded76b54a24dc8aa678a71bca22273e8d8 upstream.

Re-execution after an emulation decode failure is only intended to
handle a case where two or vCPUs race to write a shadowed page, i.e.
we should never re-execute an instruction as part of RSM emulation.

Add a new helper, kvm_emulate_instruction_from_buffer(), to support
emulating from a pre-defined buffer.  This eliminates the last direct
call to x86_emulate_instruction() outside of kvm_mmu_page_fault(),
which means x86_emulate_instruction() can be unexported in a future
patch.

Fixes: 7607b7174405 ("KVM: SVM: install RSM intercept")
Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/kvm_host.h |    7 +++++++
 arch/x86/kvm/svm.c              |    4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1212,6 +1212,13 @@ static inline int emulate_instruction(st
 			emulation_type | EMULTYPE_NO_REEXECUTE, NULL, 0);
 }
 
+static inline int kvm_emulate_instruction_from_buffer(struct kvm_vcpu *vcpu,
+						      void *insn, int insn_len)
+{
+	return x86_emulate_instruction(vcpu, 0, EMULTYPE_NO_REEXECUTE,
+				       insn, insn_len);
+}
+
 void kvm_enable_efer_bits(u64);
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
 int kvm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr);
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3875,8 +3875,8 @@ static int emulate_on_interception(struc
 
 static int rsm_interception(struct vcpu_svm *svm)
 {
-	return x86_emulate_instruction(&svm->vcpu, 0, 0,
-				       rsm_ins_bytes, 2) == EMULATE_DONE;
+	return kvm_emulate_instruction_from_buffer(&svm->vcpu,
+					rsm_ins_bytes, 2) == EMULATE_DONE;
 }
 
 static int rdpmc_interception(struct vcpu_svm *svm)


