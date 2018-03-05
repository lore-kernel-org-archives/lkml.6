Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELuppZmQCPBY5zdkCcHiu9TNHXDouuckEdRf46X8kHr6nLe+N+89vK+1bDxWdmx82dwLbcb5
ARC-Seal: i=1; a=rsa-sha256; t=1520245571; cv=none;
        d=google.com; s=arc-20160816;
        b=KnyhLeHtRYaNrre4VDF6OOZl3SRBKkiVZqsx4iVwfnV6CpIFs243DVQUjQxfnsOipp
         N+uNFnf7Li08lA/jki1JAPJ2B8PEdMxw5H8yavaD09hOIarXZYlzoVzBjnLBmgEBlqif
         wnzAAVUKUMW7wXLLx/ncfTm2IbHEh/QznKtV3wRocrTXmQYpXssOG+Zcr3VnGJmFZ923
         25vdX89mtAuo9RGouzLOBoTFO4fsXy2qV4ArXCeOXmSkex88RVGfE06qxcB95MiT6fFd
         cluaALj4ukH/pQ3WK1HQrzxy/J+yj7IJWHcTjik3i5oMesuwdO9XpLvFFXVMw/nicuyV
         rNgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=qxWeLBWPXfhZcdORXt/N8vBDLLsrpvteBpcTwZSO2Cc=;
        b=wUzWbe27XA+hFVmr8lYp7By5vPGn1SWsIncIyLmjcPxX4GPEM6TxOWr/i/VRHDUtzI
         OscSoQIMClzGXvMivO6yO5GK6DCxuyowUPG2gagF4I1nmyngcorr880DPIQnJs0lhsTf
         2bqjaONQPxoYI7ulJ523NvTR4/PmqmdzQjRMUIFwMndw6jACnjn6Qk0pVtsb3Q2sEMNo
         IvZyEYJexSlAeV5eEECshzXe81BIPaP7e/Bk78Fy+ZeaKe7bJO5F8pcsT5ptAd2y+2BW
         PEizBEYH2i1WNG4h1RyedQvCu0MWZywWDLh/5mMaoTTU+TTtLGLiXTBoRWlYreKiOIIf
         oGDA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=dh4LVBXL;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=dh4LVBXL;
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
Subject: [PATCH 05/34] x86/entry/32: Unshare NMI return path
Date: Mon,  5 Mar 2018 11:25:34 +0100
Message-Id: <1520245563-8444-6-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093020612909997?=
X-GMAIL-MSGID: =?utf-8?q?1594093020612909997?=
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
