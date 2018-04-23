Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx49BtY5+YdwrbuHzMgyOqqotKi4HbOYvNbO4Uvh4M9hFk+iMOlZsyYNvu1ntrjsxLuiBeChL
ARC-Seal: i=1; a=rsa-sha256; t=1524498470; cv=none;
        d=google.com; s=arc-20160816;
        b=hNJLtUnLabsai52sXvkFhW8OKXwWyrjmpVr6oqKAZrsL1KjdjcDYUOta6edEBF721A
         BpirNDgkgctbM+GEBmdaxW7jTsGEhXuQYo+oMsu9DmI91W68PBdxJCTGCiVbMhF8VYr2
         JQ3ne+6+WyhlQZkUAzuAgSSbxaFxHGUl65WH0E7Hxedfq3789wCuPFhkO2O4tsk0qNrC
         ci036AMiJAUEyQow+4mv6FCcR6VLuzoCIILaFzuhcHNSjUV/H+lXSQOfNtY9uD94PckQ
         0vjw5GiXXVgAX7mF4G0+N4NhGfH1zC7tJYNIF9u6UZRjnou4FcUiZGDAdhMltuOM5WQi
         musg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=qKlv0dlfoJ0ph1CRFQGBUdfpl5F5TOgxEbVvMSZxBUI=;
        b=IwknQZO3c4HiIKGaSJlKlZi2ZwcdpOE0wR05aTGib0+H0X8m8C56/fK3v8Upe35ktY
         l92mngqIbDn4i0fLk6HLCtbsecueiQFxJFUh1LQ/tXF9KhaAXeX8n12VMfMM4iIJaTby
         ZKBsP5/Nbw8hGah+A7V9ZWvHJH7ca52TbETJiJZiVIXcl0ElUdB7xZXYXwQLfTryQqOE
         KiTx4LmFXeHtc4R6uf2qNYsCGDnIReGcM6JqI81tNt/N1fqiN9/YglmG9c5g8YWpBeDm
         YnhLKbkomfmgy/S/Tn2DdBMqg1UaKPHnqRsFmEzhshRdj/32Z6bIMqrGLp2ychSlLfnk
         vkSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Hg4Sqz/I;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Hg4Sqz/I;
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
Subject: [PATCH 05/37] x86/entry/32: Unshare NMI return path
Date: Mon, 23 Apr 2018 17:47:08 +0200
Message-Id: <1524498460-25530-6-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552508044366036?=
X-GMAIL-MSGID: =?utf-8?q?1598552508044366036?=
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
index 118420b..3a319fd 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1017,7 +1017,7 @@ ENTRY(nmi)
 
 	/* Not on SYSENTER stack. */
 	call	do_nmi
-	jmp	.Lrestore_all_notrace
+	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:
 	/*
@@ -1028,7 +1028,11 @@ ENTRY(nmi)
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
