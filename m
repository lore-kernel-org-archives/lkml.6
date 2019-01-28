Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0F1C282CC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3EE20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfA1G7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:59:14 -0500
Received: from foss.arm.com ([217.140.101.70]:39818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfA1G7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:59:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1241A78;
        Sun, 27 Jan 2019 22:59:13 -0800 (PST)
Received: from a075553-lin.blr.arm.com (a075553-lin.blr.arm.com [10.162.0.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB17E3F5AF;
        Sun, 27 Jan 2019 22:59:09 -0800 (PST)
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
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 0/6] Add ARMv8.3 pointer authentication for kvm guest
Date:   Mon, 28 Jan 2019 12:28:41 +0530
Message-Id: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series adds pointer authentication support for KVM guest and
is based on top of Linux 5.0-rc3. The basic patches in this series was
originally posted by Mark Rutland earlier[1,2] and contains some history
of this work.

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
userspace/kernel and can be found in Kristina's generic pointer authentication
patch series[3].

KVM guest work:
==============================================

If pointer authentication is enabled for KVM guests then the new PAC instructions
will not trap to EL2. If not then they may be ignored if in HINT region or trapped
in EL2 as illegal instruction. Since KVM guest vcpu runs as a thread so they have
a key initialized which will be used by PAC. When world switch happens between
host and guest then this key is exchanged.

There were some review comments by Christoffer Dall in the original series [1,2,3]
and this patch series tries to implement them. The original series enabled pointer
authentication for both userspace and kvm userspace. However it is now
bifurcated and this series contains only KVM guest support.

The current v5 patch series contains most of the suggestion by James Morse.
One of the suggestions was to do save/restore keys in asm during switch. However
this series re-uses the arm64 core functions __ptrauth_key_install but called from
C function using __no_ptrauth attribute.

Changes since v4 [6]: Several suggestions from James Morse
* Move host registers to be saved/restored inside struct kvm_cpu_context.
* Similar to hcr_el2, save/restore mdcr_el2 register also.
* Added save routines for ptrauth keys in generic arm core and
  use them during KVM context switch.
* Defined a GCC attribute __no_ptrauth which discards generating
  ptrauth instructions in a function. This is taken from Kristina's
  earlier kernel pointer authentication support patches [4].
* Dropped a patch to mask cpufeature when not enabled from userspace and
  now only key registers are masked from register list.

Changes since v3 [5]:
* Use pointer authentication only when VHE is present as ARM8.3 implies ARM8.1
  features to be present.
* Added lazy context handling of ptrauth instructions from V2 version again. 
* Added more details in Documentation.

Changes since v2 [1,2]:
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

[1]: https://lore.kernel.org/lkml/20171127163806.31435-11-mark.rutland@arm.com/
[2]: https://lore.kernel.org/lkml/20171127163806.31435-10-mark.rutland@arm.com/
[3]: https://lkml.org/lkml/2018/12/7/666
[4]: https://lore.kernel.org/lkml/20181005084754.20950-1-kristina.martsenko@arm.com/
[5]: https://lkml.org/lkml/2018/10/17/594
[6]: https://lkml.org/lkml/2018/12/18/80


Linux (5.0-rc3 based):

Amit Daniel Kachhap (5):
  arm64: Add utilities to save restore pointer authentication keys
  arm64/kvm: preserve host HCR_EL2/MDCR_EL2 value
  arm64/kvm: context-switch ptrauth registers
  arm64/kvm: add a userspace option to enable pointer authentication
  arm64/kvm: control accessibility of ptrauth key registers

 Documentation/arm64/pointer-authentication.txt | 12 +++--
 Documentation/virtual/kvm/api.txt              |  4 ++
 arch/arm/include/asm/kvm_host.h                |  8 ++-
 arch/arm64/include/asm/cpufeature.h            |  5 ++
 arch/arm64/include/asm/kvm_asm.h               |  2 +
 arch/arm64/include/asm/kvm_emulate.h           | 22 ++++----
 arch/arm64/include/asm/kvm_host.h              | 55 +++++++++++++++++---
 arch/arm64/include/asm/kvm_hyp.h               |  9 +++-
 arch/arm64/include/asm/pointer_auth.h          | 28 +++++++++++
 arch/arm64/include/uapi/asm/kvm.h              |  1 +
 arch/arm64/kernel/traps.c                      |  1 +
 arch/arm64/kvm/debug.c                         | 28 +++--------
 arch/arm64/kvm/guest.c                         |  2 +-
 arch/arm64/kvm/handle_exit.c                   | 24 +++++----
 arch/arm64/kvm/hyp/Makefile                    |  1 +
 arch/arm64/kvm/hyp/ptrauth-sr.c                | 57 +++++++++++++++++++++
 arch/arm64/kvm/hyp/switch.c                    | 44 ++++++++--------
 arch/arm64/kvm/hyp/sysreg-sr.c                 | 13 ++++-
 arch/arm64/kvm/hyp/tlb.c                       |  6 ++-
 arch/arm64/kvm/reset.c                         |  3 ++
 arch/arm64/kvm/sys_regs.c                      | 70 +++++++++++++++++++++-----
 include/uapi/linux/kvm.h                       |  1 +
 virt/kvm/arm/arm.c                             |  6 ++-
 23 files changed, 307 insertions(+), 95 deletions(-)
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

