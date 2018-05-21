Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqkR6PCa6PloM3mj4SVBqt8MrA4qh9NBEXDtpM1rdn5NQvB2em6KfizRozU112tj/U5eJsi
ARC-Seal: i=1; a=rsa-sha256; t=1526937245; cv=none;
        d=google.com; s=arc-20160816;
        b=M76DIOYp63ePc//eW9yySj/01a6HhaNG2qpDyTAfSku+VqYv0OnJs4GKCty7TBsbg4
         pjQfLpHRk6HErcEbyX+4gykyxbVCTfwEm5tSGN0/k6lDRaqWcnYChk39kZq689cAg5Ia
         20USSj82TtsgZ8K0U9t6fxH3dG7ZeJ2BNXy9OJkhI4eOew6DWYXmLj403vvv1D2LZCAq
         XXy8NTH7qZenPUdx+dHOFdOwifyi90L6iAeECMkXLZHqJZx2l2KGFytDefEu9vJ42qsM
         wh44+mhM82Z7XTVyuLPw/SMDbTHcz6x9RI8m/w5zNRdnL/KuC0i253wj6mhBx8xvC1qk
         8TGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=aWBuoJcLUlwaFDcvuWa1JnIbuH59dVOmnCIDbzVYGrI=;
        b=WtlwbcqgcBXjrr/a3nfEuZ2V4Wv7ft24HpuQutU9lNjseuyn20RNDTMNFFXflzDOin
         /1XLwpUh08+PF1mScX1I3I1bxgEP5/d9wBgVMWbvCGZnXJBQBreXr89fuVo6usO7wwlb
         815S+UYAKTa1uwaKaM4IjQC5Jhbgrgvo1CyknPPK1V+QETQR5PHT4COfIxLwlPVJc9A8
         KjoqAYReCPl4tD6Tl/6FW3WK+7jiut85jiLXmFPUq1Pt1XZ976IPG8zogYSHc8OICIwa
         aZH9HvOJZ+rc+Lus0cBCWZONsemMJjlpUTTybPnf3mCD4uGCjMBMAffoRTtF+M/U1fyc
         MWrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=zayr/PBJ;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=zayr/PBJ;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Glauber <jan.glauber@caviumnetworks.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.9 12/87] KVM: arm/arm64: VGIC/ITS: protect kvm_read_guest() calls with SRCU lock
Date: Mon, 21 May 2018 23:10:48 +0200
Message-Id: <20180521210421.374492967@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109749875942072?=
X-GMAIL-MSGID: =?utf-8?q?1601109749875942072?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andre Przywara <andre.przywara@arm.com>

commit bf308242ab98b5d1648c3663e753556bef9bec01 upstream.

kvm_read_guest() will eventually look up in kvm_memslots(), which requires
either to hold the kvm->slots_lock or to be inside a kvm->srcu critical
section.
In contrast to x86 and s390 we don't take the SRCU lock on every guest
exit, so we have to do it individually for each kvm_read_guest() call.

Provide a wrapper which does that and use that everywhere.

Note that ending the SRCU critical section before returning from the
kvm_read_guest() wrapper is safe, because the data has been *copied*, so
we don't need to rely on valid references to the memslot anymore.

Cc: Stable <stable@vger.kernel.org> # 4.8+
Reported-by: Jan Glauber <jan.glauber@caviumnetworks.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/include/asm/kvm_mmu.h   |   16 ++++++++++++++++
 arch/arm64/include/asm/kvm_mmu.h |   16 ++++++++++++++++
 virt/kvm/arm/vgic/vgic-its.c     |   15 ++++++++-------
 3 files changed, 40 insertions(+), 7 deletions(-)

--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -223,6 +223,22 @@ static inline unsigned int kvm_get_vmid_
 	return 8;
 }
 
+/*
+ * We are not in the kvm->srcu critical section most of the time, so we take
+ * the SRCU read lock here. Since we copy the data from the user page, we
+ * can immediately drop the lock again.
+ */
+static inline int kvm_read_guest_lock(struct kvm *kvm,
+				      gpa_t gpa, void *data, unsigned long len)
+{
+	int srcu_idx = srcu_read_lock(&kvm->srcu);
+	int ret = kvm_read_guest(kvm, gpa, data, len);
+
+	srcu_read_unlock(&kvm->srcu, srcu_idx);
+
+	return ret;
+}
+
 static inline void *kvm_get_hyp_vector(void)
 {
 	return kvm_ksym_ref(__kvm_hyp_vector);
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -313,6 +313,22 @@ static inline unsigned int kvm_get_vmid_
 	return (cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR1_VMIDBITS_SHIFT) == 2) ? 16 : 8;
 }
 
+/*
+ * We are not in the kvm->srcu critical section most of the time, so we take
+ * the SRCU read lock here. Since we copy the data from the user page, we
+ * can immediately drop the lock again.
+ */
+static inline int kvm_read_guest_lock(struct kvm *kvm,
+				      gpa_t gpa, void *data, unsigned long len)
+{
+	int srcu_idx = srcu_read_lock(&kvm->srcu);
+	int ret = kvm_read_guest(kvm, gpa, data, len);
+
+	srcu_read_unlock(&kvm->srcu, srcu_idx);
+
+	return ret;
+}
+
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 #include <asm/mmu.h>
 
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -208,8 +208,8 @@ static int update_lpi_config(struct kvm
 	u8 prop;
 	int ret;
 
-	ret = kvm_read_guest(kvm, propbase + irq->intid - GIC_LPI_OFFSET,
-			     &prop, 1);
+	ret = kvm_read_guest_lock(kvm, propbase + irq->intid - GIC_LPI_OFFSET,
+				  &prop, 1);
 
 	if (ret)
 		return ret;
@@ -339,8 +339,9 @@ static int its_sync_lpi_pending_table(st
 		 * this very same byte in the last iteration. Reuse that.
 		 */
 		if (byte_offset != last_byte_offset) {
-			ret = kvm_read_guest(vcpu->kvm, pendbase + byte_offset,
-					     &pendmask, 1);
+			ret = kvm_read_guest_lock(vcpu->kvm,
+						  pendbase + byte_offset,
+						  &pendmask, 1);
 			if (ret) {
 				kfree(intids);
 				return ret;
@@ -628,7 +629,7 @@ static bool vgic_its_check_id(struct vgi
 		return false;
 
 	/* Each 1st level entry is represented by a 64-bit value. */
-	if (kvm_read_guest(its->dev->kvm,
+	if (kvm_read_guest_lock(its->dev->kvm,
 			   BASER_ADDRESS(baser) + index * sizeof(indirect_ptr),
 			   &indirect_ptr, sizeof(indirect_ptr)))
 		return false;
@@ -1152,8 +1153,8 @@ static void vgic_its_process_commands(st
 	cbaser = CBASER_ADDRESS(its->cbaser);
 
 	while (its->cwriter != its->creadr) {
-		int ret = kvm_read_guest(kvm, cbaser + its->creadr,
-					 cmd_buf, ITS_CMD_SIZE);
+		int ret = kvm_read_guest_lock(kvm, cbaser + its->creadr,
+					      cmd_buf, ITS_CMD_SIZE);
 		/*
 		 * If kvm_read_guest() fails, this could be due to the guest
 		 * programming a bogus value in CBASER or something else going
