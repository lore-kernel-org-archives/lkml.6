Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB4BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D296720818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D296720818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbeKLGTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:19:03 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50552 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730472AbeKLFsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:22 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsh-0000oM-LO; Sun, 11 Nov 2018 19:58:51 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsa-0001rN-7G; Sun, 11 Nov 2018 19:58:44 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Wanpeng Li" <wanpeng.li@hotmail.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.400624834@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 339/366] KVM: x86: fix escape of guest dr6 to the host
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Wanpeng Li <wanpeng.li@hotmail.com>

commit efdab992813fb2ed825745625b83c05032e9cda2 upstream.

syzkaller reported:

   WARNING: CPU: 0 PID: 12927 at arch/x86/kernel/traps.c:780 do_debug+0x222/0x250
   CPU: 0 PID: 12927 Comm: syz-executor Tainted: G           OE    4.15.0-rc2+ #16
   RIP: 0010:do_debug+0x222/0x250
   Call Trace:
    <#DB>
    debug+0x3e/0x70
   RIP: 0010:copy_user_enhanced_fast_string+0x10/0x20
    </#DB>
    _copy_from_user+0x5b/0x90
    SyS_timer_create+0x33/0x80
    entry_SYSCALL_64_fastpath+0x23/0x9a

The testcase sets a watchpoint (with perf_event_open) on a buffer that is
passed to timer_create() as the struct sigevent argument.  In timer_create(),
copy_from_user()'s rep movsb triggers the BP.  The testcase also sets
the debug registers for the guest.

However, KVM only restores host debug registers when the host has active
watchpoints, which triggers a race condition when running the testcase with
multiple threads.  The guest's DR6.BS bit can escape to the host before
another thread invokes timer_create(), and do_debug() complains.

The fix is to respect do_debug()'s dr6 invariant when leaving KVM.

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/x86.c | 6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2892,6 +2892,12 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *
 	kvm_x86_ops->vcpu_put(vcpu);
 	kvm_put_guest_fpu(vcpu);
 	vcpu->arch.last_host_tsc = native_read_tsc();
+	/*
+	 * If userspace has set any breakpoints or watchpoints, dr6 is restored
+	 * on every vmexit, but if not, we might have a stale dr6 from the
+	 * guest. do_debug expects dr6 to be cleared after it runs, do the same.
+	 */
+	set_debugreg(0, 6);
 }
 
 static int kvm_vcpu_ioctl_get_lapic(struct kvm_vcpu *vcpu,

