Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F81C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F66421771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F66421771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbeHHSQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:16:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729638AbeHHSQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:16:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9DAE040216E7;
        Wed,  8 Aug 2018 15:56:18 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F22621568A3;
        Wed,  8 Aug 2018 15:56:16 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v4 09/12] x86/kvm/nVMX: allow bare VMXON state migration
Date:   Wed,  8 Aug 2018 17:55:49 +0200
Message-Id: <20180808155552.4836-10-vkuznets@redhat.com>
In-Reply-To: <20180808155552.4836-1-vkuznets@redhat.com>
References: <20180808155552.4836-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 08 Aug 2018 15:56:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 08 Aug 2018 15:56:18 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is perfectly valid for a guest to do VMXON and not do VMPTRLD. This
state needs to be preserved on migration.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 377fd91a1a71..6eb86991ca60 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -14132,13 +14132,6 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	if (!page_address_valid(vcpu, kvm_state->vmx.vmxon_pa))
 		return -EINVAL;
 
-	if (kvm_state->size < sizeof(kvm_state) + sizeof(*vmcs12))
-		return -EINVAL;
-
-	if (kvm_state->vmx.vmcs_pa == kvm_state->vmx.vmxon_pa ||
-	    !page_address_valid(vcpu, kvm_state->vmx.vmcs_pa))
-		return -EINVAL;
-
 	if ((kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_GUEST_MODE) &&
 	    (kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE))
 		return -EINVAL;
@@ -14160,6 +14153,14 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	if (ret)
 		return ret;
 
+	/* Empty 'VMXON' state is permitted */
+	if (kvm_state->size < sizeof(kvm_state) + sizeof(*vmcs12))
+		return 0;
+
+	if (kvm_state->vmx.vmcs_pa == kvm_state->vmx.vmxon_pa ||
+	    !page_address_valid(vcpu, kvm_state->vmx.vmcs_pa))
+		return -EINVAL;
+
 	set_current_vmptr(vmx, kvm_state->vmx.vmcs_pa);
 
 	if (kvm_state->vmx.smm.flags & KVM_STATE_NESTED_SMM_VMXON) {
-- 
2.14.4

