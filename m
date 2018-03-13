Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932531AbeCMRsK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:48:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932302AbeCMRsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:48:09 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 0/2] x86/kvm: avoid expensive rdmsrs for FS/GS base MSRs
Date: Tue, 13 Mar 2018 18:48:03 +0100
Message-Id: <20180313174805.11825-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
- Merged patches 1 and 2, skip savesegment() for FS and FS for x86_64
  as save_fsgs() already does that [Paolo Bonzini]
- Rename save_current_fsgs() -> save_fsgs_for_kvm() [Andy Lutomirski]
- Trimmed comments [Andy Lutomirski]
- Add Andy's A-b to what is now PATCH2

Some time ago Paolo suggested to take a look at probably unneeded expensive
rdmsrs for FS/GS base MSR in vmx_save_host_state(). This is called on every
vcpu run when we need to handle vmexit in userspace.

vmx_save_host_state() is always called in a very well defined context
(ioctl from userspace) so we may try to get the required values for FS/GS
bases from in-kernel variables and avoid expensive rdmsrs.

My debug shows we're shaving off 240 cpu cycles (E5-2603 v3).

Vitaly Kuznetsov (2):
  x86/kvm/vmx: read MSR_{FS,KERNEL_GS}_BASE from current->thread
  x86/kvm/vmx: avoid expensive rdmsr for MSR_GS_BASE

 arch/x86/include/asm/processor.h | 10 ++++++++++
 arch/x86/kernel/cpu/common.c     |  3 ++-
 arch/x86/kernel/process_64.c     | 14 ++++++++++++++
 arch/x86/kvm/vmx.c               | 16 ++++++++++++----
 4 files changed, 38 insertions(+), 5 deletions(-)

-- 
2.14.3
