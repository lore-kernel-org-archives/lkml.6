Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226WER2rlUiEVh8Oa76iYoJ2gBcLMD/kTmNWSitAFYfb6/8VMn28Y7DPjNVu5mCQH0J6U4Ac
ARC-Seal: i=1; a=rsa-sha256; t=1518708668; cv=none;
        d=google.com; s=arc-20160816;
        b=z+hgIZwylT9LbzneGrrVnLS5wKwZU1P83QteG/SgmmqEGPgmS1GGiC9dsg3hgA/mCC
         TW3HjVcA+RAu9oGO2xgYo7NAdi7uIF9BLHAcjzwCuglSs3Uj4Xw2s2N4FpU+k6S+/xGt
         58MbkW+NDDAqJ2ZvdcWaZL1HbawuFKLCP/FFQlIa3mpS8qC4coE/+fNIMnSOh+mHLq/+
         AZJKTYu40yO81AVlu/2viakPdfSxrtJFmtpSIMrLRWucStmm8RxMXsz0w/uavM8cDzmd
         9qq9L579cPcKjypCdyaeepqfqcJbf4/6ugb/wMJhAIHjfszzESiIe1qvRD6G7CWWkXtv
         H48Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ra8AphYWeL84vxSIuY1Aryy/As3v66TDPaTfYjp50xc=;
        b=oAyhsMU7FN4IgHKpLb4iNxYLn0Fa/uwPvzGtk7rwNkdWNqYXTxlz5xtbLe3sV2nHb4
         wr/9lnzecClpfsng4nZ85BzhcxIppd6LvlnisRUKkgxO4gC4CjeGexEQ63LbtxrGeyij
         ssd0RlWq39bfkWaVQo6+R/9LhxSHd4lPnc6G+1gHzPe0BgsjPeTVr6SkaNcel0tiyy7d
         INh+hhGROmgYs52c+geaMl8u1rJ5O/zgvFeKmBZyzeBbTcJYN8ANxFYgOU7asgxEBeNj
         A/AzA7p9qhWJBF1KZ5E/QKQH74f6kn5hENRs0kEU6cOs3jmZiWqugtkoE3K513D5Nfzz
         VH4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Laura Abbott <labbott@redhat.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 036/195] [Variant 3/Meltdown] arm64: erratum: Work around Falkor erratum #E1003 in trampoline code
Date: Thu, 15 Feb 2018 16:15:27 +0100
Message-Id: <20180215151707.555503500@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481460953332607?=
X-GMAIL-MSGID: =?utf-8?q?1592481460953332607?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit d1777e686ad1 upstream.

We rely on an atomic swizzling of TTBR1 when transitioning from the entry
trampoline to the kernel proper on an exception. We can't rely on this
atomicity in the face of Falkor erratum #E1003, so on affected cores we
can issue a TLB invalidation to invalidate the walk cache prior to
jumping into the kernel. There is still the possibility of a TLB conflict
here due to conflicting walk cache entries prior to the invalidation, but
this doesn't appear to be the case on these CPUs in practice.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/Kconfig        |   17 +++++------------
 arch/arm64/kernel/entry.S |   12 ++++++++++++
 2 files changed, 17 insertions(+), 12 deletions(-)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -504,20 +504,13 @@ config CAVIUM_ERRATUM_30115
 config QCOM_FALKOR_ERRATUM_1003
 	bool "Falkor E1003: Incorrect translation due to ASID change"
 	default y
-	select ARM64_PAN if ARM64_SW_TTBR0_PAN
 	help
 	  On Falkor v1, an incorrect ASID may be cached in the TLB when ASID
-	  and BADDR are changed together in TTBRx_EL1. The workaround for this
-	  issue is to use a reserved ASID in cpu_do_switch_mm() before
-	  switching to the new ASID. Saying Y here selects ARM64_PAN if
-	  ARM64_SW_TTBR0_PAN is selected. This is done because implementing and
-	  maintaining the E1003 workaround in the software PAN emulation code
-	  would be an unnecessary complication. The affected Falkor v1 CPU
-	  implements ARMv8.1 hardware PAN support and using hardware PAN
-	  support versus software PAN emulation is mutually exclusive at
-	  runtime.
-
-	  If unsure, say Y.
+	  and BADDR are changed together in TTBRx_EL1. Since we keep the ASID
+	  in TTBR1_EL1, this situation only occurs in the entry trampoline and
+	  then only for entries in the walk cache, since the leaf translation
+	  is unchanged. Work around the erratum by invalidating the walk cache
+	  entries for the trampoline before entering the kernel proper.
 
 config QCOM_FALKOR_ERRATUM_1009
 	bool "Falkor E1009: Prematurely complete a DSB after a TLBI"
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -941,6 +941,18 @@ __ni_sys_trace:
 	sub	\tmp, \tmp, #(SWAPPER_DIR_SIZE + RESERVED_TTBR0_SIZE)
 	bic	\tmp, \tmp, #USER_ASID_FLAG
 	msr	ttbr1_el1, \tmp
+#ifdef CONFIG_QCOM_FALKOR_ERRATUM_1003
+alternative_if ARM64_WORKAROUND_QCOM_FALKOR_E1003
+	/* ASID already in \tmp[63:48] */
+	movk	\tmp, #:abs_g2_nc:(TRAMP_VALIAS >> 12)
+	movk	\tmp, #:abs_g1_nc:(TRAMP_VALIAS >> 12)
+	/* 2MB boundary containing the vectors, so we nobble the walk cache */
+	movk	\tmp, #:abs_g0_nc:((TRAMP_VALIAS & ~(SZ_2M - 1)) >> 12)
+	isb
+	tlbi	vae1, \tmp
+	dsb	nsh
+alternative_else_nop_endif
+#endif /* CONFIG_QCOM_FALKOR_ERRATUM_1003 */
 	.endm
 
 	.macro tramp_unmap_kernel, tmp
