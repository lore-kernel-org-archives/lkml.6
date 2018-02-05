Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226v48xlLcea1xHsuuES1uGnVl2hG2GSqbix2dUKIOQob+J50VmJLQduI4crmMUj9EufxdVy
ARC-Seal: i=1; a=rsa-sha256; t=1517855115; cv=none;
        d=google.com; s=arc-20160816;
        b=EZ8KB1fz1MWC4iyzhXe4EdlFFG2b+CXHuEJd4bpUiTNIE9+8eaon2ZPsW+EOjRFeEM
         DnPqOyRN9ioG99ZPYsNzXckV9Vfz//IG/AQpJ+EnzkwEwoHe7jDuwdqQTtilEwzD3Mdx
         2bjTcfQFv+HfOzwL/0fBiA5uY1yTAjzlY2G1uRDhk+kDpNXdM0WWcmBM3diouLH5OkYD
         YYhrdqZi76jb6FZnbb0Nt3UhlZZDAfpa5WkVE3TYFSSNoQlYWnb466hDg2iUgCor0VCj
         hqhKXUHhhSnZmqMpdmqmBTTSvvkojLLB3HOhh0V0VDctZgwl09VaPbHb9ldn7a/EJsEs
         bFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nMRA/GgkDZztbw6u5v7Cz/6+f/3N0qFadu618zEra0g=;
        b=B5rFND0NStgqQmvaQqa7Lwal8rtyDJpCt52WuAAVYLUhHUVEmXYi8doGVlCqjd37Uq
         NzllMpEk+DZBK1ESI86/xYfyz7a9L4WttwVUNiDCcn7BDOPTnZBs8KGGAr5vJAtPf82q
         vm9iWY5E+5yBQE1/1IRLTMNXQqJb2TnAj3TI8eOMcnDhmw+2w1390WUIcgW2OH4JJM80
         EBRFPGuDdmIpbz7WiOXsU+B6WEbidRf1CiL3eJ2NgH8D2BXJ/1CXGv3+AdaFYan94enE
         T7Gz+ApZi4hYQjVr+KF9/REaI0v0dOtFT30nLH1PRJDR8DCmk/g44ICxkX0mXEJf2lXM
         8kRw==
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
	Guenter Roeck <linux@roeck-us.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juergen Gross <jgross@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 25/60] objtool: Add support for alternatives at the end of a section
Date: Mon,  5 Feb 2018 10:22:58 -0800
Message-Id: <20180205182214.970097989@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586357239310339?=
X-GMAIL-MSGID: =?utf-8?q?1591586444833781099?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf jpoimboe@redhat.com

commit 17bc33914bcc98ba3c6b426fd1c49587a25c0597

Now that the previous patch gave objtool the ability to read retpoline
alternatives, it shows a new warning:

  arch/x86/entry/entry_64.o: warning: objtool: .entry_trampoline: don't know how to handle alternatives at end of section

This is due to the JMP_NOSPEC in entry_SYSCALL_64_trampoline().

Previously, objtool ignored this situation because it wasn't needed, and
it would have required a bit of extra code.  Now that this case exists,
add proper support for it.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/2a30a3c2158af47d891a76e69bb1ef347e0443fd.1517284349.git.jpoimboe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/check.c |   53 +++++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -594,7 +594,7 @@ static int handle_group_alt(struct objto
 			    struct instruction *orig_insn,
 			    struct instruction **new_insn)
 {
-	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump;
+	struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
 	unsigned long dest_off;
 
 	last_orig_insn = NULL;
@@ -610,28 +610,30 @@ static int handle_group_alt(struct objto
 		last_orig_insn = insn;
 	}
 
-	if (!next_insn_same_sec(file, last_orig_insn)) {
-		WARN("%s: don't know how to handle alternatives at end of section",
-		     special_alt->orig_sec->name);
-		return -1;
-	}
-
-	fake_jump = malloc(sizeof(*fake_jump));
-	if (!fake_jump) {
-		WARN("malloc failed");
-		return -1;
+	if (next_insn_same_sec(file, last_orig_insn)) {
+		fake_jump = malloc(sizeof(*fake_jump));
+		if (!fake_jump) {
+			WARN("malloc failed");
+			return -1;
+		}
+		memset(fake_jump, 0, sizeof(*fake_jump));
+		INIT_LIST_HEAD(&fake_jump->alts);
+		clear_insn_state(&fake_jump->state);
+
+		fake_jump->sec = special_alt->new_sec;
+		fake_jump->offset = -1;
+		fake_jump->type = INSN_JUMP_UNCONDITIONAL;
+		fake_jump->jump_dest = list_next_entry(last_orig_insn, list);
+		fake_jump->ignore = true;
 	}
-	memset(fake_jump, 0, sizeof(*fake_jump));
-	INIT_LIST_HEAD(&fake_jump->alts);
-	clear_insn_state(&fake_jump->state);
-
-	fake_jump->sec = special_alt->new_sec;
-	fake_jump->offset = -1;
-	fake_jump->type = INSN_JUMP_UNCONDITIONAL;
-	fake_jump->jump_dest = list_next_entry(last_orig_insn, list);
-	fake_jump->ignore = true;
 
 	if (!special_alt->new_len) {
+		if (!fake_jump) {
+			WARN("%s: empty alternative at end of section",
+			     special_alt->orig_sec->name);
+			return -1;
+		}
+
 		*new_insn = fake_jump;
 		return 0;
 	}
@@ -654,8 +656,14 @@ static int handle_group_alt(struct objto
 			continue;
 
 		dest_off = insn->offset + insn->len + insn->immediate;
-		if (dest_off == special_alt->new_off + special_alt->new_len)
+		if (dest_off == special_alt->new_off + special_alt->new_len) {
+			if (!fake_jump) {
+				WARN("%s: alternative jump to end of section",
+				     special_alt->orig_sec->name);
+				return -1;
+			}
 			insn->jump_dest = fake_jump;
+		}
 
 		if (!insn->jump_dest) {
 			WARN_FUNC("can't find alternative jump destination",
@@ -670,7 +678,8 @@ static int handle_group_alt(struct objto
 		return -1;
 	}
 
-	list_add(&fake_jump->list, &last_new_insn->list);
+	if (fake_jump)
+		list_add(&fake_jump->list, &last_new_insn->list);
 
 	return 0;
 }
