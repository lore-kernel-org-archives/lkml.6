Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753833AbeDKRVh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 13:21:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753813AbeDKRVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 13:21:34 -0400
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
Subject: [PATCH v2 2/6] KVM: x86: hyperv: use defines when parsing hypercall parameters
Date: Wed, 11 Apr 2018 19:21:22 +0200
Message-Id: <20180411172126.16355-3-vkuznets@redhat.com>
In-Reply-To: <20180411172126.16355-1-vkuznets@redhat.com>
References: <20180411172126.16355-1-vkuznets@redhat.com>
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
index 98618e397342..3cb3bb68db7e 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1339,9 +1339,9 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
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
