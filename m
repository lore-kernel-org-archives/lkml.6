Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932207AbeB1NoP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:44:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932167AbeB1NoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:44:11 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Andrey Smetanin <asmetanin@virtuozzo.com>,
        Roman Kagan <rkagan@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>
Subject: [PATCH 3/3] x86/kvm/hyper-v: inject #GP only when invalid SINTx vector is unmasked
Date: Wed, 28 Feb 2018 14:44:01 +0100
Message-Id: <20180228134401.6544-4-vkuznets@redhat.com>
In-Reply-To: <20180228134401.6544-1-vkuznets@redhat.com>
References: <20180228134401.6544-1-vkuznets@redhat.com>
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
 arch/x86/include/uapi/asm/hyperv.h | 1 +
 arch/x86/kvm/hyperv.c              | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/hyperv.h b/arch/x86/include/uapi/asm/hyperv.h
index 62c778a303a1..a492dc357bd7 100644
--- a/arch/x86/include/uapi/asm/hyperv.h
+++ b/arch/x86/include/uapi/asm/hyperv.h
@@ -326,6 +326,7 @@ typedef struct _HV_REFERENCE_TSC_PAGE {
 #define HV_SYNIC_SIEFP_ENABLE		(1ULL << 0)
 #define HV_SYNIC_SINT_MASKED		(1ULL << 16)
 #define HV_SYNIC_SINT_AUTO_EOI		(1ULL << 17)
+#define HV_SYNIC_SINT_POLLING		(1ULL << 18)
 #define HV_SYNIC_SINT_VECTOR_MASK	(0xFF)
 
 #define HV_SYNIC_STIMER_COUNT		(4)
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 6d14f808145d..d3d866c32976 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -95,9 +95,14 @@ static int synic_set_sint(struct kvm_vcpu_hv_synic *synic, int sint,
 			  u64 data, bool host)
 {
 	int vector, old_vector;
+	bool masked, polling;
 
 	vector = data & HV_SYNIC_SINT_VECTOR_MASK;
-	if (vector < HV_SYNIC_FIRST_VALID_VECTOR && !host)
+	masked = data & HV_SYNIC_SINT_MASKED;
+	polling = data & HV_SYNIC_SINT_POLLING;
+
+	if (vector < HV_SYNIC_FIRST_VALID_VECTOR &&
+	    !host && !masked && !polling)
 		return 1;
 	/*
 	 * Guest may configure multiple SINTs to use the same vector, so
-- 
2.14.3
