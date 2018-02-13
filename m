Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933104AbeBMBFt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 20:05:49 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45675 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932736AbeBMBFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 20:05:47 -0500
X-Google-Smtp-Source: AH8x226EtaEVIOwGU61cWMkbwema4XTCRcxRcVkSYH9vFOeAQNzOCf1LkpevnhvqQWIa9l0KQxGoSQ==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH v4 0/3] KVM: Introduce dedicated vCPUs hint KVM_HINTS_DEDICATED
Date: Tue, 13 Feb 2018 09:05:39 +0800
Message-Id: <1518483942-14741-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces dedicated vCPUs(vCPU pinning, and there is no 
vCPU over-commitment) hint KVM_HINTS_DEDICATED, it has two users now:

1) Waiman Long mentioned that:

    Generally speaking, unfair lock performs well for VMs with a small
    number of vCPUs. Native qspinlock may perform better than pvqspinlock
    if there is vCPU pinning and there is no vCPU over-commitment.

2) vCPUs are very unlikely to get preempted when they are the only task 
   running on a CPU. PV TLB flush is slower that the native flush in that 
   case.

v3 -> v4:
 * update feature bit document
v2 -> v3:
 * a separate table for CPUID[0x40000001].EDX bits
 * a new kvm_hint_has_feature macro
v1 -> v2:
 * update to KVM_HINTS_DEDICATED

Wanpeng Li (3):
  KVM: Introduce dedicated vCPUs hint KVM_HINTS_DEDICATED
  KVM: X86: Choose qspinlock when dedicated vCPUs available
  KVM: X86: Don't use PV TLB flush with dedicated vCPUs and steal time disabled

 Documentation/virtual/kvm/cpuid.txt  | 15 +++++++++++++--
 arch/mips/include/asm/kvm_para.h     |  5 +++++
 arch/powerpc/include/asm/kvm_para.h  |  5 +++++
 arch/s390/include/asm/kvm_para.h     |  5 +++++
 arch/x86/include/asm/kvm_para.h      |  6 ++++++
 arch/x86/include/uapi/asm/kvm_para.h |  8 ++++++--
 arch/x86/kernel/kvm.c                | 18 ++++++++++++++++--
 include/asm-generic/kvm_para.h       |  5 +++++
 include/linux/kvm_para.h             |  5 +++++
 9 files changed, 66 insertions(+), 6 deletions(-)

-- 
2.7.4
