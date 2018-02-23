Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225F+9RF8msFlsAkOKxlaMANoRUdb244xGxIlHshQO2g2NU79rTFMceJ6MdISKqC5pil3i6n
ARC-Seal: i=1; a=rsa-sha256; t=1519410990; cv=none;
        d=google.com; s=arc-20160816;
        b=DonmvkWZ1MjUtjL+OOPAheyXk9JNCajv+5Vbna6mC8tbuY6qWpQctCy9na+GapHY2c
         aWYfsVG4xbfrqdFW/MChEW52Z9C1MH7uoCiSPv5zBYrn5ZwG4udQg3WEq6viyDjwrQyu
         ajBj6TJQf5vgHgAF5axwbp7Uf1pqTw72Z/OACZmXpNifM9EiOI1NC+A2vFFIYxAP0g/N
         Rt+5tJZvOuHQHpdR/YPJ3bzN7LxDMhtphZyPxkKpqGAU80/kjjy9hu93qZcF5dfobXAE
         lmzjIMT0sFEFyPvXvyMtbUkb4hqTFA50iXbTAB89a1W5TF5xJxR3TC0G6/au+GCYPAtk
         FhAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HnZ2i/LB0xRAU7KyIf68Pf32ibmj3ueJSij7yrZKTCQ=;
        b=jLhUxHkwTHIbaQ+oe3fe4PqJ0MyBsL5iWxZh2CQvOD9j0b8kjyJWJo3vtvErIkhwIK
         JCozFRPuOtucXSVB8gdLPp29YpME8sLdgKU6idcrAA6707JLimeHwFSBIewXc6xd6WrI
         tZWE2CbCfj8mdB1kyUETqRit8m02rklMu9X+37Ah6Cvu9OrziVSqqV/7+qbGR6YlPKZs
         h0nDjsMy/7mRvleybXGQD5JEFr5+ZKlRS4tMaBd9VONT1W3MJjdLIh2UY2CBZ8VxBk2v
         4JzNaHG86l/zdzvr7LD755QGxZGSmgGzlfkFLrSRJT7BC4KDqfW4RgbkWXnTwxkfrxno
         X98w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 083/193] x86/boot: Avoid warning for zero-filling .bss
Date: Fri, 23 Feb 2018 19:25:16 +0100
Message-Id: <20180223170339.053467259@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217898849923537?=
X-GMAIL-MSGID: =?utf-8?q?1593217898849923537?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 553bbc11aa6c1f9e0f529a06aeeca15fbe4a3985 upstream.

The latest binutils are warning about a .fill directive with an explicit
value in a .bss section:

  arch/x86/kernel/head_32.S: Assembler messages:
  arch/x86/kernel/head_32.S:677: Warning: ignoring fill value in section `.bss..page_aligned'
  arch/x86/kernel/head_32.S:679: Warning: ignoring fill value in section `.bss..page_aligned'

This comes from the 'ENTRY()' macro padding the space between the symbols
with 'nop' via:

  .align 4,0x90

Open-coding the .globl directive without the padding avoids that warning,
as all the symbols are already page aligned.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20161116141726.2013389-1-arnd@arndb.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/head_32.S |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -669,14 +669,17 @@ __PAGE_ALIGNED_BSS
 initial_pg_pmd:
 	.fill 1024*KPMDS,4,0
 #else
-ENTRY(initial_page_table)
+.globl initial_page_table
+initial_page_table:
 	.fill 1024,4,0
 #endif
 initial_pg_fixmap:
 	.fill 1024,4,0
-ENTRY(empty_zero_page)
+.globl empty_zero_page
+empty_zero_page:
 	.fill 4096,1,0
-ENTRY(swapper_pg_dir)
+.globl swapper_pg_dir
+swapper_pg_dir:
 	.fill 1024,4,0
 
 /*
