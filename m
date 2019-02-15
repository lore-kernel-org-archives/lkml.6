Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA28C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E2F222DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197756;
	bh=eiBabLThfvITQaflfLrUTq4NoTkOQKfHZWI7tFM+M98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GKNThv0XRolnaLczR77dCdC75VlcknWwP57/HG5P8bTFRqyUNtA0xO+Eai7mN+WV2
	 yhp/ON7GYkF1m7UniGuk2KgUmf9+akV6ZJaxpGCpZmLXSk3cEG96sUGm5p2y5jnCYN
	 gfeNJ5MqvHNUG8/hZX1YGvFxp+HT69ptxjmQ91Iw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbfBOC3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:29:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391311AbfBOCNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:13:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C1AC206BA;
        Fri, 15 Feb 2019 02:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196785;
        bh=eiBabLThfvITQaflfLrUTq4NoTkOQKfHZWI7tFM+M98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HmP/cMRFOQkeJcdDOJV2FCiZolNpVrnCcfKrTxJDcbdWu6BEO5Wmjr4Gsk9UNtfjC
         cD6DjkOH/bu6ouk1z/taDuw87lMwMa/hVzqbbPZpEBscyXO+Ug0GcfiqhLeBrHDZsw
         5nH+qFIv/AHuqfVciQ7VfZ5xyy4+jBvii8lNLuDY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 63/65] KVM: nSVM: clear events pending from svm_complete_interrupts() when exiting to L1
Date:   Thu, 14 Feb 2019 21:11:19 -0500
Message-Id: <20190215021121.177674-63-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit 619ad846fc3452adaf71ca246c5aa711e2055398 ]

kvm-unit-tests' eventinj "NMI failing on IDT" test results in NMI being
delivered to the host (L1) when it's running nested. The problem seems to
be: svm_complete_interrupts() raises 'nmi_injected' flag but later we
decide to reflect EXIT_NPF to L1. The flag remains pending and we do NMI
injection upon entry so it got delivered to L1 instead of L2.

It seems that VMX code solves the same issue in prepare_vmcs12(), this was
introduced with code refactoring in commit 5f3d5799974b ("KVM: nVMX: Rework
event injection and recovery").

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 4f9cc07a67d8..d7073dffa39f 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3399,6 +3399,14 @@ static int nested_svm_vmexit(struct vcpu_svm *svm)
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
2.19.1

