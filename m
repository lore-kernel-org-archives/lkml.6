Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2262FcuEknF4eoZ6A/n5qFn1zczdXE1ciIo/cSzeyOPdD77Q87kwq8sm1ZyvxPG4BP8z5Ww1
ARC-Seal: i=1; a=rsa-sha256; t=1518709289; cv=none;
        d=google.com; s=arc-20160816;
        b=PUPp4wW+Ar+X6rR17KOasbwM25Y/W1wthNBph2SVoebemw4aDBRoLZcZkiVSPKK7XV
         cbu4Tuo/zwnFYEpCMin73Vsikr+bgz6MNk9JJzuSaBsmea3z2dnotSAyT/cZw9URMu57
         sug65tYCzj7R0mKn+jwSSn8hJZlF3gYWmKadnIlJq6k4fLsCzIpnS1D6aFkJLZHBDfsV
         7J6RXD8MEJGFmbJcWtNBra5/5Iv/UL1+qhmFGy4UV+TAag0m+YfOlKbUaTnMHyozfTp8
         0wPpbs1irDBAhy/EhIgR9BfU0vU5oqOw5XQMc/q3a5kaQXwYOrzANnPuULlkdqrApjPa
         Xfpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LJJ30nVEMH2BQg5YJ5bQnA9AXzDlQfSUxFPIHcKspIk=;
        b=pFqokDBrfBGnQWAJPVSP5JXlpEeIMdiHnTOn9nWQ6PzI3RPpjwn7Lu72tCtBI6yWIF
         oo+ov+T6q2SZNrQECYTLByf5O5lJofn2Eq6YqUic58w5p1qcHUUKBIjBG4LL8zG3Cv7p
         9H4ORaDT5yiYXymVSy6R0MdqF3PlyLDIwGcgPyabvBzJjQ/jBfykKJJPX7WWCG7Rds1J
         ObMTD3kVyf1WvDP8NFMa2fKPZyH/t5XA/t3l930DKLsJ9Otq5v0QVGgBeRjeKx4lOZop
         8eY/lbZ1S1omTbIZgOY0lI7Z0bN56K+MJtO7LNjzbwh5SMCrsXudpNzvAH7QTKkYsdKZ
         xesQ==
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
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 047/202] [Variant 3/Meltdown] arm64: idmap: Use "awx" flags for .idmap.text .pushsection directives
Date: Thu, 15 Feb 2018 16:15:47 +0100
Message-Id: <20180215151715.665160566@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481617965638958?=
X-GMAIL-MSGID: =?utf-8?q?1592482111768385442?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -184,7 +184,7 @@ ENDPROC(idmap_cpu_replace_ttbr1)
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
