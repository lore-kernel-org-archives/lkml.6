Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeBELFo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 06:05:44 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42803 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeBELFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 06:05:35 -0500
X-Google-Smtp-Source: AH8x226JUAZ9n/nIv7uBZkA9m15KFsOwGbq6JOpwc0Cr7k2eQ+Gt2WXOqjlIbRD5DWNQjn5EX99gdg==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH] KVM: nVMX: Fix CR4 after VMLAUNCH/VMRESUME failure
Date: Mon,  5 Feb 2018 03:04:46 -0800
Message-Id: <1517828686-29070-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

In L0, Haswell client host:

 nested_vmx_exit_reflected failed vm entry 7
 WARNING: CPU: 6 PID: 6797 at kvm/arch/x86/kvm//vmx.c:6206 handle_desc+0x2d/0x40 [kvm_intel]
 CPU: 6 PID: 6797 Comm: qemu-system-x86 Tainted: G        W  OE    4.15.0+ #4
 RIP: 0010:handle_desc+0x2d/0x40 [kvm_intel]
 Call Trace:
  vmx_handle_exit+0xbd/0xe20 [kvm_intel]
  ? kvm_arch_vcpu_ioctl_run+0xcde/0x1c00 [kvm]
  kvm_arch_vcpu_ioctl_run+0xd5a/0x1c00 [kvm]
  kvm_vcpu_ioctl+0x3e9/0x720 [kvm]
  ? kvm_vcpu_ioctl+0x3e9/0x720 [kvm]
  ? __fget+0xfc/0x210
  ? __fget+0xfc/0x210
  do_vfs_ioctl+0xa4/0x6a0
  ? __fget+0x11d/0x210
  SyS_ioctl+0x79/0x90
  entry_SYSCALL_64_fastpath+0x25/0x9c

This can be reproduced by running kvm-unit-tests/run_tests.sh vmx_controls in 
L1. UMIP CPUID bit is exposed to the L1 UMIP aware guest since it is emulated 
by enabling descriptor-table exits on L0. There is a vmentry fail when 
L0 tries to run L2 directly, the L1 guest architectural CR4 is not restored 
after this failure since commit 4f350c6dbcb (kvm: nVMX: Handle deferred early 
VMLAUNCH/VMRESUME failure properly). The L2 is kvm-unit-tests which will not 
write CR4 w/ X86_CR4_UMIP bit. After another L1 access descriptor vmexit, we 
check L2's architectural CR4 instead of L1's architectural CR4. This patch 
fixes it by restoring L1's architectural CR4 after L0's VMLAUNCH/VMRESUME 
failure.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/vmx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 23789c9..9fc0492 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11633,6 +11633,7 @@ static void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 	 */
 	nested_vmx_failValid(vcpu, VMXERR_ENTRY_INVALID_CONTROL_FIELD);
 
+	vcpu->arch.cr4 = vmcs12->host_cr4;
 	load_vmcs12_mmu_host_state(vcpu, vmcs12);
 
 	/*
-- 
2.7.4
