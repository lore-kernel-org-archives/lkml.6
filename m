Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/EwLhl5Sa7rkZr8PaqGWWlIuMCF6AF4llY3B488fmPFXxojAFyEs+cM8K0ZESmtTyNL1kz
ARC-Seal: i=1; a=rsa-sha256; t=1523473058; cv=none;
        d=google.com; s=arc-20160816;
        b=FtbZlxJ7b63p6w2071jup/HFnzXzsFknn6zM6VyZA+yy/p7tCevyv/cF/jWSdD1uUa
         qcrD+MOP2MYz874YgLVbtY916JDO8sz3m1U0B5yl4yDqeS3QFdFW10vftmOp4peXCjmf
         64bYCci8khOMTeyOQN5lsohGp69fYbm/ihN/xMaXge2M1ciMIjuDDAAxdU4I0D6xnRwO
         UU7jyeYFKfZorMtst58e25yL6LKndW9znKy6KytqDTGkMDleFbWFnnoFMW9iSHY7aJMH
         IrlxLF7DI6FYTtx6PL6j73Wx0AgakAma6H2eHsPdUozP5eIlIzah+jS0zDc1D4jFciZT
         U4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=w41pESWx2J8x+A2mr7Wci5pv0r5kY9T2np4QRS1tHng=;
        b=YkCbGqHvxDiT1YM3HCeGm+2LWp2TxqjSSDfOWRF1sO1gQtS4LBc7IO/9OBQl2TSuq6
         uSs9rZ6p3fk13fdMOKaxDW2EJnB6NckK1mjdSud1Dd355yU9Phuit4CQ6Rf5R+QcAgBv
         dF+5QK2spMMTRGNkDxRa9QHSWaSg6f79fhI5hjTokT5zlA6t7LCZjSGp1rItid0JpN4g
         bd0JeGRWq9KvdBSN5KPo6pDKDZJgdp+70oVf8TkKLA7JashfRVg0vvh/vyiwsqzrHxhK
         yynp9NSe5fyUCP3utxUwCC70BkTesAG6ApFQqCW3IXm+d5UFHFjQfpb5LyGW3zBAQU0I
         +lXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Wanpeng Li <wanpeng.li@hotmail.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 115/310] KVM: X86: Fix preempt the preemption timer cancel
Date: Wed, 11 Apr 2018 20:34:14 +0200
Message-Id: <20180411183627.126496876@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477285872664459?=
X-GMAIL-MSGID: =?utf-8?q?1597477285872664459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wanpeng Li <wanpeng.li@hotmail.com>


[ Upstream commit 5acc1ca4fb15f00bfa3d4046e35ca381bc25d580 ]

Preemption can occur during cancel preemption timer, and there will be
inconsistent status in lapic, vmx and vmcs field.

          CPU0                    CPU1

  preemption timer vmexit
  handle_preemption_timer(vCPU0)
    kvm_lapic_expired_hv_timer
      vmx_cancel_hv_timer
        vmx->hv_deadline_tsc = -1
        vmcs_clear_bits
        /* hv_timer_in_use still true */
  sched_out
                           sched_in
                           kvm_arch_vcpu_load
                             vmx_set_hv_timer
                               write vmx->hv_deadline_tsc
                               vmcs_set_bits
                           /* back in kvm_lapic_expired_hv_timer */
                           hv_timer_in_use = false
                           ...
                           vmx_vcpu_run
                             vmx_arm_hv_run
                               write preemption timer deadline
                             spurious preemption timer vmexit
                               handle_preemption_timer(vCPU0)
                                 kvm_lapic_expired_hv_timer
                                   WARN_ON(!apic->lapic_timer.hv_timer_in_use);

This can be reproduced sporadically during boot of L2 on a
preemptible L1, causing a splat on L1.

 WARNING: CPU: 3 PID: 1952 at arch/x86/kvm/lapic.c:1529 kvm_lapic_expired_hv_timer+0xb5/0xd0 [kvm]
 CPU: 3 PID: 1952 Comm: qemu-system-x86 Not tainted 4.12.0-rc1+ #24 RIP: 0010:kvm_lapic_expired_hv_timer+0xb5/0xd0 [kvm]
  Call Trace:
  handle_preemption_timer+0xe/0x20 [kvm_intel]
  vmx_handle_exit+0xc9/0x15f0 [kvm_intel]
  ? lock_acquire+0xdb/0x250
  ? lock_acquire+0xdb/0x250
  ? kvm_arch_vcpu_ioctl_run+0xdf3/0x1ce0 [kvm]
  kvm_arch_vcpu_ioctl_run+0xe55/0x1ce0 [kvm]
  kvm_vcpu_ioctl+0x384/0x7b0 [kvm]
  ? kvm_vcpu_ioctl+0x384/0x7b0 [kvm]
  ? __fget+0xf3/0x210
  do_vfs_ioctl+0xa4/0x700
  ? __fget+0x114/0x210
  SyS_ioctl+0x79/0x90
  do_syscall_64+0x8f/0x750
  ? trace_hardirqs_on_thunk+0x1a/0x1c
  entry_SYSCALL64_slow_path+0x25/0x25

This patch fixes it by disabling preemption while cancelling
preemption timer.  This way cancel_hv_timer is atomic with
respect to kvm_arch_vcpu_load.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/lapic.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1363,8 +1363,10 @@ EXPORT_SYMBOL_GPL(kvm_lapic_hv_timer_in_
 
 static void cancel_hv_tscdeadline(struct kvm_lapic *apic)
 {
+	preempt_disable();
 	kvm_x86_ops->cancel_hv_timer(apic->vcpu);
 	apic->lapic_timer.hv_timer_in_use = false;
+	preempt_enable();
 }
 
 void kvm_lapic_expired_hv_timer(struct kvm_vcpu *vcpu)
