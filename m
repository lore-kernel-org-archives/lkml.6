Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031311AbeCAOP7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:15:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031264AbeCAOPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:15:24 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>
Subject: [PATCH v2 3/3] x86/kvm/hyper-v: inject #GP only when invalid SINTx vector is unmasked
Date: Thu,  1 Mar 2018 15:15:14 +0100
Message-Id: <20180301141514.3482-4-vkuznets@redhat.com>
In-Reply-To: <20180301141514.3482-1-vkuznets@redhat.com>
References: <20180301141514.3482-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyper-V 2016 on KVM with SynIC enabled doesn't boot with the following
trace:

    kvm_entry:            vcpu 0
    kvm_exit:             reason MSR_WRITE rip 0xfffff8000131c1e5 info 0 0
    kvm_hv_synic_set_msr: vcpu_id 0 msr 0x40000090 data 0x10000 host 0
    kvm_msr:              msr_write 40000090 = 0x10000 (#GP)
    kvm_inj_exception:    #GP (0x0)

KVM acts according to the following statement from TLFS:

"
11.8.4 SINTx Registers
...
Valid values for vector are 16-255 inclusive. Specifying an invalid
vector number results in #GP.
"

However, I checked and genuine Hyper-V doesn't #GP when we write 0x10000
to SINTx. I checked with Microsoft and they confirmed that if either the
Masked bit (bit 16) or the Polling bit (bit 18) is set to 1, then they
ignore the value of Vector. Make KVM act accordingly.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
Changes since v1:
- Drop 'polling' bit check for now as we don't support this mode. We'll
  need to bring some form of this check back when polling mode is
  implemented [Roman Kagan].
- Add a comment explaining "!host && !masked" in synic_set_sint()
---
 arch/x86/kvm/hyperv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 6d14f808145d..b390a4d9ea14 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -95,9 +95,17 @@ static int synic_set_sint(struct kvm_vcpu_hv_synic *synic, int sint,
 			  u64 data, bool host)
 {
 	int vector, old_vector;
+	bool masked;
 
 	vector = data & HV_SYNIC_SINT_VECTOR_MASK;
-	if (vector < HV_SYNIC_FIRST_VALID_VECTOR && !host)
+	masked = data & HV_SYNIC_SINT_MASKED;
+
+	/*
+	 * Valid vectors are 16-255, however, nested Hyper-V attempts to write
+	 * default '0x10000' value on boot and this should not #GP. We need to
+	 * allow zero-initing the register from host as well.
+	 */
+	if (vector < HV_SYNIC_FIRST_VALID_VECTOR && !host && !masked)
 		return 1;
 	/*
 	 * Guest may configure multiple SINTs to use the same vector, so
-- 
2.14.3
