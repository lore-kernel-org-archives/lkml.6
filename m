Return-Path: <kernel-hardening-return-13021-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49NyOCt5/Cq+4ZxmUunI6uHdiOkpgGd/mHOGcjAwxiufdYs9neAyNLksKB122h1PjABAwI3
ARC-Seal: i=1; a=rsa-sha256; t=1523990348; cv=none;
        d=google.com; s=arc-20160816;
        b=GmNq1CiwXq6QBIHxBmGNQc5JQB44ki+2LnPUfkNSO1nhUxqGNpiVM3259qxN7UAC6M
         Qq5doEFWKrteBf9/ioyvCWxjQ+2+baqoEAoXfZA9zmgyj8KiPzuyMFV0oBpTNP3pgHug
         QziKKWJXLCcZdrR35cVwuVTpgRWhM2xvGljothxi3+Vy9XnNePxmmM1ZXhjydBUNNgdy
         ToiGW2AIuz282eNo33v/E1QwHCHsqLzWwBY5oesN82jwzVEUlPUCBOWxPLwxV7taWmtf
         8JZs9nB2x7UtPqIXcdeaJxW6koca94VR51RMylG6/gZKtBAhAlQP4AG1DnEmiXm7f9wU
         ioBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=Fn8xtB+CwNlvAku6GAuXB7RMe1286hdtILaL+6SVwIU=;
        b=Rj0wvC2jJGFmJ4OY6y4yINSjmeo+wKGV964G9r4NBbRN9WEUWKplkor69+lPKE6s/o
         1p0lHQZijFxg5OUpV1gVgu5AzSaiPyZ4oSmY/J7wK0tOdCOIVl+niRv6tFAjsKjUeJxT
         LfXk02qkKWUoJXKWvwQRSygq9rfs58CzF8kZ7BkpNGtz70o9h47YRiXFygeQxIjQ2J1j
         xSPxjmRRACRB7uljcTU6lxSTOTZyFqwBsLCxR9/W+VozqwP9LNC6nh4itwNC20Z+GU88
         N8pyXgl2VUIrw3YV92OmHRhb+gSNfrwi1f+q6+cuEaIotwi8xkyQvkH9YaNJ+oHQN4N0
         y/fA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13021-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13021-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13021-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13021-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de,
	catalin.marinas@arm.com,
	cdall@kernel.org,
	drjones@redhat.com,
	kvmarm@lists.cs.columbia.edu,
	linux-arch@vger.kernel.org,
	marc.zyngier@arm.com,
	mark.rutland@arm.com,
	ramana.radhakrishnan@arm.com,
	suzuki.poulose@arm.com,
	will.deacon@arm.com,
	linux-kernel@vger.kernel.org,
	awallis@codeaurora.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCHv3 04/11] arm64: Don't trap host pointer auth use to EL2
Date: Tue, 17 Apr 2018 19:37:28 +0100
Message-Id: <20180417183735.56985-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417183735.56985-1-mark.rutland@arm.com>
References: <20180417183735.56985-1-mark.rutland@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598019703538856592?=
X-GMAIL-MSGID: =?utf-8?q?1598019703538856592?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To allow EL0 (and/or EL1) to use pointer authentication functionality,
we must ensure that pointer authentication instructions and accesses to
pointer authentication keys are not trapped to EL2.

This patch ensures that HCR_EL2 is configured appropriately when the
kernel is booted at EL2. For non-VHE kernels we set HCR_EL2.{API,APK},
ensuring that EL1 can access keys and permit EL0 use of instructions.
For VHE kernels host EL0 (TGE && E2H) is unaffected by these settings,
and it doesn't matter how we configure HCR_EL2.{API,APK}, so we don't
bother setting them.

This does not enable support for KVM guests, since KVM manages HCR_EL2
itself when running VMs.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
---
 arch/arm64/include/asm/kvm_arm.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 89b3dda7e3cb..4d57e1e58323 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -23,6 +23,8 @@
 #include <asm/types.h>
 
 /* Hyp Configuration Register (HCR) bits */
+#define HCR_API		(UL(1) << 41)
+#define HCR_APK		(UL(1) << 40)
 #define HCR_TEA		(UL(1) << 37)
 #define HCR_TERR	(UL(1) << 36)
 #define HCR_TLOR	(UL(1) << 35)
@@ -86,7 +88,7 @@
 			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW | HCR_TLOR | \
 			 HCR_FMO | HCR_IMO)
 #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
-#define HCR_HOST_NVHE_FLAGS (HCR_RW)
+#define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK)
 #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
 
 /* TCR_EL2 Registers bits */
-- 
2.11.0
