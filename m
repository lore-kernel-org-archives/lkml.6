Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F5DC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5519C2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxxQOKOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5519C2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeJCSf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:35:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39425 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbeJCSf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:35:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id q8-v6so5306611wmq.4;
        Wed, 03 Oct 2018 04:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JuzfczhLlmrJYUGS3HkZzgMkIcgs4yXjieCh43v5oQk=;
        b=DxxQOKOev6RTLN6BGmdX4wTl1b+76xphkEwjV2Fzf2PAdefnveZ7aOReccRNbVr0Z9
         A9Hu1+srl8Dfvz7zg6meaCAX4yy7DkjfZDGOTjFscsKgweDCSSzTDJCtO0z1S8+UhY/2
         Hhb8f7HIwiEO414i9wQlSwqP33MWlctIcXXClk0JrKXsb2Mv7+E6XrmVDPW/Dpx2A9ud
         cuYd5RRSUSruqAsIZl/K1hPoQY9WYww3mt69j9c31vEI7I2HFw+xHxNHGm7aHkKxmhK4
         DRJpaBoBXez9LPPyJKUeGBQ7PNg0DV8pOv4LZm9Gsw5caMTfxY3QKA5MKbqMhZeeD73U
         0L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=JuzfczhLlmrJYUGS3HkZzgMkIcgs4yXjieCh43v5oQk=;
        b=JaF9UpwyCArxu6DbFXOQ3yLkOr53nKw4YUA6tsju/wuuOcKdMCj89O9Lu2/Cj/mCCF
         luPRPvVvzYeSdptXa1bgiDtPKSZixH1y6cX01LyJ4N5M7eufz2FZttPg8DaeHDI81daH
         8KRT1mCSfsUNvNjn+9frfKUWcFVjFI44u1dxD2GOuZ0aV4m6GALdU8sWfFBgsvzIe/1N
         i9UZ4NOaWgXvEvrlXPWazqJBtonNaQRViiwoKpI72C4ATTqmlgUGwVwc4kkKQTTTrn5E
         tTIrTMvbJviQjRTuEgaw9dBhPiVGvCFyM3z9aMEJO4ZRrOXFMuxuiYlS2xQHAOfGPGGz
         V2Bw==
X-Gm-Message-State: ABuFfohkNp2CJmQ66aXaN+ozl69W0iAdqaMqEYMfqh6yDWnpuF/qiIHP
        WzesyeW/1e0WAY+4nIxxpR6rse64
X-Google-Smtp-Source: ACcGV609N0WNUu1w1YEtJh7mz/+ScFBytOw/naIfcqazmLkSljZ+xCLN6liBwQbfuOs5L0uzAVOVng==
X-Received: by 2002:a1c:8f0e:: with SMTP id r14-v6mr1198355wmd.79.1538567272153;
        Wed, 03 Oct 2018 04:47:52 -0700 (PDT)
Received: from 640k.lan (94-36-187-248.adsl-ull.clienti.tiscali.it. [94.36.187.248])
        by smtp.gmail.com with ESMTPSA id c8-v6sm2112445wrb.6.2018.10.03.04.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 04:47:51 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Nikita Leshchenko <nikita.leshchenko@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Liran Alon <liran.alon@oracle.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH] kvm: nVMX: fix entry with pending interrupt if APICv is enabled
Date:   Wed,  3 Oct 2018 13:47:47 +0200
Message-Id: <1538567267-2343-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b5861e5cf2fcf83031ea3e26b0a69d887adf7d21 introduced a check on
the interrupt-window and NMI-window CPU execution controls in order to
inject an external interrupt vmexit before the first guest instruction
executes.  However, when APIC virtualization is enabled the host does not
need a vmexit in order to inject an interrupt at the next interrupt window;
instead, it just places the interrupt vector in RVI and the processor will
inject it as soon as possible.  Therefore, on machines with APICv it is
not enough to check the CPU execution controls: the same scenario can also
happen if RVI>0.

Fixes: b5861e5cf2fcf83031ea3e26b0a69d887adf7d21
Cc: Nikita Leshchenko <nikita.leshchenko@oracle.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Liran Alon <liran.alon@oracle.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 6ef2d5b139b9..c0c7689f0049 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10280,6 +10280,11 @@ static void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
 	}
 }
 
+static u8 vmx_get_rvi(void)
+{
+	return vmcs_read16(GUEST_INTR_STATUS) & 0xff;
+}
+
 static void vmx_set_rvi(int vector)
 {
 	u16 status;
@@ -12593,10 +12598,13 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu, u32 *exit_qual)
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	bool from_vmentry = !!exit_qual;
 	u32 dummy_exit_qual;
-	u32 vmcs01_cpu_exec_ctrl;
+	bool evaluate_pending_interrupts;
 	int r = 0;
 
-	vmcs01_cpu_exec_ctrl = vmcs_read32(CPU_BASED_VM_EXEC_CONTROL);
+	evaluate_pending_interrupts = vmcs_read32(CPU_BASED_VM_EXEC_CONTROL) &
+		(CPU_BASED_VIRTUAL_INTR_PENDING | CPU_BASED_VIRTUAL_NMI_PENDING);
+	if (enable_apicv && kvm_vcpu_apicv_active(vcpu))
+		evaluate_pending_interrupts |= vmx_get_rvi() > 0;
 
 	enter_guest_mode(vcpu);
 
@@ -12650,10 +12658,8 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu, u32 *exit_qual)
 	 * instead. Thus, we force L0 to perform pending event
 	 * evaluation by requesting a KVM_REQ_EVENT.
 	 */
-	if (vmcs01_cpu_exec_ctrl &
-		(CPU_BASED_VIRTUAL_INTR_PENDING | CPU_BASED_VIRTUAL_NMI_PENDING)) {
+	if (evaluate_pending_interrupts)
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
-	}
 
 	/*
 	 * Note no nested_vmx_succeed or nested_vmx_fail here. At this point
-- 
1.8.3.1

