Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075FEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC52B206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="glVX89Xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfBVIX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:23:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38682 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVIXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:23:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id m2so795318pgl.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 00:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bgi/EwWWX2Li81Mw0qcYS+JuoX7DsHGY+9JFpKlkgdc=;
        b=glVX89XfORwvW7FkND8gZJzWrHSHwaG4itLrZHBr4FtkNJ6lMhUsHHTNzqDKS+iDZU
         bDGk298KA7z/RP0due2fQziBZ1CPnNU5zcNXON30p1+uPXUpkTTxg1TvH1i771k0me3p
         VAQys7QShIJSO7z3/1EpSU4HBnERZ7ZESzp98tv8XgB37kyCSfqd6sr/13ohOgbRHjEb
         nlVeJ/tRVyyq6BG92HILxgNZs42uQ7uk6hV695t8Hhm07nf1JeSlHTJGs09pQdG2KWox
         DgFleQLZaYeMp2ARvyttG9DHqV1d/+6Dm5adgI16HdcMCRNk1O+awlRX7d4wh396+frB
         zrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bgi/EwWWX2Li81Mw0qcYS+JuoX7DsHGY+9JFpKlkgdc=;
        b=OE/oODjByPe2n9f+PJ/yj1sUST5a2HWdZEwEGzIE/v8+OIo9c3KJJ39emNfVcvmxLe
         k8tsjT3b+Ee035GbVBRbS906/I40z1PfLQTiQQbOm2+iQuw8njkY+ur9B/g/1vy5VKG8
         OOIDViwZ+6JWc7rCkr5sTWdfyNlPEM/Hz24GOqMyCf4Menljsa4xXsVxFE6skVs510A+
         Ls+qAQRMVqeJz5eodAdxdorFFZRtSdeOp6ChdZHBCLvQ+fxd3UtFN2Q/+Qb/5M4EfV7U
         FFVv7sHIKndaJ+3Mt+0k89qavM2Gh/Fw0Mh9ACGQCmNmBRtmiphHy6ORh+5bH3xqK67q
         PTcg==
X-Gm-Message-State: AHQUAuZQa7nP0GJY2h2QYs/CubiBHocf5eZc1YNqB//DbzjjHuwvDBH6
        vwSmMEJI2GtjmtrpCDWyDMRfJQ==
X-Google-Smtp-Source: AHgI3Ia5hNRiwxytszVdshV3NZynVSqQC4W3Tw34lPMYufhILVuh352r8QGCnNq/B8RT2OANfG46xA==
X-Received: by 2002:a62:e716:: with SMTP id s22mr2984891pfh.35.1550823834722;
        Fri, 22 Feb 2019 00:23:54 -0800 (PST)
Received: from localhost.localdomain (li1195-158.members.linode.com. [45.79.96.158])
        by smtp.gmail.com with ESMTPSA id y22sm133821pfn.136.2019.02.22.00.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 00:23:54 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 3/4] KVM: arm/arm64: Define TCR_EL2_T0SZ_MASK as TCR_T0SZ_MASK
Date:   Fri, 22 Feb 2019 16:23:25 +0800
Message-Id: <20190222082327.3312-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222082327.3312-1-leo.yan@linaro.org>
References: <20190222082327.3312-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define macro TCR_EL2_T0SZ_MASK as TCR_T0SZ_MASK, so can remove the hard
number 0x3f.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/include/asm/kvm_arm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 6f602af5263c..d945a787f36e 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -99,7 +99,7 @@
 #define TCR_EL2_SH0_MASK	TCR_SH0_MASK
 #define TCR_EL2_ORGN0_MASK	TCR_ORGN0_MASK
 #define TCR_EL2_IRGN0_MASK	TCR_IRGN0_MASK
-#define TCR_EL2_T0SZ_MASK	0x3f
+#define TCR_EL2_T0SZ_MASK	TCR_T0SZ_MASK
 #define TCR_EL2_MASK	(TCR_EL2_TG0_MASK | TCR_EL2_SH0_MASK | \
 			 TCR_EL2_ORGN0_MASK | TCR_EL2_IRGN0_MASK | TCR_EL2_T0SZ_MASK)
 
-- 
2.17.1

