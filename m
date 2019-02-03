Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2BDC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36A020821
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbfBCODP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:03:15 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54822 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727986AbfBCODN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:03:13 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIEO-0003tl-FV; Sun, 03 Feb 2019 13:54:44 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9u-0007RT-D8; Sun, 03 Feb 2019 14:50:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        syzbot+39810e6c400efadfef71@syzkaller.appspotmail.com,
        "Wanpeng Li" <wanpengli@tencent.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.663279408@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 291/305] KVM: X86: Fix NULL deref in vcpu_scan_ioapic
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Wanpeng Li <wanpengli@tencent.com>

commit dcbd3e49c2f0b2c2d8a321507ff8f3de4af76d7c upstream.

Reported by syzkaller:

    CPU: 1 PID: 5962 Comm: syz-executor118 Not tainted 4.20.0-rc6+ #374
    Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
    RIP: 0010:kvm_apic_hw_enabled arch/x86/kvm/lapic.h:169 [inline]
    RIP: 0010:vcpu_scan_ioapic arch/x86/kvm/x86.c:7449 [inline]
    RIP: 0010:vcpu_enter_guest arch/x86/kvm/x86.c:7602 [inline]
    RIP: 0010:vcpu_run arch/x86/kvm/x86.c:7874 [inline]
    RIP: 0010:kvm_arch_vcpu_ioctl_run+0x5296/0x7320 arch/x86/kvm/x86.c:8074
    Call Trace:
	 kvm_vcpu_ioctl+0x5c8/0x1150 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2596
	 vfs_ioctl fs/ioctl.c:46 [inline]
	 file_ioctl fs/ioctl.c:509 [inline]
	 do_vfs_ioctl+0x1de/0x1790 fs/ioctl.c:696
	 ksys_ioctl+0xa9/0xd0 fs/ioctl.c:713
	 __do_sys_ioctl fs/ioctl.c:720 [inline]
	 __se_sys_ioctl fs/ioctl.c:718 [inline]
	 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
	 do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
	 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The reason is that the testcase writes hyperv synic HV_X64_MSR_SINT14 msr
and triggers scan ioapic logic to load synic vectors into EOI exit bitmap.
However, irqchip is not initialized by this simple testcase, ioapic/apic
objects should not be accessed.

This patch fixes it by also considering whether or not apic is present.

Reported-by: syzbot+39810e6c400efadfef71@syzkaller.appspotmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6054,7 +6054,7 @@ static void vcpu_scan_ioapic(struct kvm_
 	u64 eoi_exit_bitmap[4];
 	u32 tmr[8];
 
-	if (!kvm_apic_hw_enabled(vcpu->arch.apic))
+	if (!kvm_apic_present(vcpu))
 		return;
 
 	memset(eoi_exit_bitmap, 0, 32);

