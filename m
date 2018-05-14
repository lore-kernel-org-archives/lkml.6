Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AB8JxZqtlgvQVE0x8UJDMHNJHatGpEIH7Zg1EbG808cW4EAOOCDFOPfc+98MxUSOgVuNPAW/4Y+j
ARC-Seal: i=1; a=rsa-sha256; t=1526301550; cv=none;
        d=google.com; s=arc-20160816;
        b=BFr4RDrthGKQn0o0FtsG2SRlKoSQmA6k9jYna/mMEPfWi16/eXK4chlUk8aFGiLbGD
         7VECW2aJXiesQcfWpYo75KAttI+Txwvx6Ta9Hyn7ex6eVnrfJSGjB5kGUY+34ycJEYqI
         0m+OK5kDx+K/Qcwv6sayj+sLzYfKboHorrmSiyowd4aOGzt1UVAQPT5fz8mkIlr1sxzE
         9HHY0cwMKiL4bQL1te9KsjrTFsznwbZo9zEeNN9XoWsBIyoARHAE6OjkDweNQethK0RR
         2b8VdWyxjZ7NVqbdSCtp9GRI7ttGsdce44RHb+z7OGae8YXfom8uvThWQjyhmtbExhK9
         2D4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=d/vobhZ2+kc8Y46z7W6Ba9DsbLB+baf9tIxy+FZnmk4=;
        b=wPi4AOr/rj1GwrOchB3k96t0RioeOwfFZUsui8TToMD928HO48WiRhUUV6OQHQMEFq
         avnd3eNtxjBT2p+y7hLcXjZXK/OKEl5AJvfxnC/OiAVwWdpWURxkKfkYNXBWpdNAaO3v
         XYSbn9WlnZQo4ri4qbHAHNEt79uwHpu8Pc8IG0nsGwrXOZTTFf+FvKcA46RvSO+D7alN
         hEn0ra1iwwDEaPceDwylRT7htNMBQavBj1tp5M2fDiFpoU2O6DSdLplJAitGwohqXnav
         vVzba9CIiaPt09sG2Ac0Mxvhy/OCBLt61Xetz9CIxd4uTCH94mxadDlZySlVv3sfX6YL
         DBRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Mon, 14 May 2018 05:38:17 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-fd35c88b74170d9335530d9abf271d5d73eb5401@git.kernel.org>
Cc: torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org,
        damian.tometzki@icloud.com, David.Laight@ACULAB.COM,
        peterz@infradead.org, arnd@arndb.de, lkp@intel.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Reply-To: rdunlap@infradead.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        damian.tometzki@icloud.com, peterz@infradead.org,
        David.Laight@ACULAB.COM, mingo@kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, tglx@linutronix.de, lkp@intel.com,
        arnd@arndb.de
In-Reply-To: <20180510224849.xwi34d6tzheb5wgw@treble>
References: <20180510224849.xwi34d6tzheb5wgw@treble>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] objtool: Support GCC 8 switch tables
Git-Commit-ID: fd35c88b74170d9335530d9abf271d5d73eb5401
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600046846156782249?=
X-GMAIL-MSGID: =?utf-8?q?1600443174352079871?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  fd35c88b74170d9335530d9abf271d5d73eb5401
Gitweb:     https://git.kernel.org/tip/fd35c88b74170d9335530d9abf271d5d73eb5401
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Thu, 10 May 2018 17:48:49 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 10:20:54 +0200

objtool: Support GCC 8 switch tables

With GCC 8, some issues were found with the objtool switch table
detection.

1) In the .rodata section, immediately after the switch table, there can
   be another object which contains a pointer to the function which had
   the switch statement.  In this case objtool wrongly considers the
   function pointer to be part of the switch table.  Fix it by:

   a) making sure there are no pointers to the beginning of the
      function; and

   b) making sure there are no gaps in the switch table.

   Only the former was needed, the latter adds additional protection for
   future optimizations.

2) In find_switch_table(), case 1 and case 2 are missing the check to
   ensure that the .rodata switch table data is anonymous, i.e. that it
   isn't already associated with an ELF symbol.  Fix it by adding the
   same find_symbol_containing() check which is used for case 3.

This fixes the following warnings with GCC 8:

  drivers/block/virtio_blk.o: warning: objtool: virtio_queue_rq()+0x0: stack state mismatch: cfa1=7+8 cfa2=7+72
  net/ipv6/icmp.o: warning: objtool: icmpv6_rcv()+0x0: stack state mismatch: cfa1=7+8 cfa2=7+64
  drivers/usb/core/quirks.o: warning: objtool: quirks_param_set()+0x0: stack state mismatch: cfa1=7+8 cfa2=7+48
  drivers/mtd/nand/raw/nand_hynix.o: warning: objtool: hynix_nand_decode_id()+0x0: stack state mismatch: cfa1=7+8 cfa2=7+24
  drivers/mtd/nand/raw/nand_samsung.o: warning: objtool: samsung_nand_decode_id()+0x0: stack state mismatch: cfa1=7+8 cfa2=7+32
  drivers/gpu/drm/nouveau/nvkm/subdev/top/gk104.o: warning: objtool: gk104_top_oneinit()+0x0: stack state mismatch: cfa1=7+8 cfa2=7+64

Reported-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: damian <damian.tometzki@icloud.com>
Link: http://lkml.kernel.org/r/20180510224849.xwi34d6tzheb5wgw@treble
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/check.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 14daf6a27d9f..9bb04fddd3c8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -810,17 +810,28 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
 	struct rela *rela = table;
 	struct instruction *alt_insn;
 	struct alternative *alt;
+	struct symbol *pfunc = insn->func->pfunc;
+	unsigned int prev_offset = 0;
 
 	list_for_each_entry_from(rela, &file->rodata->rela->rela_list, list) {
 		if (rela == next_table)
 			break;
 
+		/* Make sure the switch table entries are consecutive: */
+		if (prev_offset && rela->offset != prev_offset + 8)
+			break;
+
+		/* Detect function pointers from contiguous objects: */
+		if (rela->sym->sec == pfunc->sec &&
+		    rela->addend == pfunc->offset)
+			break;
+
 		alt_insn = find_insn(file, rela->sym->sec, rela->addend);
 		if (!alt_insn)
 			break;
 
 		/* Make sure the jmp dest is in the function or subfunction: */
-		if (alt_insn->func->pfunc != insn->func->pfunc)
+		if (alt_insn->func->pfunc != pfunc)
 			break;
 
 		alt = malloc(sizeof(*alt));
@@ -831,6 +842,13 @@ static int add_switch_table(struct objtool_file *file, struct instruction *insn,
 
 		alt->insn = alt_insn;
 		list_add_tail(&alt->list, &insn->alts);
+		prev_offset = rela->offset;
+	}
+
+	if (!prev_offset) {
+		WARN_FUNC("can't find switch jump table",
+			  insn->sec, insn->offset);
+		return -1;
 	}
 
 	return 0;
@@ -887,7 +905,9 @@ static struct rela *find_switch_table(struct objtool_file *file,
 	struct instruction *orig_insn = insn;
 
 	text_rela = find_rela_by_dest_range(insn->sec, insn->offset, insn->len);
-	if (text_rela && text_rela->sym == file->rodata->sym) {
+	if (text_rela && text_rela->sym == file->rodata->sym &&
+	    !find_symbol_containing(file->rodata, text_rela->addend)) {
+
 		/* case 1 */
 		rodata_rela = find_rela_by_dest(file->rodata,
 						text_rela->addend);
