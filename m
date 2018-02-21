Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226flJo2pCV/gPQQgd1kC97ONv83KoZHQscJOK3I20kWJZH2veaT/yqTSTayumKPJqyO2L4S
ARC-Seal: i=1; a=rsa-sha256; t=1519218542; cv=none;
        d=google.com; s=arc-20160816;
        b=E2kCCYDcSmLHnPijuwRAcf9m/tKiotImcxy+WDC1EWDbGuo6pGabsEcvl3XfObvoVv
         QiOG2vv+l2sYIOC30rKbL1Tcpy5xRBVGGK+cJrM01dxwseygPkUc4ReGr0t0Sb7gXJei
         ipXIk4kxRjvU/GhctMYJ9iIFxLYhgWxss1B4xqpcrX1jwxgM3PQ4fMmJA3oFT6gSaF3R
         R/d+ZGyrc4quwHoNnGiTFkCc+BM10Pn1t8biNRmx75P4W+QWYIQaj+JGhJQKyRibFjxI
         jxe8BeF/MiKOB3wPkp3S/gs5SDm8PMDq/bqR85+c+bJIjxCQXDCCeVv6MfLEg8uw1daz
         o+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=soWwpva6Mph8aUxK75EV+UNCCqS66qrGZyDuoM8iIVM=;
        b=GoGqMGPvLr05h/WQ5RtLHaut+iZvlpV3AnDbGHq11CgFzQneIZI6OHSJPqwzkwO6a3
         pkR0CnpluZvDqK3A3dn1TlIh5pRJEzhc26TEm2cPcXe5ho6v2RB8coNT0B7b9syUrIVk
         hSxFPWMIv5VXfmI1y0n681LZFcjf5IGdzZ7wsFQiCV5A0qqTZZcqYMeKh/tn60zaXnZ1
         MK+TLCsZCZFc4y+ti5mpZhyeF9Ki7oHt6zlw3zZEk6wngUiXsUmSrCGbWOpAATfMJLr3
         O8x8ocKBDMYhX9Npo/650yo06FnyFDbpFzoDJ4pL/x5DpKtCnycu7qWqggC1dEhITIIO
         EM8Q==
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
Subject: [PATCH 4.15 076/163] objtool: Fix segfault in ignore_unreachable_insn()
Date: Wed, 21 Feb 2018 13:48:25 +0100
Message-Id: <20180221124534.667702428@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015699116643894?=
X-GMAIL-MSGID: =?utf-8?q?1593016102792238006?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
