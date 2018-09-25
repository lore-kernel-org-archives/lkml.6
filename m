Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7619C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B66020C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B66020C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeIZAH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:07:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbeIZAH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:07:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A92E3082E24;
        Tue, 25 Sep 2018 17:59:19 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18F2160BEC;
        Tue, 25 Sep 2018 17:59:12 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] x86/kvm/mmu.c: set get_pdptr hook in kvm_init_shadow_ept_mmu()
Date:   Tue, 25 Sep 2018 19:58:37 +0200
Message-Id: <20180925175844.20277-3-vkuznets@redhat.com>
In-Reply-To: <20180925175844.20277-1-vkuznets@redhat.com>
References: <20180925175844.20277-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 25 Sep 2018 17:59:19 +0000 (UTC)
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
---
 arch/x86/kvm/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index ca79ec0d8060..2bdc63f67886 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4846,6 +4846,8 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 	context->root_level = PT64_ROOT_4LEVEL;
 	context->direct_map = false;
 	context->base_role.word = root_page_role.word & mmu_base_role_mask.word;
+	context->get_pdptr = kvm_pdptr_read;
+
 	update_permission_bitmask(vcpu, context, true);
 	update_pkru_bitmask(vcpu, context, true);
 	update_last_nonleaf_level(vcpu, context);
-- 
2.17.1

