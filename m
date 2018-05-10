Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AB8JxZqXG8YZK4DImOSj/MIsOQqQ1JjWc4xVtuULl7FMibUPnSJ/tGcE3ImT7B6cZQJyYDiJbAdy
ARC-Seal: i=1; a=rsa-sha256; t=1525992531; cv=none;
        d=google.com; s=arc-20160816;
        b=kNoJh1cpzYE+md0N6tlvsvW0kBu3mR3bvpijh3lOs32T9sVAME93dxOOY2cpV3LFr6
         SCka8GyuI6/Bduohmda1G8MWXd8BY3NhSlykBZgMf3ufPE2g0nKquCyXspFhf5cJ8EBr
         uOljkueAI7EdEGh3XbWIkmuL8xUw3V5DfSEZDF+XI3zr3ShHK3DXPOP7I53Y6NJ0PwUO
         tQQRLYdwXuywn2cDT9R1RPJwMZyc9JPlZ9a7vbwYMIDQthUYnhJ2iEttAB9r1XLFiMFm
         Hs9N/psxRLleXDMU0ikIWeAtFoXUI8y2MzBGOq9TMyj6LpZjrqiUgTq8Tjdl/9my8Fco
         HWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ymlmBTa7uMnJrjInY+T8fhtyKafgxqqV89GsDWTdZxI=;
        b=pijKcli6WBNlyLVaF+jlZ86O7+5LSBd8NcmBVFAVBmlqMnBV89bYG/2/GFvzuMzwkc
         IfOZrdkYtGaPf+IKVT3l7EqiwCZyARDf5u1PRkLA5cuQ4OxB+3jL+66mXzKTzZMbJOq4
         rbOd4Ddp4FrwKMO9h68XPhJGPtTZk0SljLJJtYBQ08CahOiwZ5ZDrN64iY1vOocZpRk8
         CevsXIlevlQLQEY8Pff5aEENKwgW90ntgBhHklMUl4Zho/0D8t7rVXfUVefP2wRpqlZy
         yrNNf+Z2rGm5CYdinVQqRlD/6I6mmPP5SKqsgSEfXbyZgtcsvbh3/O/ThK/aMM4dfykY
         1/7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Thu, 10 May 2018 17:48:49 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Laight <David.Laight@ACULAB.COM>,
	damian <damian.tometzki@icloud.com>
Subject: [PATCH v1.3 3/3] objtool: Support GCC 8 switch tables
Message-ID: <20180510224849.xwi34d6tzheb5wgw@treble>
References: <cover.1525923412.git.jpoimboe@redhat.com>
 <60ba92277204856ced0723f7d7ca52c691baace3.1525923412.git.jpoimboe@redhat.com>
 <20180510084125.GY12217@hirez.programming.kicks-ass.net>
 <20180510124424.uauk7p4uzsfon4hs@treble>
 <20180510224516.s7qcjvbolwxkvzqd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180510224516.s7qcjvbolwxkvzqd@treble>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600046846156782249?=
X-GMAIL-MSGID: =?utf-8?q?1600119144993656328?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


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
---
v1.3: Combine improved patch description from 1.1 with 32-bit host
      cross-compile from 1.2.

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
-- 
2.17.0
