Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD39C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7953720880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763307;
	bh=PvpnZs8XYcSxCP76717UpTQu0z66fV73s39taDx7jHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IYObklHwW1XZduyveylyRraHFwX7nXpPa35+YghcxHmGmqZFGRxNecbKETc0lOQOC
	 N6iczONJMoVWQSsxTcFEAmIQah5Wa3HB3B52EnRxyYI2JqYNgoB2VCocpcBwtBCWja
	 cZbXqvGkopYxVK9/quLNU67A/r87antqZIahRdIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbfA2MBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:01:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:35776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730733AbfA2LpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:45:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A8782086C;
        Tue, 29 Jan 2019 11:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762319;
        bh=PvpnZs8XYcSxCP76717UpTQu0z66fV73s39taDx7jHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZV+C/HIAPTXiFgmp899qI+Ue/8kmingsgXSFXi5BM1y9kE7noBtKdyug83jSd/2JP
         +qHETZIvR56/9HzLYtp0Y6dUKlzZfoRBLAqj4rba8mnhibt/BLSOOGPsVSlquC7RwY
         QopQOT6ntXO2S2TzlkPsewGXG9k2xqr3b9fzEq5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Popov <alex.popov@linux.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 067/103] KVM: x86: Fix single-step debugging
Date:   Tue, 29 Jan 2019 12:35:44 +0100
Message-Id: <20190129113204.656880907@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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
@@ -6277,8 +6277,7 @@ restart:
 		toggle_interruptibility(vcpu, ctxt->interruptibility);
 		vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
 		kvm_rip_write(vcpu, ctxt->eip);
-		if (r == EMULATE_DONE &&
-		    (ctxt->tf || (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP)))
+		if (r == EMULATE_DONE && ctxt->tf)
 			kvm_vcpu_do_singlestep(vcpu, &r);
 		if (!ctxt->have_exception ||
 		    exception_type(ctxt->exception.vector) == EXCPT_TRAP)


