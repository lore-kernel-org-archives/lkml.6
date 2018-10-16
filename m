Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FDDC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8198F21470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8198F21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeJQAlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:41:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbeJQAlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:41:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE3F03082B23;
        Tue, 16 Oct 2018 16:50:35 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3605D608EE;
        Tue, 16 Oct 2018 16:50:32 +0000 (UTC)
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
Subject: [PATCH v6 07/13] x86/kvm/hyperv: don't clear VP assist pages on init
Date:   Tue, 16 Oct 2018 18:50:05 +0200
Message-Id: <20181016165011.6607-8-vkuznets@redhat.com>
In-Reply-To: <20181016165011.6607-1-vkuznets@redhat.com>
References: <20181016165011.6607-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 16 Oct 2018 16:50:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VP assist pages may hold valuable data which needs to be preserved across
migration. Clean PV EOI portion of the data on init, the guest is
responsible for making sure there's no garbage in the rest.

This will be used for nVMX migration, eVMCS address needs to be preserved.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index d9b7b4cd4e43..4e80080f277a 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1104,7 +1104,13 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 		addr = kvm_vcpu_gfn_to_hva(vcpu, gfn);
 		if (kvm_is_error_hva(addr))
 			return 1;
-		if (__clear_user((void __user *)addr, PAGE_SIZE))
+
+		/*
+		 * Clear apic_assist portion of f(struct hv_vp_assist_page
+		 * only, there can be valuable data in the rest which needs
+		 * to be preserved e.g. on migration.
+		 */
+		if (__clear_user((void __user *)addr, sizeof(u32)))
 			return 1;
 		hv_vcpu->hv_vapic = data;
 		kvm_vcpu_mark_page_dirty(vcpu, gfn);
-- 
2.17.1

