Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752554AbeDOVyy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 17:54:54 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:21598 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeDOVyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 17:54:52 -0400
X-IronPort-AV: E=Sophos;i="5.48,456,1517875200";
   d="scan'208";a="735371352"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v2 00/12] KVM/X86: Introduce a new guest mapping interface
Date: Sun, 15 Apr 2018 23:53:06 +0200
Message-Id: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guest memory can either be directly managed by the kernel (i.e. have a "struct
page") or they can simply live outside kernel control (i.e. do not have a
"struct page"). KVM mostly support these two modes, except in a few places
where the code seems to assume that guest memory must have a "struct page".

This patchset introduces a new mapping interface to map guest memory into host
kernel memory which also supports PFN-based memory (i.e. memory without 'struct
page'). It also converts all offending code to this interface or simply
read/write directly from guest memory.

As far as I can see all offending code is now fixed except the APIC-access page
which I will handle in a seperate patch.

Filippo Sironi (1):
  X86/KVM: Handle PFNs outside of kernel reach when touching GPTEs

KarimAllah Ahmed (11):
  X86/nVMX: handle_vmon: Read 4 bytes from guest memory
  X86/nVMX: handle_vmptrld: Copy the VMCS12 directly from guest memory
  X86/nVMX: Update the PML table without mapping and unmapping the page
  KVM: Introduce a new guest mapping API
  KVM/nVMX: Use kvm_vcpu_map when mapping the L1 MSR bitmap
  KVM/nVMX: Use kvm_vcpu_map when mapping the virtual APIC page
  KVM/nVMX: Use kvm_vcpu_map when mapping the posted interrupt
    descriptor table
  KVM/X86: Use kvm_vcpu_map in emulator_cmpxchg_emulated
  KVM/X86: hyperv: Use kvm_vcpu_map in synic_clear_sint_msg_pending
  KVM/X86: hyperv: Use kvm_vcpu_map in synic_deliver_msg
  KVM/nSVM: Use the new mapping API for mapping guest memory

 arch/x86/kvm/hyperv.c      |  28 ++++-----
 arch/x86/kvm/paging_tmpl.h |  38 +++++++++---
 arch/x86/kvm/svm.c         |  97 +++++++++++++++---------------
 arch/x86/kvm/vmx.c         | 145 +++++++++++++++------------------------------
 arch/x86/kvm/x86.c         |  13 ++--
 include/linux/kvm_host.h   |   9 +++
 virt/kvm/kvm_main.c        |  50 ++++++++++++++++
 7 files changed, 203 insertions(+), 177 deletions(-)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

-- 
2.7.4
