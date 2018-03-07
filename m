Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtUb7Noflt4LlEbM0nrzJmpkuhNC8y1SQZWOXhPAfQaiAvcbiBV8smcQKsFnw6FmippAGOf
ARC-Seal: i=1; a=rsa-sha256; t=1520452051; cv=none;
        d=google.com; s=arc-20160816;
        b=AlCjAXedgvacx9GT5alpsDUgBjT+oYoKdAJBD5pxDM5QA6ENgeY3KJGGC3LmhYpWFT
         rJCgmU01HBk9d5GEGcP3qT1e8Jjcr7SZlgBkGkdMgClemrVkxQS+8uaPxaMUfLGXc7UZ
         iq4/4GtXYpjeyGjrbrnTERXfFWvDMD3J8Psb7CXR/OW9o2c+1meF3+AA0VSf2B/CjsmN
         LJ5cKg6u0bZzFlfQoItpU04iSiGTpEuWqwdj+0I98ZL/VW4kdNfslv4ANov6a95uDD2r
         B+t5yi9ar9fg3ndmXThHGjwB7cJMeDZe37iM1p9GoS8CxR6i6SYs1ls/AKQuYq8/6aWr
         TGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8Bu3uODmxgZZdbhSxsf1qghDWtTAMnobL15EUOjviYs=;
        b=0qWFqlyRecjFm5uJB6Qd+GWA/LLyGHBIOtGH49Tf9yGvG3GatNOJOCSi8LNTE3SDjR
         czuwXwd59pkfAbqD6tLdoipDYqFAdYd9tppKi1vKvL7lNG/3JpKqmrIawjZJBUtwKhUz
         YyoXps9JFMXKAriMlOXKb99AdwHsvGqQLU5NY0gzgBRnZd38LZQOJGL1NMXM2SwkCUbb
         k+5MHf4XBnB5tRXUAVUK4PjK4aryORnRco44nimFYGyZA3sOCcojcuzELTmoTgTa5kwC
         mSzWujUR+fg65Lw+OM8m55ZGj26xAhY+V6GBqrgiadacguL/oJg1KTmxcQc4GKRR0Yqa
         /XSw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4.14 087/110] KVM: s390: provide only a single function for setting the tod (fix SCK)
Date: Wed,  7 Mar 2018 11:39:10 -0800
Message-Id: <20180307191051.008571274@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309275983778176?=
X-GMAIL-MSGID: =?utf-8?q?1594309530549400918?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>

commit 0e7def5fb0dc53ddbb9f62a497d15f1e11ccdc36 upstream.

Right now, SET CLOCK called in the guest does not properly take care of
the epoch index, as the call goes via the old kvm_s390_set_tod_clock()
interface. So the epoch index is neither reset to 0, if required, nor
properly set to e.g. 0xff on negative values.

Fix this by providing a single kvm_s390_set_tod_clock() function. Move
Multiple-epoch facility handling into it.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180207114647.6220-3-david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Fixes: 8fa1696ea781 ("KVM: s390: Multiple Epoch Facility support")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kvm/kvm-s390.c |   46 +++++++++++++++-------------------------------
 arch/s390/kvm/kvm-s390.h |    5 ++---
 arch/s390/kvm/priv.c     |    9 +++++----
 3 files changed, 22 insertions(+), 38 deletions(-)

--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -888,12 +888,9 @@ static int kvm_s390_set_tod_ext(struct k
 	if (copy_from_user(&gtod, (void __user *)attr->addr, sizeof(gtod)))
 		return -EFAULT;
 
-	if (test_kvm_facility(kvm, 139))
-		kvm_s390_set_tod_clock_ext(kvm, &gtod);
-	else if (gtod.epoch_idx == 0)
-		kvm_s390_set_tod_clock(kvm, gtod.tod);
-	else
+	if (!test_kvm_facility(kvm, 139) && gtod.epoch_idx)
 		return -EINVAL;
+	kvm_s390_set_tod_clock(kvm, &gtod);
 
 	VM_EVENT(kvm, 3, "SET: TOD extension: 0x%x, TOD base: 0x%llx",
 		gtod.epoch_idx, gtod.tod);
@@ -918,13 +915,14 @@ static int kvm_s390_set_tod_high(struct
 
 static int kvm_s390_set_tod_low(struct kvm *kvm, struct kvm_device_attr *attr)
 {
-	u64 gtod;
+	struct kvm_s390_vm_tod_clock gtod = { 0 };
 
-	if (copy_from_user(&gtod, (void __user *)attr->addr, sizeof(gtod)))
+	if (copy_from_user(&gtod.tod, (void __user *)attr->addr,
+			   sizeof(gtod.tod)))
 		return -EFAULT;
 
-	kvm_s390_set_tod_clock(kvm, gtod);
-	VM_EVENT(kvm, 3, "SET: TOD base: 0x%llx", gtod);
+	kvm_s390_set_tod_clock(kvm, &gtod);
+	VM_EVENT(kvm, 3, "SET: TOD base: 0x%llx", gtod.tod);
 	return 0;
 }
 
@@ -2945,8 +2943,8 @@ retry:
 	return 0;
 }
 
-void kvm_s390_set_tod_clock_ext(struct kvm *kvm,
-				 const struct kvm_s390_vm_tod_clock *gtod)
+void kvm_s390_set_tod_clock(struct kvm *kvm,
+			    const struct kvm_s390_vm_tod_clock *gtod)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_s390_tod_clock_ext htod;
@@ -2958,10 +2956,12 @@ void kvm_s390_set_tod_clock_ext(struct k
 	get_tod_clock_ext((char *)&htod);
 
 	kvm->arch.epoch = gtod->tod - htod.tod;
-	kvm->arch.epdx = gtod->epoch_idx - htod.epoch_idx;
-
-	if (kvm->arch.epoch > gtod->tod)
-		kvm->arch.epdx -= 1;
+	kvm->arch.epdx = 0;
+	if (test_kvm_facility(kvm, 139)) {
+		kvm->arch.epdx = gtod->epoch_idx - htod.epoch_idx;
+		if (kvm->arch.epoch > gtod->tod)
+			kvm->arch.epdx -= 1;
+	}
 
 	kvm_s390_vcpu_block_all(kvm);
 	kvm_for_each_vcpu(i, vcpu, kvm) {
@@ -2972,22 +2972,6 @@ void kvm_s390_set_tod_clock_ext(struct k
 	kvm_s390_vcpu_unblock_all(kvm);
 	preempt_enable();
 	mutex_unlock(&kvm->lock);
-}
-
-void kvm_s390_set_tod_clock(struct kvm *kvm, u64 tod)
-{
-	struct kvm_vcpu *vcpu;
-	int i;
-
-	mutex_lock(&kvm->lock);
-	preempt_disable();
-	kvm->arch.epoch = tod - get_tod_clock();
-	kvm_s390_vcpu_block_all(kvm);
-	kvm_for_each_vcpu(i, vcpu, kvm)
-		vcpu->arch.sie_block->epoch = kvm->arch.epoch;
-	kvm_s390_vcpu_unblock_all(kvm);
-	preempt_enable();
-	mutex_unlock(&kvm->lock);
 }
 
 /**
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -272,9 +272,8 @@ int kvm_s390_handle_sigp_pei(struct kvm_
 int handle_sthyi(struct kvm_vcpu *vcpu);
 
 /* implemented in kvm-s390.c */
-void kvm_s390_set_tod_clock_ext(struct kvm *kvm,
-				 const struct kvm_s390_vm_tod_clock *gtod);
-void kvm_s390_set_tod_clock(struct kvm *kvm, u64 tod);
+void kvm_s390_set_tod_clock(struct kvm *kvm,
+			    const struct kvm_s390_vm_tod_clock *gtod);
 long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable);
 int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr);
 int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr);
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -84,9 +84,10 @@ int kvm_s390_handle_e3(struct kvm_vcpu *
 /* Handle SCK (SET CLOCK) interception */
 static int handle_set_clock(struct kvm_vcpu *vcpu)
 {
+	struct kvm_s390_vm_tod_clock gtod = { 0 };
 	int rc;
 	u8 ar;
-	u64 op2, val;
+	u64 op2;
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
@@ -94,12 +95,12 @@ static int handle_set_clock(struct kvm_v
 	op2 = kvm_s390_get_base_disp_s(vcpu, &ar);
 	if (op2 & 7)	/* Operand must be on a doubleword boundary */
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-	rc = read_guest(vcpu, op2, ar, &val, sizeof(val));
+	rc = read_guest(vcpu, op2, ar, &gtod.tod, sizeof(gtod.tod));
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 
-	VCPU_EVENT(vcpu, 3, "SCK: setting guest TOD to 0x%llx", val);
-	kvm_s390_set_tod_clock(vcpu->kvm, val);
+	VCPU_EVENT(vcpu, 3, "SCK: setting guest TOD to 0x%llx", gtod.tod);
+	kvm_s390_set_tod_clock(vcpu->kvm, &gtod);
 
 	kvm_s390_set_psw_cc(vcpu, 0);
 	return 0;
