Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034287AbeBPOYQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 09:24:16 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:64799 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034154AbeBPOYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 09:24:13 -0500
X-IronPort-AV: E=Sophos;i="5.46,519,1511827200";
   d="scan'208";a="719951176"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: kvm@vger.kernel.org, x86@kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [RFC 0/2] KVM/nVMX: Add support for saving and restoring L1 hypervisors with its running L2s
Date: Fri, 16 Feb 2018 15:23:48 +0100
Message-Id: <1518791030-31765-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Live migration software in L0 needs to be able to capture an accurate state of
the L1 guest in order to save it and later restore it. One of the complications
of doing this when you have a nested/L2 guest is that the state from the L0
user space point of view is very indeterminstic. The state can be coming from
the L1 or the L2 guest depending on when the vCPU was kicked out of non-root
mode. There is also no way currently to extract the extra meta-state that L0
holds in order to run L2s.

In order to fix this, always switch to L1 state before exiting to user space
(Patch 1) and provide a new ioctl command to extra the extra meta-state (Patch 2).

This is still an early RFC because:

1- To get feedback on the approach taken here.
2- I am still debugging a VMEntry failure for L2 that occassionaly happens when
   I run a pause+unpause loop against an L1 guest running L2s. Also there is some
   meta-state that I am not extracting yet (will update this soon). L1 seems to
   be very stable though.

KarimAllah Ahmed (2):
  KVM/nVMX: Cleanly exit from L2 to L1 on user-space exit
  KVM/nVMX: Add support for saving/restoring L2 meta-state stored by L0

 arch/x86/include/asm/kvm_host.h |  5 +++
 arch/x86/include/uapi/asm/kvm.h |  7 ++++
 arch/x86/kvm/vmx.c              | 83 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              | 43 ++++++++++++++++++---
 include/linux/kvm_host.h        |  2 +
 include/uapi/linux/kvm.h        |  3 ++
 virt/kvm/kvm_main.c             | 24 ++++++++++++
 7 files changed, 162 insertions(+), 5 deletions(-)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

-- 
2.7.4
