Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E954AC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BB920BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BB920BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeGLLoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:44:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726575AbeGLLoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:44:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6B6940201BF;
        Thu, 12 Jul 2018 11:35:08 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 401842156889;
        Thu, 12 Jul 2018 11:35:07 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        x86@kernel.org, Wanpeng Li <kernellwp@gmail.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/kvm/nVMX: set exit_qualification correctly when nested_vmx_load_msr() fails
Date:   Thu, 12 Jul 2018 13:35:05 +0200
Message-Id: <20180712113505.23354-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 11:35:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 11:35:08 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e79f245ddec1 ("X86/KVM: Properly update 'tsc_offset' to represent
the running guest") introduced a regression in enter_vmx_non_root_mode():
when nested_vmx_load_msr() fails exit_qualification needs to point to the
entry number we failed to validate. Intel's SDM states:

"VM-entry failure due to MSR loading. The exit qualification is loaded to
indicate which entry in the VM-entry MSR-load area caused the problem (1
for the first entry, 2 for the second, etc.)."

Fixes: e79f245ddec1 ("X86/KVM: Properly update 'tsc_offset' to represent the running guest")
Reported-by: Wanpeng Li <kernellwp@gmail.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 65968649b365..be468c822892 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11720,8 +11720,10 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu)
 	msr_entry_idx = nested_vmx_load_msr(vcpu,
 					    vmcs12->vm_entry_msr_load_addr,
 					    vmcs12->vm_entry_msr_load_count);
-	if (msr_entry_idx)
+	if (msr_entry_idx) {
+		exit_qual = msr_entry_idx;
 		goto fail;
+	}
 
 	/*
 	 * Note no nested_vmx_succeed or nested_vmx_fail here. At this point
-- 
2.14.4

