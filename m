Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbeBHHcw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 02:32:52 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36854 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeBHHcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 02:32:50 -0500
X-Google-Smtp-Source: AH8x224QR2o6rvyigV1LLtVOb8GwXoS5bktbF1uvJHnhWMaPX/TImnLme4Da5Lk4nXfTHAIWkApORg==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v2] KVM: X86: Fix SMRAM accessing even if VM is shutdown
Date: Thu,  8 Feb 2018 15:32:45 +0800
Message-Id: <1518075165-5376-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Reported by syzkaller:

   WARNING: CPU: 6 PID: 2434 at arch/x86/kvm/vmx.c:6660 handle_ept_misconfig+0x54/0x1e0 [kvm_intel]
   CPU: 6 PID: 2434 Comm: repro_test Not tainted 4.15.0+ #4
   RIP: 0010:handle_ept_misconfig+0x54/0x1e0 [kvm_intel]
   Call Trace:
    vmx_handle_exit+0xbd/0xe20 [kvm_intel]
    kvm_arch_vcpu_ioctl_run+0xdaf/0x1d50 [kvm]
    kvm_vcpu_ioctl+0x3e9/0x720 [kvm]
    do_vfs_ioctl+0xa4/0x6a0
    SyS_ioctl+0x79/0x90
    entry_SYSCALL_64_fastpath+0x25/0x9c

The syzkaller creates a former thread to issue KVM_SMI ioctl, and then creates
a latter thread to mmap and operate on the same vCPU, rsm emulation will not be 
executed since there is no something like seabios which implements smi handler 
when running syzkaller directly. This triggers a race condition when running 
the testcase with multiple threads. Sometimes one thread exit w/ SHUTDOWN 
reason, another thread mmaps and operates on the same vCPU, it continues to 
use CS=0x30000, IP=0x8000 to access the address of SMI handler which results 
in the above ept misconfig. This patch fixes it by returning RET_PF_EMULATE
in kvm_handle_bad_page() which would cause an emulation failure and then an 
exit with KVM_EXIT_INTERNAL_ERROR, the VM will stop instead of resetting and 
be taken advantage of.

Reported-by: syzbot+c1d9517cab094dae65e446c0c5b4de6c40f4dc58@syzkaller.appspotmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
v1 -> v2:
 * return RET_PF_EMULATE

 arch/x86/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 8eca1d0..6c5a82c 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3029,7 +3029,7 @@ static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 		return RET_PF_RETRY;
 	}
 
-	return -EFAULT;
+	return RET_PF_EMULATE;
 }
 
 static void transparent_hugepage_adjust(struct kvm_vcpu *vcpu,
-- 
2.7.4
