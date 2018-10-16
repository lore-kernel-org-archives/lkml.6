Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7508C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D60E21470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D60E21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeJQAlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:41:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbeJQAly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:41:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 783AE285B0;
        Tue, 16 Oct 2018 16:50:38 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FD326BF7B;
        Tue, 16 Oct 2018 16:50:36 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v6 08/13] x86/kvm/lapic: preserve gfn_to_hva_cache len on cache reinit
Date:   Tue, 16 Oct 2018 18:50:06 +0200
Message-Id: <20181016165011.6607-9-vkuznets@redhat.com>
In-Reply-To: <20181016165011.6607-1-vkuznets@redhat.com>
References: <20181016165011.6607-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 16 Oct 2018 16:50:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vcpu->arch.pv_eoi is accessible through both HV_X64_MSR_VP_ASSIST_PAGE and
MSR_KVM_PV_EOI_EN so on migration userspace may try to restore them in any
order. Values match, however, kvm_lapic_enable_pv_eoi() uses different
length: for Hyper-V case it's the whole struct hv_vp_assist_page, for KVM
native case it is 8. In case we restore KVM-native MSR last cache will
be reinitialized with len=8 so trying to access VP assist page beyond
8 bytes with kvm_read_guest_cached() will fail.

Check if we re-initializing cache for the same address and preserve length
in case it was greater.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/lapic.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 79358fd6a71c..3cd227ff807f 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2647,14 +2647,22 @@ int kvm_hv_vapic_msr_read(struct kvm_vcpu *vcpu, u32 reg, u64 *data)
 int kvm_lapic_enable_pv_eoi(struct kvm_vcpu *vcpu, u64 data, unsigned long len)
 {
 	u64 addr = data & ~KVM_MSR_ENABLED;
+	struct gfn_to_hva_cache *ghc = &vcpu->arch.pv_eoi.data;
+	unsigned long new_len;
+
 	if (!IS_ALIGNED(addr, 4))
 		return 1;
 
 	vcpu->arch.pv_eoi.msr_val = data;
 	if (!pv_eoi_enabled(vcpu))
 		return 0;
-	return kvm_gfn_to_hva_cache_init(vcpu->kvm, &vcpu->arch.pv_eoi.data,
-					 addr, len);
+
+	if (addr == ghc->gpa && len <= ghc->len)
+		new_len = ghc->len;
+	else
+		new_len = len;
+
+	return kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, addr, new_len);
 }
 
 void kvm_apic_accept_events(struct kvm_vcpu *vcpu)
-- 
2.17.1

