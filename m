Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C732FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B36420874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B36420874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933847AbeFRIPd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:15:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52798 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933763AbeFRIPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:15:31 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 529EDC75;
        Mon, 18 Jun 2018 08:15:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, hu huajun <huhuajun@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 003/279] KVM: X86: fix incorrect reference of trace_kvm_pi_irte_update
Date:   Mon, 18 Jun 2018 10:09:48 +0200
Message-Id: <20180618080608.984910542@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: hu huajun <huhuajun@linux.alibaba.com>

[ Upstream commit 2698d82e519413c6ad287e6f14b29e0373ed37f8 ]

In arch/x86/kvm/trace.h, this function is declared as host_irq the
first input, and vcpu_id the second, instead of otherwise.

Signed-off-by: hu huajun <huhuajun@linux.alibaba.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm.c |    5 ++---
 arch/x86/kvm/vmx.c |    2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -5142,9 +5142,8 @@ static int svm_update_pi_irte(struct kvm
 		}
 
 		if (!ret && svm) {
-			trace_kvm_pi_irte_update(svm->vcpu.vcpu_id,
-						 host_irq, e->gsi,
-						 vcpu_info.vector,
+			trace_kvm_pi_irte_update(host_irq, svm->vcpu.vcpu_id,
+						 e->gsi, vcpu_info.vector,
 						 vcpu_info.pi_desc_addr, set);
 		}
 
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -12237,7 +12237,7 @@ static int vmx_update_pi_irte(struct kvm
 		vcpu_info.pi_desc_addr = __pa(vcpu_to_pi_desc(vcpu));
 		vcpu_info.vector = irq.vector;
 
-		trace_kvm_pi_irte_update(vcpu->vcpu_id, host_irq, e->gsi,
+		trace_kvm_pi_irte_update(host_irq, vcpu->vcpu_id, e->gsi,
 				vcpu_info.vector, vcpu_info.pi_desc_addr, set);
 
 		if (set)


