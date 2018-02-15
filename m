Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227+kRqSKsUF7OTWDNOnpVx7FGwrw1GHvgJKycfzblDmuHc+bYVX+xG3S1WyoeIx9Hm8ttuF
ARC-Seal: i=1; a=rsa-sha256; t=1518708821; cv=none;
        d=google.com; s=arc-20160816;
        b=Tpz3EtRkGarpuP5R0GuzVxzpupAJvfgXU4f99P2vcTzLEGoPJPWjgZ/dvHdOO7KcPH
         cRlpM30c2cuZFp0PiswlwiVs3sVN3xPn0/DC03SiLfTP1U3CYwfa64bD5yeTkwtFG8+B
         8rtOiYvPLXFCISvkAlhni6xsz+Rb6xtNR/c+Nfb5XUH8EVG2NqFHRSd64Yg+mwPWlaNl
         UBUFQAGdyMzPrU7sE6UahALIFdWMdYn/xS4n2ZjCkgTjvEl0toQI5TYB+x4QU3Fn4Gkf
         J9/bKwqjNQ6tRcHI13hzksW00i2xKki4VB/VNtCTTlWqBpheYo7qB/TFL+eUOlCmguzE
         OReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LVgUfovXsXmxcpfRpioJfHhgGFLt6Z0L1RS2ftlifyA=;
        b=Q9nOPhW/7Cf1zQhLP0Ks3tJUt/TuspnhVGIPO7J2TxTPjQ+UMvY+JZfwZMq4Jsm5LA
         KUgItl8HaXxXDzTXNtRV5Rdi2Bgkl8VAbGw+nt3VF/rNSS6ZQZ31gXIEFN6n+/p5K6pm
         n0YzUgFcb+9BYlcaZxcosomrNtIsA6ciORlUaz907Ks0ocieDEMs8z+p6SZMBfkG9Znr
         Pl0WO97ITEY9Rr+dyR/EK1tyZj1V0seSEcjQq1YckJkQlC5NvJvFMFsLWasrycPFwC1K
         KMAeOAToVKh4v3Rx4FfNWz2GJTZF/Ru2HLM0k4SRoDqA5jo24CLL5BQfyAUhyB0675X+
         gQlw==
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 056/195] [Variant 1/Spectre-v1] arm64: barrier: Add CSDB macros to control data-value prediction
Date: Thu, 15 Feb 2018 16:15:47 +0100
Message-Id: <20180215151708.535992836@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481620719505373?=
X-GMAIL-MSGID: =?utf-8?q?1592481620719505373?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 669474e772b9 upstream.

For CPUs capable of data value prediction, CSDB waits for any outstanding
predictions to architecturally resolve before allowing speculative execution
to continue. Provide macros to expose it to the arch code.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/assembler.h |    7 +++++++
 arch/arm64/include/asm/barrier.h   |    2 ++
 2 files changed, 9 insertions(+)

--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -96,6 +96,13 @@
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
@@ -31,6 +31,8 @@
 #define dmb(opt)	asm volatile("dmb " #opt : : : "memory")
 #define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
 
+#define csdb()		asm volatile("hint #20" : : : "memory")
+
 #define mb()		dsb(sy)
 #define rmb()		dsb(ld)
 #define wmb()		dsb(st)
