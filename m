Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAFAC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DDC2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfznrV8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DDC2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbeKCDwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbeKCDwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:52:49 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11EFD20847;
        Fri,  2 Nov 2018 18:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184276;
        bh=AHwcKnbHe3R7oTji2ieRPEmiiK1pBY5RkvwuWFLLlIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RfznrV8j1w6aIjDJO5x26M/27MqEAjCTeiynDm5vCoQmfjCM2qUjHM+PEUo7R63ut
         WKdb/L4fsr5MXF/w9O0PgAID/wbHxv7Fw0p7uy3dozxRn2eEKtnTzpyIAf0zZp4GuA
         hOteZ5gZUk2JpAlwDmXNOI2Io6Z8gQbcBRpe+WX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 087/150] KVM: x86: support CONFIG_KVM_AMD=y with CONFIG_CRYPTO_DEV_CCP_DD=m
Date:   Fri,  2 Nov 2018 19:34:09 +0100
Message-Id: <20181102182909.567471217@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



