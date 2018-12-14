Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61458C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264EF21486
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789177;
	bh=Rp81G6lI+bQ/fTlttJOIYDzpV3n5fV48NqwWTARdPsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fsZrOpwljjmslEOiR5wEXv6c7iWuKHJrKsb2G+q+Aw1m4HKs8upxeuo71/8L9WooF
	 BKgYPsMNP2yy68rXJaa1J5wj0sz5S50x6cGbL/1zMRTZE4RBjBMXwj4jsiIZ2+z+yI
	 TwGrPmSBC6lmhp7xRAC6HgPJNJrxh+EAp+gMvRLE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264EF21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbeLNMGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:06:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729832AbeLNMGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:06:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 599E92147D;
        Fri, 14 Dec 2018 12:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789171;
        bh=Rp81G6lI+bQ/fTlttJOIYDzpV3n5fV48NqwWTARdPsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DZ9xsfQ13A7dowIDerJ2lavVA8k/8HM0b2XIqAOVE+JfxNEXmCwS1U5p4+elIhKHD
         /+gNz3lLSQ0Df1ZIFCk0sMxvWgxFv+9LQH8rRCVeg+OK3v1H6VyJCnjN11w2gaoLjZ
         kl1NJ8uX+MxpW3yIph2SNFjr7TBQBioRwRwlhLPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 099/142] x86/kvm/vmx: fix old-style function declaration
Date:   Fri, 14 Dec 2018 12:59:44 +0100
Message-Id: <20181214115751.011454954@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index b1aef90aab91..c97a9d60d305 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1285,7 +1285,7 @@ static void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked);
 static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
 					    u16 error_code);
 static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
-static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
 							  u32 msr, int type);
 
 static DEFINE_PER_CPU(struct vmcs *, vmxarea);
@@ -5935,7 +5935,7 @@ static void free_vpid(int vpid)
 	spin_unlock(&vmx_vpid_lock);
 }
 
-static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
 							  u32 msr, int type)
 {
 	int f = sizeof(unsigned long);
@@ -5973,7 +5973,7 @@ static void __always_inline vmx_disable_intercept_for_msr(unsigned long *msr_bit
 	}
 }
 
-static void __always_inline vmx_enable_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_enable_intercept_for_msr(unsigned long *msr_bitmap,
 							 u32 msr, int type)
 {
 	int f = sizeof(unsigned long);
@@ -6011,7 +6011,7 @@ static void __always_inline vmx_enable_intercept_for_msr(unsigned long *msr_bitm
 	}
 }
 
-static void __always_inline vmx_set_intercept_for_msr(unsigned long *msr_bitmap,
+static __always_inline void vmx_set_intercept_for_msr(unsigned long *msr_bitmap,
 			     			      u32 msr, int type, bool value)
 {
 	if (value)
-- 
2.19.1



