Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BD3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4132D20879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545998048;
	bh=jL2JHwpEpYLiZKXLvgWWJInnjOUuvqNVC+PBvnlGyyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fc9bpyMikucRw4jDu0wEzBysfHxPumVqiL0fJtGYv5Zu/b4YwaEhjT92CKNvK7Leb
	 q8QZ7WXAzEw33fHS2rTe8AxKMFRhH727T9Uqgua4qRuFKr6WzsVou/7zzbGJ21NmLi
	 kXSe4GFQyUF3vzXtxZbulE22Z6BAcnbdDHMpfTBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbeL1Lxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 06:53:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbeL1Lxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 06:53:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 563732148E;
        Fri, 28 Dec 2018 11:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545998021;
        bh=jL2JHwpEpYLiZKXLvgWWJInnjOUuvqNVC+PBvnlGyyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GKPByK+V2wrE7/VwwiwOmtOwHWgr50ajM4rBDhOhlh36oJPMdEt1xJlqCEn1MbGZN
         qf32XAlDQF19qL/l5UK/1ju0PHC5MzT7egKTgoxpcU5KV1g4Th7x2qfHWiLOjyapoA
         zFxWqeNTezbRAtzfj0YBm/TcYC2D3BCxSm5bzoqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+39810e6c400efadfef71@syzkaller.appspotmail.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>
Subject: [PATCH 4.19 21/46] KVM: X86: Fix NULL deref in vcpu_scan_ioapic
Date:   Fri, 28 Dec 2018 12:52:15 +0100
Message-Id: <20181228113126.008457453@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7304,7 +7304,7 @@ void kvm_make_scan_ioapic_request(struct
 
 static void vcpu_scan_ioapic(struct kvm_vcpu *vcpu)
 {
-	if (!kvm_apic_hw_enabled(vcpu->arch.apic))
+	if (!kvm_apic_present(vcpu))
 		return;
 
 	bitmap_zero(vcpu->arch.ioapic_handled_vectors, 256);


