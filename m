Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeDQFrE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 01:47:04 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37997 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbeDQFrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 01:47:00 -0400
X-Google-Smtp-Source: AIpwx4/KUmTTXHfdQAlIkGn4n1nfzfCCPv+W9R4g0UGhIIc65V4XfTz6WZlflQDnvqVm3ZsM1PgrUg==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Tim Shearer <tshearer@advaoptical.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH 3/3] KVM: VMX: Allow I/O port 0x80 bypass when userspace prefer
Date: Mon, 16 Apr 2018 22:46:02 -0700
Message-Id: <1523943962-25415-4-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523943962-25415-1-git-send-email-wanpengli@tencent.com>
References: <1523943962-25415-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Tim Shearer reported that "There is a guest which is running a packet 
forwarding app based on the DPDK (dpdk.org). The packet receive routine 
writes to 0xc070 using glibc's "outw_p" function which does an additional 
write to I/O port 80. It does this write for every packet that's received, 
causing a flood of KVM userspace context switches". He uses mpstat to 
observe a CPU performing L2 packet forwarding on a pinned guest vCPU, 
the guest time is 95 percent when allowing I/O port 0x80 bypass, however, 
it is 65.78 percent when I/O port 0x80 bypss is disabled.  

This patch allows I/O port 0x80 bypass when userspace prefer.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Tim Shearer <tshearer@advaoptical.com>
Cc: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/vmx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index ebf1140..d3e5fef 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10118,6 +10118,13 @@ static int vmx_vm_init(struct kvm *kvm)
 			goto out;
 		memset(kvm_vmx->vmx_io_bitmap[i], 0xff, PAGE_SIZE);
 	}
+	if (kvm->arch.ioport_disable_intercept)	{
+		/*
+		 * Allow direct access to the PC debug port (it is often used for I/O
+		 * delays, but the vmexits simply slow things down).
+		 */
+		clear_bit(0x80, kvm_vmx->vmx_io_bitmap[VMX_IO_BITMAP_A]);
+	}
 	return 0;
 
 out:
-- 
2.7.4
