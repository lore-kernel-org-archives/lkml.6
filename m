Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD75ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F072146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F072146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbeIREhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:37:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49868 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731108AbeIREhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:37:42 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C0C96C49;
        Mon, 17 Sep 2018 23:08:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Xiao Guangrong <xiaoguangrong@tencent.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 4.18 030/158] KVM: x86: Do not re-{try,execute} after failed emulation in L2
Date:   Tue, 18 Sep 2018 00:41:00 +0200
Message-Id: <20180917211712.389170415@linuxfoundation.org>
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

commit 6c3dfeb6a48b1562bd5b8ec5f3317ef34d0134ef upstream.

Commit a6f177efaa58 ("KVM: Reenter guest after emulation failure if
due to access to non-mmio address") added reexecute_instruction() to
handle the scenario where two (or more) vCPUS race to write a shadowed
page, i.e. reexecute_instruction() is intended to return true if and
only if the instruction being emulated was accessing a shadowed page.
As L0 is only explicitly shadowing L1 tables, an emulation failure of
a nested VM instruction cannot be due to a race to write a shadowed
page and so should never be re-executed.

This fixes an issue where an "MMIO" emulation failure[1] in L2 is all
but guaranteed to result in an infinite loop when TDP is enabled.
Because "cr2" is actually an L2 GPA when TDP is enabled, calling
kvm_mmu_gva_to_gpa_write() to translate cr2 in the non-direct mapped
case (L2 is never direct mapped) will almost always yield UNMAPPED_GVA
and cause reexecute_instruction() to immediately return true.  The
!mmio_info_in_cache() check in kvm_mmu_page_fault() doesn't catch this
case because mmio_info_in_cache() returns false for a nested MMU (the
MMIO caching currently handles L1 only, e.g. to cache nested guests'
GPAs we'd have to manually flush the cache when switching between
VMs and when L1 updated its page tables controlling the nested guest).

Way back when, commit 68be0803456b ("KVM: x86: never re-execute
instruction with enabled tdp") changed reexecute_instruction() to
always return false when using TDP under the assumption that KVM would
only get into the emulator for MMIO.  Commit 95b3cf69bdf8 ("KVM: x86:
let reexecute_instruction work for tdp") effectively reverted that
behavior in order to handle the scenario where emulation failed due to
an access from L1 to the shadow page tables for L2, but it didn't
account for the case where emulation failed in L2 with TDP enabled.

All of the above logic also applies to retry_instruction(), added by
commit 1cb3f3ae5a38 ("KVM: x86: retry non-page-table writing
instructions").  An indefinite loop in retry_instruction() should be
impossible as it protects against retrying the same instruction over
and over, but it's still correct to not retry an L2 instruction in
the first place.

Fix the immediate issue by adding a check for a nested guest when
determining whether or not to allow retry in kvm_mmu_page_fault().
In addition to fixing the immediate bug, add WARN_ON_ONCE in the
retry functions since they are not designed to handle nested cases,
i.e. they need to be modified even if there is some scenario in the
future where we want to allow retrying a nested guest.

[1] This issue was encountered after commit 3a2936dedd20 ("kvm: mmu:
    Don't expose private memslots to L2") changed the page fault path
    to return KVM_PFN_NOSLOT when translating an L2 access to a
    prive memslot.  Returning KVM_PFN_NOSLOT is semantically correct
    when we want to hide a memslot from L2, i.e. there effectively is
    no defined memory region for L2, but it has the unfortunate side
    effect of making KVM think the GFN is a MMIO page, thus triggering
    emulation.  The failure occurred with in-development code that
    deliberately exposed a private memslot to L2, which L2 accessed
    with an instruction that is not emulated by KVM.

Fixes: 95b3cf69bdf8 ("KVM: x86: let reexecute_instruction work for tdp")
Fixes: 1cb3f3ae5a38 ("KVM: x86: retry non-page-table writing instructions")
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Cc: Xiao Guangrong <xiaoguangrong@tencent.com>
Cc: stable@vger.kernel.org
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/mmu.c |    7 +++++--
 arch/x86/kvm/x86.c |    6 ++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5007,9 +5007,12 @@ int kvm_mmu_page_fault(struct kvm_vcpu *
 	 * re-execute the instruction that caused the page fault.  Do not allow
 	 * retrying MMIO emulation, as it's not only pointless but could also
 	 * cause us to enter an infinite loop because the processor will keep
-	 * faulting on the non-existent MMIO address.
+	 * faulting on the non-existent MMIO address.  Retrying an instruction
+	 * from a nested guest is also pointless and dangerous as we are only
+	 * explicitly shadowing L1's page tables, i.e. unprotecting something
+	 * for L1 isn't going to magically fix whatever issue cause L2 to fail.
 	 */
-	if (!mmio_info_in_cache(vcpu, cr2, direct))
+	if (!mmio_info_in_cache(vcpu, cr2, direct) && !is_guest_mode(vcpu))
 		emulation_type = EMULTYPE_ALLOW_RETRY;
 emulate:
 	/*
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5813,6 +5813,9 @@ static bool reexecute_instruction(struct
 	if (!(emulation_type & EMULTYPE_ALLOW_RETRY))
 		return false;
 
+	if (WARN_ON_ONCE(is_guest_mode(vcpu)))
+		return false;
+
 	if (!vcpu->arch.mmu.direct_map) {
 		/*
 		 * Write permission should be allowed since only
@@ -5901,6 +5904,9 @@ static bool retry_instruction(struct x86
 	if (!(emulation_type & EMULTYPE_ALLOW_RETRY))
 		return false;
 
+	if (WARN_ON_ONCE(is_guest_mode(vcpu)))
+		return false;
+
 	if (x86_page_table_writing_insn(ctxt))
 		return false;
 


