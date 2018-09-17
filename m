Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC33EECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A815214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A815214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbeIREhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:37:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49852 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeIREhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:37:35 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A5919C49;
        Mon, 17 Sep 2018 23:08:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 4.18 029/158] KVM: x86: Default to not allowing emulation retry in kvm_mmu_page_fault
Date:   Tue, 18 Sep 2018 00:40:59 +0200
Message-Id: <20180917211712.335191585@linuxfoundation.org>
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

commit 472faffacd9032164f611f56329d0025ddca55b5 upstream.

Effectively force kvm_mmu_page_fault() to opt-in to allowing retry to
make it more obvious when and why it allows emulation to be retried.
Previously this approach was less convenient due to retry and
re-execute behavior being controlled by separate flags that were also
inverted in their implementations (opt-in versus opt-out).

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/mmu.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4960,7 +4960,7 @@ static int make_mmu_pages_available(stru
 int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t cr2, u64 error_code,
 		       void *insn, int insn_len)
 {
-	int r, emulation_type = EMULTYPE_ALLOW_RETRY;
+	int r, emulation_type = 0;
 	enum emulation_result er;
 	bool direct = vcpu->arch.mmu.direct_map;
 
@@ -4973,10 +4973,8 @@ int kvm_mmu_page_fault(struct kvm_vcpu *
 	r = RET_PF_INVALID;
 	if (unlikely(error_code & PFERR_RSVD_MASK)) {
 		r = handle_mmio_page_fault(vcpu, cr2, direct);
-		if (r == RET_PF_EMULATE) {
-			emulation_type = 0;
+		if (r == RET_PF_EMULATE)
 			goto emulate;
-		}
 	}
 
 	if (r == RET_PF_INVALID) {
@@ -5003,8 +5001,16 @@ int kvm_mmu_page_fault(struct kvm_vcpu *
 		return 1;
 	}
 
-	if (mmio_info_in_cache(vcpu, cr2, direct))
-		emulation_type = 0;
+	/*
+	 * vcpu->arch.mmu.page_fault returned RET_PF_EMULATE, but we can still
+	 * optimistically try to just unprotect the page and let the processor
+	 * re-execute the instruction that caused the page fault.  Do not allow
+	 * retrying MMIO emulation, as it's not only pointless but could also
+	 * cause us to enter an infinite loop because the processor will keep
+	 * faulting on the non-existent MMIO address.
+	 */
+	if (!mmio_info_in_cache(vcpu, cr2, direct))
+		emulation_type = EMULTYPE_ALLOW_RETRY;
 emulate:
 	/*
 	 * On AMD platforms, under certain conditions insn_len may be zero on #NPF.


