Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04465ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2772214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2772214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeJQSnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:43:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49572 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbeJQSnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:43:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90E8C341;
        Wed, 17 Oct 2018 03:48:32 -0700 (PDT)
Received: from a75553-lin.blr.arm.com (unknown [10.162.0.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0D4E63F71D;
        Wed, 17 Oct 2018 03:48:28 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Subject: [PATCH v3 0/7] Add ARMv8.3 pointer authentication for kvm guest
Date:   Wed, 17 Oct 2018 16:17:53 +0530
Message-Id: <1539773280-4159-1-git-send-email-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series adds pointer authentication support for KVM guest and
is based on top of Linux 4.19-rc7 and generic pointer authentication patch
series[1]. The first two patch in this series was originally posted by
Mark Rutland earlier[2,3] and contains some history of this work.

Extension Overview:
=============================================

The ARMv8.3 pointer authentication extension adds functionality to detect
modification of pointer values, mitigating certain classes of attack such as
stack smashing, and making return oriented programming attacks harder.

The extension introduces the concept of a pointer authentication code (PAC),
which is stored in some upper bits of pointers. Each PAC is derived from the
original pointer, another 64-bit value (e.g. the stack pointer), and a secret
128-bit key.

New instructions are added which can be used to:

* Insert a PAC into a pointer
* Strip a PAC from a pointer
* Authenticate and strip a PAC from a pointer

The detailed description of ARMv8.3 pointer authentication support in
userspace/kernel can be found in Kristina's generic pointer authentication
patch series[1].

KVM guest work:
==============================================

If pointer authentication is enabled for KVM guests then the new PAC intructions
will not trap to EL2. If not then they may be ignored if in HINT region or trapped
in EL2 as illegal instruction. Since KVM guest vcpu runs as a thread so they have
a key initialised (Only APIAKey now) which will be used by PAC. When world switch
happens between host and guest then this key is exchanged.

There were some review comments by Christoffer Dall in the original series[2,3]
and this patch series tries to implement them. The original series enabled pointer
authentication for both userspace and kvm userspace. However it is now
bifurcated and this series contains only KVM guest support.

Changes since v2 [2,3]:
* Allow host and guest to have different HCR_EL2 settings and not just constant
  value HCR_HOST_VHE_FLAGS or HCR_HOST_NVHE_FLAGS.
* Optimise the reading of HCR_EL2 in host/guest switch by fetching it once
  during KVM initialisation state and using it later.
* Context switch pointer authentication keys when switching between guest
  and host. Pointer authentication was enabled in a lazy context earlier[2] and
  is removed now to make it simple. However it can be revisited later if there
  is significant performance issue.
* Added a userspace option to choose pointer authentication.
* Based on the userspace option, ptrauth cpufeature will be visible.
* Based on the userspace option, ptrauth key registers will be accessible.
* A small document is added on how to enable pointer authentication from
  userspace KVM API.

Looking for feedback and comments.

Thanks,
Amit

[1]: https://patchwork.kernel.org/cover/10627655/
[2]: https://lore.kernel.org/lkml/20171127163806.31435-11-mark.rutland@arm.com/
[3]: https://lore.kernel.org/lkml/20171127163806.31435-10-mark.rutland@arm.com/


Linux (4.19-rc7 based):

Amit Daniel Kachhap (6):
  arm64/kvm: preserve host HCR_EL2 value
  arm64/kvm: context-switch ptrauth registers
  arm64/kvm: add a userspace option to enable pointer authentication
  arm64/kvm: enable pointer authentication cpufeature conditionally
  arm64/kvm: control accessibility of ptrauth key registers
  arm64: docs: document KVM support of pointer authentication

Mark Rutland (2):
  arm64/kvm: preserve host HCR_EL2 value
  arm64/kvm: context-switch ptrauth registers

 Documentation/arm64/pointer-authentication.txt |  8 ++-
 Documentation/virtual/kvm/api.txt              |  2 +
 arch/arm/include/asm/kvm_host.h                |  8 +++
 arch/arm64/include/asm/cpufeature.h            |  6 ++
 arch/arm64/include/asm/kvm_asm.h               |  2 +
 arch/arm64/include/asm/kvm_host.h              | 45 ++++++++++++-
 arch/arm64/include/asm/kvm_hyp.h               |  7 ++
 arch/arm64/include/uapi/asm/kvm.h              |  1 +
 arch/arm64/kernel/traps.c                      |  1 +
 arch/arm64/kvm/handle_exit.c                   | 24 ++++---
 arch/arm64/kvm/hyp/Makefile                    |  1 +
 arch/arm64/kvm/hyp/ptrauth-sr.c                | 89 +++++++++++++++++++++++++
 arch/arm64/kvm/hyp/switch.c                    | 23 +++++--
 arch/arm64/kvm/hyp/sysreg-sr.c                 | 11 ++++
 arch/arm64/kvm/hyp/tlb.c                       |  6 +-
 arch/arm64/kvm/reset.c                         |  3 +
 arch/arm64/kvm/sys_regs.c                      | 91 ++++++++++++++++++++------
 include/uapi/linux/kvm.h                       |  1 +
 virt/kvm/arm/arm.c                             |  5 ++
 19 files changed, 295 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/ptrauth-sr.c

kvmtool:

Repo: git.kernel.org/pub/scm/linux/kernel/git/will/kvmtool.git
Amit Daniel Kachhap (1):
  arm/kvm: arm64: Add a vcpu feature for pointer authentication

 arm/aarch32/include/kvm/kvm-cpu-arch.h    | 2 ++
 arm/aarch64/include/asm/kvm.h             | 3 +++
 arm/aarch64/include/kvm/kvm-arch.h        | 1 +
 arm/aarch64/include/kvm/kvm-config-arch.h | 4 +++-
 arm/aarch64/include/kvm/kvm-cpu-arch.h    | 2 ++
 arm/aarch64/kvm-cpu.c                     | 5 +++++
 arm/include/arm-common/kvm-config-arch.h  | 1 +
 arm/kvm-cpu.c                             | 7 +++++++
 include/linux/kvm.h                       | 1 +
 9 files changed, 25 insertions(+), 1 deletion(-)
-- 
2.7.4

