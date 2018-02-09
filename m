Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751139AbeBINBh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 08:01:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750993AbeBINBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 08:01:36 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH] KVM: lapic: stop advertising DIRECTED_EOI when in-kernel IOAPIC is in use
Date: Fri,  9 Feb 2018 14:01:33 +0100
Message-Id: <20180209130133.28387-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Devices which use level-triggered interrupts under Windows 2016 with
Hyper-V role enabled don't work: Windows disables EOI broadcast in SPIV
unconditionally. Our in-kernel IOAPIC implementation emulates an old IOAPIC
version which has no EOI register so EOI never happens.

The issue was discovered and discussed a while ago:
https://www.spinics.net/lists/kvm/msg148098.html

While this is a guest OS bug (it should check that IOAPIC has the required
capabilities before disabling EOI broadcast) we can workaround it in KVM:
advertising DIRECTED_EOI with in-kernel IOAPIC makes little sense anyway.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
- Radim's suggestion was to disable DIRECTED_EOI unconditionally but I'm not
  that radical :-) In theory, we may have multiple IOAPICs in userspace in
  future and DIRECTED_EOI can be leveraged.
---
 arch/x86/kvm/lapic.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 924ac8ce9d50..5339287fee63 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -321,8 +321,16 @@ void kvm_apic_set_version(struct kvm_vcpu *vcpu)
 	if (!lapic_in_kernel(vcpu))
 		return;
 
+	/*
+	 * KVM emulates 82093AA datasheet (with in-kernel IOAPIC implementation)
+	 * which doesn't have EOI register; Some buggy OSes (e.g. Windows with
+	 * Hyper-V role) disable EOI broadcast in lapic not checking for IOAPIC
+	 * version first and level-triggered interrupts never get EOIed in
+	 * IOAPIC.
+	 */
 	feat = kvm_find_cpuid_entry(apic->vcpu, 0x1, 0);
-	if (feat && (feat->ecx & (1 << (X86_FEATURE_X2APIC & 31))))
+	if (feat && (feat->ecx & (1 << (X86_FEATURE_X2APIC & 31))) &&
+	    !ioapic_in_kernel(vcpu->kvm))
 		v |= APIC_LVR_DIRECTED_EOI;
 	kvm_lapic_set_reg(apic, APIC_LVR, v);
 }
-- 
2.14.3
