Return-Path: <kernel-hardening-return-13024-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+JwRK+6BAKnbiH7ew3vSlQMGDp5A/2f9YdlfIQ9acKLSnIiKCgubKK1D2esqD3rydL16Z3
ARC-Seal: i=1; a=rsa-sha256; t=1523990378; cv=none;
        d=google.com; s=arc-20160816;
        b=lMqXvNlsh9ORcH/ltyQLJQMYJ2MgJaBkW7TRNqt+4/PijznYjO/4wqI/fD0gjUqlrc
         syXKFctX5D6rDvwPRAnuv2wxDpnrjIUJanuVxGR4tWNX0fX4+2JYI3JNO3pvFZMWTQrO
         LsL+BAdMuOI0vJKDyldjihDHb84Yu7HAy1LJ8BOIbZWI78KuBG8qg6CfGFM8YyKr062Z
         Ge4AxeROJ6munbIWA+dHU8nFzTNK3f3vOjUGDkLIZY0v37VVoegW5MQ5Dp8UWhjvlyv5
         OamfEfoOw/TUQ36jZy4JvRdaVpmH3KnRNesUFnalzpRkN55AdKn5HVC7DV/abASNttFu
         l3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=I4QW1qdEk8tC8nDWOrEQmpFv3zVp92/g2kt8GUOONBg=;
        b=e25ZOMfraoZF1UHEmupVDVc1ElPluV8F0W+WZcG8KjNfDWIDHBbbUBqgJHooCnS+m/
         1KPEIwnmP8mC+AJlUIp3qxui1zU3GVu0Dh7WTFoKtSfGWsBKe0LCpFKfOdenKvoZuDhU
         hTWw7+RAVcWmGaiXtD6xUAblTcUbPtQJYQqaF06Yz/l2nM0TDTzS5KEhISuTriId1VUp
         cfMLSJ9lk+rCmCe9rjodTughc+ERpd+5rHz8XHc7kLc/Vn3jXrAr2ACtrwTFhm/4RfxB
         InFhu5aEoQH2m0mzzGpNO2+gkELomFQfIlc8ejp0nh5PGC0iTmgXuc4uKpnG9xghaf+m
         gKxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13024-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13024-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13024-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13024-gregkh=linuxfoundation.org@lists.openwall.com
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
Subject: [PATCHv3 09/11] arm64: perf: strip PAC when unwinding userspace
Date: Tue, 17 Apr 2018 19:37:33 +0100
Message-Id: <20180417183735.56985-10-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417183735.56985-1-mark.rutland@arm.com>
References: <20180417183735.56985-1-mark.rutland@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598019734783664993?=
X-GMAIL-MSGID: =?utf-8?q?1598019734783664993?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When the kernel is unwinding userspace callchains, we can't expect that
the userspace consumer of these callchains has the data necessary to
strip the PAC from the stored LR.

This patch has the kernel strip the PAC from user stackframes when the
in-kernel unwinder is used. This only affects the LR value, and not the
FP.

This only affects the in-kernel unwinder. When userspace performs
unwinding, it is up to userspace to strip PACs as necessary (which can
be determined from DWARF information).

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/pointer_auth.h | 7 +++++++
 arch/arm64/kernel/perf_callchain.c    | 5 ++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index 5ff141245633..a9ad81791c7f 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -79,6 +79,12 @@ static inline void ptrauth_keys_dup(struct ptrauth_keys *old,
  */
 #define ptrauth_pac_mask() 	GENMASK(54, VA_BITS)
 
+/* Only valid for EL0 TTBR0 instruction pointers */
+static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
+{
+	return ptr & ~ptrauth_pac_mask();
+}
+
 #define mm_ctx_ptrauth_init(ctx) \
 	ptrauth_keys_init(&(ctx)->ptrauth_keys)
 
@@ -89,6 +95,7 @@ static inline void ptrauth_keys_dup(struct ptrauth_keys *old,
 	ptrauth_keys_dup(&(oldctx)->ptrauth_keys, &(newctx)->ptrauth_keys)
 
 #else
+#define ptrauth_strip_insn_pac(lr)	(lr)
 #define mm_ctx_ptrauth_init(ctx)
 #define mm_ctx_ptrauth_switch(ctx)
 #define mm_ctx_ptrauth_dup(oldctx, newctx)
diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index bcafd7dcfe8b..928204f6ab08 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -35,6 +35,7 @@ user_backtrace(struct frame_tail __user *tail,
 {
 	struct frame_tail buftail;
 	unsigned long err;
+	unsigned long lr;
 
 	/* Also check accessibility of one struct frame_tail beyond */
 	if (!access_ok(VERIFY_READ, tail, sizeof(buftail)))
@@ -47,7 +48,9 @@ user_backtrace(struct frame_tail __user *tail,
 	if (err)
 		return NULL;
 
-	perf_callchain_store(entry, buftail.lr);
+	lr = ptrauth_strip_insn_pac(buftail.lr);
+
+	perf_callchain_store(entry, lr);
 
 	/*
 	 * Frame pointers should strictly progress back up the stack
-- 
2.11.0
