Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AA4C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21151208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZh2BoB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21151208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbeJEXO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:14:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729628AbeJEXO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75A972148D;
        Fri,  5 Oct 2018 16:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756104;
        bh=m9DQ+1CkvQ3VhCOS/vdXUK+A+AL3pS5kBtqQV+Tu4hQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qZh2BoB9Fc20La5e1+65ClrrD4IJQOFtbyZy/eGGIvd/8WF8YIJxIrN9GYMGRfz8d
         NcR40Rm9dXDgDeqtZp8NFfnLdDa4gqIvZFXWNBH0kHiWf+m6LWZU8hK7DwgZvV/63V
         Gi69nuJWGTztFAnQ6WdW1xL6x95xNM94E00NofpU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 43/48] x86/kvm/lapic: always disable MMIO interface in x2APIC mode
Date:   Fri,  5 Oct 2018 12:14:19 -0400
Message-Id: <20181005161424.20521-43-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit d1766202779e81d0f2a94c4650a6ba31497d369d ]

When VMX is used with flexpriority disabled (because of no support or
if disabled with module parameter) MMIO interface to lAPIC is still
available in x2APIC mode while it shouldn't be (kvm-unit-tests):

PASS: apic_disable: Local apic enabled in x2APIC mode
PASS: apic_disable: CPUID.1H:EDX.APIC[bit 9] is set
FAIL: apic_disable: *0xfee00030: 50014

The issue appears because we basically do nothing while switching to
x2APIC mode when APIC access page is not used. apic_mmio_{read,write}
only check if lAPIC is disabled before proceeding to actual write.

When APIC access is virtualized we correctly manipulate with VMX controls
in vmx_set_virtual_apic_mode() and we don't get vmexits from memory writes
in x2APIC mode so there's no issue.

Disabling MMIO interface seems to be easy. The question is: what do we
do with these reads and writes? If we add apic_x2apic_mode() check to
apic_mmio_in_range() and return -EOPNOTSUPP these reads and writes will
go to userspace. When lAPIC is in kernel, Qemu uses this interface to
inject MSIs only (see kvm_apic_mem_write() in hw/i386/kvm/apic.c). This
somehow works with disabled lAPIC but when we're in xAPIC mode we will
get a real injected MSI from every write to lAPIC. Not good.

The simplest solution seems to be to just ignore writes to the region
and return ~0 for all reads when we're in x2APIC mode. This is what this
patch does. However, this approach is inconsistent with what currently
happens when flexpriority is enabled: we allocate APIC access page and
create KVM memory region so in x2APIC modes all reads and writes go to
this pre-allocated page which is, btw, the same for all vCPUs.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/include/uapi/asm/kvm.h |  1 +
 arch/x86/kvm/lapic.c            | 22 +++++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index c535c2fdea13..9bba9737ee0b 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -377,5 +377,6 @@ struct kvm_sync_regs {
 
 #define KVM_X86_QUIRK_LINT0_REENABLED	(1 << 0)
 #define KVM_X86_QUIRK_CD_NW_CLEARED	(1 << 1)
+#define KVM_X86_QUIRK_LAPIC_MMIO_HOLE	(1 << 2)
 
 #endif /* _ASM_X86_KVM_H */
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index b5cd8465d44f..83c4e8cc7eb9 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1291,9 +1291,8 @@ EXPORT_SYMBOL_GPL(kvm_lapic_reg_read);
 
 static int apic_mmio_in_range(struct kvm_lapic *apic, gpa_t addr)
 {
-	return kvm_apic_hw_enabled(apic) &&
-	    addr >= apic->base_address &&
-	    addr < apic->base_address + LAPIC_MMIO_LENGTH;
+	return addr >= apic->base_address &&
+		addr < apic->base_address + LAPIC_MMIO_LENGTH;
 }
 
 static int apic_mmio_read(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
@@ -1305,6 +1304,15 @@ static int apic_mmio_read(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
 	if (!apic_mmio_in_range(apic, address))
 		return -EOPNOTSUPP;
 
+	if (!kvm_apic_hw_enabled(apic) || apic_x2apic_mode(apic)) {
+		if (!kvm_check_has_quirk(vcpu->kvm,
+					 KVM_X86_QUIRK_LAPIC_MMIO_HOLE))
+			return -EOPNOTSUPP;
+
+		memset(data, 0xff, len);
+		return 0;
+	}
+
 	kvm_lapic_reg_read(apic, offset, len, data);
 
 	return 0;
@@ -1864,6 +1872,14 @@ static int apic_mmio_write(struct kvm_vcpu *vcpu, struct kvm_io_device *this,
 	if (!apic_mmio_in_range(apic, address))
 		return -EOPNOTSUPP;
 
+	if (!kvm_apic_hw_enabled(apic) || apic_x2apic_mode(apic)) {
+		if (!kvm_check_has_quirk(vcpu->kvm,
+					 KVM_X86_QUIRK_LAPIC_MMIO_HOLE))
+			return -EOPNOTSUPP;
+
+		return 0;
+	}
+
 	/*
 	 * APIC register must be aligned on 128-bits boundary.
 	 * 32/64/128 bits registers must be accessed thru 32 bits.
-- 
2.17.1

