Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BFBC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2876720882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762326;
	bh=EjCC3/oL9EJ8nUMkyAyoBits8BSfuT80B/jivBjwxtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aOk7RNAxzh9wIlPsUHrfyDLvYZBLCC+aH5krS87tRkl7JoAvP0nTxgBhrUyHVQmZo
	 8Kym6hgBUsl3dcb7i3a6CETwUlrksZB6SafsONTU7irSCOLCdt0UnfFPr6FJPiUJEZ
	 CyByNw4NlJBez5seEPmCI1kE3aysCRHxGO97iWac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbfA2LpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:45:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730744AbfA2LpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:45:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C86232086C;
        Tue, 29 Jan 2019 11:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762322;
        bh=EjCC3/oL9EJ8nUMkyAyoBits8BSfuT80B/jivBjwxtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2AxaQpnsYwAWQkJMROEi07kkrocUFaLCO0nywj+z9QAiM5kiTmV3Nh4VYii6pCnhj
         ygXyhW7cWqORalELy69q1z3efEnfnZWw1QepTaT4hqQel6ItK51eNz4LVyMJSLflgg
         n1aJkxGo2a3SKcu0u8HMLPkP2v7Tj0zNLN0EzqQU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 068/103] KVM: x86: Fix PV IPIs for 32-bit KVM host
Date:   Tue, 29 Jan 2019 12:35:45 +0100
Message-Id: <20190129113204.718342487@linuxfoundation.org>
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
@@ -6867,10 +6867,10 @@ int kvm_emulate_hypercall(struct kvm_vcp
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


