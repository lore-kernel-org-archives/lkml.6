Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELukUGnBk6BbrT1HSk19akZPqOepbFvx67Extyd+8moRbJphtj38nW62Tj+S0I9UtAQnjW4k
ARC-Seal: i=1; a=rsa-sha256; t=1521228603; cv=none;
        d=google.com; s=arc-20160816;
        b=IfM0eytI0s0glVLfyDqSmIKfXUcdtrw9+FpObKIDAXksZU9a69olhMIGqMtq5oJ/C4
         YpZOttcYesW2ILYjicg+IEt++4Lauz1s9qCiLMVijGQ0dHhu09DEFdyfgSIJyRUXFbQN
         LKH7VLwn3YKiOUz3ejTHWLFpBNlQ+7eEHr1/QtiiugJTBjLrellNnKsD9oCXk7ripf7m
         0ebBflC9FN/taOpH1lXsAcAeNSPNIFdZxVoTo1uJznveBPDXMwwBVevtRArYQRVhplYx
         0H65rTUhVZcsFn5w8624/GKVTqROxKFxXcRw6yCb5I1wyLCd8XA1IFnMWnuYiCcHNPu3
         wlWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=qxWeLBWPXfhZcdORXt/N8vBDLLsrpvteBpcTwZSO2Cc=;
        b=xEHTYQUEKi1CeZdTu35NlKUDtirTaIyaLJV/eEIJSJYr0vLrBZfH1OHPEEkDDy/WWC
         tHJIeBDIvr5ANTjLRMp7b3QEhEBtyVEIb+7tp8I6KO2esxbYYbAcZcioI/FYV9VJUuc0
         kkGXuKiABEHnHTWHVgiZjkodPmFjx20+LFjHc9KDK5GJT/IhbsD8q/APBcvZxlHkoD/5
         2pWFsYdcvc9OeuE/cuEVCS04YzteL/ZIPoqqmndyR4MJzUzERR7OxwaTe5DAIjakN3vP
         H2m/i9DGQCill6FZeT90hry54JXNAcrBduBK82evNWuUvO9R3a3JaubVt4aW2vaoJCDk
         coAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=nC1vDT1F;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=nC1vDT1F;
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
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 05/35] x86/entry/32: Unshare NMI return path
Date: Fri, 16 Mar 2018 20:29:23 +0100
Message-Id: <1521228593-3820-6-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123803811470578?=
X-GMAIL-MSGID: =?utf-8?q?1595123803811470578?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

NMI will no longer use most of the shared return path,
because NMI needs special handling when the CR3 switches for
PTI are added. This patch prepares for that.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 0289bde..00ae759 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1007,7 +1007,7 @@ ENTRY(nmi)
 
 	/* Not on SYSENTER stack. */
 	call	do_nmi
-	jmp	.Lrestore_all_notrace
+	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:
 	/*
@@ -1018,7 +1018,11 @@ ENTRY(nmi)
 	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esp
 	call	do_nmi
 	movl	%ebx, %esp
-	jmp	.Lrestore_all_notrace
+
+.Lnmi_return:
+	CHECK_AND_APPLY_ESPFIX
+	RESTORE_REGS 4
+	jmp	.Lirq_return
 
 #ifdef CONFIG_X86_ESPFIX32
 .Lnmi_espfix_stack:
-- 
2.7.4
