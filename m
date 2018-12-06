Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE96C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F81720989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDW/bu3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F81720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbeLFHeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:34:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45406 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbeLFHet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:34:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so11359492plm.12;
        Wed, 05 Dec 2018 23:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Wflgf3vXwnh/NSYRkoySbbMJEXzxzoKSWgrFRBiNdkE=;
        b=DDW/bu3pOGbmLFs1yK/UylRVgagoX1wPc5aftiH/T7idPyQhx6XIlWnPoPJ2Ziu0oA
         7Gcwa3WGBm+bS/55zmwuw6wgT3n2t9mZ2h870Tv7VkgOMmFt0d/k+euTvRGHdf1zyqd1
         wwXDhjMseD+P1y+mAirWrIfiiwjmds4ilQEW4bswUwa1mH6dLjcHviVPpkmQLYqg922z
         7IdS49l6MI7U9GjdUORdoWIRf4XkLfbmMKMyqthmgSIar9Jt5+zlk5xsI7HBdXAVX4Xr
         UR23AcOFiRK0OL8Jq2TZzz5ZhgTvAogZcCkaBCg8R6gMlZm4FEzwSYWZgfsZIhP2nJRO
         sYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wflgf3vXwnh/NSYRkoySbbMJEXzxzoKSWgrFRBiNdkE=;
        b=YMP3KrHcy7jxQlUTKLlYBzb0aPAPTXFB1Ui25iXhnPV1KuNaAMwMKvDeBbxkXZbVjv
         6UmSDaB7UDiGzVlIwfszFQ5GNt5mX5urPyDPq8dlfkH7FATh3BzUMHCQ1EzCXsjWmQc7
         g+59Guj8D8h3w5OZi8iAN6P6mdH05ibTxsMsflGhmfXKFBLmg94/tyb3COuFhDnleGBQ
         19xkXovK61/xhBUqnWjZO/LgVnwpJSTr+BdT+W6J9DcNQ7s/vdIGimlOXWHQusidliO+
         Br1viZAK9ofIbcf3CljCdt5o48Mb808ZPC69OiPoTDOI8uEy7yG06I3A1Mjx3LFuzZSX
         yq4Q==
X-Gm-Message-State: AA+aEWYcmRPmOBQkcnAglk9M67YGwF1QqISB450Ict2oCRvs2Vo1UjqN
        Zpakqx3LAQrC3Qm8++wdtzo=
X-Google-Smtp-Source: AFSGD/UWxQ0d3461omH+E90NdX6NrbxSjZp2M+O/LZAdqhCFeh+2ka9OMqUzBBHYRW/VdeObw55XcQ==
X-Received: by 2002:a17:902:b282:: with SMTP id u2mr27570866plr.89.1544081689162;
        Wed, 05 Dec 2018 23:34:49 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id x3sm70418768pgt.45.2018.12.05.23.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 23:34:48 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com
Subject: [PATCH V2 1/2] KVM/VMX: Check ept_pointer before flushing ept tlb
Date:   Thu,  6 Dec 2018 15:34:36 +0800
Message-Id: <20181206073437.1995-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to initialize ept_pointer to INVALID_PAGE and check it
before flushing ept tlb. If ept_pointer is invalid, bypass the flush
request.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/vmx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index c379d0bfdcba..6577ec8cbb0f 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1582,11 +1582,18 @@ static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
 	/*
 	 * FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE hypercall needs the address of the
 	 * base of EPT PML4 table, strip off EPT configuration information.
+	 * If ept_pointer is invalid pointer, bypass the flush request.
 	 */
 	if (to_kvm_vmx(kvm)->ept_pointers_match != EPT_POINTERS_MATCH) {
-		kvm_for_each_vcpu(i, vcpu, kvm)
+		kvm_for_each_vcpu(i, vcpu, kvm) {
+			u64 ept_pointer = to_vmx(vcpu)->ept_pointer;
+
+			if (!VALID_PAGE(ept_pointer))
+				continue;
+
 			ret |= hyperv_flush_guest_mapping(
-				to_vmx(kvm_get_vcpu(kvm, i))->ept_pointer & PAGE_MASK);
+				ept_pointer & PAGE_MASK);
+		}
 	} else {
 		ret = hyperv_flush_guest_mapping(
 				to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer & PAGE_MASK);
@@ -11614,6 +11621,8 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 	vmx->pi_desc.nv = POSTED_INTR_VECTOR;
 	vmx->pi_desc.sn = 1;
 
+	vmx->ept_pointer = INVALID_PAGE;
+
 	return &vmx->vcpu;
 
 free_vmcs:
-- 
2.14.4

