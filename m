Return-Path: <msuchanek@suse.de>
X-Google-Smtp-Source: AG47ELsSlKuQD6Abnp+DqOghqsp7uC4ndl1UzDrcaxYCBo/ig/UalPZoJ/UQTiSjVvYfLrx0tEx6
ARC-Seal: i=1; a=rsa-sha256; t=1521141383; cv=none;
        d=google.com; s=arc-20160816;
        b=XecdE79VmBqkZ7eF5jQrXj9Ev2gM5IWVnTGivHX3Bxn6/fWrI34ORJRoThzmM5eGDj
         c+Esu9FkxBl3dEMqD1TxYydunDfdzQiVAcl5FWe7JuWoooxAED5MjqErK6uTeIdHTU/Q
         0hfUbE1UaalFvnnHJAzIRH/TxVin1nnLGIsNVcOAzIXA2nRKsdsv2Hk8ifva8PEiQ/Y+
         AhhN6KhwjX4/gMUXUqfGYi7dEsHQtthMZ38/p+D7DJUDw3QUM4divUnrmg9UtblIFYZj
         V0W4Y0eBJdHLH2xXx23hnIKh/KlLEMW75ZgAIpEGAk7EdxDkzl953sgxvWA2VFgsH6N0
         b3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3QUYJirZMKT0LZMvYQm8l4VppfjJ2dhpcmjDpYwyky0=;
        b=bCtsHBjK+aKJPvW4Ve26jc2RAJia6FcgRT8x+ICppLOxLwsXbOi4iJav1JoYRkKH7T
         ICiHqYdj7aa0PBQPst19C0D9DTatpgOfHQwOw3sftb9LKwSsQDJ1jTqlSMAX88UnTmZj
         YZzAWPmtMhA5bVyrQBTb0P+vdgAbZOxcopKCXwY7jrpqiIMlf5upS7EWeh9hn/Y7Ra01
         e7ipd6RIi19N6YJ7/w3b5fsc0WKTsvCCYf5esjF9fHF81ac+VANCd2FItclZo55enSxb
         PMFVIWjO0Vk52Lr+hvCcFYKf5rI8o9TAHojoVVtY4NGlllJ3iQzvyLMgR0c/viBE+807
         nBUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Michael Neuling <mikey@neuling.org>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Daniel Axtens <dja@axtens.net>,
	Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	David Gibson <david@gibson.dropbear.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Joe Perches <joe@perches.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Tobin C. Harding" <me@tobin.cc>,
	Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH RFC rebase 3/9] powerpc/64: Use barrier_nospec in syscall entry
Date: Thu, 15 Mar 2018 20:15:52 +0100
Message-Id: <b8253774e223530c808eed65d116deecc46ad36b.1521141122.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de>
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <cover.1521141122.git.msuchanek@suse.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595032347539334628?=
X-GMAIL-MSGID: =?utf-8?q?1595032347539334628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On powerpc syscall entry is done in assembly so patch in an explicit
barrier_nospec.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/kernel/entry_64.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2cb5109a7ea3..7bfc4cf48af2 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -36,6 +36,7 @@
 #include <asm/context_tracking.h>
 #include <asm/tm.h>
 #include <asm/ppc-opcode.h>
+#include <asm/barrier.h>
 #include <asm/export.h>
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/exception-64s.h>
@@ -159,6 +160,7 @@ system_call:			/* label this so stack traces look sane */
 	andi.	r11,r10,_TIF_SYSCALL_DOTRACE
 	bne	.Lsyscall_dotrace		/* does not return */
 	cmpldi	0,r0,NR_syscalls
+	barrier_nospec
 	bge-	.Lsyscall_enosys
 
 .Lsyscall:
@@ -319,6 +321,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ld	r10,TI_FLAGS(r10)
 
 	cmpldi	r0,NR_syscalls
+	barrier_nospec
 	blt+	.Lsyscall
 
 	/* Return code is already in r3 thanks to do_syscall_trace_enter() */
-- 
2.13.6
