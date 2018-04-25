Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZr+mdOcrfyn9eOMpnDOC3nEiccr7vUC4t5YNARCIFrisXUiBHdcIAs1oMp+Liq2Tn2YulZQ
ARC-Seal: i=1; a=rsa-sha256; t=1524652666; cv=none;
        d=google.com; s=arc-20160816;
        b=zN4Ty3crIFZDZRDr94A8caOS31ZFg1px9iS9fEGvS3B88ZZqYldEvZtbIc4AVjUI1j
         0wwo0Wj0VKs9OWW9aTw18UsAClOG5HdJ6IA2F5juO0Lksm5PFo2lWJvV6B1StOUmMEin
         m7FpFCxo5jWJmdkmSbJ8ApXvst5cYByf7RLajQlAwTopaiCMI4NtNpVs3Vfs//AQTHS/
         DAGN4ZSWUIAggLFqa+J/GgrswQ984u6zuvh40s5BQZEaqPW9LaKSH4ODEOmphVFJaWNp
         7fMVkavSfgTZHSpBEFTRtR2wwYJ0vkr8otKf1IZlvi1XwGsTg5KmPXk2SRL+gDvXoDVe
         c6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=goTtXt/hAn3fCEO6JkKZtxNEMxUF2ZwJLbpYRqnZ5C8=;
        b=Sb//MH1OQQ2alJSQDuX9wuOPzeAhjzhZyL56q1V4Ukw7wJ5ZghUN0EKT+0rlCi2/wl
         5ofDr4nIiWwzz8kT9XJMFyQBSD7phsuzcIMNn/DQuSTKerfwnt0FEVz79Wt5I1hFrrTf
         Rwu8DTUSx04mwC/PCRMTNcdWx312x+91tXT2iQ1W8LNNxwnI+Z/i44j4ULKS0+S7maof
         FcN1QjQBUAk2KBVbj83s9lYo0s5mgSCvWJw5h+Uz83JNaFQVrzKIjDKp8QbKhX4Ml+M+
         8VZiEzVT2odHc7B1c8MVe47nAjJT8zjMBE93FCWL0e6iVDHGq2dlpwi3plVS/Tp98lVb
         JdHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paul Mackerras <paulus@ozlabs.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 024/183] KVM: PPC: Book3S HV: Enable migration of decrementer register
Date: Wed, 25 Apr 2018 12:34:04 +0200
Message-Id: <20180425103243.573996837@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714193779602420?=
X-GMAIL-MSGID: =?utf-8?q?1598714193779602420?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Mackerras <paulus@ozlabs.org>


[ Upstream commit 5855564c8ab2d9cefca7b2933bd19818eb795e40 ]

This adds a register identifier for use with the one_reg interface
to allow the decrementer expiry time to be read and written by
userspace.  The decrementer expiry time is in guest timebase units
and is equal to the sum of the decrementer and the guest timebase.
(The expiry time is used rather than the decrementer value itself
because the expiry time is not constantly changing, though the
decrementer value is, while the guest vcpu is not running.)

Without this, a guest vcpu migrated to a new host will see its
decrementer set to some random value.  On POWER8 and earlier, the
decrementer is 32 bits wide and counts down at 512MHz, so the
guest vcpu will potentially see no decrementer interrupts for up
to about 4 seconds, which will lead to a stall.  With POWER9, the
decrementer is now 56 bits side, so the stall can be much longer
(up to 2.23 years) and more noticeable.

To help work around the problem in cases where userspace has not been
updated to migrate the decrementer expiry time, we now set the
default decrementer expiry at vcpu creation time to the current time
rather than the maximum possible value.  This should mean an
immediate decrementer interrupt when a migrated vcpu starts
running.  In cases where the decrementer is 32 bits wide and more
than 4 seconds elapse between the creation of the vcpu and when it
first runs, the decrementer would have wrapped around to positive
values and there may still be a stall - but this is no worse than
the current situation.  In the large-decrementer case, we are sure
to get an immediate decrementer interrupt (assuming the time from
vcpu creation to first run is less than 2.23 years) and we thus
avoid a very long stall.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/virtual/kvm/api.txt   |    1 +
 arch/powerpc/include/uapi/asm/kvm.h |    2 ++
 arch/powerpc/kvm/book3s_hv.c        |    8 ++++++++
 arch/powerpc/kvm/powerpc.c          |    2 +-
 4 files changed, 12 insertions(+), 1 deletion(-)

--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1837,6 +1837,7 @@ registers, find a list below:
   PPC	| KVM_REG_PPC_DBSR              | 32
   PPC   | KVM_REG_PPC_TIDR              | 64
   PPC   | KVM_REG_PPC_PSSCR             | 64
+  PPC   | KVM_REG_PPC_DEC_EXPIRY        | 64
   PPC   | KVM_REG_PPC_TM_GPR0           | 64
           ...
   PPC   | KVM_REG_PPC_TM_GPR31          | 64
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -607,6 +607,8 @@ struct kvm_ppc_rmmu_info {
 #define KVM_REG_PPC_TIDR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbc)
 #define KVM_REG_PPC_PSSCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbd)
 
+#define KVM_REG_PPC_DEC_EXPIRY	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbe)
+
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
  */
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1497,6 +1497,10 @@ static int kvmppc_get_one_reg_hv(struct
 	case KVM_REG_PPC_ARCH_COMPAT:
 		*val = get_reg_val(id, vcpu->arch.vcore->arch_compat);
 		break;
+	case KVM_REG_PPC_DEC_EXPIRY:
+		*val = get_reg_val(id, vcpu->arch.dec_expires +
+				   vcpu->arch.vcore->tb_offset);
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -1724,6 +1728,10 @@ static int kvmppc_set_one_reg_hv(struct
 	case KVM_REG_PPC_ARCH_COMPAT:
 		r = kvmppc_set_arch_compat(vcpu, set_reg_val(id, *val));
 		break;
+	case KVM_REG_PPC_DEC_EXPIRY:
+		vcpu->arch.dec_expires = set_reg_val(id, *val) -
+			vcpu->arch.vcore->tb_offset;
+		break;
 	default:
 		r = -EINVAL;
 		break;
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -758,7 +758,7 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *
 
 	hrtimer_init(&vcpu->arch.dec_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
 	vcpu->arch.dec_timer.function = kvmppc_decrementer_wakeup;
-	vcpu->arch.dec_expires = ~(u64)0;
+	vcpu->arch.dec_expires = get_tb();
 
 #ifdef CONFIG_KVM_EXIT_TIMING
 	mutex_init(&vcpu->arch.exit_timing_lock);
