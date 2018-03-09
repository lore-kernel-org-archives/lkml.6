Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932075AbeCIOCy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:02:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751056AbeCIOCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:02:53 -0500
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
Subject: [PATCH v3 0/7] Enlightened VMCS support for KVM on Hyper-V
Date: Fri,  9 Mar 2018 15:02:42 +0100
Message-Id: <20180309140249.2840-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
- Move hyperv.h out of uapi [Radim Krčmář], PATCHes 1 and 2 added.
- define KVM_EVMCS_VERSION, HV_X64_ENLIGHTENED_VMCS_VERSION [Radim Krčmář]
- WARN_ONCE in get_evmcs_offset[,_cf] [Radim Krčmář]
- add evmcs_sanitize_exec_ctrls() and use it in hardware_setup() and
  dump_vmcs() [Radim Krčmář]

When running nested KVM on Hyper-V it's possible to use so called
'Enlightened VMCS' and do normal memory reads/writes instead of
doing VMWRITE/VMREAD instructions. In addition, clean field mask
provides a huge room for optimization on L0's side.

Tight CPUID loop test shows significant speedup (E5-2667 v4 @ 3.20GHz):
  Before: 18890 cycles
  After: 8304 cycles

Ladi Prosek (1):
  x86/kvm: rename HV_X64_MSR_APIC_ASSIST_PAGE to
    HV_X64_MSR_VP_ASSIST_PAGE

Vitaly Kuznetsov (6):
  x86/hyper-v: move hyperv.h out of uapi
  x86/hyper-v: move definitions from TLFS to hyperv-tlfs.h
  x86/hyper-v: allocate and use Virtual Processor Assist Pages
  x86/hyper-v: define struct hv_enlightened_vmcs and clean field bits
  x86/hyper-v: detect nested features
  x86/kvm: use Enlightened VMCS when running on Hyper-V

 MAINTAINERS                          |   2 +-
 arch/x86/hyperv/hv_init.c            |  35 +-
 arch/x86/include/asm/hyperv-tlfs.h   | 695 +++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/kvm_host.h      |   1 +
 arch/x86/include/asm/mshyperv.h      |  91 +----
 arch/x86/include/uapi/asm/hyperv.h   | 421 ---------------------
 arch/x86/include/uapi/asm/kvm_para.h |   1 -
 arch/x86/kernel/cpu/mshyperv.c       |  21 +-
 arch/x86/kvm/hyperv.c                |   8 +-
 arch/x86/kvm/lapic.h                 |   2 +-
 arch/x86/kvm/vmx.c                   | 625 ++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c                   |   2 +-
 drivers/hv/connection.c              |   1 -
 drivers/hv/hv.c                      |   1 -
 drivers/hv/hyperv_vmbus.h            |   1 +
 drivers/hv/vmbus_drv.c               |   1 -
 include/linux/hyperv.h               |   1 -
 17 files changed, 1379 insertions(+), 530 deletions(-)
 create mode 100644 arch/x86/include/asm/hyperv-tlfs.h
 delete mode 100644 arch/x86/include/uapi/asm/hyperv.h

-- 
2.14.3
