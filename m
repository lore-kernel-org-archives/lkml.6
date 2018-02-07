Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbeBGGZu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 01:25:50 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:41665 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbeBGGZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 01:25:48 -0500
X-Google-Smtp-Source: AH8x225M9F/fcPSutMZRjNuc9sHjYFsgVVLAVGvvbBQukw/QDG9rlHkGA8vO4xQgUUv2LSa+Fl4YhA==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH] KVM: X86: Fix SMRAM accessing even if VM is shutdown
Date: Tue,  6 Feb 2018 22:25:06 -0800
Message-Id: <1517984706-47244-1-git-send-email-wanpengli@tencent.com>
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
in the above ept misconfig. This patch fixes it by bailing out immediately if 
the vCPU is marked EXIT_SHUTDOWN reason.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/x86.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 786cd00..445e702 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7458,6 +7458,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		goto out;
 	}
 
+	if (unlikely(vcpu->run->exit_reason == KVM_EXIT_SHUTDOWN)) {
+		r = -EINVAL;
+		goto out;
+	}
+
 	if (vcpu->run->kvm_dirty_regs) {
 		r = sync_regs(vcpu);
 		if (r != 0)
-- 
2.7.4
