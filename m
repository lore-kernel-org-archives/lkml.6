Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AB8JxZqlKHbbJml1vgVD6q51I6nLWNvjCPW+gZ4MHjd4rtVoaJYY34MUgfAeyePeFjtJW1r0kqJO
ARC-Seal: i=1; a=rsa-sha256; t=1525956267; cv=none;
        d=google.com; s=arc-20160816;
        b=Y/Nl/Qqaj0bL3ZwnbuE1ynMKFYwjMFC76kKNV0EXpV5pryKlZ6VRgiQvT3KIGI4eXL
         hW2RSrm9l5WT0+Oe4U9hG6e3ifstbI/3RI/7racltlYUefuV7fhiTjBu6ZsKiGQmhhOP
         qKjaDkXNLgVKzvbCyGYv/Fl/qMeeARYyal6IFFVcXYwvKFbo/4ZFJxYrrNwCt+AniAaI
         g3tpEwOnDDGDcKt137CsXIpfkUPBgX5DbvMxKVkr4rkzOD0RX+I4u/8JikfqHpp1aBpL
         fEcZUbNu1Zp441BRG6QTOD9rSuEtMpvIbFsrJrKeGbWSEM73Fr28cHwsDvEjXyCdo2zK
         1a4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=+VJ1YcYiAR3Z0pKsfW1dqFzyHqoYO02iPYkYC28kOBg=;
        b=FrETZuNDlyXcp0eQnn32z6H5aQ22cYSrkvuIJ3hNJXRfi6D/z2wlvwttRJJdU0/Del
         1ekBSu0Y62pSGeG9BUNyPfoPXUC4W7v+WAVPgKEWzqywXKhFesWuvxlwzpkELIIr6rMv
         OWYQ29FhgMWpqbaSylXkrMjOwecRBinlqtkflKcwT9gFf0Tc4PHw80fhugIbALT/SHqw
         PBvJv7eKMzxtu2Mk426DDOOg5RyRXBzu7M3PHh2z+2i9mR4b6K69TyXYKnkX5XSyUzKq
         SZHyF+p01DBIL8Hqe0sr2p9PMpb+jHH05s12om8ttwJ2iqWHTzgHIxOiZfa1d0nDch0K
         ay0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Thu, 10 May 2018 07:44:24 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Laight <David.Laight@ACULAB.COM>,
	damian <damian.tometzki@icloud.com>
Subject: [PATCH v1.1 3/3] objtool: Support GCC 8 switch tables
Message-ID: <20180510124424.uauk7p4uzsfon4hs@treble>
References: <cover.1525923412.git.jpoimboe@redhat.com>
 <60ba92277204856ced0723f7d7ca52c691baace3.1525923412.git.jpoimboe@redhat.com>
 <20180510084125.GY12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180510084125.GY12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600046846156782249?=
X-GMAIL-MSGID: =?utf-8?q?1600081118970113271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 10:41:25AM +0200, Peter Zijlstra wrote:
> On Wed, May 09, 2018 at 10:39:16PM -0500, Josh Poimboeuf wrote:
> > Add some additional checks to the switch jump table logic.  This fixes
> > the following warnings with GCC 8:
> > 
> >   drivers/block/virtio_blk.o: warning: objtool: virtio_queue_rq()+0x0: stack state mismatch: cfa1=7+8 cfa2=7+72
> >   net/ipv6/icmp.o: warning: objtool: icmpv6_rcv()+0x0: stack state mismatch: cfa1=7+8 cfa2=7+64
> >   drivers/usb/core/quirks.o: warning: objtool: quirks_param_set()+0x0: stack state mismatch: cfa1=7+8 cfa2=7+48
> >   drivers/mtd/nand/raw/nand_hynix.o: warning: objtool: hynix_nand_decode_id()+0x0: stack state mismatch: cfa1=7+8 cfa2=7+24
> >   drivers/mtd/nand/raw/nand_samsung.o: warning: objtool: samsung_nand_decode_id()+0x0: stack state mismatch: cfa1=7+8 cfa2=7+32
> >   drivers/gpu/drm/nouveau/nvkm/subdev/top/gk104.o: warning: objtool: gk104_top_oneinit()+0x0: stack state mismatch: cfa1=7+8 cfa2=7+64
> 
> Could you maybe detail how the GCC8 switch tables are different? And
> thus what needed fixing?

Good point, how about this?

----

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v1.1 3/3] objtool: Support GCC 8 switch tables

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
 tools/objtool/check.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 14daf6a27d9f..6b6885e1e431 100644
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
+		if (prev_offset && rela->offset != prev_offset + sizeof(long))
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
