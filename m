Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227MLZAR2jagcVUdKBkatlWHlVFXjjmxfMvDSD9rFq22JiQ1L/C9GfMyLBtfFhaEH411VnqO
ARC-Seal: i=1; a=rsa-sha256; t=1518709357; cv=none;
        d=google.com; s=arc-20160816;
        b=yiigUpMKLGbxIVw8FHjTkOfCIDlCmaaz2YgwNuV7mLlL/2eQj7IXGqte+7DhFk1t+x
         l2YbUTvvY3PnQBDyaq7BxcfvIK2EqHtVicThfITP4BwkjOFLVDLxuFoZj36mgYU0sf9F
         y1LCUX9a3a3GKrJG6BgiboMXOi/Ty72cn9y9nZD53gvkFBhMQVgnV/QWwbD0S16jPqb/
         fk2VKsoVAHifIbRTUX6BZuluCaaIT6fBTx+1OqStHAOmAGLd6pFlgcJilwj3r9IX05AZ
         75nythgTn5EaJpPO52l3XzT5pWBOAFA2tJU9z+Y0GCSopQ1n8lV8Lz6vit/er5M/KyTs
         VgbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AjqPufArAALc9zRTgk/YEekF0mYqYH08r8DYC6Xcsto=;
        b=lcJMnZCs7GtfqF/y6iG2bIMr+bWcTrkEMaHW/nH3LOxGc7LGRWQ+mJO+VYM2/yxEXR
         F2U4eHrtfgtfsblcFxLdqH+HPGzuSY+4m8Ray7FNd3Ck89gZKT7BTP/jKfz0z/ktLRih
         hGrgRc/muv4WU0St5x2lZN5nLAOx8USsmPjnQ8VRPKQroyX695jwjETQytX8rziBR05r
         LJ62w8h1a5c1qcHejk/HSDiraUpd20XnhvAuJ1Tc8+7J3eFqypYiSLg4fEbnfQstqrjy
         0Z/bPAo+D2PwYysbAStNwNYjA6bOZ7CXe57qXUyjfuI0TQ5JyuwR6DJ671komtbr0Ga2
         C9Zg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 053/202] [Variant 1/Spectre-v1] arm64: entry: Ensure branch through syscall table is bounded under speculation
Date: Thu, 15 Feb 2018 16:15:53 +0100
Message-Id: <20180215151716.007874324@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481526327320243?=
X-GMAIL-MSGID: =?utf-8?q?1592482183604496847?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 6314d90e6493 upstream.

In a similar manner to array_index_mask_nospec, this patch introduces an
assembly macro (mask_nospec64) which can be used to bound a value under
speculation. This macro is then used to ensure that the indirect branch
through the syscall table is bounded under speculation, with out-of-range
addresses speculating as calls to sys_io_setup (0).

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/assembler.h |   11 +++++++++++
 arch/arm64/kernel/entry.S          |    2 ++
 2 files changed, 13 insertions(+)

--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -116,6 +116,17 @@
 	.endm
 
 /*
+ * Sanitise a 64-bit bounded index wrt speculation, returning zero if out
+ * of bounds.
+ */
+	.macro	mask_nospec64, idx, limit, tmp
+	sub	\tmp, \idx, \limit
+	bic	\tmp, \tmp, \idx
+	and	\idx, \idx, \tmp, asr #63
+	csdb
+	.endm
+
+/*
  * NOP sequence
  */
 	.macro	nops, num
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -378,6 +378,7 @@ alternative_insn eret, nop, ARM64_UNMAP_
  * x7 is reserved for the system call number in 32-bit mode.
  */
 wsc_nr	.req	w25		// number of system calls
+xsc_nr	.req	x25		// number of system calls (zero-extended)
 wscno	.req	w26		// syscall number
 xscno	.req	x26		// syscall number (zero-extended)
 stbl	.req	x27		// syscall table pointer
@@ -932,6 +933,7 @@ el0_svc_naked:					// compat entry point
 	b.ne	__sys_trace
 	cmp     wscno, wsc_nr			// check upper syscall limit
 	b.hs	ni_sys
+	mask_nospec64 xscno, xsc_nr, x19	// enforce bounds for syscall number
 	ldr	x16, [stbl, xscno, lsl #3]	// address in the syscall table
 	blr	x16				// call sys_* routine
 	b	ret_fast_syscall
