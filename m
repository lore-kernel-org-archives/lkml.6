Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+0uOGPsJsywY6cACGjlv6VGBMtiu6EfEKdMcJQkrMOIceHiSOhjoe6SaeuWBPGQXC3BhTK
ARC-Seal: i=1; a=rsa-sha256; t=1523021745; cv=none;
        d=google.com; s=arc-20160816;
        b=zCt2NUhrW/JPb0sNjeXA6sxgSja08xzG4hX75B+vpaLTljGpB+QHwcNxu2j+GaxQSO
         hG55yZCeKuVCIE+nIjNldl3kBTxhNPTnCgHmWb3FmKbUJODM04/Jx0euvip/q5E6eMMx
         nln01iwB8wtvwHSBPRyvFZkCJvYTTve6yWV7/I6hxVqztMG4yjPWzLG5WoNrMacNTv+1
         DCajbUFD5qELXNjgOF1+nBV6kcm/EgpnGqQA5tJ4HFRA0wF3+v7N4BeH7X+vuv0klzER
         zFKnI/9NaTlfykTgMB4PiEt9/aHpg/FSmbUymO9aMO7OA6Zg8jUAFyY+xlimSY3VHEgk
         5bDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ABEQTcy/EF4hsCthXGVVH5FGsY6gZPQtG/rYRFw51iE=;
        b=Cmq6ZPWkR7EnP78GVx9wKLGm2bKqvId1fy+uniCYdh5FEwPMcxyTMYcU3EKLtTg5oQ
         YCXyDJ/Ah6aRGS6xut0gxYX/zWIkZCTUV2gRyy/989fssaVXCDzm0REKRF8+RL1iCfYB
         LL9oVfKLX1c7T1Ki+fbAAxxSPWpNOSY4oj8yna3w3uAgaSDbcbH4yZHYbMWE35KhAb3T
         OosDySpE3JnA6HB923tjUdi1PdkWQ0VMh9HjMpuFobDjAFsJ8qxphne5BuWfj5Qcxmuf
         wkJbWYhbpAJctB31hwvDsotaDz4/uRpuzbiPcIhU8SYUhP0d2TTi56IfF2cJviwIsu9X
         jsFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Alex Shi <alex.shi@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 076/102] arm64: idmap: Use "awx" flags for .idmap.text .pushsection directives
Date: Fri,  6 Apr 2018 15:23:57 +0200
Message-Id: <20180406084342.245532564@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004049037519406?=
X-GMAIL-MSGID: =?utf-8?q?1597004049037519406?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit 439e70e27a51 upstream.

The identity map is mapped as both writeable and executable by the
SWAPPER_MM_MMUFLAGS and this is relied upon by the kpti code to manage
a synchronisation flag. Update the .pushsection flags to reflect the
actual mapping attributes.

Reported-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org> [v4.9 backport]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Greg Hackmann <ghackmann@google.com>
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
@@ -473,7 +473,7 @@ ENDPROC(__primary_switched)
  * end early head section, begin head code that is also used for
  * hotplug and needs to have the same protections as the text region
  */
-	.section ".idmap.text","ax"
+	.section ".idmap.text","awx"
 
 ENTRY(kimage_vaddr)
 	.quad		_text - TEXT_OFFSET
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -95,7 +95,7 @@ ENTRY(__cpu_suspend_enter)
 	ret
 ENDPROC(__cpu_suspend_enter)
 
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 ENTRY(cpu_resume)
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
 	bl	__cpu_setup
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -83,7 +83,7 @@ ENDPROC(cpu_do_suspend)
  *
  * x0: Address of context pointer
  */
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 ENTRY(cpu_do_resume)
 	ldp	x2, x3, [x0]
 	ldp	x4, x5, [x0, #16]
@@ -147,7 +147,7 @@ alternative_else_nop_endif
 	ret
 ENDPROC(cpu_do_switch_mm)
 
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 
 .macro	__idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
 	adrp	\tmp1, empty_zero_page
@@ -180,7 +180,7 @@ ENDPROC(idmap_cpu_replace_ttbr1)
 	.popsection
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 
 	.macro	__idmap_kpti_get_pgtable_ent, type
 	dc	cvac, cur_\()\type\()p		// Ensure any existing dirty
@@ -368,7 +368,7 @@ ENDPROC(idmap_kpti_install_ng_mappings)
  *	Initialise the processor for turning the MMU on.  Return in x0 the
  *	value of the SCTLR_EL1 register.
  */
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 ENTRY(__cpu_setup)
 	tlbi	vmalle1				// Invalidate local TLB
 	dsb	nsh
