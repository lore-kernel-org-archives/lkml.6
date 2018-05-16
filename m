Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeEPPVs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:21:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751830AbeEPPVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:21:41 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/8] KVM: x86: hyperv: use defines when parsing hypercall parameters
Date: Wed, 16 May 2018 17:21:26 +0200
Message-Id: <20180516152131.30689-4-vkuznets@redhat.com>
In-Reply-To: <20180516152131.30689-1-vkuznets@redhat.com>
References: <20180516152131.30689-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid open-coding offsets for hypercall input parameters, we already
have defines for them.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 5708e951a5c6..dcfeae2deafa 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1341,9 +1341,9 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 #endif
 
 	code = param & 0xffff;
-	fast = (param >> 16) & 0x1;
-	rep_cnt = (param >> 32) & 0xfff;
-	rep_idx = (param >> 48) & 0xfff;
+	fast = !!(param & HV_HYPERCALL_FAST_BIT);
+	rep_cnt = (param >> HV_HYPERCALL_REP_COMP_OFFSET) & 0xfff;
+	rep_idx = (param >> HV_HYPERCALL_REP_START_OFFSET) & 0xfff;
 
 	trace_kvm_hv_hypercall(code, fast, rep_cnt, rep_idx, ingpa, outgpa);
 
-- 
2.14.3
