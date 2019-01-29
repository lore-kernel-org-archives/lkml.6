Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92500C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B45C2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762584;
	bh=CfcGS8xDG7kEg8MDKvv3izcP5rR8GXn/plLhrHanLIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WsZsN0uWb4p8Mil2L/R/RMUOTX0p5n8DDB7tPP02ZDK4OIXQ6f0afKQaeltIhiROE
	 cdyvAp+y6J1/I0ofkOw/uOv0eANZ9M6J+4QwD1pTfB97y+mnVhOOiLSMR4ilUSzeGJ
	 ncHpt807pmyewKFZNfeFC5tymQNbwlY4V4yuMdmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbfA2Ltn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:49:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730422AbfA2Ltj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:49:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 241AC2083B;
        Tue, 29 Jan 2019 11:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762578;
        bh=CfcGS8xDG7kEg8MDKvv3izcP5rR8GXn/plLhrHanLIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wW/Ah+5kwwRE8SWT4raFOSEaTi4EbqtomZXiZNtVMd9R+oPh8X6pzlO/EvreUVUud
         HQIoKaGoSlRcJglQIB93lgMJJifswqhikDh9T3NMBQ2Ub9QFZwxQWonEoXwSy3hVRC
         MfAgilwloaB41/1L18zPYpJVnMwZHgUhn8XSBHBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Rik van Riel <riel@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Lindroth <thomas.lindroth@gmail.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 4.14 54/68] KVM: x86: Fix a 4.14 backport regression related to userspace/guest FPU
Date:   Tue, 29 Jan 2019 12:36:16 +0100
Message-Id: <20190129113136.611289187@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <sean.j.christopherson@intel.com>

Upstream commit:

    f775b13eedee ("x86,kvm: move qemu/guest FPU switching out to vcpu_run")

introduced a bug, which was later fixed by upstream commit:

    5663d8f9bbe4 ("kvm: x86: fix WARN due to uninitialized guest FPU state")

For reasons unknown, both commits were initially passed-over for
inclusion in the 4.14 stable branch despite being tagged for stable.
Eventually, someone noticed that the fixup, commit 5663d8f9bbe4, was
missing from stable[1], and so it was queued up for 4.14 and included in
release v4.14.79.

Even later, the original buggy patch, commit f775b13eedee, was also
applied to the 4.14 stable branch.  Through an unlucky coincidence, the
incorrect ordering did not generate a conflict between the two patches,
and led to v4.14.94 and later releases containing a spurious call to
kvm_load_guest_fpu() in kvm_arch_vcpu_ioctl_run().  As a result, KVM may
reload stale guest FPU state, e.g. after accepting in INIT event.  This
can manifest as crashes during boot, segfaults, failed checksums and so
on and so forth.

Remove the unwanted kvm_{load,put}_guest_fpu() calls, i.e. make
kvm_arch_vcpu_ioctl_run() look like commit 5663d8f9bbe4 was backported
after commit f775b13eedee.

[1] https://www.spinics.net/lists/stable/msg263931.html

Fixes: 4124a4cff344 ("x86,kvm: move qemu/guest FPU switching out to vcpu_run")
Cc: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Reported-by: Roman Mamedov
Reported-by: Thomas Lindroth <thomas.lindroth@gmail.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/x86.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7422,14 +7422,12 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
 		}
 	}
 
-	kvm_load_guest_fpu(vcpu);
-
 	if (unlikely(vcpu->arch.complete_userspace_io)) {
 		int (*cui)(struct kvm_vcpu *) = vcpu->arch.complete_userspace_io;
 		vcpu->arch.complete_userspace_io = NULL;
 		r = cui(vcpu);
 		if (r <= 0)
-			goto out_fpu;
+			goto out;
 	} else
 		WARN_ON(vcpu->arch.pio.count || vcpu->mmio_needed);
 
@@ -7438,8 +7436,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
 	else
 		r = vcpu_run(vcpu);
 
-out_fpu:
-	kvm_put_guest_fpu(vcpu);
 out:
 	kvm_put_guest_fpu(vcpu);
 	post_kvm_run_save(vcpu);


