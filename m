Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F5BC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB74214AE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789376;
	bh=xKkXIsuNqVXQulI+2J5M1R6aZsCXnu+b9bbOYvhqNr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I5ufW8xgLaK9wiuyt8Ta1yySNvivT593RIewzBg4a1r9/i9uHSU942e8wtE6DrW+M
	 oUn9e7cjrtJDrx4/empZJhcgcDPU9mEY+QhOZ0X8mhIJLAl7aMkxLNO6B25x6yEjVE
	 BsZWvs/xOnX8s6u79j48Jcr5yGF1HRkoxIqZGcT4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB74214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731484AbeLNMJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:09:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731125AbeLNMJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:09:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1275B2147D;
        Fri, 14 Dec 2018 12:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789369;
        bh=xKkXIsuNqVXQulI+2J5M1R6aZsCXnu+b9bbOYvhqNr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NIlQngg4FYycugii3nnnH2JzAZPgyErnn9GSnA1ValUsM8nKx4iAr2PNPOhvB/1JA
         7cDmbtzBh61w5c5+N7FIxAhweSvog0FG0R2m9EZH+SwfpLfwqta9OmmEJfCMwkGUt1
         kQ4k8MrmP1YcgcIqhaLMpQ9nLkUxYAzA8+UoPWgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 56/89] x86/kvm/vmx: fix old-style function declaration
Date:   Fri, 14 Dec 2018 13:00:09 +0100
Message-Id: <20181214115732.437357569@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1e4329ee2c52692ea42cc677fb2133519718b34a ]

The inline keyword which is not at the beginning of the function
declaration may trigger the following build warnings, so let's fix it:

arch/x86/kvm/vmx.c:1309:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
arch/x86/kvm/vmx.c:5947:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
arch/x86/kvm/vmx.c:5985:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
arch/x86/kvm/vmx.c:6023:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index ec588cf4fe95..4353580b659a 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1089,7 +1089,7 @@ static void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked);
 static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
 					    u16 error_code);
 static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
-static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
 							  u32 msr, int type);
 
 static DEFINE_PER_CPU(struct vmcs *, vmxarea);
@@ -5227,7 +5227,7 @@ static void free_vpid(int vpid)
 	spin_unlock(&vmx_vpid_lock);
 }
 
-static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
 							  u32 msr, int type)
 {
 	int f = sizeof(unsigned long);
@@ -5262,7 +5262,7 @@ static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bit
 	}
 }
 
-static void __always_inline vmx_enable_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_enable_intercept_for_msr(unsigned long *msr_bitmap,
 							 u32 msr, int type)
 {
 	int f = sizeof(unsigned long);
@@ -5297,7 +5297,7 @@ static void __always_inline vmx_enable_intercept_for_msr(unsigned long *msr_bitm
 	}
 }
 
-static void __always_inline vmx_set_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_set_intercept_for_msr(unsigned long *msr_bitmap,
 			     			      u32 msr, int type, bool value)
 {
 	if (value)
-- 
2.19.1



