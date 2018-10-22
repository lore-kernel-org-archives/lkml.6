Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3347C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA13B20881
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qj8bG4xF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA13B20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbeJVShs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728793AbeJVShr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:37:47 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C738020658;
        Mon, 22 Oct 2018 10:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203592;
        bh=Qe0+i5d/xo2r7SB75+kno1Z1xwgbD6jHEKENUIjavIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qj8bG4xF4PQDQzv1VAAmTjeeGrN1QmFaGpdK1ovPwpux4Wt1slW+5bJLBpLYGXDgy
         Fp4wDExFH68FvHY9idQQeM36OeCq2kAJsLnVS5DmRSyEfye2IQfOJ6OVHk764+bKrk
         gwR4gpkrtspEpaA129nzyjK9tSwZktcK8MGMpAEM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 14/27] KVM: x86: support CONFIG_KVM_AMD=y with CONFIG_CRYPTO_DEV_CCP_DD=m
Date:   Mon, 22 Oct 2018 06:19:11 -0400
Message-Id: <20181022101924.40531-14-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022101924.40531-1-sashal@kernel.org>
References: <20181022101924.40531-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit 853c110982eaff0d99dace3f66f1ba58b5bfd9d5 ]

SEV requires access to the AMD cryptographic device APIs, and this
does not work when KVM is builtin and the crypto driver is a module.
Actually the Kconfig conditions for CONFIG_KVM_AMD_SEV try to disable
SEV in that case, but it does not work because the actual crypto
calls are not culled, only sev_hardware_setup() is.

This patch adds two CONFIG_KVM_AMD_SEV checks that gate all the remaining
SEV code; it fixes this particular configuration, and drops 5 KiB of
code when CONFIG_KVM_AMD_SEV=n.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index ef772e5634d4..3e59a187fe30 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -436,14 +436,18 @@ static inline struct kvm_svm *to_kvm_svm(struct kvm *kvm)
 
 static inline bool svm_sev_enabled(void)
 {
-	return max_sev_asid;
+	return IS_ENABLED(CONFIG_KVM_AMD_SEV) ? max_sev_asid : 0;
 }
 
 static inline bool sev_guest(struct kvm *kvm)
 {
+#ifdef CONFIG_KVM_AMD_SEV
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
 
 	return sev->active;
+#else
+	return false;
+#endif
 }
 
 static inline int sev_get_asid(struct kvm *kvm)
-- 
2.17.1

