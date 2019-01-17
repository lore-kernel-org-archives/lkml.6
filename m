Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BEFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAAC20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfAQRMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:12:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfAQRMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:12:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C6D12CD817;
        Thu, 17 Jan 2019 17:12:18 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B7C15E7AF;
        Thu, 17 Jan 2019 17:12:15 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>
Subject: [PATCH 1/2] x86/kvm/hyper-v: nested_enable_evmcs() sets vmcs_version incorrectly
Date:   Thu, 17 Jan 2019 18:12:09 +0100
Message-Id: <20190117171210.9493-2-vkuznets@redhat.com>
In-Reply-To: <20190117171210.9493-1-vkuznets@redhat.com>
References: <20190117171210.9493-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 17 Jan 2019 17:12:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e2e871ab2f02 ("x86/kvm/hyper-v: Introduce nested_get_evmcs_version()
helper") broke EVMCS enablement: to set vmcs_version we now call
nested_get_evmcs_version() but this function checks
enlightened_vmcs_enabled flag which is not yet set so we end up returning
zero.

Fix the issue by re-arranging things in nested_enable_evmcs().

Fixes: e2e871ab2f02 ("x86/kvm/hyper-v: Introduce nested_get_evmcs_version() helper")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/evmcs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
index 95bc2247478d..5466c6d85cf3 100644
--- a/arch/x86/kvm/vmx/evmcs.c
+++ b/arch/x86/kvm/vmx/evmcs.c
@@ -332,16 +332,17 @@ int nested_enable_evmcs(struct kvm_vcpu *vcpu,
 			uint16_t *vmcs_version)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	bool evmcs_already_enabled = vmx->nested.enlightened_vmcs_enabled;
+
+	vmx->nested.enlightened_vmcs_enabled = true;
 
 	if (vmcs_version)
 		*vmcs_version = nested_get_evmcs_version(vcpu);
 
 	/* We don't support disabling the feature for simplicity. */
-	if (vmx->nested.enlightened_vmcs_enabled)
+	if (evmcs_already_enabled)
 		return 0;
 
-	vmx->nested.enlightened_vmcs_enabled = true;
-
 	vmx->nested.msrs.pinbased_ctls_high &= ~EVMCS1_UNSUPPORTED_PINCTRL;
 	vmx->nested.msrs.entry_ctls_high &= ~EVMCS1_UNSUPPORTED_VMENTRY_CTRL;
 	vmx->nested.msrs.exit_ctls_high &= ~EVMCS1_UNSUPPORTED_VMEXIT_CTRL;
-- 
2.20.1

