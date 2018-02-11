Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeBKD3x (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 22:29:53 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42207 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbeBKD3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 22:29:51 -0500
X-Google-Smtp-Source: AH8x226UPf13cXtNAK6ok5BTWp57//a+dJ8fQTq0aI064dRd31K0FrR9LFnLTVL6EHjVQVcC48XNqw==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v3 0/3] KVM: Introduce dedicated vCPUs hint KVM_HINTS_DEDICATED
Date: Sun, 11 Feb 2018 11:29:43 +0800
Message-Id: <1518319786-1466-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces dedicated vCPUs hint KVM_HINTS_DEDICATED, it 
has two users now:

1) Waiman Long mentioned that:

    Generally speaking, unfair lock performs well for VMs with a small
    number of vCPUs. Native qspinlock may perform better than pvqspinlock
    if there is vCPU pinning and there is no vCPU over-commitment.

2) vCPUs are very unlikely to get preempted when they are the only task 
   running on a CPU. PV TLB flush is slower that the native flush in that 
   case.

v2 -> v3:
 * a separate table for CPUID[0x40000001].EDX bits
 * a new kvm_hint_has_feature macro
v1 -> v2:
 * update to KVM_HINTS_DEDICATED

Wanpeng Li (3):
  KVM: Introduce dedicated vCPUs hint KVM_HINTS_DEDICATED
  KVM: X86: Choose qspinlock when dedicated vCPUs available
  KVM: X86: Don't use PV TLB flush with dedicated vCPUs and steal time
    disabled

 Documentation/virtual/kvm/cpuid.txt  | 12 +++++++++++-
 arch/mips/include/asm/kvm_para.h     |  5 +++++
 arch/powerpc/include/asm/kvm_para.h  |  5 +++++
 arch/s390/include/asm/kvm_para.h     |  5 +++++
 arch/x86/include/asm/kvm_para.h      |  6 ++++++
 arch/x86/include/uapi/asm/kvm_para.h |  8 ++++++--
 arch/x86/kernel/kvm.c                | 18 ++++++++++++++++--
 include/asm-generic/kvm_para.h       |  5 +++++
 include/linux/kvm_para.h             |  5 +++++
 9 files changed, 64 insertions(+), 5 deletions(-)

-- 
2.7.4
