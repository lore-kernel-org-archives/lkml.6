Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031261AbeCAOPV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:15:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031211AbeCAOPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:15:19 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>
Subject: [PATCH v2 0/4] x86/kvm/hyper-v: More fixes for TSC page clocksource for Hyper-V on KVM
Date: Thu,  1 Mar 2018 15:15:11 +0100
Message-Id: <20180301141514.3482-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
- Drop 'polling' bit check for now as we don't support this mode
  [Roman Kagan].
- Add a comment explaining "!host && !masked" in synic_set_sint()
- Add Roman's R-b to PATCH1 and PATCH2.

Previously (see commit 72c139bacf) it was found that Hyper-V frequency
MSRs are required to make Hyper-V on KVM pass through TSC page as stable
clocksource to its guests. However, to make things work this is not
enough. Hyper-V tries to prove that TSC frequency underneath it won't
change (e.g. when it's migrated), there are two mechanisms:

1) Invariant TSC (CPUID.80000007H:EDX[8]). If Hyper-V sees this bit it will
 treat TSC as stable. We, however, don't want to pass it as it makes
 migration hard (e.g. Qemu adds a migration blocker when 'invtsc' flag is
 passed. Genuine Hyper-V running in L0 doesn't pass it either.

2) Hyper-V Reenlightenment (CPUID.40000003H:EAX[13]).

This patch series add rudimentary support for Hyper-V reenlightenment
notifications to KVM ('producer' part; we already implemented
reenlightenment 'consumer' for KVM-on Hyper-V some time ago) and fixes
bugs I found during testing. Fully fledged reenlightenment  implementation
will be added later when we learn to migrate nested workloads in KVM making
testing possible.

Qemu patches are also required, I'll post them separately.

Vitaly Kuznetsov (3):
  x86/kvm/hyper-v: add reenlightenment MSRs support
  x86/kvm/hyper-v: remove stale entries from vec_bitmap/auto_eoi_bitmap
    on vector change
  x86/kvm/hyper-v: inject #GP only when invalid SINTx vector is unmasked

 arch/x86/include/asm/kvm_host.h    |  4 +++
 arch/x86/include/uapi/asm/hyperv.h |  2 ++
 arch/x86/kvm/hyperv.c              | 61 +++++++++++++++++++++++++++++++-------
 arch/x86/kvm/x86.c                 | 12 +++++++-
 4 files changed, 68 insertions(+), 11 deletions(-)

-- 
2.14.3
