Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELtohH8CpuqThPA9yDXa9Wartr6SeQt5NvJnA4eyzssEk4YaJdAQXKh+XZhw5bTC4J9SVkIo
ARC-Seal: i=1; a=rsa-sha256; t=1520824088; cv=none;
        d=google.com; s=arc-20160816;
        b=bMiZS9VCTI+kZVlfOj4UKucKOIjbm0vpOvr+AJYW2GVxKi6Kw6d+oGm4xtitxwPDGh
         IO+GyHHGPetyTsIHJthOGbLp94iyS/MDA+Y6LRoAi5STMJhwHqYrMZuMGgf/xXQLapMt
         wDUkWprecs1mApnGoWrKCrfEe7OlnTkvGS0yqkA1ebZa1X7g6gJlGjKZ1TjOQjW7AGTV
         9VELrWNPT2lUexmUnhaiplTMaPesOHjMtW4AzHpy62LmVrQ6BMY5aMAQHR8eoLY9ZVqy
         Opfrh4ZgoXHWlJpginvCJRz/0tijpdKl5YnVTeDXgHf6P/mVAMwNLrwVLDnkmEduq24B
         5ugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=c2T5YRHLeOG8HxEuQlzay7gjE3BlwFMnOw/fa1XZa9U=;
        b=TH8IHMNQMCmhAf8mEE9HAG4xhODrb467vH6XiyUjairUZHhyQaqo6RWPjfov8AW64U
         hGXSpUysJrgxk+gn/GmhtAp1ICW93aKSFdpDbowiN7ZfbCTs4AqX0H7uWBaBghVycLp+
         AENy07u6JCHxbjviZUGl+cAwYv8eaTS4EK2ibHgrHKtXHPYLEkxI1iEs7uufcxiIFKET
         xCOa8eABMXdurS1bBMUgAzdeqw8XUcuIYDEFecLKcjIkwFPovtE3vZiaTvkgDV6LkNZq
         XuTYms2RMs20tBmJGr3w8VWESRoN+ujo9OlIqt1FTuAhpUFNHWgremBc1ohzWKsOoecw
         XOoA==
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
CC: akpm@linux-foundation.org,
 "Paul Turner" <pjt@google.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 gnomes@lxorguk.ukuu.org.uk,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 "Ingo Molnar" <mingo@kernel.org>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Andi Kleen" <ak@linux.intel.com>,
 "Rik van Riel" <riel@redhat.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Kees Cook" <keescook@google.com>,
 "Arjan van de Ven" <arjan@linux.intel.com>,
 thomas.lendacky@amd.com
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.655826580@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 064/104] x86/retpoline/checksum32: Convert assembler
 indirect jumps
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699639123527975?=
X-GMAIL-MSGID: =?utf-8?q?1594699639123527975?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/lib/checksum_32.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/x86/lib/checksum_32.S
+++ b/arch/x86/lib/checksum_32.S
@@ -28,7 +28,8 @@
 #include <linux/linkage.h>
 #include <asm/dwarf2.h>
 #include <asm/errno.h>
-				
+#include <asm/nospec-branch.h>
+
 /*
  * computes a partial checksum, e.g. for TCP/UDP fragments
  */
@@ -164,7 +165,7 @@ ENTRY(csum_partial)
 	negl %ebx
 	lea 45f(%ebx,%ebx,2), %ebx
 	testl %esi, %esi
-	jmp *%ebx
+	JMP_NOSPEC %ebx
 
 	# Handle 2-byte-aligned regions
 20:	addw (%esi), %ax
@@ -466,7 +467,7 @@ ENTRY(csum_partial_copy_generic)
 	andl $-32,%edx
 	lea 3f(%ebx,%ebx), %ebx
 	testl %esi, %esi 
-	jmp *%ebx
+	JMP_NOSPEC %ebx
 1:	addl $64,%esi
 	addl $64,%edi 
 	SRC(movb -32(%edx),%bl)	; SRC(movb (%edx),%bl)
