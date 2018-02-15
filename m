Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227dDZcuBpqBboDUQru07q7Zn9ZNN9Z8EKT3mwiFhk1l+JWf2nb5d7RRDCWYFZgKTKzL7j2Y
ARC-Seal: i=1; a=rsa-sha256; t=1518708818; cv=none;
        d=google.com; s=arc-20160816;
        b=HuXi/ftDNqweTPcKpd/FFGPUOHv+y8bkG+KdTRL/4QXqGehl9CKIw8UlHB3R2tS9vO
         wxW5PKE4CDccH4s/j1ioUEoFZv2TomA6BK77b8nVZY0MRrvkoKhFnMZc++TSgBrxIGSt
         rx9jv0STZZgN6tsm1eztrhbqDzCbzhnDTrmFykogQODvHtzhAeK9oyV6py8oE07rp2bA
         eABkXYUVi1YlEdWe8l1t2tA+aCH638b9j2lAva0r4G/UftSv2ogV85tmbEiqlMptZ4js
         3N+bvrH81A7JyavpxbGSefBxu1WItJljj8k5mHN7SKm8Mir8y6y4hXJf26vraznPb9sr
         FaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AQ1BAuFHaAC71IWd5duUqBGWigWkmdfPG/tLchEWiwM=;
        b=OnYMmQ052XtDB7sWg4mbvBIqYOCxLtbkh/VgR98LlPpokrFIeA+vJCOP3uVQWJz6Ei
         BrNxNvZdoKjElWD9hj5vv3m1tkTTSD51I0QIkOyVxyb5QCcKdnYmxdMuynBoEJF9Ulph
         F5S8jO0cQn/sNwZtfx138EKmj+wI4UWaoTT0yycPi2Qxbodk+pV56EHGhUP/7ojkGBgy
         1YMLyA2TSIQ/zAUpHUwbOygoKU1VcBOP0E4IUE6ljSIZroeqtkJ9JN0RbpT7P76hKUR1
         W+L2EakuFKmScvF3dNvHcEqQoKeUpGPCuHBbybwz+mPbcQtklCdIB6vldryMaAgVfRkm
         RoMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 055/195] [Variant 3/Meltdown] arm64: idmap: Use "awx" flags for .idmap.text .pushsection directives
Date: Thu, 15 Feb 2018 16:15:46 +0100
Message-Id: <20180215151708.484383036@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481617965638958?=
X-GMAIL-MSGID: =?utf-8?q?1592481617965638958?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 439e70e27a51 upstream.

The identity map is mapped as both writeable and executable by the
SWAPPER_MM_MMUFLAGS and this is relied upon by the kpti code to manage
a synchronisation flag. Update the .pushsection flags to reflect the
actual mapping attributes.

Reported-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpu-reset.S |    2 +-
 arch/arm64/kernel/head.S      |    2 +-
 arch/arm64/kernel/sleep.S     |    2 +-
 arch/arm64/mm/proc.S          |    8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -16,7 +16,7 @@
 #include <asm/virt.h>
 
 .text
-.pushsection    .idmap.text, "ax"
+.pushsection    .idmap.text, "awx"
 
 /*
  * __cpu_soft_restart(el2_switch, entry, arg0, arg1, arg2) - Helper for
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -371,7 +371,7 @@ ENDPROC(__primary_switched)
  * end early head section, begin head code that is also used for
  * hotplug and needs to have the same protections as the text region
  */
-	.section ".idmap.text","ax"
+	.section ".idmap.text","awx"
 
 ENTRY(kimage_vaddr)
 	.quad		_text - TEXT_OFFSET
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -96,7 +96,7 @@ ENTRY(__cpu_suspend_enter)
 	ret
 ENDPROC(__cpu_suspend_enter)
 
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 ENTRY(cpu_resume)
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
 	bl	__cpu_setup
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -86,7 +86,7 @@ ENDPROC(cpu_do_suspend)
  *
  * x0: Address of context pointer
  */
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 ENTRY(cpu_do_resume)
 	ldp	x2, x3, [x0]
 	ldp	x4, x5, [x0, #16]
@@ -152,7 +152,7 @@ ENTRY(cpu_do_switch_mm)
 	ret
 ENDPROC(cpu_do_switch_mm)
 
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 
 .macro	__idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
 	adrp	\tmp1, empty_zero_page
@@ -185,7 +185,7 @@ ENDPROC(idmap_cpu_replace_ttbr1)
 	.popsection
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 
 	.macro	__idmap_kpti_get_pgtable_ent, type
 	dc	cvac, cur_\()\type\()p		// Ensure any existing dirty
@@ -373,7 +373,7 @@ ENDPROC(idmap_kpti_install_ng_mappings)
  *	Initialise the processor for turning the MMU on.  Return in x0 the
  *	value of the SCTLR_EL1 register.
  */
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 ENTRY(__cpu_setup)
 	tlbi	vmalle1				// Invalidate local TLB
 	dsb	nsh
