Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeBMKLE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:11:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751132AbeBMKLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:11:02 -0500
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, ebiederm@xmission.com
Cc: mingo@kernel.org, tglx@linutronix.de, x86@kernel.org,
        douly.fnst@cn.fujitsu.com, joro@8bytes.org, uobergfe@redhat.com,
        prarit@redhat.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 0/5] x86/apic: Fix restoring boot irq mode in reboot and kexec/kdump
Date: Tue, 13 Feb 2018 18:10:46 +0800
Message-Id: <20180213101051.13630-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v4 post. Only patch 0002 is updated.

A regression bug was introduced in below commit.
commit 522e66464467 ("x86/apic: Disable I/O APIC before shutdown of the local APIC")

It caused the action to fail which we try to restore boot irq mode
in reboot and kexec/kdump. Details can be seen in patch 0002.

Warning can always be seen during kdump kernel boot on qemu/kvm
platform. Our customer even saw casual kdump kernel hang once in
~30 attempts during stress testing of kdump on KVM machine.

v3->v4:
  Eric pointed out that in patch 0002 the change related to
  KEXEC_JUMP is not right.
  Correct it.

  Add Fixes tag and Cc to stable.

v2->v3:
  Change as Eric suggested:

  Rerrange patches and change code and messy function/variable naming.
  Change patch subject and log to make it more understandable. 

Baoquan He (5):
  x86/apic: Split out restore_boot_irq_mode from disable_IO_APIC
  x86/apic: Fix restoring boot irq mode in reboot and kexec/kdump
  x86/apic: Remove useless disable_IO_APIC
  x86/apic: Rename variable/function related to x86_io_apic_ops
  x86/apic: Set up through-local-APIC on boot CPU if 'noapic' specified

 arch/x86/include/asm/io_apic.h     |  9 +++++----
 arch/x86/include/asm/x86_init.h    |  8 ++++----
 arch/x86/kernel/apic/apic.c        |  2 +-
 arch/x86/kernel/apic/io_apic.c     | 16 ++++------------
 arch/x86/kernel/crash.c            |  3 ++-
 arch/x86/kernel/machine_kexec_32.c |  8 ++++----
 arch/x86/kernel/machine_kexec_64.c |  8 ++++----
 arch/x86/kernel/reboot.c           |  3 ++-
 arch/x86/kernel/x86_init.c         |  6 +++---
 arch/x86/xen/apic.c                |  2 +-
 drivers/iommu/irq_remapping.c      |  4 ++--
 11 files changed, 32 insertions(+), 37 deletions(-)

-- 
2.13.6
