Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753561AbeAaRNv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:13:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753460AbeAaRNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:13:49 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Enlightened VMCS support for KVM on Hyper-V
Date: Wed, 31 Jan 2018 18:13:36 +0100
Message-Id: <20180131171341.21478-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running nested KVM on Hyper-V it's possible to use so called
'Enlightened VMCS' and do normal memory reads/writes instead of
doing VMWRITE/VMREAD instructions. In addition, clean field mask
provides a huge room for optimization on L0's side.

Tight CPUID loop test shows significant speedup (current kvm/queue on
E5-2667 v4 @ 3.20GHz):
 Before: 20766 cycles
 After: 8912 cycles

The series is based on current kvm/queue tree + 'reenlightenment' series.

Ladi Prosek (1):
  x86/kvm: rename HV_X64_MSR_APIC_ASSIST_PAGE to
    HV_X64_MSR_VP_ASSIST_PAGE

Vitaly Kuznetsov (4):
  x86/hyper-v: allocate and use Virtual Processor Assist Pages
  x86/hyper-v: define struct hv_enlightened_vmcs and clean field bits
  x86/hyper-v: detect nested features
  x86/kvm: use Enlightened VMCS when running on Hyper-V

 arch/x86/hyperv/hv_init.c          |  33 +++
 arch/x86/include/asm/mshyperv.h    |  12 +
 arch/x86/include/uapi/asm/hyperv.h | 223 ++++++++++++++-
 arch/x86/kernel/cpu/mshyperv.c     |   3 +
 arch/x86/kvm/hyperv.c              |   8 +-
 arch/x86/kvm/lapic.h               |   2 +-
 arch/x86/kvm/vmx.c                 | 561 ++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c                 |   2 +-
 8 files changed, 825 insertions(+), 19 deletions(-)

-- 
2.14.3
