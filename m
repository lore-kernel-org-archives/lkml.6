Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227ZnF9OddNQM7D40YznkFV0qZjvB3+9uNTbJBPxIdAF3EH+oO4VuexLrq8pyPCikQUbDn+f
ARC-Seal: i=1; a=rsa-sha256; t=1518709346; cv=none;
        d=google.com; s=arc-20160816;
        b=vQcRHiKGx7NOq1g6kMJ3oFpybk6SXrcIABrei6YEm69NnP//l0LA94az2DfUIHNT3Q
         CDoQf7iM+tdohWodRLZg/TAQXiV3TnZBY++6tKUZ9jxwBkMZdeMxdmV2jEJ5hpy/t5YV
         BVW3KkpzkeJPwv+FiwEDd1r/5wdpr7W8oBHMwXTewOrfajoed7ltnBe8cgTS/55cVXc1
         kz1mbYRrgx6j40VeX7gnrjIFYWXjVl7JVfOnPI0vx9QuoaOzri2cZKLGBsBHbWK/xU9G
         zBSGa7tOnofddLsvIkLHoxNsSTGDVgZ4GLt8x3CsRV/mIW5QlVAMe+r/GAi10atEdnNt
         z7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lErbmpuGUm4FXeezRLGdKMo3/VBqIvY4/u5Y6eMeBwM=;
        b=H+jHlBm/9L4cPS+UsoefIDAZ85khSUAbBKq+ZlWMUbEGXyb8o38j80vTWAkbibw+xJ
         PBKyUhPZFMueGcYTu5NTSrAcaQ9UI2nJIaNgyCK0nGRZUhCWEcSUJWFgkgP/9l4yvgMV
         JS+bPwa6v0nOYdIsc+5DdirHYmhr518XlvVi3CCDkfJCvL6Ydvciv65jbF/Z71ltuV6r
         gGvTR1hh1K8VKzkVnFxjT/WyQ5L/83eef+t7cWKFkF0M3mKY6VXS67a4qAUcy1I3vNpX
         qSYAt9zKJwt6YI2ekWqv0poHiQRNSsXpKf2cnjuhLTtR1vsLjowf0YTXt1SoiGL3zX+n
         W4bw==
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
Subject: [PATCH 4.15 049/202] [Variant 1/Spectre-v1] arm64: barrier: Add CSDB macros to control data-value prediction
Date: Thu, 15 Feb 2018 16:15:49 +0100
Message-Id: <20180215151715.780120327@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481620719505373?=
X-GMAIL-MSGID: =?utf-8?q?1592482172583067929?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 669474e772b9 upstream.

For CPUs capable of data value prediction, CSDB waits for any outstanding
predictions to architecturally resolve before allowing speculative execution
to continue. Provide macros to expose it to the arch code.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Conflicts:
	arch/arm64/include/asm/assembler.h
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/assembler.h |    7 +++++++
 arch/arm64/include/asm/barrier.h   |    1 +
 2 files changed, 8 insertions(+)

--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -109,6 +109,13 @@
 	.endm
 
 /*
+ * Value prediction barrier
+ */
+	.macro	csdb
+	hint	#20
+	.endm
+
+/*
  * NOP sequence
  */
 	.macro	nops, num
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -32,6 +32,7 @@
 #define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
 
 #define psb_csync()	asm volatile("hint #17" : : : "memory")
+#define csdb()		asm volatile("hint #20" : : : "memory")
 
 #define mb()		dsb(sy)
 #define rmb()		dsb(ld)
