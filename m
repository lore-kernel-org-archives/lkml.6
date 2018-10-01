Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F992C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8A2208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8A2208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbeJAU6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:58:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35407 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729575AbeJAU6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:58:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5DF978046B;
        Mon,  1 Oct 2018 14:20:37 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-59.brq.redhat.com [10.40.204.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D72466E520;
        Mon,  1 Oct 2018 14:20:34 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/9] x86/kvm/mmu.c: set get_pdptr hook in kvm_init_shadow_ept_mmu()
Date:   Mon,  1 Oct 2018 16:20:03 +0200
Message-Id: <20181001142010.21132-3-vkuznets@redhat.com>
In-Reply-To: <20181001142010.21132-1-vkuznets@redhat.com>
References: <20181001142010.21132-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 01 Oct 2018 14:20:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_init_shadow_ept_mmu() doesn't set get_pdptr() hook and is this
not a problem just because MMU context is already initialized and this
hook points to kvm_pdptr_read(). As we're intended to use a dedicated
MMU for shadow EPT MMU set this hook explicitly.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
Changes since v2:
- move get_pdptr setting to nested_ept_init_mmu_context()
  [Sean Christopherson]
---
 arch/x86/kvm/mmu.c | 1 +
 arch/x86/kvm/vmx.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index ca79ec0d8060..89cd5aafcec8 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4846,6 +4846,7 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 	context->root_level = PT64_ROOT_4LEVEL;
 	context->direct_map = false;
 	context->base_role.word = root_page_role.word & mmu_base_role_mask.word;
+
 	update_permission_bitmask(vcpu, context, true);
 	update_pkru_bitmask(vcpu, context, true);
 	update_last_nonleaf_level(vcpu, context);
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 4b8dc85afe34..1ca5ff4d5d97 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11339,6 +11339,7 @@ static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu->set_cr3           = vmx_set_cr3;
 	vcpu->arch.mmu->get_cr3           = nested_ept_get_cr3;
 	vcpu->arch.mmu->inject_page_fault = nested_ept_inject_page_fault;
+	vcpu->arch.mmu->get_pdptr         = kvm_pdptr_read;
 
 	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
 	return 0;
-- 
2.17.1

