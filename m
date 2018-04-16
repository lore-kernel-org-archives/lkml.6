Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx49AoSafK8oTS3Sf4h6ywwyGVYKhPcm3BLvBubHDeXRRNXbNPyyhFXHSJelHCdr25PCq4+y+
ARC-Seal: i=1; a=rsa-sha256; t=1523892343; cv=none;
        d=google.com; s=arc-20160816;
        b=AI16UzZiNxR55B3JlCali7CjwUqSKb6bvZyFGcMkx0/I+uPvF7AOPStOiCxs6uzjeb
         U6i4F2Q5wN7ng2+6guzoxO/EvFwqR/wXU7Nom+e5aONsmQERLXccHtmNRqjuGhN5YIQa
         mS+9xp4V20QgQ2TEdTZxqtrGPvNoJ7/dRk5tPB4c3eVRaz41Gbu8yseV+h1w17xBddQu
         qFNwzHNs1WvB+LbQcQgOKcqg+3SwBn1IHNu6a5nW4kn+2PosaNMT3W0XsMueMobp2XG2
         /Ppw9Pt7RJkP0teEbjmw/ZQNuFClz70FIPv6WZsP1fewwI9uSs5yONrWpXstoQJLAclV
         /g6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=3iy4hHBTYS8Y6OIhJpAvVb/NIIrv1CbReyBomjD1ntw=;
        b=qH52CoY4ZxyAKM3g7JsLk2Xigf3ejR51dbZipSpWDBxpv/fE01kj+S8TFquTjp9zbG
         ZocERp/PxSaRb9h1i6bWa/7yXBOUEPn6f5Yxt5vHLOotVR2SBfebsR/4Dq55joVwYrvC
         N7KGE7cyqhWfcTPAua7oIZSEZEqA67JGaDvPfCxpXvouFyiwewRBafO8ZPgKgMYRS0ch
         bvwGCGJG2LzCKrlK0jMY9XnN/Sq6p2ptMPSpcC2bAkBg2K42E9mMumw93xHGDa4m0iEj
         Dgao5N59QXkT/J8SmzPWzLb0s39m1KiDr+QjUSZXitlJ8xjoEaFlIKiSE8qtmj5pIz4I
         obdg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Z1mIzaE9;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Z1mIzaE9;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
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
Subject: [PATCH 09/35] x86/entry/32: Introduce SAVE_ALL_NMI and RESTORE_ALL_NMI
Date: Mon, 16 Apr 2018 17:24:57 +0200
Message-Id: <1523892323-14741-10-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916937991032749?=
X-GMAIL-MSGID: =?utf-8?q?1597916937991032749?=
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
