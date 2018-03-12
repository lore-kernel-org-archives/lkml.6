Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELuz+/qo6HoeS1eze0R6xDO5oq0bsq8J2gUI6AymyVNtyBTXKv9oBpRpi0ALSOK0WVNcy+qS
ARC-Seal: i=1; a=rsa-sha256; t=1520824099; cv=none;
        d=google.com; s=arc-20160816;
        b=skx5U0BEb9iTgWCPiljafiUQgFd9SvsnfMCE3OhgFFUCfJ5QDB3OHDjlQZZ6mzJtCG
         6C/iXNJc42pNVt+TO8lpoKWztF039lP7eo8EXSANdJlJ2pFVdI6210eRudCI9ZClmXXX
         mQeP98Ajv33UPVl4gGbSkDrMp+auT5hlGamotGh+glvKIF76WiZT0GsF8m9HYJdbQLRW
         YjBugxIIUGI31RhH2DICrHLgCekDxw8AQ5X2+Ym9/yO3inq4V/voYRib/MbPF3oneywK
         Byn/uuhPB24b1fEG/u8UIHVw3nqIGE4B9l324JP3MZ1uqQ5Z8P82/7h4M5fSUdj9rZT0
         J59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=+XX8CcY+NcuVFD/pSw2qhDMOeD3P0Lz8vAgBPm/TIA4=;
        b=srBj6LcvLFkzpj6oVWoAb9NbioXirBCwI3oPxHwhFWebhFU57CAfKClvrT+fXHrpWl
         A9xAxu9p+GFx3y+dqUqktInQexFLYKzCS9NrTUWT8Tt6qJ/yUnf634nSoCHst/wiViUi
         fgB87vi9XA3sz8YoMmGgY3bqXvIpwNonsVSgbbdk3FKnWXPlCO1FggUeJMtUwVJUEwPU
         UIDqlGdMvnpR5+Hahor2IAbhDhylPw2X1K1fx13ZejuGCYX8PVk0SfJ/G2wH+zlwt23Q
         OGLukD2Ln2Oz6pSBcCE1Tau9xzfJ4M7F53rE8dlLYYHf1aAGCAejXG4vq4LOloP+IrUC
         E/bA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, gnomes@lxorguk.ukuu.org.uk,
 "Ingo Molnar" <mingo@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Rik van Riel" <riel@redhat.com>,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 thomas.lendacky@amd.com,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Kees Cook" <keescook@google.com>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Paul Turner" <pjt@google.com>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Tim Chen" <tim.c.chen@linux.intel.com>
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.276571405@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 30/76] x86/retpoline/checksum32: Convert assembler
 indirect jumps
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699639123527975?=
X-GMAIL-MSGID: =?utf-8?q?1594699651655561627?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 5096732f6f695001fa2d6f1335a2680b37912c69 upstream.

Convert all indirect jumps in 32bit checksum assembler code to use
non-speculative sequences when CONFIG_RETPOLINE is enabled.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Arjan van de Ven <arjan@linux.intel.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: Rik van Riel <riel@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: thomas.lendacky@amd.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <keescook@google.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Link: https://lkml.kernel.org/r/1515707194-20531-11-git-send-email-dwmw@amazon.co.uk
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/lib/checksum_32.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/x86/lib/checksum_32.S
+++ b/arch/x86/lib/checksum_32.S
@@ -29,7 +29,8 @@
 #include <asm/dwarf2.h>
 #include <asm/errno.h>
 #include <asm/asm.h>
-				
+#include <asm/nospec-branch.h>
+
 /*
  * computes a partial checksum, e.g. for TCP/UDP fragments
  */
@@ -165,7 +166,7 @@ ENTRY(csum_partial)
 	negl %ebx
 	lea 45f(%ebx,%ebx,2), %ebx
 	testl %esi, %esi
-	jmp *%ebx
+	JMP_NOSPEC %ebx
 
 	# Handle 2-byte-aligned regions
 20:	addw (%esi), %ax
@@ -463,7 +464,7 @@ ENTRY(csum_partial_copy_generic)
 	andl $-32,%edx
 	lea 3f(%ebx,%ebx), %ebx
 	testl %esi, %esi 
-	jmp *%ebx
+	JMP_NOSPEC %ebx
 1:	addl $64,%esi
 	addl $64,%edi 
 	SRC(movb -32(%edx),%bl)	; SRC(movb (%edx),%bl)
