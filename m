Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226kHbtkHvIqJ5W+RW+jqSroBsPtK4Gztp4JsMWJRl/fZ+Vm+2na4mcruXKXYFGO8lCqFomp
ARC-Seal: i=1; a=rsa-sha256; t=1519218548; cv=none;
        d=google.com; s=arc-20160816;
        b=Ncx6acEVK783Q8DDMc2KOsa7AolXv3m1o+6KKHyGBczZOXEZqjgyCJR4TNnvUoIi9r
         gONhosgGkJH3k+cJUs71M8lnOn83TvndLQUwvceKEI7aNJEfNMbxrwIvaH8eCffif0oD
         d6UamK3jHmncUGKkWGNl/pNv0WRU1WZjTz+17kPOmMeVd0BEapnpAKt6MBJYuW761upg
         olC1utWBSmNe4fwCh++uZXMqvif4+wXViIQiBVWo7+elrg7lJlIVVG74Ap2wsWsWfwYI
         aSBjVqdT0OQId7Ho3u836+rUPO72SEgq7ADPfTXEIOzLYql4ifgL0wgYyUrEbUbaqIad
         4gBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rzbve1c0qRMiI9NjGtgqs8Q7AK5MKseQ5g675z48QNA=;
        b=NDDUEa+De6hWLzcL5Zrpb1FwhjzZIUPcS+iLYgDyqTfIWZrQHymO+ACBW5a3pxG3pQ
         cVrhmZlWllqoTDyqsXr56kVjBijJT8K+948/RKgfaAwL3poHg+bWaiAdd63OYpkGNbKD
         iyKMoD6+YIAXiSG+YWIdE1qaWcpg2z3chnMWCguIxmzmfM0t3yogrSCLwODbXeqFXHyC
         7XScE1eaopk8enaBOzsxtMUwvMKmIrkXMc/DXwWD3YpeOeQ0ICBU45Bjfnf4XnBewpHe
         yJZrsQFcp2oworIZhh9pRgoDvMZ53DixagjOtHG8RGX/Pc8i6g3kAk/+v3JH6l3VQGgd
         k6SA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 078/163] x86/debug: Use UD2 for WARN()
Date: Wed, 21 Feb 2018 13:48:27 +0100
Message-Id: <20180221124534.760076350@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015704879461165?=
X-GMAIL-MSGID: =?utf-8?q?1593016108437819969?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 3b3a371cc9bc980429baabe0a8e5f307f3d1f463 upstream.

Since the Intel SDM added an ModR/M byte to UD0 and binutils followed
that specification, we now cannot disassemble our kernel anymore.

This now means Intel and AMD disagree on the encoding of UD0. And instead
of playing games with additional bytes that are valid ModR/M and single
byte instructions (0xd6 for instance), simply use UD2 for both WARN() and
BUG().

Requested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180208194406.GD25181@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/bug.h |   15 ++++++---------
 arch/x86/kernel/traps.c    |    2 +-
 2 files changed, 7 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -5,23 +5,20 @@
 #include <linux/stringify.h>
 
 /*
- * Since some emulators terminate on UD2, we cannot use it for WARN.
- * Since various instruction decoders disagree on the length of UD1,
- * we cannot use it either. So use UD0 for WARN.
+ * Despite that some emulators terminate on UD2, we use it for WARN().
  *
- * (binutils knows about "ud1" but {en,de}codes it as 2 bytes, whereas
- *  our kernel decoder thinks it takes a ModRM byte, which seems consistent
- *  with various things like the Intel SDM instruction encoding rules)
+ * Since various instruction decoders/specs disagree on the encoding of
+ * UD0/UD1.
  */
 
-#define ASM_UD0		".byte 0x0f, 0xff"
+#define ASM_UD0		".byte 0x0f, 0xff" /* + ModRM (for Intel) */
 #define ASM_UD1		".byte 0x0f, 0xb9" /* + ModRM */
 #define ASM_UD2		".byte 0x0f, 0x0b"
 
 #define INSN_UD0	0xff0f
 #define INSN_UD2	0x0b0f
 
-#define LEN_UD0		2
+#define LEN_UD2		2
 
 #ifdef CONFIG_GENERIC_BUG
 
@@ -79,7 +76,7 @@ do {								\
 
 #define __WARN_FLAGS(flags)					\
 do {								\
-	_BUG_FLAGS(ASM_UD0, BUGFLAG_WARNING|(flags));		\
+	_BUG_FLAGS(ASM_UD2, BUGFLAG_WARNING|(flags));		\
 	annotate_reachable();					\
 } while (0)
 
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -181,7 +181,7 @@ int fixup_bug(struct pt_regs *regs, int
 		break;
 
 	case BUG_TRAP_TYPE_WARN:
-		regs->ip += LEN_UD0;
+		regs->ip += LEN_UD2;
 		return 1;
 	}
 
