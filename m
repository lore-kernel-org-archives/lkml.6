Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4+oaDh+n19yyBEOEFYTyKB0nnAo55JJ6iyeQvee+mlMmokDHG2EvV4vHhdOZFt6xJY9UA4e
ARC-Seal: i=1; a=rsa-sha256; t=1524498470; cv=none;
        d=google.com; s=arc-20160816;
        b=O5p5kWCxFnF//Ajjx4Xd8ZY4Ird1dDAcax0aYcJzHjHQTcbLYhCk+UQeWPq/PrMlKP
         lZR+3PPB/XGYhydu8Gk63V/AudHR87DY+M5iqkS52eadDD0UEoLhj2aNMc0Mtgnu3Gtk
         epN1gWWcw5fNNuDsNk3mn89bzAl4jPaFW6KSbEAy+2hpGBfGf1ZBN+o4DBMHiRtTUoVU
         lTkyveQUJcvSAHmdYroK6W74PdIIJgIHUQhZw3Fav3PjgKIQIBh04QpiIs2brnAiyFCi
         nKv+iJ+Xw85wysTvDrdiQ5mTK5j6dsaAaX7dCEviaSE9mEWUO2E0gpZ4mQLWingjcMte
         iLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=3iy4hHBTYS8Y6OIhJpAvVb/NIIrv1CbReyBomjD1ntw=;
        b=EvDTcycdF9+SMYyJPlUEmIj+Q/MxsE6nbwz2+QTATvSSvpCpAqfhJuKqsHn/ANphid
         ZbMzQ8XDhD0DjVu/BB7CdRVoCBVq8sK+CMqO/op4d3frW1XMwTjnPrf6lZiWoVvb5Ac/
         eI38VwTuQsEf2cMbvrXEqczCdAnA8X9PzlC98TNkIdybbQDEkLweQuCdkRcAc1S25U/3
         1TYWhmKQes/x44qgDct8SFSaR/vRFibbA6LYwDU0txuIGLuuH5BUYex7Oo2VNYrDOfX6
         zR+9WLwEfP6TpJNoc5Quxm8idBNGha9/lymfYSpGelf55p4th1WgHrQNYAsFCdBwy0fX
         CleA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=JSrr118C;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=JSrr118C;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at,
	hughd@google.com,
	keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 09/37] x86/entry/32: Introduce SAVE_ALL_NMI and RESTORE_ALL_NMI
Date: Mon, 23 Apr 2018 17:47:12 +0200
Message-Id: <1524498460-25530-10-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552507821201537?=
X-GMAIL-MSGID: =?utf-8?q?1598552507821201537?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

These macros will be used in the NMI handler code and
replace plain SAVE_ALL and RESTORE_REGS there. We will add
the NMI-specific CR3-switch to these macros later.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 927df80..e2621bf 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -186,6 +186,9 @@
 
 .endm
 
+.macro SAVE_ALL_NMI
+	SAVE_ALL
+.endm
 /*
  * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
  * frame pointer is replaced with an encoded pointer to pt_regs.  The encoding
@@ -232,6 +235,10 @@
 	POP_GS_EX
 .endm
 
+.macro RESTORE_ALL_NMI pop=0
+	RESTORE_REGS pop=\pop
+.endm
+
 .macro CHECK_AND_APPLY_ESPFIX
 #ifdef CONFIG_X86_ESPFIX32
 #define GDT_ESPFIX_SS PER_CPU_VAR(gdt_page) + (GDT_ENTRY_ESPFIX_SS * 8)
@@ -1166,7 +1173,7 @@ ENTRY(nmi)
 #endif
 
 	pushl	%eax				# pt_regs->orig_ax
-	SAVE_ALL
+	SAVE_ALL_NMI
 	ENCODE_FRAME_POINTER
 	xorl	%edx, %edx			# zero error code
 	movl	%esp, %eax			# pt_regs pointer
@@ -1194,7 +1201,7 @@ ENTRY(nmi)
 
 .Lnmi_return:
 	CHECK_AND_APPLY_ESPFIX
-	RESTORE_REGS 4
+	RESTORE_ALL_NMI pop=4
 	jmp	.Lirq_return
 
 #ifdef CONFIG_X86_ESPFIX32
@@ -1210,12 +1217,12 @@ ENTRY(nmi)
 	pushl	16(%esp)
 	.endr
 	pushl	%eax
-	SAVE_ALL
+	SAVE_ALL_NMI
 	ENCODE_FRAME_POINTER
 	FIXUP_ESPFIX_STACK			# %eax == %esp
 	xorl	%edx, %edx			# zero error code
 	call	do_nmi
-	RESTORE_REGS
+	RESTORE_ALL_NMI
 	lss	12+4(%esp), %esp		# back to espfix stack
 	jmp	.Lirq_return
 #endif
-- 
2.7.4
