Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvRP/5iPW5dcNiV830Qw3d4nB9dRW6QkBSLu26i5mSvuy5j4bPzexuhx/Qnir6CF8R5GOm+
ARC-Seal: i=1; a=rsa-sha256; t=1520955213; cv=none;
        d=google.com; s=arc-20160816;
        b=KELcddmv3/WovxxaBOWkmQWBlIxoCa1qbBMhQhSzk9n8JADUV+McRkIGd5l2QcIdtL
         rBBxfuclFuT7OTihqhfbb7NrZ6qwN5No9YoW06SICT2OrrZ6q6PZJTxPn93xIGqkje96
         097DcCECVJotVFQe3+gClvAC3H5phwS7sevMNh460zZma0+M4p9xgubNXfwrnDBB/OoZ
         +tY282iyoeF6WusgqVRIhECExzioaA03tT3J7kdi5cr53Z+5fgOCZOGw0XyWsnGeevvJ
         kFAn/t+Yp75qE8HttZI2x4SVhTRxpClwRzHkalLDJZe8l8QzSp8/zRiMEC+zEkNNJZUn
         VAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yl8VZ4sY+5/BXnxtAhsnMs2pKS4007E2ZL0CD7gPI6E=;
        b=JmsoM5BfB/SS1BFAcHAb1wynIr1GRdnIIAIGi/yDb5FHpJLDgMNWJEBQVh916cw0Fh
         6G7KDZz08U/1pAnASz2S5v8yZk3EQ3uXxC3+js+KPI+7u0gQZG3t7jrPd4nvqpS/4+j0
         1xntK7kg6M9pXR/BX3UrtCFHW9vlADyXGmqb33NN6dz1Ja2J7zwzPYuiO8PUnO615kko
         iaCCpr4qoyXZOtIuSZzYRkOMRDR1mwQvqUUYY1zWYtf37QKGCWyO6PalNPRAVPezkG1Y
         k9JNb/wauFELkvmMLY6uuUb2yuLqQhmwzGFQRMetgHlkCN9ytXvYKG2lLH5p4hg1RKb3
         nyQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sven Joachim <svenjoac@gmx.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 102/146] objtool: Fix 32-bit build
Date: Tue, 13 Mar 2018 16:24:29 +0100
Message-Id: <20180313152328.377728392@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837134351255647?=
X-GMAIL-MSGID: =?utf-8?q?1594837134351255647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 63474dc4ac7ed3848a4786b9592dd061901f606d upstream.

Fix the objtool build when cross-compiling a 64-bit kernel on a 32-bit
host.  This also simplifies read_retpoline_hints() a bit and makes its
implementation similar to most of the other annotation reading
functions.

Reported-by: Sven Joachim <svenjoac@gmx.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: b5bc2231b8ad ("objtool: Add retpoline validation")
Link: http://lkml.kernel.org/r/2ca46c636c23aa9c9d57d53c75de4ee3ddf7a7df.1520380691.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/check.c |   27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1115,42 +1115,29 @@ static int read_unwind_hints(struct objt
 
 static int read_retpoline_hints(struct objtool_file *file)
 {
-	struct section *sec, *relasec;
+	struct section *sec;
 	struct instruction *insn;
 	struct rela *rela;
-	int i;
 
-	sec = find_section_by_name(file->elf, ".discard.retpoline_safe");
+	sec = find_section_by_name(file->elf, ".rela.discard.retpoline_safe");
 	if (!sec)
 		return 0;
 
-	relasec = sec->rela;
-	if (!relasec) {
-		WARN("missing .rela.discard.retpoline_safe section");
-		return -1;
-	}
-
-	if (sec->len % sizeof(unsigned long)) {
-		WARN("retpoline_safe size mismatch: %d %ld", sec->len, sizeof(unsigned long));
-		return -1;
-	}
-
-	for (i = 0; i < sec->len / sizeof(unsigned long); i++) {
-		rela = find_rela_by_dest(sec, i * sizeof(unsigned long));
-		if (!rela) {
-			WARN("can't find rela for retpoline_safe[%d]", i);
+	list_for_each_entry(rela, &sec->rela_list, list) {
+		if (rela->sym->type != STT_SECTION) {
+			WARN("unexpected relocation symbol type in %s", sec->name);
 			return -1;
 		}
 
 		insn = find_insn(file, rela->sym->sec, rela->addend);
 		if (!insn) {
-			WARN("can't find insn for retpoline_safe[%d]", i);
+			WARN("bad .discard.retpoline_safe entry");
 			return -1;
 		}
 
 		if (insn->type != INSN_JUMP_DYNAMIC &&
 		    insn->type != INSN_CALL_DYNAMIC) {
-			WARN_FUNC("retpoline_safe hint not a indirect jump/call",
+			WARN_FUNC("retpoline_safe hint not an indirect jump/call",
 				  insn->sec, insn->offset);
 			return -1;
 		}
