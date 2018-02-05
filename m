Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225OUVmtrv5n1FtdjQcEHGukJBBleP3bhdOLD3NhqUP+p51PecMTVw2c6nN3BEIDMUhzGM9r
ARC-Seal: i=1; a=rsa-sha256; t=1517855029; cv=none;
        d=google.com; s=arc-20160816;
        b=ion8cfGkFM44DJLC79EPcrjEISSvc1GO6UxbgO5d8Fznus14uI5BgxLoKinOVl6HkO
         OzFVRzq2FGRsZJnNbgqCRVnRR+eXfM4AITgGvRi1C0Oc2xxZLO1nPrm2CqqlyrHQm8eZ
         k2o1+NX4C+u+bsA5fM4bNIDI9YFidphzxVelZelTNFyFwt2fmqfP34e/yXzWDYFDK3jC
         P4QUG5WLmM2AY/yzovBnm/Av56KtVPH04Xja4LiNdYML+kZemgv8t79S993xC1VFIgpQ
         nGy/Qh8XGIv49e3mHMZOJifLQekQmTD5IwtjW3iHkJHeDYJOqBeyChEzwaSaYYbypniP
         ZXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/EdHxLbPbQL/+txObrsV/y6Hl6g2/ENIBEhid+ff4KI=;
        b=YsCR3MUwBZUdMU+2vfuz7jKhGlMsaL+hzisu+UtrAKWRKfz9hVValdQoS0omGeV1iK
         R6nxua9730PP8l2qRpLzT1tESK2YqiE8dJH/7NafuMxEXj/M1wWYPeP7YMRR6yNJ6bt8
         uSk+V3LV3DoTgs/y2qb3fI6Cbi3zvKfpm1YacGq2a6oBevuiO7mTZiKsjSKjRE9sx8q1
         bOUTK0ZiD6DupYd9fSd1zJpVIHQGSGT0sjWV3kj0dYIESIJxC/etmildeCrOZ6/H7828
         4pqfqGRF8NfiUiAj/hp5LG0G4R8w3EXmqQiL4Hc/783r+B/fA/NV3Onm05/jLgeK6q7U
         7P9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juergen Gross <jgross@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 28/64] objtool: Improve retpoline alternative handling
Date: Mon,  5 Feb 2018 10:22:47 -0800
Message-Id: <20180205182139.722565597@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586355800627411?=
X-GMAIL-MSGID: =?utf-8?q?1591586355800627411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf jpoimboe@redhat.com

commit a845c7cf4b4cb5e9e3b2823867892b27646f3a98

Currently objtool requires all retpolines to be:

  a) patched in with alternatives; and

  b) annotated with ANNOTATE_NOSPEC_ALTERNATIVE.

If you forget to do both of the above, objtool segfaults trying to
dereference a NULL 'insn->call_dest' pointer.

Avoid that situation and print a more helpful error message:

  quirks.o: warning: objtool: efi_delete_dummy_variable()+0x99: unsupported intra-function call
  quirks.o: warning: objtool: If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.

Future improvements can be made to make objtool smarter with respect to
retpolines, but this is a good incremental improvement for now.

Reported-and-tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/819e50b6d9c2e1a22e34c1a636c0b2057cc8c6e5.1517284349.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/check.c |   36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -543,18 +543,14 @@ static int add_call_destinations(struct
 			dest_off = insn->offset + insn->len + insn->immediate;
 			insn->call_dest = find_symbol_by_offset(insn->sec,
 								dest_off);
-			/*
-			 * FIXME: Thanks to retpolines, it's now considered
-			 * normal for a function to call within itself.  So
-			 * disable this warning for now.
-			 */
-#if 0
-			if (!insn->call_dest) {
-				WARN_FUNC("can't find call dest symbol at offset 0x%lx",
-					  insn->sec, insn->offset, dest_off);
+
+			if (!insn->call_dest && !insn->ignore) {
+				WARN_FUNC("unsupported intra-function call",
+					  insn->sec, insn->offset);
+				WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
 				return -1;
 			}
-#endif
+
 		} else if (rela->sym->type == STT_SECTION) {
 			insn->call_dest = find_symbol_by_offset(rela->sym->sec,
 								rela->addend+4);
@@ -648,6 +644,8 @@ static int handle_group_alt(struct objto
 
 		last_new_insn = insn;
 
+		insn->ignore = orig_insn->ignore_alts;
+
 		if (insn->type != INSN_JUMP_CONDITIONAL &&
 		    insn->type != INSN_JUMP_UNCONDITIONAL)
 			continue;
@@ -729,10 +727,6 @@ static int add_special_section_alts(stru
 			goto out;
 		}
 
-		/* Ignore retpoline alternatives. */
-		if (orig_insn->ignore_alts)
-			continue;
-
 		new_insn = NULL;
 		if (!special_alt->group || special_alt->new_len) {
 			new_insn = find_insn(file, special_alt->new_sec,
@@ -1089,11 +1083,11 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
-	ret = add_call_destinations(file);
+	ret = add_special_section_alts(file);
 	if (ret)
 		return ret;
 
-	ret = add_special_section_alts(file);
+	ret = add_call_destinations(file);
 	if (ret)
 		return ret;
 
@@ -1720,10 +1714,12 @@ static int validate_branch(struct objtoo
 
 		insn->visited = true;
 
-		list_for_each_entry(alt, &insn->alts, list) {
-			ret = validate_branch(file, alt->insn, state);
-			if (ret)
-				return 1;
+		if (!insn->ignore_alts) {
+			list_for_each_entry(alt, &insn->alts, list) {
+				ret = validate_branch(file, alt->insn, state);
+				if (ret)
+					return 1;
+			}
 		}
 
 		switch (insn->type) {
