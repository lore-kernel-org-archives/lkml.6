Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF86BECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70B220658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZpzF/+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70B220658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbeJSCIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbeJSCIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:08:19 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD66E20658;
        Thu, 18 Oct 2018 18:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885971;
        bh=5RHJNFKZfN0UQU1RS9b4zjV0iL1YfcU5hEtlzn9uvz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MZpzF/+G8KgE/5qGJh7JC9756xv0GJOZe/I9FZecIUheDjkbHO7s17TiazC5Pys+X
         m27QS163vsoW5b9dhZo0Hroq6fazDFRtZObUKfPgULqwHThzzVruOuzRpMNDKQCBOF
         HB9WGa+P8kM6twiOKxqyuYaZ2H/12qTEDKywKpSE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: [PATCH 4.4 31/48] KVM: x86: remove eager_fpu field of struct kvm_vcpu_arch
Date:   Thu, 18 Oct 2018 19:55:06 +0200
Message-Id: <20181018175429.615288507@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
References: <20181018175427.133690306@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit 5a5fbdc0e3f1159a734f1890da60fce70e98271d upstream.

It is now equal to use_eager_fpu(), which simply tests a cpufeature bit.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/kvm_host.h |    1 -
 arch/x86/kvm/cpuid.c            |    3 +--
 arch/x86/kvm/x86.c              |    2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -439,7 +439,6 @@ struct kvm_vcpu_arch {
 	struct kvm_mmu_memory_cache mmu_page_header_cache;
 
 	struct fpu guest_fpu;
-	bool eager_fpu;
 	u64 xcr0;
 	u64 guest_supported_xcr0;
 	u32 guest_xstate_size;
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -104,8 +104,7 @@ int kvm_update_cpuid(struct kvm_vcpu *vc
 	if (best && (best->eax & (F(XSAVES) | F(XSAVEC))))
 		best->ebx = xstate_required_size(vcpu->arch.xcr0, true);
 
-	vcpu->arch.eager_fpu = use_eager_fpu();
-	if (vcpu->arch.eager_fpu)
+	if (use_eager_fpu())
 		kvm_x86_ops->fpu_activate(vcpu);
 
 	/*
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7325,7 +7325,7 @@ void kvm_put_guest_fpu(struct kvm_vcpu *
 	 * Every 255 times fpu_counter rolls over to 0; a guest that uses
 	 * the FPU in bursts will revert to loading it on demand.
 	 */
-	if (!vcpu->arch.eager_fpu) {
+	if (!use_eager_fpu()) {
 		if (++vcpu->fpu_counter < 5)
 			kvm_make_request(KVM_REQ_DEACTIVATE_FPU, vcpu);
 	}


