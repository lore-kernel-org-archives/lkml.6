Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933159AbeCSJZA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:25:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933029AbeCSJUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:20:32 -0400
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com, cdall@kernel.org,
        peter.maydell@linaro.org
Cc: andre.przywara@arm.com, drjones@redhat.com, wei@redhat.com
Subject: [RFC 00/12] KVM: arm/arm64: Allow multiple GICv3 redistributor regions
Date: Mon, 19 Mar 2018 10:20:08 +0100
Message-Id: <1521451220-27754-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment the KVM VGICv3 only supports a single redistributor
region (whose base address is set through the GICv3 kvm device
KVM_DEV_ARM_VGIC_GRP_ADDR/KVM_VGIC_V3_ADDR_TYPE_REDIST). There,
all the redistributors are laid out contiguously. The size of this
single redistributor region is not set explicitly but instead
induced at a late stage by the number of online vcpus.

The GIC specification does not mandate all redistributors to be
contiguous. Moreover DT and ACPI were specified so that multiple
redistributors regions can be defined.

The current interface brings a limitation on QEMU where ARM
virt machine available GPA holes only allowed to assign a
redistributor region fitting a max of 123 vcpus. Overcoming this
limitation would force either to create a new machine or relocate
the single rdist region or allow the allocation of multiple rdist
regions.

This series enables this last alternative. A new GICv3 KVM device
KVM_DEV_ARM_VGIC_GRP_ADDR/KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION allows
to register individual redistributor regions whose size is defined
explicitly. Those rdist regions then are filled by vcpu rdist frames
according to the need. The vgic init and related base address checks
are impacted.

Best Regards

Eric

Git: complete series available at
https://github.com/eauger/linux/tree/v4.16-rc5-rdist-regions-rfc

* Testing:
- With QEMU, splitting the single rdist region into 2 seperate ones.
- Work in progress to allow clean support of more than 123 vcpus.

Eric Auger (12):
  KVM: arm/arm64: Avoid multiple dist->spis kfree
  KVM: arm/arm64: Document KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION
  KVM: arm/arm64: Record RDIST Last bit at registration
  KVM: arm/arm64: Replace the single rdist region by a list
  KVM: arm/arm64: Helper to locate free rdist space
  KVM: arm/arm64: Helper to detect whether an RDIST is the last one
  KVM: arm/arm64: Helper to register a new redistributor region
  KVM: arm/arm64: Adapt vgic_v3_check_base to multiple rdist regions
  KVM: arm/arm64: Check vcpu redist base before registering an iodev
  KVM: arm/arm64: Check all vcpu redistributors are set on map_resources
  KVM: arm/arm64: Add KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION
  KVM: arm/arm64: Implement KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION

 Documentation/virtual/kvm/devices/arm-vgic-v3.txt |  12 +++
 arch/arm/include/uapi/asm/kvm.h                   |   7 +-
 arch/arm64/include/uapi/asm/kvm.h                 |   7 +-
 include/kvm/arm_vgic.h                            |  14 ++-
 virt/kvm/arm/vgic/vgic-init.c                     |  25 ++++-
 virt/kvm/arm/vgic/vgic-kvm-device.c               |  47 ++++++++-
 virt/kvm/arm/vgic/vgic-mmio-v3.c                  | 111 +++++++++++++++++++---
 virt/kvm/arm/vgic/vgic-v3.c                       |  89 +++++++++++++----
 virt/kvm/arm/vgic/vgic.h                          |  42 +++++++-
 9 files changed, 307 insertions(+), 47 deletions(-)

-- 
2.5.5
