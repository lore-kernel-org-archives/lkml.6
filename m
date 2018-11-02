Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73449C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4930B2084C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZ75QYJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4930B2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731549AbeKCEES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:04:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbeKCEES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:04:18 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A113A20848;
        Fri,  2 Nov 2018 18:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184961;
        bh=ht0gSJWDnQLRPtYp86Do7XER+J1sddL4RO3TzZVS9Yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZ75QYJibhEZmn2vqWLZTv2i3+zalgFec5zsmeCGCzNk7O+B8+EgNQibDfc7k7Gxk
         ick7h6X6rJAsLWEqpSxqk+j9RW6usBU8a2W59B2VBq4b8J9JQl7HvLQC/yZ8mAsuzI
         u8hKlwEVh5PQOg5brGozTXDJs9p1ookOS4zOEbFU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 108/143] kvm: x86: fix WARN due to uninitialized guest FPU state
Date:   Fri,  2 Nov 2018 19:34:53 +0100
Message-Id: <20181102182906.466254364@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 5663d8f9bbe4bf15488f7351efb61ea20fa6de06 upstream

------------[ cut here ]------------
 Bad FPU state detected at kvm_put_guest_fpu+0xd8/0x2d0 [kvm], reinitializing FPU registers.
 WARNING: CPU: 1 PID: 4594 at arch/x86/mm/extable.c:103 ex_handler_fprestore+0x88/0x90
 CPU: 1 PID: 4594 Comm: qemu-system-x86 Tainted: G    B      OE    4.15.0-rc2+ #10
 RIP: 0010:ex_handler_fprestore+0x88/0x90
 Call Trace:
  fixup_exception+0x4e/0x60
  do_general_protection+0xff/0x270
  general_protection+0x22/0x30
 RIP: 0010:kvm_put_guest_fpu+0xd8/0x2d0 [kvm]
 RSP: 0018:ffff8803d5627810 EFLAGS: 00010246
  kvm_vcpu_reset+0x3b4/0x3c0 [kvm]
  kvm_apic_accept_events+0x1c0/0x240 [kvm]
  kvm_arch_vcpu_ioctl_run+0x1658/0x2fb0 [kvm]
  kvm_vcpu_ioctl+0x479/0x880 [kvm]
  do_vfs_ioctl+0x142/0x9a0
  SyS_ioctl+0x74/0x80
  do_syscall_64+0x15f/0x600

where kvm_put_guest_fpu is called without a prior kvm_load_guest_fpu.
To fix it, move kvm_load_guest_fpu to the very beginning of
kvm_arch_vcpu_ioctl_run.

Cc: stable@vger.kernel.org
Fixes: f775b13eedee2f7f3c6fdd4e90fb79090ce5d339
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3856828ee1dc..8d688b213504 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7393,13 +7393,12 @@ static int complete_emulated_mmio(struct kvm_vcpu *vcpu)
 
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 {
-	struct fpu *fpu = &current->thread.fpu;
 	int r;
 
-	fpu__initialize(fpu);
-
 	kvm_sigset_activate(vcpu);
 
+	kvm_load_guest_fpu(vcpu);
+
 	if (unlikely(vcpu->arch.mp_state == KVM_MP_STATE_UNINITIALIZED)) {
 		if (kvm_run->immediate_exit) {
 			r = -EINTR;
@@ -7440,6 +7439,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		r = vcpu_run(vcpu);
 
 out:
+	kvm_put_guest_fpu(vcpu);
 	post_kvm_run_save(vcpu);
 	kvm_sigset_deactivate(vcpu);
 
-- 
2.17.1



