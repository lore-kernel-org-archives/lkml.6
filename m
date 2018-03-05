Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELsu33jldHUJ8NbmO6BAetBZF3CRguuK8ZQ8SgBgFzR1NbYjbg1r2NKjV+ZLqdcurZPlY0p3
ARC-Seal: i=1; a=rsa-sha256; t=1520245574; cv=none;
        d=google.com; s=arc-20160816;
        b=jEpbGTWSr+QyyNXGaSYbJyIoPBc7X3C8jLxTmhZFY7HTcJzGLuPQl/l9IqdxD6osOC
         4bTcgtsmugO45ii8wr1LRDBVxU1DT9c4WmDvWlVzv0sPQz446jpChmYo7S3qYGNSD2wh
         T2NsATcttSLX7CPAvqlJpJMpG8Bm6RsSzfvTqua+HwghTP1D42vFfsxeg0ZcvIIVJ7VG
         CnhiGb9XEq6B95653+83SaCQo0XUpOSmsiRjJRtaaBr5fXLdCuRiezZMpSLjggwb5oZj
         kldWhXftOO8RQH/OAE0/ePSycoZuBWSwcaQN+qvTbaC+Lwo2pZWkLhHa32Zk4/5mpuKO
         7P3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=lqDTZPgOy9Zup7fwv8/14WJaSbYFMc3N9hyxJ0hwDZA=;
        b=bdXay1X95vKmETBYauHlzdjE8gDYTTWGvq9RH6Z+FSCUTEyvVzqPSpf0LKOXJ5y8d/
         AM2glSXLiFl6lciWCDA08wxZ9/sRVIX+tp2QNaj5UabfJibX1K5besP3Fxu5INQiwK8a
         1P98XDjwB8+eBwO5X+Z4Z91rBqknNReMPccPWzpby/rpLHOaigF1ulG1VjMGdXhjYZg4
         0NhIg4euMLxr2L/7ca+HBdd670Y1wTpwfmfmZMl8ZKxztSEUGnEDWu+0RMdxpUdMz0eH
         4jwP5e04ua/HQaLRGpO0JZNRUYsYyndSM4uNdy9CN4O8tHwvxUhthWzjb+DrKXMn61j1
         TYJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=d/vFP1db;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=d/vFP1db;
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
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 13/34] x86/entry/32: Add PTI cr3 switches to NMI handler code
Date: Mon,  5 Mar 2018 11:25:42 +0100
Message-Id: <1520245563-8444-14-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093023530932487?=
X-GMAIL-MSGID: =?utf-8?q?1594093023530932487?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

The NMI handler is special, as it needs to leave with the
same cr3 as it was entered with. We need to do this because
we could enter the NMI handler from kernel code with
user-cr3 already loaded.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 52 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index b1a5f34ee..35379e5 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -77,6 +77,8 @@
 #endif
 .endm
 
+#define PTI_SWITCH_MASK         (1 << PAGE_SHIFT)
+
 /*
  * User gs save/restore
  *
@@ -167,8 +169,30 @@
 
 .endm
 
-.macro SAVE_ALL_NMI
+.macro SAVE_ALL_NMI cr3_reg:req
 	SAVE_ALL
+
+	/*
+	 * Now switch the CR3 when PTI is enabled.
+	 *
+	 * We can enter with either user or kernel cr3, the code will
+	 * store the old cr3 in \cr3_reg and switches to the kernel cr3
+	 * if necessary.
+	 */
+	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
+
+	movl	%cr3, \cr3_reg
+	testl	$PTI_SWITCH_MASK, \cr3_reg
+	jz	.Lend_\@	/* Already on kernel cr3 */
+
+	/* On user cr3 - write new kernel cr3 */
+	andl	$(~PTI_SWITCH_MASK), \cr3_reg
+	movl	\cr3_reg, %cr3
+
+	/* Restore user cr3 value */
+	orl	$PTI_SWITCH_MASK, \cr3_reg
+
+.Lend_\@:
 .endm
 /*
  * This is a sneaky trick to help the unwinder find pt_regs on the stack.  The
@@ -227,13 +251,29 @@
 	RESTORE_SKIP_SEGMENTS \pop
 .endm
 
-.macro RESTORE_ALL_NMI pop=0
+.macro RESTORE_ALL_NMI cr3_reg:req pop=0
 	/*
 	 * Restore segments - might cause exceptions when loading
 	 * user-space segments
 	 */
 	RESTORE_SEGMENTS
 
+	/*
+	 * Now switch the CR3 when PTI is enabled.
+	 *
+	 * We enter with kernel cr3 and switch the cr3 to the value
+	 * stored on \cr3_reg, which is either a user or a kernel cr3.
+	 */
+	ALTERNATIVE "jmp .Lswitched_\@", "", X86_FEATURE_PTI
+
+	testl	$PTI_SWITCH_MASK, \cr3_reg
+	jz	.Lswitched_\@
+
+	/* User cr3 in \cr3_reg - write it to hardware cr3 */
+	movl	\cr3_reg, %cr3
+
+.Lswitched_\@:
+
 	/* Restore integer registers and unwind stack to iret frame */
 	RESTORE_INT_REGS
 	RESTORE_SKIP_SEGMENTS \pop
@@ -1242,7 +1282,7 @@ ENTRY(nmi)
 #endif
 
 	pushl	%eax				# pt_regs->orig_ax
-	SAVE_ALL_NMI
+	SAVE_ALL_NMI cr3_reg=%edi
 	ENCODE_FRAME_POINTER
 	xorl	%edx, %edx			# zero error code
 	movl	%esp, %eax			# pt_regs pointer
@@ -1270,7 +1310,7 @@ ENTRY(nmi)
 
 .Lnmi_return:
 	CHECK_AND_APPLY_ESPFIX
-	RESTORE_ALL_NMI pop=4
+	RESTORE_ALL_NMI cr3_reg=%edi pop=4
 	jmp	.Lirq_return
 
 #ifdef CONFIG_X86_ESPFIX32
@@ -1286,12 +1326,12 @@ ENTRY(nmi)
 	pushl	16(%esp)
 	.endr
 	pushl	%eax
-	SAVE_ALL_NMI
+	SAVE_ALL_NMI cr3_reg=%edi
 	ENCODE_FRAME_POINTER
 	FIXUP_ESPFIX_STACK			# %eax == %esp
 	xorl	%edx, %edx			# zero error code
 	call	do_nmi
-	RESTORE_ALL_NMI
+	RESTORE_ALL_NMI cr3_reg=%edi
 	lss	12+4(%esp), %esp		# back to espfix stack
 	jmp	.Lirq_return
 #endif
-- 
2.7.4
