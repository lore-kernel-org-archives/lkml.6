Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbeCLLyW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:54:22 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42994 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeCLLyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:54:20 -0400
X-Google-Smtp-Source: AG47ELuZottmrHsGC+TNvwQynu3cEIDUdNlwjFB8uGmqspwjb15G6bIuV/jwpf4N2n/8qANN6NUmqQ==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        =?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
Subject: [PATCH v2 0/3] Provides userspace with per-VM capability to improve latency
Date: Mon, 12 Mar 2018 04:53:01 -0700
Message-Id: <1520855584-10079-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provides userspace with per-VM capability(KVM_CAP_X86_DISABLE_EXITS) to 
not intercept MWAIT/HLT/PAUSE in order that to improve latency in some 
workloads.

The patchset implements the original proposal from Radim.
https://www.spinics.net/lists/kvm/msg146879.html

In addition, thanks to Jan H. Schönherr's attempt last year.

v1 -> v2:
 * remove blinding setting KVM_ENABLE_CAP statement in doc
 * move PV_UNHALT associated statement to 2/3
 * rename kvm_mwait_can_in_guest to kvm_can_mwait_in_guest
 * remove unconditionally set INTERCEPT HLT in svm 
 * call vmx_clear_hlt() from pre_enter_smm()
 * add a check to kvm_update_cpuid() that forbits KVM_FEATURE_PV_UNHALT
   when halt exits are disabld

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Jan H. Schönherr <jschoenh@amazon.de>

Wanpeng Li (3):
  KVM: X86: Provides userspace with a capability to not intercept MWAIT
  KVM: X86: Provides userspace with a capability to not intercept HLT
  KVM: X86: Provides userspace with a capability to not intercept PAUSE

 Documentation/virtual/kvm/api.txt | 24 ++++++++++++-------
 arch/x86/include/asm/kvm_host.h   |  4 ++++
 arch/x86/kvm/cpuid.c              |  5 ++++
 arch/x86/kvm/svm.c                |  9 ++++---
 arch/x86/kvm/vmx.c                | 50 ++++++++++++++++++++++++++++++++-------
 arch/x86/kvm/x86.c                | 29 +++++++++++++++++++----
 arch/x86/kvm/x86.h                | 24 +++++++++++++++----
 include/uapi/linux/kvm.h          |  2 +-
 tools/include/uapi/linux/kvm.h    |  2 +-
 9 files changed, 118 insertions(+), 31 deletions(-)

-- 
2.7.4
