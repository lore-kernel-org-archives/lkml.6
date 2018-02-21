Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934894AbeBURrl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:47:41 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:46048 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932228AbeBURri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:47:38 -0500
X-IronPort-AV: E=Sophos;i="5.47,375,1515456000";
   d="scan'208";a="720905212"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hpa@zytor.com, jmattson@google.com, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH 00/10] KVM/X86: Handle guest memory that does not have a struct page
Date: Wed, 21 Feb 2018 18:47:11 +0100
Message-Id: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the most part, KVM can handle guest memory that does not have a struct
page (i.e. not directly managed by the kernel). However, There are a few places
in the code, specially in the nested code, that does not support that.

Patch 1, 2, and 3 avoid the mapping and unmapping all together and just
directly use kvm_guest_read and kvm_guest_write.

Patch 4 introduces a new guest mapping interface that encapsulate all the
bioler plate code that is needed to map and unmap guest memory. It also
supports guest memory without "struct page".

Patch 5, 6, 7, 8, 9, and 10 switch most of the offending code in VMX and hyperv
to use the new guest mapping API.

This patch series is the first set of fixes. Handling SVM and APIC-access page
will be handled in a different patch series.

KarimAllah Ahmed (10):
  X86/nVMX: handle_vmon: Read 4 bytes from guest memory instead of
    map->read->unmap sequence
  X86/nVMX: handle_vmptrld: Copy the VMCS12 directly from guest memory
    instead of map->copy->unmap sequence.
  X86/nVMX: Update the PML table without mapping and unmapping the page
  KVM: Introduce a new guest mapping API
  KVM/nVMX: Use kvm_vcpu_map when mapping the L1 MSR bitmap
  KVM/nVMX: Use kvm_vcpu_map when mapping the virtual APIC page
  KVM/nVMX: Use kvm_vcpu_map when mapping the posted interrupt
    descriptor table
  KVM/X86: Use kvm_vcpu_map in emulator_cmpxchg_emulated
  KVM/X86: hyperv: Use kvm_vcpu_map in synic_clear_sint_msg_pending
  KVM/X86: hyperv: Use kvm_vcpu_map in synic_deliver_msg

 arch/x86/kvm/hyperv.c    |  28 ++++-----
 arch/x86/kvm/vmx.c       | 144 +++++++++++++++--------------------------------
 arch/x86/kvm/x86.c       |  13 ++---
 include/linux/kvm_host.h |  15 +++++
 virt/kvm/kvm_main.c      |  50 ++++++++++++++++
 5 files changed, 129 insertions(+), 121 deletions(-)

-- 
2.7.4
