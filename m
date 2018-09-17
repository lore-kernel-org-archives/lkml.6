Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62C4ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987E02146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987E02146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbeIREha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:37:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49836 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeIREh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:37:29 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 201B8C7D;
        Mon, 17 Sep 2018 23:07:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 4.18 027/158] KVM: x86: Invert emulation re-execute behavior to make it opt-in
Date:   Tue, 18 Sep 2018 00:40:57 +0200
Message-Id: <20180917211712.235326945@linuxfoundation.org>
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

commit 8065dbd1ee0ef04321d80da7999b4f0086e0a407 upstream.

Re-execution of an instruction after emulation decode failure is
intended to be used only when emulating shadow page accesses.  Invert
the flag to make allowing re-execution opt-in since that behavior is
by far in the minority.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/kvm_host.h |    8 +++-----
 arch/x86/kvm/mmu.c              |    2 +-
 arch/x86/kvm/x86.c              |    2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1199,7 +1199,7 @@ enum emulation_result {
 #define EMULTYPE_TRAP_UD	    (1 << 1)
 #define EMULTYPE_SKIP		    (1 << 2)
 #define EMULTYPE_RETRY		    (1 << 3)
-#define EMULTYPE_NO_REEXECUTE	    (1 << 4)
+#define EMULTYPE_ALLOW_REEXECUTE    (1 << 4)
 #define EMULTYPE_NO_UD_ON_FAIL	    (1 << 5)
 #define EMULTYPE_VMWARE		    (1 << 6)
 int x86_emulate_instruction(struct kvm_vcpu *vcpu, unsigned long cr2,
@@ -1208,15 +1208,13 @@ int x86_emulate_instruction(struct kvm_v
 static inline int emulate_instruction(struct kvm_vcpu *vcpu,
 			int emulation_type)
 {
-	return x86_emulate_instruction(vcpu, 0,
-			emulation_type | EMULTYPE_NO_REEXECUTE, NULL, 0);
+	return x86_emulate_instruction(vcpu, 0, emulation_type, NULL, 0);
 }
 
 static inline int kvm_emulate_instruction_from_buffer(struct kvm_vcpu *vcpu,
 						      void *insn, int insn_len)
 {
-	return x86_emulate_instruction(vcpu, 0, EMULTYPE_NO_REEXECUTE,
-				       insn, insn_len);
+	return x86_emulate_instruction(vcpu, 0, 0, insn, insn_len);
 }
 
 void kvm_enable_efer_bits(u64);
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4960,7 +4960,7 @@ static int make_mmu_pages_available(stru
 int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t cr2, u64 error_code,
 		       void *insn, int insn_len)
 {
-	int r, emulation_type = EMULTYPE_RETRY;
+	int r, emulation_type = EMULTYPE_RETRY | EMULTYPE_ALLOW_REEXECUTE;
 	enum emulation_result er;
 	bool direct = vcpu->arch.mmu.direct_map;
 
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5810,7 +5810,7 @@ static bool reexecute_instruction(struct
 	gpa_t gpa = cr2;
 	kvm_pfn_t pfn;
 
-	if (emulation_type & EMULTYPE_NO_REEXECUTE)
+	if (!(emulation_type & EMULTYPE_ALLOW_REEXECUTE))
 		return false;
 
 	if (!vcpu->arch.mmu.direct_map) {


