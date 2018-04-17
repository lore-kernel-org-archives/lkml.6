Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeDQFqz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 01:46:55 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38363 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbeDQFqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 01:46:53 -0400
X-Google-Smtp-Source: AIpwx487CthSjln1mrYHzSV8dT9in/Wi7h80Vv3GDSYa3C6NVK01DeKi3anorLx8tYmD4puU2yAkmA==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Tim Shearer <tshearer@advaoptical.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH 0/3] KVM: VMX: Allow to disable ioport intercept per-VM by userspace
Date: Mon, 16 Apr 2018 22:45:59 -0700
Message-Id: <1523943962-25415-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Shearer reported that "There is a guest which is running a packet
forwarding app based on the DPDK (dpdk.org). The packet receive routine
writes to 0xc070 using glibc's "outw_p" function which does an additional
write to I/O port 0x80. It does this write for every packet that's
received, causing a flood of KVM userspace context switches". He uses
mpstat to observe a CPU performing L2 packet forwarding on a pinned
guest vCPU, the guest time is 95 percent when allowing I/O port 0x80
bypass, however, it is 65.78 percent when I/O port 0x80 bypss is
disabled.

This patchset introduces per-VM I/O permission bitmaps, the userspace
can disable the ioport intercept when they are more concern the
performance than the security.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Tim Shearer <tshearer@advaoptical.com>
Cc: Liran Alon <liran.alon@oracle.com>

Wanpeng Li (3):
  KVM: VMX: Introduce per-VM I/O permission bitmaps
  KVM: X86: Allow userspace to disable ioport intercept
  KVM: VMX: Allow I/O port 0x80 bypass when userspace prefer

 Documentation/virtual/kvm/api.txt | 11 +++++++++++
 arch/x86/include/asm/kvm_host.h   |  2 ++
 arch/x86/kvm/vmx.c                | 41 ++++++++++++++++++++++++++++++++++++---
 arch/x86/kvm/x86.c                |  5 +++++
 include/uapi/linux/kvm.h          |  1 +
 5 files changed, 57 insertions(+), 3 deletions(-)

-- 
2.7.4
