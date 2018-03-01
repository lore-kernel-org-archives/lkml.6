Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031282AbeCAOP2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:15:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031211AbeCAOPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:15:22 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>
Subject: [PATCH v2 2/3] x86/kvm/hyper-v: remove stale entries from vec_bitmap/auto_eoi_bitmap on vector change
Date: Thu,  1 Mar 2018 15:15:13 +0100
Message-Id: <20180301141514.3482-3-vkuznets@redhat.com>
In-Reply-To: <20180301141514.3482-1-vkuznets@redhat.com>
References: <20180301141514.3482-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a new vector is written to SINx we update vec_bitmap/auto_eoi_bitmap
but we forget to remove old vector from these masks (in case it is not
present in some other SINTx).

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
---
 arch/x86/include/uapi/asm/hyperv.h |  2 ++
 arch/x86/kvm/hyperv.c              | 32 ++++++++++++++++++++++----------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/uapi/asm/hyperv.h b/arch/x86/include/uapi/asm/hyperv.h
index 197c2e6c7376..62c778a303a1 100644
--- a/arch/x86/include/uapi/asm/hyperv.h
+++ b/arch/x86/include/uapi/asm/hyperv.h
@@ -318,6 +318,8 @@ typedef struct _HV_REFERENCE_TSC_PAGE {
 #define HV_SYNIC_SINT_COUNT		(16)
 /* Define the expected SynIC version. */
 #define HV_SYNIC_VERSION_1		(0x1)
+/* Valid SynIC vectors are 16-255. */
+#define HV_SYNIC_FIRST_VALID_VECTOR	(16)
 
 #define HV_SYNIC_CONTROL_ENABLE		(1ULL << 0)
 #define HV_SYNIC_SIMP_ENABLE		(1ULL << 0)
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 05f414525538..6d14f808145d 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -74,13 +74,30 @@ static bool synic_has_vector_auto_eoi(struct kvm_vcpu_hv_synic *synic,
 	return false;
 }
 
+static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
+				int vector)
+{
+	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
+		return;
+
+	if (synic_has_vector_connected(synic, vector))
+		__set_bit(vector, synic->vec_bitmap);
+	else
+		__clear_bit(vector, synic->vec_bitmap);
+
+	if (synic_has_vector_auto_eoi(synic, vector))
+		__set_bit(vector, synic->auto_eoi_bitmap);
+	else
+		__clear_bit(vector, synic->auto_eoi_bitmap);
+}
+
 static int synic_set_sint(struct kvm_vcpu_hv_synic *synic, int sint,
 			  u64 data, bool host)
 {
-	int vector;
+	int vector, old_vector;
 
 	vector = data & HV_SYNIC_SINT_VECTOR_MASK;
-	if (vector < 16 && !host)
+	if (vector < HV_SYNIC_FIRST_VALID_VECTOR && !host)
 		return 1;
 	/*
 	 * Guest may configure multiple SINTs to use the same vector, so
@@ -88,18 +105,13 @@ static int synic_set_sint(struct kvm_vcpu_hv_synic *synic, int sint,
 	 * bitmap of vectors with auto-eoi behavior.  The bitmaps are
 	 * updated here, and atomically queried on fast paths.
 	 */
+	old_vector = synic_read_sint(synic, sint) & HV_SYNIC_SINT_VECTOR_MASK;
 
 	atomic64_set(&synic->sint[sint], data);
 
-	if (synic_has_vector_connected(synic, vector))
-		__set_bit(vector, synic->vec_bitmap);
-	else
-		__clear_bit(vector, synic->vec_bitmap);
+	synic_update_vector(synic, old_vector);
 
-	if (synic_has_vector_auto_eoi(synic, vector))
-		__set_bit(vector, synic->auto_eoi_bitmap);
-	else
-		__clear_bit(vector, synic->auto_eoi_bitmap);
+	synic_update_vector(synic, vector);
 
 	/* Load SynIC vectors into EOI exit bitmap */
 	kvm_make_request(KVM_REQ_SCAN_IOAPIC, synic_to_vcpu(synic));
-- 
2.14.3
