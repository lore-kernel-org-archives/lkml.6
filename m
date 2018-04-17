Return-Path: <kernel-hardening-return-13026-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48hwZp1S5bs2qI+hFsxDarkcxYmUGRbsWfFEY7hzsta39ZwU7kvA0+qND+xkDysMCXgn7b7
ARC-Seal: i=1; a=rsa-sha256; t=1523990403; cv=none;
        d=google.com; s=arc-20160816;
        b=J2GUwTUmym4Rw8iwiUsErNH+L+mmY7Y0wLPVSBRUYCJqGDirrEVCKHAPuLkFZRyw9i
         e6TFHQ+UI57p/AS7DgMsUI3yCl0y7I9gwMl38FkGb5lmDF9dHydXDRadlcsnlbMxNw+K
         G6UN1hOCsEtMt7rpt7lWYbeLN1NO1j6eySFPIfVe3rtnjeNxkDhg2RRiSN8FjZLIKVHK
         QvQ+DDPpRBSo8FCUA3WV7RYEzcubGIgIPO3q9QHFteBngLaeUpy1h1YMOsFkTyeJ2UXN
         5VoVwHHgn55Q7yLTuUmWY7eTN1unpNmHCJgqS9cncONKxxUZz8L082kg35uA5ryEBVt3
         Hj8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=4LVUTzyQ2OJXCHpF83tP6m/H15e7vVAfSJud/Ls2QQI=;
        b=adYVabbm4EhsrVEmPnTx4KhStcerME9ciucrXGM9f1fSD6y9Oxd1O6daJIrTaIOpvd
         hBlkaq5sskZEELUNWurdrH+FhaAJFMVq8o6rsbfcwU7Y+5SieTfNDtXV8/AOerMZ+7Q7
         yec47/S1Eqh+UQcykYjc+VC6rbVzPsaTKPCX/EpPg/9tK4dvBIuiVU80v0ZIG2Rr65zx
         z/r7nTRFCDT0Wmmo/Z2pvvEVFIQ6bFUy0dH1BVWIXSbrEU3Rm1vkZx8Y+wCg6bOepV/J
         9Vh7L7VZ0F4iaLgUL60Ub1+V5BF/5rnbxX9Ii9mHwFda1QxbtsRloz6KQvN77BXnBQdy
         XQ0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13026-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13026-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13026-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13026-gregkh=linuxfoundation.org@lists.openwall.com
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
Subject: [PATCHv3 10/11] arm64: enable pointer authentication
Date: Tue, 17 Apr 2018 19:37:34 +0100
Message-Id: <20180417183735.56985-11-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417183735.56985-1-mark.rutland@arm.com>
References: <20180417183735.56985-1-mark.rutland@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598019761501375375?=
X-GMAIL-MSGID: =?utf-8?q?1598019761501375375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that all the necessary bits are in place for userspace, add the
necessary Kconfig logic to allow this to be enabled.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index eb2cf4938f6d..d6ce16b1ee47 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1127,6 +1127,29 @@ config ARM64_RAS_EXTN
 
 endmenu
 
+menu "ARMv8.3 architectural features"
+
+config ARM64_PTR_AUTH
+	bool "Enable support for pointer authentication"
+	default y
+	help
+	  Pointer authentication (part of the ARMv8.3 Extensions) provides
+	  instructions for signing and authenticating pointers against secret
+	  keys, which can be used to mitigate Return Oriented Programming (ROP)
+	  and other attacks.
+
+	  This option enables these instructions at EL0 (i.e. for userspace).
+
+	  Choosing this option will cause the kernel to initialise secret keys
+	  for each process at exec() time, with these keys being
+	  context-switched along with the process.
+
+	  The feature is detected at runtime. If the feature is not present in
+	  hardware it will not be advertised to userspace nor will it be
+	  enabled.
+
+endmenu
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y
-- 
2.11.0
