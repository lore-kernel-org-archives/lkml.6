Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3195DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD85214C1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD85214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeLETT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:19:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbeLETT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:19:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D0C6985362;
        Wed,  5 Dec 2018 19:19:58 +0000 (UTC)
Received: from localhost (ovpn-116-33.gru2.redhat.com [10.97.116.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 489BD5D96E;
        Wed,  5 Dec 2018 19:19:58 +0000 (UTC)
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] kvm: x86: Report STIBP on GET_SUPPORTED_CPUID
Date:   Wed,  5 Dec 2018 17:19:56 -0200
Message-Id: <20181205191956.31480-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 05 Dec 2018 19:19:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Months ago, we have added code to allow direct access to MSR_IA32_SPEC_CTRL
to the guest, which makes STIBP available to guests.  This was implemented
by commits d28b387fb74d ("KVM/VMX: Allow direct access to
MSR_IA32_SPEC_CTRL") and b2ac58f90540 ("KVM/SVM: Allow direct access to
MSR_IA32_SPEC_CTRL").

However, we never updated GET_SUPPORTED_CPUID to let userspace know that
STIBP can be enabled in CPUID.  Fix that by updating
kvm_cpuid_8000_0008_ebx_x86_features and kvm_cpuid_7_0_edx_x86_features.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/kvm/cpuid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 7bcfa61375c0..cc6dd65828a4 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -381,7 +381,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 	/* cpuid 0x80000008.ebx */
 	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
 		F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSBD) |
-		F(AMD_SSB_NO);
+		F(AMD_SSB_NO) | F(AMD_STIBP);
 
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_cpuid_C000_0001_edx_x86_features =
@@ -411,7 +411,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
 		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
-		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES);
+		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | F(INTEL_STIBP);
 
 	/* all calls to cpuid_count() should be made on the same cpu */
 	get_cpu();
-- 
2.18.0.rc1.1.g3f1ff2140

