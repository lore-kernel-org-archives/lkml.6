Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0203CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB23720851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yGqzu05/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB23720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbeLDL3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:29:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:41940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbeLDK5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:57:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47A4B20878;
        Tue,  4 Dec 2018 10:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921069;
        bh=ephEgpv4aN9JPKmp1LWZBBbtm4ucmuzRjunhbwSCG0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yGqzu05/+xvC6cCFnmOLnM5/7iDkdFuHR3J9fk+WM3E3h9Hjc7hEf/UFJgvPX0PdU
         IidXkCWRbvsqWETCQOaYgzoqlCWYmn4jA1ehSAli3EesJpzWAa7fOS7n4XZKuwJGs6
         h0kvZf6xzPTMKTLkE5wnYszPMe/9vvs7dy/Jq+MQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Wu <ww9210@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>
Subject: [PATCH 4.19 067/139] KVM: LAPIC: Fix pv ipis use-before-initialization
Date:   Tue,  4 Dec 2018 11:49:08 +0100
Message-Id: <20181204103652.803586868@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

From: Wanpeng Li <kernellwp@gmail.com>

commit 38ab012f109caf10f471db1adf284e620dd8d701 upstream.

Reported by syzkaller:

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000014
 PGD 800000040410c067 P4D 800000040410c067 PUD 40410d067 PMD 0
 Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 3 PID: 2567 Comm: poc Tainted: G           OE     4.19.0-rc5 #16
 RIP: 0010:kvm_pv_send_ipi+0x94/0x350 [kvm]
 Call Trace:
  kvm_emulate_hypercall+0x3cc/0x700 [kvm]
  handle_vmcall+0xe/0x10 [kvm_intel]
  vmx_handle_exit+0xc1/0x11b0 [kvm_intel]
  vcpu_enter_guest+0x9fb/0x1910 [kvm]
  kvm_arch_vcpu_ioctl_run+0x35c/0x610 [kvm]
  kvm_vcpu_ioctl+0x3e9/0x6d0 [kvm]
  do_vfs_ioctl+0xa5/0x690
  ksys_ioctl+0x6d/0x80
  __x64_sys_ioctl+0x1a/0x20
  do_syscall_64+0x83/0x6e0
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The reason is that the apic map has not yet been initialized, the testcase
triggers pv_send_ipi interface by vmcall which results in kvm->arch.apic_map
is dereferenced. This patch fixes it by checking whether or not apic map is
NULL and bailing out immediately if that is the case.

Fixes: 4180bf1b65 (KVM: X86: Implement "send IPI" hypercall)
Reported-by: Wei Wu <ww9210@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Wei Wu <ww9210@gmail.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/lapic.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -571,6 +571,11 @@ int kvm_pv_send_ipi(struct kvm *kvm, uns
 	rcu_read_lock();
 	map = rcu_dereference(kvm->arch.apic_map);
 
+	if (unlikely(!map)) {
+		count = -EOPNOTSUPP;
+		goto out;
+	}
+
 	if (min > map->max_apic_id)
 		goto out;
 	/* Bits above cluster_size are masked in the caller.  */


