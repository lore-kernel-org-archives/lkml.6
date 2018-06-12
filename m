Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 41BDDC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFE7208B4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkXS0oVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFE7208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935025AbeFLQu0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934882AbeFLQsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:48:02 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB004208B8;
        Tue, 12 Jun 2018 16:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822082;
        bh=OLFpDrXrtl2zWLXxpZ6L98RviF6WcoQY6N+T1o6tSZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kkXS0oVG+uJbICrP+k4jN3ykT37+S4pEiQfoeri3NYO+06LiEu5Nlxgx/ZPSxa6FI
         MD8Av1Iv5cIoYz1QEgAsA62p9gd4Ow0sDFy1j1Lj2/YpsibgTJ1kWh2S2H3ISQSq2+
         dKfq37iiczRBeks3EWxbDezu8fckIHP8HQX3+GvY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, kvm@vger.kernel.org
Subject: [PATCH 4.9 28/31] KVM: VMX: Expose SSBD properly to guests, 4.9 supplement
Date:   Tue, 12 Jun 2018 18:46:31 +0200
Message-Id: <20180612164621.898625630@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164620.797338191@linuxfoundation.org>
References: <20180612164620.797338191@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

Fix an additional misuse of X86_FEATURE_SSBD in
guest_cpuid_has_spec_ctrl().  This function was introduced in the
backport of SSBD support to 4.9 and is not present upstream, so it was
not fixed by commit 43462d908821 "KVM: VMX: Expose SSBD properly to
guests."

Fixes: 52817587e706 ("x86/cpufeatures: Disentangle SSBD enumeration")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: kvm@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/cpuid.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -179,7 +179,7 @@ static inline bool guest_cpuid_has_spec_
 	if (best && (best->ebx & bit(X86_FEATURE_AMD_IBRS)))
 		return true;
 	best = kvm_find_cpuid_entry(vcpu, 7, 0);
-	return best && (best->edx & (bit(X86_FEATURE_SPEC_CTRL) | bit(X86_FEATURE_SSBD)));
+	return best && (best->edx & (bit(X86_FEATURE_SPEC_CTRL) | bit(X86_FEATURE_SPEC_CTRL_SSBD)));
 }
 
 static inline bool guest_cpuid_has_arch_capabilities(struct kvm_vcpu *vcpu)


