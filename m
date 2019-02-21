Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B14C10F07
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FC02146E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfBUBWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:22:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfBUBWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:22:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 349DD307D911;
        Thu, 21 Feb 2019 01:22:52 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-249.rdu2.redhat.com [10.10.120.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B468F60BF2;
        Thu, 21 Feb 2019 01:22:50 +0000 (UTC)
From:   jglisse@redhat.com
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/1] kvm/mmu_notifier: re-enable the change_pte() optimization.
Date:   Wed, 20 Feb 2019 20:22:27 -0500
Message-Id: <20190221012227.13236-2-jglisse@redhat.com>
In-Reply-To: <20190221012227.13236-1-jglisse@redhat.com>
References: <20190221012227.13236-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 21 Feb 2019 01:22:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Since changes to mmu notifier the change_pte() optimization was lost
for kvm. This re-enable it, when ever a pte is going from read and
write to read only with same pfn, or from read only to read and write
with different pfn.

It is safe to update the secondary MMUs, because the primary MMU
pte invalidate must have already happened with a ptep_clear_flush()
before set_pte_at_notify() is invoked (and thus before change_pte()
callback).

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 virt/kvm/kvm_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 629760c0fb95..0f979f02bf1c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -369,6 +369,14 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
 	int need_tlb_flush = 0, idx;
 	int ret;
 
+	/*
+	 * Nothing to do when using change_pte() which will be call for each
+	 * individual pte update at the right time. See mmu_notifier.h for more
+	 * informations.
+	 */
+	if (mmu_notifier_range_use_change_pte(range))
+		return 0;
+
 	idx = srcu_read_lock(&kvm->srcu);
 	spin_lock(&kvm->mmu_lock);
 	/*
@@ -399,6 +407,14 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 {
 	struct kvm *kvm = mmu_notifier_to_kvm(mn);
 
+	/*
+	 * Nothing to do when using change_pte() which will be call for each
+	 * individual pte update at the right time. See mmu_notifier.h for more
+	 * informations.
+	 */
+	if (mmu_notifier_range_use_change_pte(range))
+		return;
+
 	spin_lock(&kvm->mmu_lock);
 	/*
 	 * This sequence increase will notify the kvm page fault that
-- 
2.17.2

