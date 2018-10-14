Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B590C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC7120645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC7120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbeJNXjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:39:11 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35971 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727565AbeJNXLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:52 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLf-0004cF-Vp; Sun, 14 Oct 2018 16:30:32 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0000kU-0R; Sun, 14 Oct 2018 16:30:27 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Wei Huang" <wei@redhat.com>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        "Bandan Das" <bsd@redhat.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.831180161@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 348/366] KVM: x86: Update cpuid properly when
 CR4.OSXAVE or CR4.PKE is changed
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Huang <wei@redhat.com>

commit c4d2188206bafa177ea58e9a25b952baa0bf7712 upstream.

The CPUID bits of OSXSAVE (function=0x1) and OSPKE (func=0x7, leaf=0x0)
allows user apps to detect if OS has set CR4.OSXSAVE or CR4.PKE. KVM is
supposed to update these CPUID bits when CR4 is updated. Current KVM
code doesn't handle some special cases when updates come from emulator.
Here is one example:

  Step 1: guest boots
  Step 2: guest OS enables XSAVE ==> CR4.OSXSAVE=1 and CPUID.OSXSAVE=1
  Step 3: guest hot reboot ==> QEMU reset CR4 to 0, but CPUID.OSXAVE==1
  Step 4: guest os checks CPUID.OSXAVE, detects 1, then executes xgetbv

Step 4 above will cause an #UD and guest crash because guest OS hasn't
turned on OSXAVE yet. This patch solves the problem by comparing the the
old_cr4 with cr4. If the related bits have been changed,
kvm_update_cpuid() needs to be called.

Signed-off-by: Wei Huang <wei@redhat.com>
Reviewed-by: Bandan Das <bsd@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
[bwh: Backported to 3.16: PKE is not supported]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/x86.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6668,6 +6668,7 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct
 {
 	struct msr_data apic_base_msr;
 	int mmu_reset_needed = 0;
+	int cpuid_update_needed = 0;
 	int pending_vec, max_bits, idx;
 	struct desc_ptr dt;
 
@@ -6702,8 +6703,10 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct
 	vcpu->arch.cr0 = sregs->cr0;
 
 	mmu_reset_needed |= kvm_read_cr4(vcpu) != sregs->cr4;
+	cpuid_update_needed |= ((kvm_read_cr4(vcpu) ^ sregs->cr4) &
+				X86_CR4_OSXSAVE);
 	kvm_x86_ops->set_cr4(vcpu, sregs->cr4);
-	if (sregs->cr4 & X86_CR4_OSXSAVE)
+	if (cpuid_update_needed)
 		kvm_update_cpuid(vcpu);
 
 	idx = srcu_read_lock(&vcpu->kvm->srcu);

