Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD7EC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AAF2588C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9J5tn4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AAF2588C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933635AbeFYMFS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:05:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39464 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933505AbeFYMFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:05:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so9678612wmc.4;
        Mon, 25 Jun 2018 05:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Axp6xn5PBPRXBzL4xZ6zEI9ONg2Tro3BmRY/1zXJyBA=;
        b=R9J5tn4aNN8MYYh5e/NhklEtezb7a1vV0Qt9NQF7mGTLCCLnw9s46GTvFBoGvrEpri
         BDniIn2/difosKlrkVtBLFiovJ4zW4Qhg7dsWM5yosWK0LRLfLMZ+MpfjCSowqCfAmfG
         XDSD/DR8k5jz9Y8oEuz0tS8vno/bhXM2zXzH+3OYCw7wOmZ3IjBiVpOQAF/2dM30py6H
         OCslx1BGX2cOVeXEsiuz3AwChe9oflFv5fJeDHRhc5pYdQ0u+M8uNSJHwYuq30AebyM8
         LuK3w0wOP2uAsdPI7nc5c8KZxPM+9c/JU2doQVh7ptXxH4xOPFuuRnQt3oFe15+Efzs7
         aSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Axp6xn5PBPRXBzL4xZ6zEI9ONg2Tro3BmRY/1zXJyBA=;
        b=cPZIw4ZeWtWnupVBtehQ56jegY/Su+11qw8TIreOSMcz3hbENejHh/SqI4o+RzCMLR
         pnK0srGjzR5mj/5NEO+rnsVXEI56iUIZlWBBQQXCubAGUVwBhsSDkugmQP78IXxiKlgj
         VwZMEX+IQcM38OrAuIsQerlNcwb7jlse03AhBFM6LIpKH+jhlF/z9EA+niMkzgGbOab5
         91lK0vqvTijRfR0UINtifK5Kaw9ilx78G598WkOh49CAQYqq+Znd56/Ph8WwmH4Y5aN/
         3yIMgGPNM48ojYbKsHFMZH8V6zk0oLtRrDqCUDczJK2R/pR0dclxp4ZRq4wwdOoz7Zcf
         YYEw==
X-Gm-Message-State: APt69E3VyRaNMmUruILI2JT1+vUt0L9Xpvb6SlNi4lxDDdSUeqTYggZh
        WYMwLNDONIdCyhdbe66Zqtj2VFFN
X-Google-Smtp-Source: ADUXVKLN67kGNEepppy+ysUyvgi54rP9oC/Ds2WhqdK0N81PGXO0jjL9JlLEGxnhUuMPhzdNb9dOEQ==
X-Received: by 2002:a1c:8cd:: with SMTP id 196-v6mr872930wmi.46.1529928310267;
        Mon, 25 Jun 2018 05:05:10 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111])
        by smtp.gmail.com with ESMTPSA id n10-v6sm16377196wrs.64.2018.06.25.05.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 05:05:09 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     robert.hu@linux.intel.com
Subject: [PATCH] KVM: VMX: support MSR_IA32_ARCH_CAPABILITIES as a feature MSR
Date:   Mon, 25 Jun 2018 14:04:37 +0200
Message-Id: <1529928277-22739-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This lets userspace read the MSR_IA32_ARCH_CAPABILITIES and check that all
requested features are available on the host.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c88ed554bb66..a029f9fca993 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1097,6 +1097,7 @@ bool kvm_rdpmc(struct kvm_vcpu *vcpu)
 
 	MSR_F10H_DECFG,
 	MSR_IA32_UCODE_REV,
+	MSR_IA32_ARCH_CAPABILITIES,
 };
 
 static unsigned int num_msr_based_features;
@@ -1105,7 +1106,8 @@ static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
 {
 	switch (msr->index) {
 	case MSR_IA32_UCODE_REV:
-		rdmsrl(msr->index, msr->data);
+	case MSR_IA32_ARCH_CAPABILITIES:
+		rdmsrl_safe(msr->index, &msr->data);
 		break;
 	default:
 		if (kvm_x86_ops->get_msr_feature(msr))
-- 
1.8.3.1

