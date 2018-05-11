Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753188AbeEKNh4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 09:37:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752977AbeEKNhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 09:37:55 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Subject: [PATCH RFC v2 0/5] KVM: nVMX: Enlightened VMCS for Hyper-V on KVM
Date: Fri, 11 May 2018 15:37:46 +0200
Message-Id: <20180511133751.13414-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been a while since RFCv1 (https://lwn.net/Articles/741846/). After the
initial submission I decided to implement Enlightened VMCS for KVM on
Hyper-V first and this is now fully merged. Time to resume this work.

This is an initial implementation of Enlightened VMCS for nested Hyper-V on
KVM. Using it helps to spare 1100 cpu cycles for nested vmexit (tight cpuid
loop in WS2016 with Hyper-V role on KVM: 15200 cycles -> 14100 cycles).

'RFC' mostly goes to the last patch in the series. Currently, we have
prepare_vmcs02()/prepare_vmcs02_full() split which is only valid for Shadow
VMCS. Enlightened VMCS has 'clean fields' idea and I'm having hard times
incorporating it. The simplest way is implemented in the patch: we just
wrap groups of vmwrites with 'if (!hv_evmcs||evmcs_needs_write(vmx, ...))'
checks. This works and doesn't give much overhead for non-eVMCS case 
(compared to e.g. wrapping each vmwrite with such check) but this is not
flexible and ugly. In case we'll need to implement additional ideas later
(eVMCSv2 when it comes, something similar for KVM-on-KVM,...) it will be
really hard. So.. looking forward to your ideas!

Ladi Prosek (1):
  KVM: hyperv: define VP assist page helpers

Vitaly Kuznetsov (4):
  KVM: nVMX: add KVM_CAP_HYPERV_ENLIGHTENED_VMCS capability
  KVM: nVMX: add enlightened VMCS state
  KVM: nVMX: implement enlightened VMPTRLD and VMCLEAR
  KVM: nVMX: optimize prepare_vmcs02{,_full} for Enlightened VMCS case

 arch/x86/include/asm/kvm_host.h |   3 +
 arch/x86/kvm/hyperv.c           |  23 +-
 arch/x86/kvm/hyperv.h           |   4 +
 arch/x86/kvm/lapic.c            |   4 +-
 arch/x86/kvm/lapic.h            |   2 +-
 arch/x86/kvm/svm.c              |   9 +
 arch/x86/kvm/vmx.c              | 807 +++++++++++++++++++++++++++++++++-------
 arch/x86/kvm/x86.c              |  17 +-
 include/uapi/linux/kvm.h        |   1 +
 9 files changed, 728 insertions(+), 142 deletions(-)

-- 
2.14.3
