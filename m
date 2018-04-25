Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48MyOZekFozuI/azxJV7LSQh2+/m0YgxqEvoIziPBhcz7Q4+h6BH8Dh2qsLhP7m6d739mlX
ARC-Seal: i=1; a=rsa-sha256; t=1524652818; cv=none;
        d=google.com; s=arc-20160816;
        b=NoEVVOci+0A9ZhqOCq7+33w6wDoBCANS+sXyZeTADlAUsfD01AHhmdLEDavdStP6e4
         vGjvMfUjX+iWl6sXFwzDjzs43du5riauC7Ukm4GmFhSTgiolQLXk2e0T5DymWUV4tbMq
         9DMwViUbisj5riBeK1g1cTukRZYpXAesd7OjvA5BhnSsfQTyscWkPNsLzMl6uIqoaA57
         revmujGj2aZU5w3eTNewiU7zQ8c5sxLpiMuHMlaf5wbjmgc11dbgymZnvQZO8Iicgxti
         9Wac+iVDdt1sd31RP40CjWjr22zDbFN2mq1IziUwBDQzTmjpSWouv3kxAAzLGYlaPYjC
         A1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ku3ahJj0KAhb+mX8x9Uy7LfVJXUtGAcmXVVJVJukboY=;
        b=w0vDrTItcERGfiHrnjKmW76jfrgpubGZU0gbS9/KniuSIxhNjpPtvkehIcpaD1HPah
         x8xKjbyvY6NuxwTr80kV2a629uG/pIJoU6nG1mVnWTOtgNYbxK+SstBUCqjhLGj1Uh8y
         iezgV2zbWcLRdL4eq+wGpjami25wWRbT53z1imcfk8337WswteC+4dJaa4xbwNGj2smH
         x7uKQ6aqPoYQTXBByPZ+HNB9pKqOOai/wuyCL8p4GsQZG+aBdeZDtmIcEF0+fvQs20yw
         F5diuYquZMiB/tzUSmKshCFZqebHuYRZLuQnOmwc7BwZ8sfr8m5SgDg7dGgYKc5DZy+s
         AwTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 081/183] KVM: s390: vsie: use READ_ONCE to access some SCB fields
Date: Wed, 25 Apr 2018 12:35:01 +0200
Message-Id: <20180425103245.759647073@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714354238075057?=
X-GMAIL-MSGID: =?utf-8?q?1598714354238075057?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>


[ Upstream commit b3ecd4aa8632a86428605ab73393d14779019d82 ]

Another VCPU might try to modify the SCB while we are creating the
shadow SCB. In general this is no problem - unless the compiler decides
to not load values once, but e.g. twice.

For us, this is only relevant when checking/working with such values.
E.g. the prefix value, the mso, state of transactional execution and
addresses of satellite blocks.

E.g. if we blindly forward values (e.g. general purpose registers or
execution controls after masking), we don't care.

Leaving unpin_blocks() untouched for now, will handle it separately.

The worst thing right now that I can see would be a missed prefix
un/remap (mso, prefix, tx) or using wrong guest addresses. Nothing
critical, but let's try to avoid unpredictable behavior.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180116171526.12343-2-david@redhat.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kvm/vsie.c |   50 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -31,7 +31,11 @@ struct vsie_page {
 	 * the same offset as that in struct sie_page!
 	 */
 	struct mcck_volatile_info mcck_info;    /* 0x0200 */
-	/* the pinned originial scb */
+	/*
+	 * The pinned original scb. Be aware that other VCPUs can modify
+	 * it while we read from it. Values that are used for conditions or
+	 * are reused conditionally, should be accessed via READ_ONCE.
+	 */
 	struct kvm_s390_sie_block *scb_o;	/* 0x0218 */
 	/* the shadow gmap in use by the vsie_page */
 	struct gmap *gmap;			/* 0x0220 */
@@ -143,12 +147,13 @@ static int shadow_crycb(struct kvm_vcpu
 {
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
 	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
-	u32 crycb_addr = scb_o->crycbd & 0x7ffffff8U;
+	const uint32_t crycbd_o = READ_ONCE(scb_o->crycbd);
+	const u32 crycb_addr = crycbd_o & 0x7ffffff8U;
 	unsigned long *b1, *b2;
 	u8 ecb3_flags;
 
 	scb_s->crycbd = 0;
-	if (!(scb_o->crycbd & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
+	if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
 		return 0;
 	/* format-1 is supported with message-security-assist extension 3 */
 	if (!test_kvm_facility(vcpu->kvm, 76))
@@ -186,12 +191,15 @@ static void prepare_ibc(struct kvm_vcpu
 {
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
 	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
+	/* READ_ONCE does not work on bitfields - use a temporary variable */
+	const uint32_t __new_ibc = scb_o->ibc;
+	const uint32_t new_ibc = READ_ONCE(__new_ibc) & 0x0fffU;
 	__u64 min_ibc = (sclp.ibc >> 16) & 0x0fffU;
 
 	scb_s->ibc = 0;
 	/* ibc installed in g2 and requested for g3 */
-	if (vcpu->kvm->arch.model.ibc && (scb_o->ibc & 0x0fffU)) {
-		scb_s->ibc = scb_o->ibc & 0x0fffU;
+	if (vcpu->kvm->arch.model.ibc && new_ibc) {
+		scb_s->ibc = new_ibc;
 		/* takte care of the minimum ibc level of the machine */
 		if (scb_s->ibc < min_ibc)
 			scb_s->ibc = min_ibc;
@@ -256,6 +264,10 @@ static int shadow_scb(struct kvm_vcpu *v
 {
 	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	/* READ_ONCE does not work on bitfields - use a temporary variable */
+	const uint32_t __new_prefix = scb_o->prefix;
+	const uint32_t new_prefix = READ_ONCE(__new_prefix);
+	const bool wants_tx = READ_ONCE(scb_o->ecb) & ECB_TE;
 	bool had_tx = scb_s->ecb & ECB_TE;
 	unsigned long new_mso = 0;
 	int rc;
@@ -302,14 +314,14 @@ static int shadow_scb(struct kvm_vcpu *v
 	scb_s->icpua = scb_o->icpua;
 
 	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_SM))
-		new_mso = scb_o->mso & 0xfffffffffff00000UL;
+		new_mso = READ_ONCE(scb_o->mso) & 0xfffffffffff00000UL;
 	/* if the hva of the prefix changes, we have to remap the prefix */
-	if (scb_s->mso != new_mso || scb_s->prefix != scb_o->prefix)
+	if (scb_s->mso != new_mso || scb_s->prefix != new_prefix)
 		prefix_unmapped(vsie_page);
 	 /* SIE will do mso/msl validity and exception checks for us */
 	scb_s->msl = scb_o->msl & 0xfffffffffff00000UL;
 	scb_s->mso = new_mso;
-	scb_s->prefix = scb_o->prefix;
+	scb_s->prefix = new_prefix;
 
 	/* We have to definetly flush the tlb if this scb never ran */
 	if (scb_s->ihcpu != 0xffffU)
@@ -321,11 +333,11 @@ static int shadow_scb(struct kvm_vcpu *v
 	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_ESOP))
 		scb_s->ecb |= scb_o->ecb & ECB_HOSTPROTINT;
 	/* transactional execution */
-	if (test_kvm_facility(vcpu->kvm, 73)) {
+	if (test_kvm_facility(vcpu->kvm, 73) && wants_tx) {
 		/* remap the prefix is tx is toggled on */
-		if ((scb_o->ecb & ECB_TE) && !had_tx)
+		if (!had_tx)
 			prefix_unmapped(vsie_page);
-		scb_s->ecb |= scb_o->ecb & ECB_TE;
+		scb_s->ecb |= ECB_TE;
 	}
 	/* SIMD */
 	if (test_kvm_facility(vcpu->kvm, 129)) {
@@ -544,9 +556,9 @@ static int pin_blocks(struct kvm_vcpu *v
 	gpa_t gpa;
 	int rc = 0;
 
-	gpa = scb_o->scaol & ~0xfUL;
+	gpa = READ_ONCE(scb_o->scaol) & ~0xfUL;
 	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_64BSCAO))
-		gpa |= (u64) scb_o->scaoh << 32;
+		gpa |= (u64) READ_ONCE(scb_o->scaoh) << 32;
 	if (gpa) {
 		if (!(gpa & ~0x1fffUL))
 			rc = set_validity_icpt(scb_s, 0x0038U);
@@ -566,7 +578,7 @@ static int pin_blocks(struct kvm_vcpu *v
 		scb_s->scaol = (u32)(u64)hpa;
 	}
 
-	gpa = scb_o->itdba & ~0xffUL;
+	gpa = READ_ONCE(scb_o->itdba) & ~0xffUL;
 	if (gpa && (scb_s->ecb & ECB_TE)) {
 		if (!(gpa & ~0x1fffU)) {
 			rc = set_validity_icpt(scb_s, 0x0080U);
@@ -581,7 +593,7 @@ static int pin_blocks(struct kvm_vcpu *v
 		scb_s->itdba = hpa;
 	}
 
-	gpa = scb_o->gvrd & ~0x1ffUL;
+	gpa = READ_ONCE(scb_o->gvrd) & ~0x1ffUL;
 	if (gpa && (scb_s->eca & ECA_VX) && !(scb_s->ecd & ECD_HOSTREGMGMT)) {
 		if (!(gpa & ~0x1fffUL)) {
 			rc = set_validity_icpt(scb_s, 0x1310U);
@@ -599,7 +611,7 @@ static int pin_blocks(struct kvm_vcpu *v
 		scb_s->gvrd = hpa;
 	}
 
-	gpa = scb_o->riccbd & ~0x3fUL;
+	gpa = READ_ONCE(scb_o->riccbd) & ~0x3fUL;
 	if (gpa && (scb_s->ecb3 & ECB3_RI)) {
 		if (!(gpa & ~0x1fffUL)) {
 			rc = set_validity_icpt(scb_s, 0x0043U);
@@ -617,8 +629,8 @@ static int pin_blocks(struct kvm_vcpu *v
 	if ((scb_s->ecb & ECB_GS) && !(scb_s->ecd & ECD_HOSTREGMGMT)) {
 		unsigned long sdnxc;
 
-		gpa = scb_o->sdnxo & ~0xfUL;
-		sdnxc = scb_o->sdnxo & 0xfUL;
+		gpa = READ_ONCE(scb_o->sdnxo) & ~0xfUL;
+		sdnxc = READ_ONCE(scb_o->sdnxo) & 0xfUL;
 		if (!gpa || !(gpa & ~0x1fffUL)) {
 			rc = set_validity_icpt(scb_s, 0x10b0U);
 			goto unpin;
@@ -785,7 +797,7 @@ static void retry_vsie_icpt(struct vsie_
 static int handle_stfle(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
 	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
-	__u32 fac = vsie_page->scb_o->fac & 0x7ffffff8U;
+	__u32 fac = READ_ONCE(vsie_page->scb_o->fac) & 0x7ffffff8U;
 
 	if (fac && test_kvm_facility(vcpu->kvm, 7)) {
 		retry_vsie_icpt(vsie_page);
