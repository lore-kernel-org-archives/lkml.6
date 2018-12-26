Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D73C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C42214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeLZUlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 15:41:05 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.102]:11291 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727561AbeLZUlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 15:41:05 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 7FF81E5CD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 14:41:04 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id cFzEgsv4O2PzOcFzEgbAg9; Wed, 26 Dec 2018 14:41:04 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.104] (port=60394 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gcFzB-002qjw-B5; Wed, 26 Dec 2018 14:41:01 -0600
Date:   Wed, 26 Dec 2018 14:40:59 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Luwei Kang <luwei.kang@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] KVM: x86: Fix bit shifting in update_intel_pt_cfg
Message-ID: <20181226204059.GA11391@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.78.104
X-Source-L: No
X-Exim-ID: 1gcFzB-002qjw-B5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.104]:60394
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ctl_bitmask in pt_desc is of type u64. When an integer like 0xf is
being left shifted more than 32 bits, the behavior is undefined.

Fix this by adding suffix ULL to integer 0xf.

Addresses-Coverity-ID: 1476095 ("Bad bit shift operation")
Fixes: 6c0f0bba85a0 ("KVM: x86: Introduce a function to initialize the PT configuration")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cbd55e7aeae5..251c68a74bbe 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7012,7 +7012,7 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
 
 	/* unmask address range configure area */
 	for (i = 0; i < vmx->pt_desc.addr_range; i++)
-		vmx->pt_desc.ctl_bitmask &= ~(0xf << (32 + i * 4));
+		vmx->pt_desc.ctl_bitmask &= ~(0xfULL << (32 + i * 4));
 }
 
 static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
-- 
2.20.1

