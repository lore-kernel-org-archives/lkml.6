Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Oygvc8yZKsV+hf0gGATK+5m6avjlA/gfmoYKnOJg8oJtxT7tVy78bEy8YgyJXkQWQTJcx
ARC-Seal: i=1; a=rsa-sha256; t=1523981300; cv=none;
        d=google.com; s=arc-20160816;
        b=BCj1XAmrWEt5oECvrF+77xS4e13GRnR0O6o+5EXdWeo78+MbsnE2P8mxV3rRjnaRBm
         0NkYdMoOpWWd2AW7AF9AhuFz4lZGyqnniyRQ3oaIsYAOO8gtQy7XIQ0V0eS+IhY2iAJ+
         Q85lDVSmeOmtFuyY9ZXaEM5EH+NRge8rtfrHaVUggKJT/wY2BaevuVuLamC5YYe5u1/5
         4okN5OHSbcV1dY+jdacwd+1HyjFywRSybNd5IvyxwgJjGDes/fQj/Nz8c0hA320GfQPL
         iJRWDt3q4BSrarTZdCOQUHsuQSVf901LXXvCFtDYUC6neWkv6Ujibct4WsQLHOEFuc9J
         PoPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iZcw+pFAp4yCcJy/h3rn/hHEhVJh9sx/9bxLep2++iU=;
        b=ZLVafMC/X1fCaTej85n1ok1TQ8lPO4OcQFgnRFVrKV5IatvuO0pZlaIoP5/IeYphxA
         cm79KQA07U6HKShCXYVNt6ZTJgqnnJ1rfcYVt/b64KdVQj9VyqcU0FvPQOR6T1IL4XZi
         7ZxURYXmPA7brD+9RdZGlukgH+0+x/jgCBzCALFrWZp4WNYwhVK8Uf3VrBYAnDM1LAVu
         hxaUobH8CgTKwPlD7NOOjKcJqvgskIh6rvQ87INNz4vbyCh+rBDw4POczlQCs6YudU1V
         A7muj1OX0cnXXOzk7/UlzUlZlfgGzIvIJHEb6VGRpCvIo4KMLdWOLLneLaJTi5vZfqic
         beQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 4.9 15/66] arm64: entry: Ensure branch through syscall table is bounded under speculation
Date: Tue, 17 Apr 2018 17:58:48 +0200
Message-Id: <20180417155646.506079589@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010215681504669?=
X-GMAIL-MSGID: =?utf-8?q?1598010215681504669?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Will Deacon <will.deacon@arm.com>

commit 6314d90e64936c584f300a52ef173603fb2461b5 upstream.

In a similar manner to array_index_mask_nospec, this patch introduces an
assembly macro (mask_nospec64) which can be used to bound a value under
speculation. This macro is then used to ensure that the indirect branch
through the syscall table is bounded under speculation, with out-of-range
addresses speculating as calls to sys_io_setup (0).

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[v4.9: use existing scno & sc_nr definitions]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/assembler.h |   11 +++++++++++
 arch/arm64/kernel/entry.S          |    1 +
 2 files changed, 12 insertions(+)

--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -94,6 +94,17 @@
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
@@ -795,6 +795,7 @@ el0_svc_naked:					// compat entry point
 	b.ne	__sys_trace
 	cmp     scno, sc_nr                     // check upper syscall limit
 	b.hs	ni_sys
+	mask_nospec64 scno, sc_nr, x19	// enforce bounds for syscall number
 	ldr	x16, [stbl, scno, lsl #3]	// address in the syscall table
 	blr	x16				// call sys_* routine
 	b	ret_fast_syscall
