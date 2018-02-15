Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225feodh4sadam/fuTuUcDBLYMkDCpM+Da9ymQaczI2WSCES7Hbk1p6i32iB1GTBoLYqBMoz
ARC-Seal: i=1; a=rsa-sha256; t=1518709317; cv=none;
        d=google.com; s=arc-20160816;
        b=zZGMb33pmoZesAaQvqOKLX/xDn2zE6XVPW4g7r3DFNJ915oIAmdIpEPW3yFHppJFI7
         PcXske7cVbPQs1gaMOWuYQH0On7x42nZ1gDXruWEWMmq5YT4K6rvWg+7sWwPboRw1Z44
         7RuwHZWoMsnSxOCOmVqCvHzXuBV0qxYzbUpSzju1xSMHlcFQQtWHWwlwXf7FmF9x274y
         EaAMgglS3WU332HlnlN/sMV50lbuEUU2QO5IrEMG1ct9QKI3ng0PbF6uVmh8AKTBdkH6
         o+ScdW6i8JJVtMee69t/5tgKn4M0UfMB1VBMjwC4KmDtVHTyGVGsnjnKS/pp36X4f/GV
         7U3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1B/KvN3RrHJCQsG8pKVDcVEmzfuYylXy4CTaf2FBV8M=;
        b=mCz8Yvc4wHVSJLiBOTVQZBAG0vAW0kt9j47KZsWGwlREOr7ZV/zA/frD6bAp8WscKA
         pmy6b/8dW0jvDyZ+NyqZB7Kqm3KtH5bdWFoqdBhuGG7nPDA41tpzgpPuH8u3RaxqWeSs
         lR247i9RSpOR7V1k0Ikd3ntTsMINu2ce+HQVMI7MO4BI5SpinJPW/lrTes0FkXfI5dt/
         SpPFKnSXZjXd4KpEBU3SHh1LeeVrnzNDnlcd+sfCxhadz6zkbutFetY3PL7iyA58fKnu
         6PC3iVMJSBRqhizBdNtQ96oL3Mto8H4ABVJg2Jq+CRt1+YFVlLntkXUeZ4EUX95kPpaY
         32kA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 074/202] [Variant 2/Spectre-v2] arm/arm64: KVM: Add PSCI_VERSION helper
Date: Thu, 15 Feb 2018 16:16:14 +0100
Message-Id: <20180215151717.364509633@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481591958290613?=
X-GMAIL-MSGID: =?utf-8?q?1592482140591680187?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit d0a144f12a7c upstream.

As we're about to trigger a PSCI version explosion, it doesn't
hurt to introduce a PSCI_VERSION helper that is going to be
used everywhere.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/kvm/arm_psci.h    |    6 ++++--
 include/uapi/linux/psci.h |    3 +++
 virt/kvm/arm/psci.c       |    4 +---
 3 files changed, 8 insertions(+), 5 deletions(-)

--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -18,8 +18,10 @@
 #ifndef __KVM_ARM_PSCI_H__
 #define __KVM_ARM_PSCI_H__
 
-#define KVM_ARM_PSCI_0_1	1
-#define KVM_ARM_PSCI_0_2	2
+#include <uapi/linux/psci.h>
+
+#define KVM_ARM_PSCI_0_1	PSCI_VERSION(0, 1)
+#define KVM_ARM_PSCI_0_2	PSCI_VERSION(0, 2)
 
 int kvm_psci_version(struct kvm_vcpu *vcpu);
 int kvm_psci_call(struct kvm_vcpu *vcpu);
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -88,6 +88,9 @@
 		(((ver) & PSCI_VERSION_MAJOR_MASK) >> PSCI_VERSION_MAJOR_SHIFT)
 #define PSCI_VERSION_MINOR(ver)			\
 		((ver) & PSCI_VERSION_MINOR_MASK)
+#define PSCI_VERSION(maj, min)						\
+	((((maj) << PSCI_VERSION_MAJOR_SHIFT) & PSCI_VERSION_MAJOR_MASK) | \
+	 ((min) & PSCI_VERSION_MINOR_MASK))
 
 /* PSCI features decoding (>=1.0) */
 #define PSCI_1_0_FEATURES_CPU_SUSPEND_PF_SHIFT	1
--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -25,8 +25,6 @@
 
 #include <kvm/arm_psci.h>
 
-#include <uapi/linux/psci.h>
-
 /*
  * This is an implementation of the Power State Coordination Interface
  * as described in ARM document number ARM DEN 0022A.
@@ -222,7 +220,7 @@ static int kvm_psci_0_2_call(struct kvm_
 		 * Bits[31:16] = Major Version = 0
 		 * Bits[15:0] = Minor Version = 2
 		 */
-		val = 2;
+		val = KVM_ARM_PSCI_0_2;
 		break;
 	case PSCI_0_2_FN_CPU_SUSPEND:
 	case PSCI_0_2_FN64_CPU_SUSPEND:
