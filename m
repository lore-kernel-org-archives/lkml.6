Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E22C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8082070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfBVQqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:46:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbfBVQqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 11:46:20 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DFCF13688B;
        Fri, 22 Feb 2019 16:46:19 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86F545D70D;
        Fri, 22 Feb 2019 16:46:18 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/kvm/mmu: make mmu->prev_roots cache work for NPT case
Date:   Fri, 22 Feb 2019 17:46:16 +0100
Message-Id: <20190222164616.13859-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 22 Feb 2019 16:46:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that fast_cr3_switch() always fails when we switch back from L2
to L1 as it is not able to find a cached root. This is odd: host's CR3
usually stays the same, we expect to always follow the fast path. Turns
out the problem is that page role is always mismatched because
kvm_mmu_get_page() filters out cr4_pae when direct, the value is stored
in page header and later compared with new_role in cached_root_available().
As cr4_pae is always set in long mode prev_roots cache is dysfunctional.

The problem appeared after we introduced kvm_calc_mmu_role_common():
previously, we were only setting this bit for shadow MMU root but now
we set it for everything. Restore the original behavior.

Fixes: 7dcd57552008 ("x86/kvm/mmu: check if tdp/shadow MMU reconfiguration is needed")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
RFC:
Alternatively, I can suggest two solutions:
- Do not clear cr4_pae in kvm_mmu_get_page() and check direct on call sites
 (detect_write_misaligned(), get_written_sptes()).
- Filter cr4_pae out when direct in kvm_mmu_new_cr3().
The code in kvm_mmu_get_page() is very ancient, I'm afraid to touch it :=)
---
 arch/x86/kvm/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index f2d1d230d5b8..c729e98eee49 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4791,7 +4791,6 @@ static union kvm_mmu_role kvm_calc_mmu_role_common(struct kvm_vcpu *vcpu,
 
 	role.base.access = ACC_ALL;
 	role.base.nxe = !!is_nx(vcpu);
-	role.base.cr4_pae = !!is_pae(vcpu);
 	role.base.cr0_wp = is_write_protection(vcpu);
 	role.base.smm = is_smm(vcpu);
 	role.base.guest_mode = is_guest_mode(vcpu);
@@ -4871,6 +4870,8 @@ kvm_calc_shadow_mmu_root_page_role(struct kvm_vcpu *vcpu, bool base_only)
 {
 	union kvm_mmu_role role = kvm_calc_mmu_role_common(vcpu, base_only);
 
+	role.base.cr4_pae = !!is_pae(vcpu);
+
 	role.base.smep_andnot_wp = role.ext.cr4_smep &&
 		!is_write_protection(vcpu);
 	role.base.smap_andnot_wp = role.ext.cr4_smap &&
-- 
2.20.1

