Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8055C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9699120989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762007;
	bh=XumBGVzIHw9Xqu6DXa86f2Cq5kXpQgfmYHrBR0CE+Yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rc0oB63nsPQX8jqH0NGzIBSlS5qKY3QwImmdIpjvYCJQ/mDAMopSPm5TooTh/R17+
	 texpjQIMZEPkdMt6vBIRl3j51hbnis69E9LfUN2aAqx1kTH421eh+hS3s3ySrOCUT7
	 NXG1utA6Xbtx7q9yDwiD6m3pcuxiWiEgwH4Z4FpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbfA2LkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:40:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729039AbfA2LkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:40:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DA1F20989;
        Tue, 29 Jan 2019 11:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762002;
        bh=XumBGVzIHw9Xqu6DXa86f2Cq5kXpQgfmYHrBR0CE+Yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MiLpwlDft9hXgu3M4JfWn0o7PCoI+hX37w6AsBjW0T31vmfXTD3z0r8po64cy7Y98
         vSeTAC0ZAOUDd8gUI4s+Jra3bIZF1P049Hqc6zlqK5NcNjQYyqdvSteu0eDNZhPl4i
         EE2E5biAEoavQFniLL8RvwSIBqxIz71yVsODRzuo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Popov <alex.popov@linux.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.20 076/117] KVM: x86: Fix single-step debugging
Date:   Tue, 29 Jan 2019 12:35:27 +0100
Message-Id: <20190129113211.299489269@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Popov <alex.popov@linux.com>

commit 5cc244a20b86090c087073c124284381cdf47234 upstream.

The single-step debugging of KVM guests on x86 is broken: if we run
gdb 'stepi' command at the breakpoint when the guest interrupts are
enabled, RIP always jumps to native_apic_mem_write(). Then other
nasty effects follow.

Long investigation showed that on Jun 7, 2017 the
commit c8401dda2f0a00cd25c0 ("KVM: x86: fix singlestepping over syscall")
introduced the kvm_run.debug corruption: kvm_vcpu_do_singlestep() can
be called without X86_EFLAGS_TF set.

Let's fix it. Please consider that for -stable.

Signed-off-by: Alexander Popov <alex.popov@linux.com>
Cc: stable@vger.kernel.org
Fixes: c8401dda2f0a00cd25c0 ("KVM: x86: fix singlestepping over syscall")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6407,8 +6407,7 @@ restart:
 		toggle_interruptibility(vcpu, ctxt->interruptibility);
 		vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
 		kvm_rip_write(vcpu, ctxt->eip);
-		if (r == EMULATE_DONE &&
-		    (ctxt->tf || (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)))
+		if (r == EMULATE_DONE && ctxt->tf)
 			kvm_vcpu_do_singlestep(vcpu, &r);
 		if (!ctxt->have_exception ||
 		    exception_type(ctxt->exception.vector) == EXCPT_TRAP)


