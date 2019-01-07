Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA2CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCEB218A3
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864892;
	bh=DKpgZSbq3zjgW39SOhcn+j6yi1tm8TzaZgbnRyHRV3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xrgJFpZy5sGBvIUJtcHYvdhhbGq6VEc0Nh0oYQy2zzsfNpupL7ahtcQ7AF86HWf6R
	 xe73gqEkHIt+AGhSNbKc8OCmmS06caTvpuI5n9TvNyQfnJnMZXQZa1TPS5JiNQjTqS
	 Tatq89NrcK6OjPZ2AN8IFF8026dkWIy6X1j4/knc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfAGMlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:41:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbfAGMl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:41:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E9232183E;
        Mon,  7 Jan 2019 12:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864888;
        bh=DKpgZSbq3zjgW39SOhcn+j6yi1tm8TzaZgbnRyHRV3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DiEit/nvMBN1XTcTl0Ko8uaC+6ZGnsyDF3CO+1M9iPLeIgEuM48pSPYxqSCnV21rG
         mk/S+I+gpR8zd/P0LiDGdw1v6N0S/NpSdVV2JvnvUgvKb0howskB+GYOwVSpbaT6Iu
         VRIiD/eAqQBKItXU8QvFNcgHX3jYdb8oT4T4I1CM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.20 057/145] arm64: KVM: Make VHE Stage-2 TLB invalidation operations non-interruptible
Date:   Mon,  7 Jan 2019 13:31:34 +0100
Message-Id: <20190107104444.763090837@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit c987876a80e7bcb98a839f10dca9ce7fda4feced upstream.

Contrary to the non-VHE version of the TLB invalidation helpers, the VHE
code  has interrupts enabled, meaning that we can take an interrupt in
the middle of such a sequence, and start running something else with
HCR_EL2.TGE cleared.

That's really not a good idea.

Take the heavy-handed option and disable interrupts in
__tlb_switch_to_guest_vhe, restoring them in __tlb_switch_to_host_vhe.
The latter also gain an ISB in order to make sure that TGE really has
taken effect.

Cc: stable@vger.kernel.org
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kvm/hyp/tlb.c |   35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

--- a/arch/arm64/kvm/hyp/tlb.c
+++ b/arch/arm64/kvm/hyp/tlb.c
@@ -15,14 +15,19 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/irqflags.h>
+
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
 #include <asm/tlbflush.h>
 
-static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm)
+static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
+						 unsigned long *flags)
 {
 	u64 val;
 
+	local_irq_save(*flags);
+
 	/*
 	 * With VHE enabled, we have HCR_EL2.{E2H,TGE} = {1,1}, and
 	 * most TLB operations target EL2/EL0. In order to affect the
@@ -37,7 +42,8 @@ static void __hyp_text __tlb_switch_to_g
 	isb();
 }
 
-static void __hyp_text __tlb_switch_to_guest_nvhe(struct kvm *kvm)
+static void __hyp_text __tlb_switch_to_guest_nvhe(struct kvm *kvm,
+						  unsigned long *flags)
 {
 	__load_guest_stage2(kvm);
 	isb();
@@ -48,7 +54,8 @@ static hyp_alternate_select(__tlb_switch
 			    __tlb_switch_to_guest_vhe,
 			    ARM64_HAS_VIRT_HOST_EXTN);
 
-static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm)
+static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm,
+						unsigned long flags)
 {
 	/*
 	 * We're done with the TLB operation, let's restore the host's
@@ -56,9 +63,12 @@ static void __hyp_text __tlb_switch_to_h
 	 */
 	write_sysreg(0, vttbr_el2);
 	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
+	isb();
+	local_irq_restore(flags);
 }
 
-static void __hyp_text __tlb_switch_to_host_nvhe(struct kvm *kvm)
+static void __hyp_text __tlb_switch_to_host_nvhe(struct kvm *kvm,
+						 unsigned long flags)
 {
 	write_sysreg(0, vttbr_el2);
 }
@@ -70,11 +80,13 @@ static hyp_alternate_select(__tlb_switch
 
 void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 {
+	unsigned long flags;
+
 	dsb(ishst);
 
 	/* Switch to requested VMID */
 	kvm = kern_hyp_va(kvm);
-	__tlb_switch_to_guest()(kvm);
+	__tlb_switch_to_guest()(kvm, &flags);
 
 	/*
 	 * We could do so much better if we had the VA as well.
@@ -117,36 +129,39 @@ void __hyp_text __kvm_tlb_flush_vmid_ipa
 	if (!has_vhe() && icache_is_vpipt())
 		__flush_icache_all();
 
-	__tlb_switch_to_host()(kvm);
+	__tlb_switch_to_host()(kvm, flags);
 }
 
 void __hyp_text __kvm_tlb_flush_vmid(struct kvm *kvm)
 {
+	unsigned long flags;
+
 	dsb(ishst);
 
 	/* Switch to requested VMID */
 	kvm = kern_hyp_va(kvm);
-	__tlb_switch_to_guest()(kvm);
+	__tlb_switch_to_guest()(kvm, &flags);
 
 	__tlbi(vmalls12e1is);
 	dsb(ish);
 	isb();
 
-	__tlb_switch_to_host()(kvm);
+	__tlb_switch_to_host()(kvm, flags);
 }
 
 void __hyp_text __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = kern_hyp_va(kern_hyp_va(vcpu)->kvm);
+	unsigned long flags;
 
 	/* Switch to requested VMID */
-	__tlb_switch_to_guest()(kvm);
+	__tlb_switch_to_guest()(kvm, &flags);
 
 	__tlbi(vmalle1);
 	dsb(nsh);
 	isb();
 
-	__tlb_switch_to_host()(kvm);
+	__tlb_switch_to_host()(kvm, flags);
 }
 
 void __hyp_text __kvm_flush_vm_context(void)


