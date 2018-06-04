Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbeFDH2W (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752663AbeFDHAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:00:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        kbuild test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        damian <damian.tometzki@icloud.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 04/52] objtool: Support GCC 8 switch tables
Date: Mon,  4 Jun 2018 08:57:59 +0200
Message-Id: <20180604065606.716935646@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065606.532044490@linuxfoundation.org>
References: <20180604065606.532044490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit fd35c88b74170d9335530d9abf271d5d73eb5401 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/objtool/check.c |   24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -805,17 +805,28 @@ static int add_switch_table(struct objto
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
@@ -826,6 +837,13 @@ static int add_switch_table(struct objto
 
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
@@ -882,7 +900,9 @@ static struct rela *find_switch_table(st
 	struct instruction *orig_insn = insn;
 
 	text_rela = find_rela_by_dest_range(insn->sec, insn->offset, insn->len);
-	if (text_rela && text_rela->sym == file->rodata->sym) {
+	if (text_rela && text_rela->sym == file->rodata->sym &&
+	    !find_symbol_containing(file->rodata, text_rela->addend)) {
+
 		/* case 1 */
 		rodata_rela = find_rela_by_dest(file->rodata,
 						text_rela->addend);
