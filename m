Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2592AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2616214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762012;
	bh=CvqD9gYrN0/OTWZxOdslRm1nrCveMkJ9LuR/1EBQi7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pkfI4n8rtB8zTkcmEaCFOQkGy3KBP0Gr3xpZJn5CbyRkORuqLrr0PuEd233RBdCJE
	 RxdNKR9pb7Kdxv5MGIfOMyK/qaoVFkgRUxVNYwncVFfh35696h35Lg8ezO0dZE138O
	 vVk+WbTe0u2Y+e5UlbO6z6Vme4LN4FJQyZip/wI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfA2LkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:40:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728677AbfA2LkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:40:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9A9520857;
        Tue, 29 Jan 2019 11:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762006;
        bh=CvqD9gYrN0/OTWZxOdslRm1nrCveMkJ9LuR/1EBQi7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vGEPJA6BqDvHvZVCjveMTElp1mehd3C/I1m1mgqAfkbkDAeFpyci+tvUJhbKP8v+t
         RBhUPbAdH8QhSIZyTrEwSBxDA2qmtfFoLwvvDpqGcXB5NNAcJ25y0sP1ZKHonb6inU
         UwTXdHz2A55U0BYE2qy+5D1ZpJ/RFUYo5KEbAnwM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.20 077/117] KVM: x86: Fix PV IPIs for 32-bit KVM host
Date:   Tue, 29 Jan 2019 12:35:28 +0100
Message-Id: <20190129113211.340319742@linuxfoundation.org>
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 1ed199a41c70ad7bfaee8b14f78e791fcf43b278 upstream.

The recognition of the KVM_HC_SEND_IPI hypercall was unintentionally
wrapped in "#ifdef CONFIG_X86_64", causing 32-bit KVM hosts to reject
any and all PV IPI requests despite advertising the feature.  This
results in all KVM paravirtualized guests hanging during SMP boot due
to IPIs never being delivered.

Fixes: 4180bf1b655a ("KVM: X86: Implement "send IPI" hypercall")
Cc: stable@vger.kernel.org
Cc: Wanpeng Li <wanpengli@tencent.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6997,10 +6997,10 @@ int kvm_emulate_hypercall(struct kvm_vcp
 	case KVM_HC_CLOCK_PAIRING:
 		ret = kvm_pv_clock_pairing(vcpu, a0, a1);
 		break;
+#endif
 	case KVM_HC_SEND_IPI:
 		ret = kvm_pv_send_ipi(vcpu->kvm, a0, a1, a2, a3, op_64_bit);
 		break;
-#endif
 	default:
 		ret = -KVM_ENOSYS;
 		break;


