Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AB8JxZr5v0hX/hb5Rcgtm7cLcFyUQbN7/1orCTgYYJk+E3m1GHEYTw1DMllkuTyiyH28nA0il9Gh
ARC-Seal: i=1; a=rsa-sha256; t=1525923582; cv=none;
        d=google.com; s=arc-20160816;
        b=xydMXdVavfRPJrjNRDr+TdJKFBDKdy26LdLJKZDR2gQO1iNxfahHeUQ/JyQh+pvelX
         VzptjkhpMCLTvAOw8raVINRFPHovT/GDVstwg0obWTL4bzdhxJxhjjWgwH8drrQzAKyR
         sVwyT0Tx5FYs9U7UFFzJ8+vxSMpyOD25k4mI9SG3fjfPMPTnIcMOsU03NK/NnvGadOj2
         4k7esm9hOTF9nXLV7+A2YOI6Vo8dKJnCCCmvUyq48kI/2qE9oYEOII2/trmY2P00kvVS
         KzV/zyWTD2krQVzyzF6/eD/wEBmpbttz22zNZDrcSsUWWN0EeBTUbALObi4E1ioaxbg9
         3C7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=K+I5MPQyVlC8GrZgPscNMQWbYlgEAmhune9ZlMiqIRs=;
        b=Ut9Fz8now5n99E01lr1yvOui1Y3D+SpmADDLB3a9HMJ86BgFtV4rtex6p4ICYXHrin
         B2O3e+US5E5zB9o+YNg5XNEg3blfi8Sxm8f5RRnt0bL6NohUBPxsfWwQPhZ5x6meHzlW
         euHPSe4l9hMPHEtorzRuuy1YgHqk7Fh1dvZlaeMR8csPIvLLj66i80cZ3UcS2qz96+CI
         3b1a9dS/7k9qI2vvaINsRGZKg569WUQ+DoW3c/n06K2xDYXIVwCUhe1/1i44hoMG2P7Z
         YTQ7pAc+olmQP3mTCgFwb6Or9be3icptkeA6emzA+hJ4H3UwsbIRbqonDBJ59WmiCB5t
         Rzvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Laight <David.Laight@ACULAB.COM>,
	damian <damian.tometzki@icloud.com>
Subject: [PATCH 3/3] objtool: Support GCC 8 switch tables
Date: Wed,  9 May 2018 22:39:16 -0500
Message-Id: <60ba92277204856ced0723f7d7ca52c691baace3.1525923412.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1525923412.git.jpoimboe@redhat.com>
References: <cover.1525923412.git.jpoimboe@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600046846156782249?=
X-GMAIL-MSGID: =?utf-8?q?1600046846156782249?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add some additional checks to the switch jump table logic.  This fixes
the following warnings with GCC 8:

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
