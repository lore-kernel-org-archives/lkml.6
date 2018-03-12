Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeCLODG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:03:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751252AbeCLODD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:03:03 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 0/3] x86/kvm: avoid expensive rdmsrs for FS/GS base MSRs
Date: Mon, 12 Mar 2018 15:02:57 +0100
Message-Id: <20180312140300.6166-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since RFC [Andy Lutomirski]:
- Export new save_current_fsgs() API and call it before reading
  current->thread.fs/gsbase
- New cpu_kernelmode_gs_base() API.
- Some comments added.

Some time ago Paolo suggested to take a look at probably unneeded expensive
rdmsrs for FS/GS base MSR in vmx_save_host_state(). This is called on every
vcpu run when we need to handle vmexit in userspace.

vmx_save_host_state() is always called in a very well defined context
(ioctl from userspace) so we may try to get the required values for FS/GS
bases from in-kernel variables and avoid expensive rdmsrs.

My debug shows we're shaving off 240 cpu cycles (E5-2603 v3).

Vitaly Kuznetsov (3):
  x86/kvm/vmx: read MSR_FS_BASE from current->thread
  x86/kvm/vmx: read MSR_KERNEL_GS_BASE from current->thread
  x86/kvm/vmx: avoid expensive rdmsr for MSR_GS_BASE

 arch/x86/include/asm/processor.h |  8 ++++++++
 arch/x86/kernel/cpu/common.c     |  3 ++-
 arch/x86/kernel/process_64.c     | 20 ++++++++++++++++++++
 arch/x86/kvm/vmx.c               |  9 ++++++---
 4 files changed, 36 insertions(+), 4 deletions(-)

-- 
2.14.3
