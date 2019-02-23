Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138A7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 11:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFA5206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 11:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfBWLP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 06:15:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbfBWLP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 06:15:57 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA1B6307DABC;
        Sat, 23 Feb 2019 11:15:56 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-48.brq.redhat.com [10.40.204.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BC051001E9A;
        Sat, 23 Feb 2019 11:15:54 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 RFC] x86/kvm/mmu: make mmu->prev_roots cache work for NPT case
Date:   Sat, 23 Feb 2019 12:15:52 +0100
Message-Id: <20190223111552.27221-1-vkuznets@redhat.com>
In-Reply-To: <0c13c94e-3226-8bfd-2dc7-c75aad1c03a2@redhat.com>
References: <0c13c94e-3226-8bfd-2dc7-c75aad1c03a2@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sat, 23 Feb 2019 11:15:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alternative patch: remove the filtering from kvm_mmu_get_page() and check
for direct on call sites. cr4_pae setting in kvm_calc_mmu_role_common()
can be preserved for consistency.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/mmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index f2d1d230d5b8..7fb8118f2af6 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -2420,8 +2420,6 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 	role = vcpu->arch.mmu->mmu_role.base;
 	role.level = level;
 	role.direct = direct;
-	if (role.direct)
-		role.cr4_pae = 0;
 	role.access = access;
 	if (!vcpu->arch.mmu->direct_map
 	    && vcpu->arch.mmu->root_level <= PT32_ROOT_LEVEL) {
@@ -5176,7 +5174,7 @@ static bool detect_write_misaligned(struct kvm_mmu_page *sp, gpa_t gpa,
 		 gpa, bytes, sp->role.word);
 
 	offset = offset_in_page(gpa);
-	pte_size = sp->role.cr4_pae ? 8 : 4;
+	pte_size = (sp->role.cr4_pae && !sp->role.direct) ? 8 : 4;
 
 	/*
 	 * Sometimes, the OS only writes the last one bytes to update status
@@ -5200,7 +5198,7 @@ static u64 *get_written_sptes(struct kvm_mmu_page *sp, gpa_t gpa, int *nspte)
 	page_offset = offset_in_page(gpa);
 	level = sp->role.level;
 	*nspte = 1;
-	if (!sp->role.cr4_pae) {
+	if (!sp->role.cr4_pae || sp->role.direct) {
 		page_offset <<= 1;	/* 32->64 */
 		/*
 		 * A 32-bit pde maps 4MB while the shadow pdes map
-- 
2.20.1

