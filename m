Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbeDKRVd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 13:21:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752923AbeDKRVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 13:21:30 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] KVM: x86: hyperv: PV TLB flush for Windows guests
Date: Wed, 11 Apr 2018 19:21:20 +0200
Message-Id: <20180411172126.16355-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
- Wait for TLB flush IPIs to arrive [Radim Krcmar]
- Check 'rep' bits for all hypercalls, return 
  HV_STATUS_INVALID_HYPERCALL_INPUT in case of misuse [Radim Krcmar]
- Set proper 'rep' bits [Radim Krcmar]
- I re-tested the series on WS2016 with latest updates and it seems
  there are some optimizations in Windows which improves 'native' case,
  updated numbers in this description to match the reality (still a
  noticable improvement.) The bug with >64 vCPUs is still there.

Description:

This is both a new feature and a bugfix.

Bugfix description: 

It was found that Windows 2016 guests on KVM crash when they have > 64
vCPUs, non-flat topology (>1 core/thread per socket; in case it has >64
sockets Windows just ignores vCPUs above 64) and Hyper-V enlightenments
(any) are enabled. The most common error reported is "PAGE FAULT IN
NONPAGED AREA" but I saw different messages. Apparently, Windows doesn't
expect to run on a Hyper-V server without PV TLB flush support as there's
no such Hyper-V servers out there (it's only WS2016 supporting > 64 vCPUs
AFAIR).

Adding PV TLB flush support to KVM helps, Windows 2016 guests now boot 
normally (I tried '-smp 128,sockets=64,cores=1,threads=2' and 
'-smp 128,sockets=8,cores=16,threads=1' but other topologies should work
too).

Feature description:

PV TLB flush helps a lot when running overcommited. KVM gained support for
it recently but it is only available for Linux guests. Windows guests use
emulated Hyper-V interface and PV TLB flush needs to be added there.

I tested WS2016 guest with 128 vCPUs running on a 12 pCPU server. The test
was running 65 threads doing 50 mmap()/munmap() for 16384 pages with a
tiny random nanosleep in between (I used Cygwin. It would be great if
someone could point me to a good Windows-native TLB trashing test).

The average results are:
Before:
real    0m22.464s
user    0m0.990s
sys     1m26.3276s

After:
real    0m19.304s
user    0m0.908s
sys     0m36.249s

When running without overcommit the results of the same test are very close
so the feature can be enabled by default.

Implementation details.

The implementation is very simplistic and straightforward. We ignore
'address space' argument of the hypercalls (as there is no good way to
figure out what's currently in CR3 of a running vCPU as generally we don't
VMEXIT on guest CR3 write) and do full TLB flush on specified vCPUs. In
case said vCPUs are not running TLB flush will be performed upon guest
enter.

Qemu (and other userspaces) need to enable CPUID feature bits to make
Windows aware the feature is supported. I'll post Qemu enablement patch
separately.

Patches are based on the current kvm/queue branch.

Vitaly Kuznetsov (6):
  x86/hyper-v: move struct hv_flush_pcpu{,ex} definitions to common
    header
  KVM: x86: hyperv: use defines when parsing hypercall parameters
  KVM: x86: hyperv: do rep check for each hypercall separately
  KVM: x86: hyperv: simplistic HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE}
    implementation
  KVM: x86: hyperv: simplistic
    HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE}_EX implementation
  KVM: x86: hyperv: declare KVM_CAP_HYPERV_TLBFLUSH capability

 Documentation/virtual/kvm/api.txt  |   9 ++
 arch/x86/hyperv/mmu.c              |  40 ++-----
 arch/x86/include/asm/hyperv-tlfs.h |  20 ++++
 arch/x86/include/asm/kvm_host.h    |   1 +
 arch/x86/kvm/hyperv.c              | 217 ++++++++++++++++++++++++++++++++++---
 arch/x86/kvm/trace.h               |  51 +++++++++
 arch/x86/kvm/x86.c                 |   1 +
 include/uapi/linux/kvm.h           |   1 +
 8 files changed, 297 insertions(+), 43 deletions(-)

-- 
2.14.3
