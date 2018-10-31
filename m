Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F478C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2785F20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjqQSk3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2785F20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbeKAIJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730350AbeKAIJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 094A520840;
        Wed, 31 Oct 2018 23:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027349;
        bh=zrTOnQ9EyP/qSDvJoOAZD2E/pFfgCi9kQilkq5e+1ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjqQSk3GgOu0EYo0x42r/rFp2KVv2E1AJRf/dNVG3xnGcKd4P590LaHPK2quXD1z+
         pPmGPXjOv55bEr06YkGxE318tXKRJMxY/JGVnrqB+iD3Q8U5DzemuN+xOluDzQWm9S
         6VhBBy4obb2gIjClEVwL+v0dQiQzyRG/1TVVJwuo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 082/126] KVM: nVMX: Clear reserved bits of #DB exit qualification
Date:   Wed, 31 Oct 2018 19:07:10 -0400
Message-Id: <20181031230754.29029-82-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Mattson <jmattson@google.com>

[ Upstream commit cfb634fe3052aefc4e1360fa322018c9a0b49755 ]

According to volume 3 of the SDM, bits 63:15 and 12:4 of the exit
qualification field for debug exceptions are reserved (cleared to
0). However, the SDM is incorrect about bit 16 (corresponding to
DR6.RTM). This bit should be set if a debug exception (#DB) or a
breakpoint exception (#BP) occurred inside an RTM region while
advanced debugging of RTM transactional regions was enabled. Note that
this is the opposite of DR6.RTM, which "indicates (when clear) that a
debug exception (#DB) or breakpoint exception (#BP) occurred inside an
RTM region while advanced debugging of RTM transactional regions was
enabled."

There is still an issue with stale DR6 bits potentially being
misreported for the current debug exception.  DR6 should not have been
modified before vectoring the #DB exception, and the "new DR6 bits"
should be available somewhere, but it was and they aren't.

Fixes: b96fb439774e1 ("KVM: nVMX: fixes to nested virt interrupt injection")
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/vmx.c              | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0722b7745382..ccc23203b327 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -176,6 +176,7 @@ enum {
 
 #define DR6_BD		(1 << 13)
 #define DR6_BS		(1 << 14)
+#define DR6_BT		(1 << 15)
 #define DR6_RTM		(1 << 16)
 #define DR6_FIXED_1	0xfffe0ff0
 #define DR6_INIT	0xffff0ff0
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 32721ef9652d..1dcd7f13ce76 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3159,10 +3159,13 @@ static int nested_vmx_check_exception(struct kvm_vcpu *vcpu, unsigned long *exit
 		}
 	} else {
 		if (vmcs12->exception_bitmap & (1u << nr)) {
-			if (nr == DB_VECTOR)
+			if (nr == DB_VECTOR) {
 				*exit_qual = vcpu->arch.dr6;
-			else
+				*exit_qual &= ~(DR6_FIXED_1 | DR6_BT);
+				*exit_qual ^= DR6_RTM;
+			} else {
 				*exit_qual = 0;
+			}
 			return 1;
 		}
 	}
-- 
2.17.1

