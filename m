Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426729AbeCBKzM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:55:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1426677AbeCBKzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:55:07 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH RFC 0/3] x86/kvm: avoid expensive rdmsrs for FS/GS base MSRs
Date: Fri,  2 Mar 2018 11:55:00 +0100
Message-Id: <20180302105503.24428-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some time ago Paolo suggested to take a look at probably unneeded expensive
rdmsrs for FS/GS base MSR in vmx_save_host_state(). This is called on every
vcpu run when we need to handle vmexit in userspace.

I have to admit I got a bit lost in our kernel FS/GS magic. I managed to 
convince myself that in the well defined context (ioctl from userspace)
we can always get the required values from in-kernel variables and avoid
rdmsrs. But I may have missed something really important, thus RFC.

My debug shows we're shaving off 240 cpu cycles (E5-2603 v3).

In case these patches turn out to be worthwile AMD SVM can probably be
optimized the ame way.

Vitaly Kuznetsov (3):
  x86/kvm/vmx: read MSR_FS_BASE from current->thread
  x86/kvm/vmx: read MSR_KERNEL_GS_BASE from current->thread
  x86/kvm/vmx: avoid expensive rdmsr for MSR_GS_BASE

 arch/x86/kernel/cpu/common.c | 1 +
 arch/x86/kvm/vmx.c           | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.14.3
