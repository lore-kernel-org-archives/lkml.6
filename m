Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F019DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B418421533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B418421533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbeIZXRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:17:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728823AbeIZXRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:17:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05DEA30001E2;
        Wed, 26 Sep 2018 17:03:29 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B576C60BE7;
        Wed, 26 Sep 2018 17:03:17 +0000 (UTC)
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
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/7] KVM: x86: hyperv: valid_bank_mask should be 'u64'
Date:   Wed, 26 Sep 2018 19:02:57 +0200
Message-Id: <20180926170259.29796-6-vkuznets@redhat.com>
In-Reply-To: <20180926170259.29796-1-vkuznets@redhat.com>
References: <20180926170259.29796-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 26 Sep 2018 17:03:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This probably doesn't matter much (KVM_MAX_VCPUS is much lower nowadays)
but valid_bank_mask is really u64 and not unsigned long.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 6a19c8e3c432..eeb12eacd525 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1300,7 +1300,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
 	struct hv_tlb_flush flush;
 	struct kvm_vcpu *vcpu;
 	unsigned long vcpu_bitmap[BITS_TO_LONGS(KVM_MAX_VCPUS)] = {0};
-	unsigned long valid_bank_mask = 0;
+	u64 valid_bank_mask = 0;
 	u64 sparse_banks[64];
 	int sparse_banks_len, i;
 	bool all_cpus;
@@ -1328,7 +1328,8 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *current_vcpu, u64 ingpa,
 		all_cpus = flush_ex.hv_vp_set.format !=
 			HV_GENERIC_SET_SPARSE_4K;
 
-		sparse_banks_len = bitmap_weight(&valid_bank_mask, 64) *
+		sparse_banks_len =
+			bitmap_weight((unsigned long *)&valid_bank_mask, 64) *
 			sizeof(sparse_banks[0]);
 
 		if (!sparse_banks_len && !all_cpus)
-- 
2.17.1

