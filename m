Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227GcocnEH5EwRgqrxo/j/mc8ouClUYMmZZDbY+J5s7L346Oqhz4SEDdfgR85sKAYz834Axb
ARC-Seal: i=1; a=rsa-sha256; t=1519218157; cv=none;
        d=google.com; s=arc-20160816;
        b=C5gxH11YD9+UylTMp5lBOmBdT3bDY+BZncl5A3yFDqwvXax9GfWkjY/V23iMVR7HYn
         rdpVYMljKU88J36gi/pB57dUT1AR892LzoQSRgfEh+uNbZ1wLGLtSfFu1LyNGPhWSVB+
         Bmh0znB4m/1dCPx/RiAH4K9NDoaYiEcaclx6j8vQb5NHgjYr042G4Kko+6OtBfazadNI
         8CnHJcEFUB+pmV5NOpV9R7GJayF+8Mv6VLCjFgcf2EqBrvafFBJ5T/Nzj+YMwsy8gLNg
         /RxGNzs5Y5BfrQ8Nud17/iC/X4e4yW7T0BeuR3uBLo5S2BpSVbg7E67/XfwlkUwdCM9G
         zM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IUhXd/q4O3JekHvFu0IEZuyB3DHtP+MvpdBJ8O5vqJA=;
        b=bWG7KCA7kcBMXnRK1v0sS/gCfGHEw7U64y4W/G3ird0y5AhME4wQhQEr1hqQc0TNWJ
         Tsvf3hVb4mGAd/gKfsTAY8oGTKK8l17yTWleNdFmuS/EjoF9jaGlxtDIo1cyy0iteb/M
         crHPNyHgIqcx+BqPo40urknt0mXODctKKtUUrvRKe70hCRpc5bmv2VQNQEawaSdl2m4r
         cUrz3KBFUyu9jaGKnAt9nw4tQ6pDlq26uUeYBmdJijVf0cZ9vQulnYSkppa0AJX/quAP
         ZrTU/sjJC/gkFS9dEme9k+qGrQfJLC41d3cSvoaZK8qx41CoNf/lHt3Q+AVoV9o+tEnU
         B/7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kbuild test robot <fengguang.wu@intel.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 073/167] objtool: Fix segfault in ignore_unreachable_insn()
Date: Wed, 21 Feb 2018 13:48:04 +0100
Message-Id: <20180221124528.486326973@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015699116643894?=
X-GMAIL-MSGID: =?utf-8?q?1593015699116643894?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit fe24e27128252c230a34a6c628da2bf1676781ea upstream.

Peter Zijlstra's patch for converting WARN() to use UD2 triggered a
bunch of false "unreachable instruction" warnings, which then triggered
a seg fault in ignore_unreachable_insn().

The seg fault happened when it tried to dereference a NULL 'insn->func'
pointer.  Thanks to static_cpu_has(), some functions can jump to a
non-function area in the .altinstr_aux section.  That breaks
ignore_unreachable_insn()'s assumption that it's always inside the
original function.

Make sure ignore_unreachable_insn() only follows jumps within the
current function.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kbuild test robot <fengguang.wu@intel.com>
Link: http://lkml.kernel.org/r/bace77a60d5af9b45eddb8f8fb9c776c8de657ef.1518130694.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/check.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1935,13 +1935,19 @@ static bool ignore_unreachable_insn(stru
 		if (is_kasan_insn(insn) || is_ubsan_insn(insn))
 			return true;
 
-		if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->jump_dest) {
-			insn = insn->jump_dest;
-			continue;
+		if (insn->type == INSN_JUMP_UNCONDITIONAL) {
+			if (insn->jump_dest &&
+			    insn->jump_dest->func == insn->func) {
+				insn = insn->jump_dest;
+				continue;
+			}
+
+			break;
 		}
 
 		if (insn->offset + insn->len >= insn->func->offset + insn->func->len)
 			break;
+
 		insn = list_next_entry(insn, list);
 	}
 
