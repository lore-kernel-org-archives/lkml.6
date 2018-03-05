Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935160AbeCENiz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 08:38:55 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933798AbeCENiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 08:38:51 -0500
Date: Mon, 5 Mar 2018 07:38:49 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sven Joachim <svenjoac@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Linux 4.16-rc4
Message-ID: <20180305133849.moxovwol5nek2fvh@treble>
References: <CA+55aFxXg8hi+T_DNCG_OrAotqSheyREw-Njf9XgUD1vXqAyHQ@mail.gmail.com>
 <878tb7eyf8.fsf@turtle.gmx.de>
 <20180305101748.GL25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180305101748.GL25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 11:17:48AM +0100, Peter Zijlstra wrote:
> On Mon, Mar 05, 2018 at 09:09:31AM +0100, Sven Joachim wrote:
> > On 2018-03-04 15:15 -0800, Linus Torvalds wrote:
> > 
> > > Hmm. A reasonably calm week - the biggest change is to the 'kvm-stat'
> > > tool, not any actual kernel files.
> > >
> > > But there's small changes all over, with architecture updates (x86,
> > > s390, arm, parisc) and drivers (media, md, gpu, sound) being the bulk
> > > of it.  But there's some filesystem fixes (mostly btrfs),
> > > documentation updates etc too.
> > >
> > > Go test,
> > 
> > Huh, this version does not build for me:
> > 
> > ,----
> > |   CALL    scripts/checksyscalls.sh
> > |   DESCEND  objtool
> > |   CC       /usr/local/src/linux/tools/objtool/check.o
> > | In file included from check.c:26:0:
> > | check.c: In function 'read_retpoline_hints':
> > | warn.h:57:3: error: format '%ld' expects argument of type 'long int', but argument 5 has type 'unsigned int' [-Werror=format=]
> > |    "%s: warning: objtool: " format "\n", \
> > |    ^
> > | check.c:1135:3: note: in expansion of macro 'WARN'
> > |    WARN("retpoline_safe size mismatch: %d %ld", sec->len, sizeof(unsigned long));
> > |    ^~~~
> > | check.c:1135:44: note: format string is defined here
> > |    WARN("retpoline_safe size mismatch: %d %ld", sec->len, sizeof(unsigned long));
> > |                                           ~~^
> > |                                           %d
> > | cc1: all warnings being treated as errors
> > | mv: cannot stat '/usr/local/src/linux/tools/objtool/.check.o.tmp': No such file or directory
> > | /usr/local/src/linux/tools/build/Makefile.build:96: recipe for target '/usr/local/src/linux/tools/objtool/check.o' failed
> > | make[3]: *** [/usr/local/src/linux/tools/objtool/check.o] Error 1
> > `----
> > 
> > This might be because I still use a 32-bit userland with a 64-bit
> > kernel.
> 
> Urgh, so sizeof() returns size_t which is confusing. But what is the
> actual value of sizeof(unsigned long) for you? I suspect cross building
> objtool doesn't work right at all. We build the kernel using LP64, and
> its retpoline_safe section is 8 bytes. But if we build objtool as ILP32
> then it would interpret things as 4 bytes.
> 
> Josh, is that supposed to work? I could of course move the retpoline
> annotation over to 4 byte relative addressing which would fix this one
> issue. Is that really the only case?

I suspect it may be the only case.  In most cases objtool relies on
libelf for handling the object bit width.

It looks like read_retpoline_hints() is "special" compared to the other
annotation reading functions.  The easiest fix would be to convert it to
be like the others.

Sven, can you test this patch?

---

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 472e64e95891..e00ff29cb7ea 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1112,42 +1112,29 @@ static int read_unwind_hints(struct objtool_file *file)
 
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
