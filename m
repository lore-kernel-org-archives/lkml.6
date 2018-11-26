Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080B7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E9E20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETFqnct6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E9E20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbeK0DtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:49:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54876 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbeK0DtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:49:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id z18so4298029wmc.4;
        Mon, 26 Nov 2018 08:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OhSITejzNeGxjP1F7ejjuQDTCDlvqKP9Kahne90+F9A=;
        b=ETFqnct6kKRi5I+Qd+kL+Nl55rJ1C4y2EHhr7jM16l4Y94HhZa4piFuYfuLEZYSE70
         Quo2GVd/g44fULy/VWP5A5IXX9qasFeUpCGbwRxNipKNQO84UBXUODcaEJY1E5P6X5o6
         mEaaMOTlOzMA65+g7b7NVsw3Vo5UAgKBXh2Fo3vjqD0imAQczNaSo/Yl2HA6m5/0i4Jw
         GuAV/drpryNhcterBho4r+ZCPcHVl7w1aTGiEe6BxqIwjVVVXPWzJyBH5AOovKgtNoyx
         kn0uGhhwgjv7YXy0HfWpTSdgdtR5LT9/r9hH5rAypwwOJZu3JK/5rS08hB+B04hRWAOt
         U+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=OhSITejzNeGxjP1F7ejjuQDTCDlvqKP9Kahne90+F9A=;
        b=LlThqSHTtpN4pGJIiwpsPb1UVatRfHigQUw5IzNciIE6KrT+0HfXjsBNnjkUMLwdZX
         k/tAuV5hrhxzZQ56vIVImkQLNGgfFy+11ymIz5Rk0V90pLi80aWuKu8OdtAD2WrTkaa4
         tmGOrvd81Hk6t8M0dAxXdrjIv9Afpr81HyiCyb52AoLURKRr8aiz0eZN+eazORBfHCLg
         1As6bb875syrghFB+uwrBPveVu1GYtY8s/JZ+1neX+IoGpxgRpWidkY0J44ZkNz7W4zv
         4LkqnO8/83SzQVkmEyGu5vSNCGsd3QfwRWIpYpqTt/n2JUjObVWuIkutet62j4TMoJOf
         OFog==
X-Gm-Message-State: AA+aEWbaeFrF1PkoKGd2r5dxrKt26PsSagZrCmmADi3UuKd+AzWODAW/
        s0+YgPM1LXKxza18lwhbDxwLtscy
X-Google-Smtp-Source: AJdET5cp5RAvint6dHnxI1xvm+E5cNbUTfDt1uClWfYnFNZa1JM6fUjWUQUsk0xZ5wLmNiz+rZjbxw==
X-Received: by 2002:a1c:aecb:: with SMTP id x194mr22594606wme.96.1543251257270;
        Mon, 26 Nov 2018 08:54:17 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id w8sm979240wrv.7.2018.11.26.08.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:54:15 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Junaid Shahid <junaids@google.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: [PATCH 1/3] kvm: make KVM_CAP_ENABLE_CAP_VM architecture agnostic
Date:   Mon, 26 Nov 2018 17:54:11 +0100
Message-Id: <1543251253-24762-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1543251253-24762-1-git-send-email-pbonzini@redhat.com>
References: <1543251253-24762-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first such capability to be handled in virt/kvm/ will be manual
dirty page reprotection.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virtual/kvm/api.txt | 13 +++++++++----
 arch/powerpc/kvm/powerpc.c        | 14 ++------------
 arch/s390/kvm/kvm-s390.c          | 11 +----------
 arch/x86/kvm/x86.c                | 14 ++------------
 include/linux/kvm_host.h          |  2 ++
 virt/kvm/kvm_main.c               | 25 +++++++++++++++++++++++++
 6 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index cd209f7730af..1071c10cf1c7 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1129,10 +1129,15 @@ documentation when it pops into existence).
 
 4.37 KVM_ENABLE_CAP
 
-Capability: KVM_CAP_ENABLE_CAP, KVM_CAP_ENABLE_CAP_VM
-Architectures: x86 (only KVM_CAP_ENABLE_CAP_VM),
-	       mips (only KVM_CAP_ENABLE_CAP), ppc, s390
-Type: vcpu ioctl, vm ioctl (with KVM_CAP_ENABLE_CAP_VM)
+Capability: KVM_CAP_ENABLE_CAP
+Architectures: mips, ppc, s390
+Type: vcpu ioctl
+Parameters: struct kvm_enable_cap (in)
+Returns: 0 on success; -1 on error
+
+Capability: KVM_CAP_ENABLE_CAP_VM
+Architectures: all
+Type: vcpu ioctl
 Parameters: struct kvm_enable_cap (in)
 Returns: 0 on success; -1 on error
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 2869a299c4ed..b1ed31a17a8c 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -518,7 +518,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_PPC_UNSET_IRQ:
 	case KVM_CAP_PPC_IRQ_LEVEL:
 	case KVM_CAP_ENABLE_CAP:
-	case KVM_CAP_ENABLE_CAP_VM:
 	case KVM_CAP_ONE_REG:
 	case KVM_CAP_IOEVENTFD:
 	case KVM_CAP_DEVICE_CTRL:
@@ -2084,8 +2083,8 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_event,
 }
 
 
-static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
-				   struct kvm_enable_cap *cap)
+int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
+			    struct kvm_enable_cap *cap)
 {
 	int r;
 
@@ -2273,15 +2272,6 @@ long kvm_arch_vm_ioctl(struct file *filp,
 
 		break;
 	}
-	case KVM_ENABLE_CAP:
-	{
-		struct kvm_enable_cap cap;
-		r = -EFAULT;
-		if (copy_from_user(&cap, argp, sizeof(cap)))
-			goto out;
-		r = kvm_vm_ioctl_enable_cap(kvm, &cap);
-		break;
-	}
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 	case KVM_CREATE_SPAPR_TCE_64: {
 		struct kvm_create_spapr_tce_64 create_tce_64;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index fe24150ff666..16c300bdf2c8 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -464,7 +464,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_CSS_SUPPORT:
 	case KVM_CAP_IOEVENTFD:
 	case KVM_CAP_DEVICE_CTRL:
-	case KVM_CAP_ENABLE_CAP_VM:
 	case KVM_CAP_S390_IRQCHIP:
 	case KVM_CAP_VM_ATTRIBUTES:
 	case KVM_CAP_MP_STATE:
@@ -607,7 +606,7 @@ static void icpt_operexc_on_all_vcpus(struct kvm *kvm)
 	}
 }
 
-static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
+int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 {
 	int r;
 
@@ -1933,14 +1932,6 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = kvm_s390_inject_vm(kvm, &s390int);
 		break;
 	}
-	case KVM_ENABLE_CAP: {
-		struct kvm_enable_cap cap;
-		r = -EFAULT;
-		if (copy_from_user(&cap, argp, sizeof(cap)))
-			break;
-		r = kvm_vm_ioctl_enable_cap(kvm, &cap);
-		break;
-	}
 	case KVM_CREATE_IRQCHIP: {
 		struct kvm_irq_routing_entry routing;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 63efac849655..dc902e5139c2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3025,7 +3025,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV_TIME:
 	case KVM_CAP_IOAPIC_POLARITY_IGNORED:
 	case KVM_CAP_TSC_DEADLINE_TIMER:
-	case KVM_CAP_ENABLE_CAP_VM:
 	case KVM_CAP_DISABLE_QUIRKS:
 	case KVM_CAP_SET_BOOT_CPU_ID:
  	case KVM_CAP_SPLIT_IRQCHIP:
@@ -4448,8 +4447,8 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_event,
 	return 0;
 }
 
-static int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
-				   struct kvm_enable_cap *cap)
+int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
+			    struct kvm_enable_cap *cap)
 {
 	int r;
 
@@ -4782,15 +4781,6 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = 0;
 		break;
 	}
-	case KVM_ENABLE_CAP: {
-		struct kvm_enable_cap cap;
-
-		r = -EFAULT;
-		if (copy_from_user(&cap, argp, sizeof(cap)))
-			goto out;
-		r = kvm_vm_ioctl_enable_cap(kvm, &cap);
-		break;
-	}
 	case KVM_MEMORY_ENCRYPT_OP: {
 		r = -ENOTTY;
 		if (kvm_x86_ops->mem_enc_op)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c926698040e0..54cc06dd7e6c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -765,6 +765,8 @@ int kvm_vm_ioctl_get_dirty_log(struct kvm *kvm,
 
 int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
 			bool line_status);
+int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
+			    struct kvm_enable_cap *cap);
 long kvm_arch_vm_ioctl(struct file *filp,
 		       unsigned int ioctl, unsigned long arg);
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e0ea6d7dac14..2d842fd20cd3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2944,6 +2944,7 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 #endif
 	case KVM_CAP_IOEVENTFD_ANY_LENGTH:
 	case KVM_CAP_CHECK_EXTENSION_VM:
+	case KVM_CAP_ENABLE_CAP_VM:
 		return 1;
 #ifdef CONFIG_KVM_MMIO
 	case KVM_CAP_COALESCED_MMIO:
@@ -2967,6 +2968,21 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	return kvm_vm_ioctl_check_extension(kvm, arg);
 }
 
+int __attribute__((weak)) kvm_vm_ioctl_enable_cap(struct kvm *kvm,
+						  struct kvm_enable_cap *cap)
+{
+	return -EINVAL;
+}
+
+static int kvm_vm_ioctl_enable_cap_generic(struct kvm *kvm,
+					   struct kvm_enable_cap *cap)
+{
+	switch (cap->cap) {
+	default:
+		return kvm_vm_ioctl_enable_cap(kvm, cap);
+	}
+}
+
 static long kvm_vm_ioctl(struct file *filp,
 			   unsigned int ioctl, unsigned long arg)
 {
@@ -2980,6 +2996,15 @@ static long kvm_vm_ioctl(struct file *filp,
 	case KVM_CREATE_VCPU:
 		r = kvm_vm_ioctl_create_vcpu(kvm, arg);
 		break;
+	case KVM_ENABLE_CAP: {
+		struct kvm_enable_cap cap;
+
+		r = -EFAULT;
+		if (copy_from_user(&cap, argp, sizeof(cap)))
+			goto out;
+		r = kvm_vm_ioctl_enable_cap_generic(kvm, &cap);
+		break;
+	}
 	case KVM_SET_USER_MEMORY_REGION: {
 		struct kvm_userspace_memory_region kvm_userspace_mem;
 
-- 
1.8.3.1


