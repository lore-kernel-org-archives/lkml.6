Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AB8JxZowDRqoCya9q1eVIBRXIvVLjlIbLLvIvmQT6jN2CqDDfggRRaHxibKmXuaAgUvTu2vYUDpg
ARC-Seal: i=1; a=rsa-sha256; t=1525992319; cv=none;
        d=google.com; s=arc-20160816;
        b=EtsuVHGpF1x6yJaAQHVhchETbHV+IHSYGuOU7BQspeXHE7YDjMeb8hJdEQI95a9aef
         a1u812FshnN7M59otRwOdV16JsWMnHgjSDznVx5NaRxWDhiv5UDU19TpmOMtN2SM22XU
         QnUQ7Qxet01Ua/HRIF1CMPxA4hkhdnc+BrvDLg3Xi72JF2SHH/DNsTDJSjXkIvLwCrpY
         jg4lh/yQFB09pRt1rUm4MkqTNfwDM1UgPA18bwtrmRcRKw0ioWwR0+DeYW8ac7TaEMKX
         ZCXK19Dp4Aa71bkM/HBg3wTajtBhKktGsV8ij6U0zXgcLtwo17AFFfQlxbHdpEbSWNiV
         bkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=eghvfPyqR1fMZi9xLWPSsFozaP4PBf2cIGxv781TxSs=;
        b=Ojdi6NGw/WyfrjrCg+rZI+S67Wa4FtlOS8M1P0u+K262ziOt6B8iXUtEbRLoW7k5k+
         S0n2DlXZ6Ldhm1iA2GDX7AyhCQy3rScS8YGysa9YGxysHBfkwQS2NZtZ7wxzsU/qoKos
         Wmh5He9eANl/1uJaBRpEUs8e/9xWjE5w+O6LMheQfLyjmAHMCeZXTqq1KVTvKjprO4AH
         zzLwFhuN0dBx2nzOoTjt6kvMU8J321Fc3p9L9OILsSTSntwc0TyxnWLkFnigRfIir7qB
         dCq0hCVqCNvy1EUOfL6KS8wF5TQLoSrWLi4+aF1rhOinkOxuoD9DdGSv6LiU3INRd3ja
         UNag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Thu, 10 May 2018 17:45:16 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Laight <David.Laight@ACULAB.COM>,
	damian <damian.tometzki@icloud.com>
Subject: [PATCH v1.2 3/3] objtool: Support GCC 8 switch tables
Message-ID: <20180510224516.s7qcjvbolwxkvzqd@treble>
References: <cover.1525923412.git.jpoimboe@redhat.com>
 <60ba92277204856ced0723f7d7ca52c691baace3.1525923412.git.jpoimboe@redhat.com>
 <20180510084125.GY12217@hirez.programming.kicks-ass.net>
 <20180510124424.uauk7p4uzsfon4hs@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180510124424.uauk7p4uzsfon4hs@treble>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600046846156782249?=
X-GMAIL-MSGID: =?utf-8?q?1600118922778874504?=
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
v1.2: replaced 'sizeof(long)' with '8' to fix cross-compilation of the
      64-bit target on a 32-bit host

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
