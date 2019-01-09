Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9771C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B1020859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfAIRXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:23:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfAIRXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:23:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3AB377E9CF;
        Wed,  9 Jan 2019 17:23:00 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 383755C5DF;
        Wed,  9 Jan 2019 17:22:58 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH] x86/kvm/nVMX: don't skip emulated instruction twice when vmptr address is not backed
Date:   Wed,  9 Jan 2019 18:22:56 +0100
Message-Id: <20190109172256.16711-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 09 Jan 2019 17:23:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 09abb5e3e5e50 ("KVM: nVMX: call kvm_skip_emulated_instruction
in nested_vmx_{fail,succeed}") nested_vmx_failValid() results in
kvm_skip_emulated_instruction() so doing it again in handle_vmptrld() when
vmptr address is not backed is wrong, we end up advancing RIP twice.

Fixes: fca91f6d60b6e ("kvm: nVMX: Set VM instruction error for VMPTRLD of unbacked page")
Reported-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 3170e291215d..2616bd2c7f2c 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4540,9 +4540,8 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 			 * given physical address won't match the required
 			 * VMCS12_REVISION identifier.
 			 */
-			nested_vmx_failValid(vcpu,
+			return nested_vmx_failValid(vcpu,
 				VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID);
-			return kvm_skip_emulated_instruction(vcpu);
 		}
 		new_vmcs12 = kmap(page);
 		if (new_vmcs12->hdr.revision_id != VMCS12_REVISION ||
-- 
2.20.1

