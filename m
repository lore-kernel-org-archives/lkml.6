Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeCPOW1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:22:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753008AbeCPOWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:22:25 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/7] Enlightened VMCS support for KVM on Hyper-V
Date: Fri, 16 Mar 2018 15:22:13 +0100
Message-Id: <20180316142220.32506-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3:
- Add Michael's Reviewed-by to PATCH2,5,6
- PATCH1:
  - Decipher 'TLFS' and add a reference where it can be obtained
    [Christoph Hellwig]
- PATCH4:
  - remove vfree() from hv_cpu_die() [Thomas Gleixner]
  - free hv_vp_assist_page() in the error path [Thomas Gleixner]
    While on it, add cpuhp_remove_state() call when we fail to allocate
    hypercall page to make the error path complete.
  - check hv_vp_assist_page != NULL in hv_get_vp_assist_page()
    [Thomas Gleixner]
- PATCH7:
  - split off vmx_evmcs.h [Paolo Bonzini]
  - merge get_evmcs_offset() and get_evmcs_offset_cf() [Paolo Bonzini]
  - move evmcs_sanitize_exec_ctrls() to setup_vmcs_config [Paolo Bonzini]
  - rename vmcs_load_enlightened() -> evmcs_load() [Paolo Bonzini]
  - drop evmcs_sanitize_exec_ctrls() from dump_vmcs() [Paolo Bonzini]

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
 arch/x86/hyperv/hv_init.c            |  45 ++-
 arch/x86/include/asm/hyperv-tlfs.h   | 702 +++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/kvm_host.h      |   1 +
 arch/x86/include/asm/mshyperv.h      |  94 +----
 arch/x86/include/uapi/asm/hyperv.h   | 421 ---------------------
 arch/x86/include/uapi/asm/kvm_para.h |   1 -
 arch/x86/kernel/cpu/mshyperv.c       |  21 +-
 arch/x86/kvm/hyperv.c                |   8 +-
 arch/x86/kvm/lapic.h                 |   2 +-
 arch/x86/kvm/vmx.c                   | 301 ++++++++++++++-
 arch/x86/kvm/vmx_evmcs.h             | 324 ++++++++++++++++
 arch/x86/kvm/x86.c                   |   2 +-
 drivers/hv/connection.c              |   1 -
 drivers/hv/hv.c                      |   1 -
 drivers/hv/hyperv_vmbus.h            |   1 +
 drivers/hv/vmbus_drv.c               |   1 -
 include/linux/hyperv.h               |   1 -
 18 files changed, 1396 insertions(+), 533 deletions(-)
 create mode 100644 arch/x86/include/asm/hyperv-tlfs.h
 delete mode 100644 arch/x86/include/uapi/asm/hyperv.h
 create mode 100644 arch/x86/kvm/vmx_evmcs.h

-- 
2.14.3
