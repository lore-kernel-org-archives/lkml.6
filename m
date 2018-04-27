Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpB+wagzOEpL25cNaEX2qN1XIbH/jSwLlUvw5THS3u7+AwIGuYiDypdzhAE0s6b+5zYlc6I
ARC-Seal: i=1; a=rsa-sha256; t=1524837734; cv=none;
        d=google.com; s=arc-20160816;
        b=Xses7DPDvlZ0hOzukGOiwgUg4v0BfTUYgxPD+Or3LBOKdNdPYpV2MLMVHZiU3ZEYZ1
         jTlBF5y3GOjMZjH+uqtaXhh0r6zo8qOzsuFw0OBHoGxYb9HTzWVN+/ygsNqfFxXR1Th5
         SUSyfrNUaEwACimPcfjZMzaooJiysD1lQjKaGS4b1biknLqtkBfeH9dDbD1Fcua8lBsp
         jXmC6aRnhDa/UESFLmbG9MPueRO2aYzOdp6om7cxudEdpHBR3AXmVKkBoIoqfYKJLCpS
         Z4CQrfSEHE+r0sg5OTDajzHXHpG/tU298EEK2eHsugO4ebVeBzYmo6eBH1FmMs9OU/mT
         YNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=zHU7y6d1EG+iprEL0sPJ+smrnc4oFcC+G0ZE6MMb1B0=;
        b=vdogHR0apMh6bi5XZUjnPh2VBWlE9u85OIuBhTsxAweJKzw/8K43ZAEhg9fl/SzlvH
         yoKY28Zmk+k5nQLNSYyn1vudYgeOr0uZQ608nbC8sqUzYwt2EsTzfJbfaOWEZMnIRGsv
         861CYQleCAgPX0a48I/pZRuJExYOMN5A394/B1PGLeBajQX32gQtDMxjeNh2/OQRvAJb
         8TO+CGC5BCoF8awFaJrX9rFJvYOip1zFE4skT2rPVNb3+5Mv70PkK9EAqudPGssgVHtd
         jfoUqQV2/5LYyxDJN5+bsCXPZpKjD3aiJGzbkp06gxg4ySiHj/RgTk10Nv7DUT/1xzy6
         7+ug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E478521897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 4.4 12/50] KVM: s390: wire up bpb feature
Date: Fri, 27 Apr 2018 15:58:14 +0200
Message-Id: <20180427135656.428437126@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
References: <20180427135655.623669681@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908252112326742?=
X-GMAIL-MSGID: =?utf-8?q?1598908252112326742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


From: Christian Borntraeger <borntraeger@de.ibm.com>

[ Upstream commit 35b3fde6203b932b2b1a5b53b3d8808abc9c4f60 ]

The new firmware interfaces for branch prediction behaviour changes
are transparently available for the guest. Nevertheless, there is
new state attached that should be migrated and properly resetted.
Provide a mechanism for handling reset, migration and VSIE.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
[Changed capability number to 152. - Radim]
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/kvm_host.h |    3 ++-
 arch/s390/include/uapi/asm/kvm.h |    3 +++
 arch/s390/kvm/kvm-s390.c         |   13 ++++++++++++-
 include/uapi/linux/kvm.h         |    1 +
 4 files changed, 18 insertions(+), 2 deletions(-)

--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -136,7 +136,8 @@ struct kvm_s390_sie_block {
 	__u16	ipa;			/* 0x0056 */
 	__u32	ipb;			/* 0x0058 */
 	__u32	scaoh;			/* 0x005c */
-	__u8	reserved60;		/* 0x0060 */
+#define FPF_BPBC 	0x20
+	__u8	fpf;			/* 0x0060 */
 	__u8	ecb;			/* 0x0061 */
 	__u8    ecb2;                   /* 0x0062 */
 #define ECB3_AES 0x04
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -151,6 +151,7 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_ARCH0  (1UL << 4)
 #define KVM_SYNC_PFAULT (1UL << 5)
 #define KVM_SYNC_VRS    (1UL << 6)
+#define KVM_SYNC_BPBC	(1UL << 10)
 /* definition of registers in kvm_run */
 struct kvm_sync_regs {
 	__u64 prefix;	/* prefix register */
@@ -168,6 +169,8 @@ struct kvm_sync_regs {
 	__u64 vrs[32][2];	/* vector registers */
 	__u8  reserved[512];	/* for future vector expansion */
 	__u32 fpc;	/* only valid with vector registers */
+	__u8 bpbc : 1;		/* bp mode */
+	__u8 reserved2 : 7;
 };
 
 #define KVM_REG_S390_TODPR	(KVM_REG_S390 | KVM_REG_SIZE_U32 | 0x1)
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -257,6 +257,9 @@ int kvm_vm_ioctl_check_extension(struct
 	case KVM_CAP_S390_VECTOR_REGISTERS:
 		r = MACHINE_HAS_VX;
 		break;
+	case KVM_CAP_S390_BPB:
+		r = test_facility(82);
+		break;
 	default:
 		r = 0;
 	}
@@ -1262,6 +1265,8 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *
 				    KVM_SYNC_CRS |
 				    KVM_SYNC_ARCH0 |
 				    KVM_SYNC_PFAULT;
+	if (test_kvm_facility(vcpu->kvm, 82))
+		vcpu->run->kvm_valid_regs |= KVM_SYNC_BPBC;
 	if (test_kvm_facility(vcpu->kvm, 129))
 		vcpu->run->kvm_valid_regs |= KVM_SYNC_VRS;
 
@@ -1286,7 +1291,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu
 	if (test_fp_ctl(current->thread.fpu.fpc))
 		/* User space provided an invalid FPC, let's clear it */
 		current->thread.fpu.fpc = 0;
-
 	save_access_regs(vcpu->arch.host_acrs);
 	restore_access_regs(vcpu->run->s.regs.acrs);
 	gmap_enable(vcpu->arch.gmap);
@@ -1327,6 +1331,7 @@ static void kvm_s390_vcpu_initial_reset(
 	current->thread.fpu.fpc = 0;
 	vcpu->arch.sie_block->gbea = 1;
 	vcpu->arch.sie_block->pp = 0;
+	vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
 	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
 	kvm_clear_async_pf_completion_queue(vcpu);
 	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm))
@@ -2162,6 +2167,7 @@ static void store_regs(struct kvm_vcpu *
 	kvm_run->s.regs.pft = vcpu->arch.pfault_token;
 	kvm_run->s.regs.pfs = vcpu->arch.pfault_select;
 	kvm_run->s.regs.pfc = vcpu->arch.pfault_compare;
+	kvm_run->s.regs.bpbc = (vcpu->arch.sie_block->fpf & FPF_BPBC) == FPF_BPBC;
 }
 
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
@@ -2194,6 +2200,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
 		kvm_run->exit_reason = KVM_EXIT_INTR;
 		rc = -EINTR;
 	}
+	if ((kvm_run->kvm_dirty_regs & KVM_SYNC_BPBC) &&
+	    test_kvm_facility(vcpu->kvm, 82)) {
+		vcpu->arch.sie_block->fpf &= ~FPF_BPBC;
+		vcpu->arch.sie_block->fpf |= kvm_run->s.regs.bpbc ? FPF_BPBC : 0;
+	}
 
 	if (guestdbg_exit_pending(vcpu) && !rc)  {
 		kvm_s390_prepare_debug_exit(vcpu);
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -831,6 +831,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_GUEST_DEBUG_HW_WPS 120
 #define KVM_CAP_SPLIT_IRQCHIP 121
 #define KVM_CAP_IOEVENTFD_ANY_LENGTH 122
+#define KVM_CAP_S390_BPB 152
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
