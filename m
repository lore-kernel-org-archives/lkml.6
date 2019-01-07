Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CA6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6722054F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfAGSo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:44:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbfAGSo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:44:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C97A81127;
        Mon,  7 Jan 2019 18:44:56 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9ACFE7C820;
        Mon,  7 Jan 2019 18:44:52 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        x86@kernel.org
Subject: [PATCH] KVM: nSVM: clear events pending from svm_complete_interrupts() when exiting to L1
Date:   Mon,  7 Jan 2019 19:44:51 +0100
Message-Id: <20190107184451.17749-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 07 Jan 2019 18:44:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm-unit-tests' eventinj "NMI failing on IDT" test results in NMI being
delivered to the host (L1) when it's running nested. The problem seems to
be: svm_complete_interrupts() raises 'nmi_injected' flag but later we
decide to reflect EXIT_NPF to L1. The flag remains pending and we do NMI
injection upon entry so it got delivered to L1 instead of L2.

It seems that VMX code solves the same issue in prepare_vmcs12(), this was
introduced with code refactoring in commit 5f3d5799974b ("KVM: nVMX: Rework
event injection and recovery").

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/svm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 33d4ed6e78a5..db842dafccf0 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3419,6 +3419,14 @@ static int nested_svm_vmexit(struct vcpu_svm *svm)
 	kvm_mmu_reset_context(&svm->vcpu);
 	kvm_mmu_load(&svm->vcpu);
 
+	/*
+	 * Drop what we picked up for L2 via svm_complete_interrupts() so it
+	 * doesn't end up in L1.
+	 */
+	svm->vcpu.arch.nmi_injected = false;
+	kvm_clear_exception_queue(&svm->vcpu);
+	kvm_clear_interrupt_queue(&svm->vcpu);
+
 	return 0;
 }
 
-- 
2.20.1

