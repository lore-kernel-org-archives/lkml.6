Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C64C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93EE20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388453AbfAORim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:38:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729052AbfAORil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:38:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C30B83F42;
        Tue, 15 Jan 2019 17:38:41 +0000 (UTC)
Received: from krava (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1EAAB1048110;
        Tue, 15 Jan 2019 17:38:38 +0000 (UTC)
Date:   Tue, 15 Jan 2019 18:38:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Nick Clifton <nickc@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFCv2] perf tools: Filter out hidden symbols from labels
Message-ID: <20190115173838.GB31411@krava>
References: <20190115135354.11572-1-jolsa@kernel.org>
 <960f0b83-a623-67a6-ab55-d56139d10ba2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <960f0b83-a623-67a6-ab55-d56139d10ba2@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 15 Jan 2019 17:38:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 04:13:16PM +0000, Nick Clifton wrote:
> Hi Jiri,
> 
> > When perf is built with annobin plugin (RHEL8 build) extra symbols
> > are added to its binary:
> 
>   A bit of background for those wondering why annobin is creating
>   these symbols:  Annobin is a plugin for gcc that records data 
>   about how object file were built.  It is specifically designed 
>   to be able to cope with files that are built using multiple
>   different sets of optimization options.  (Eg because of #pragma
>   directives or function specific optimization attributes).  It
>   generates notes to cover each compiled region of code, and it
>   needs the symbols in order to be able to determine exactly which
>   areas in a linked binary were compiled with which options.
> 
>   In the course of developing this plugin I encountered various
>   problems with tools not expecting to find extra symbols in a
>   binary.  Hence I made the symbols local, hidden and with no type.
>   It was the best I could do to say "ignore these symbols - they
>   are not meant to be seen by anyone but annobin".
> 
> 
> > +		elf_sym__visibility(sym) != STV_HIDDEN;
> 
>   Just to be awkward, if you are going to ignore STV_HIDDEN 
>   symbols then you should probably also ignore STV_INTERNAL ones
>   as well...  Annobin does not generate them, but you never know,
>   one day some other tool might create some.

sounds good, thanks

jirka


---
When perf is built with annobin plugin (RHEL8 build) extra symbols
are added to its binary:

  # nm perf | grep annobin | head -10
  0000000000241100 t .annobin_annotate.c
  0000000000326490 t .annobin_annotate.c
  0000000000249255 t .annobin_annotate.c_end
  00000000003283a8 t .annobin_annotate.c_end
  00000000001bce18 t .annobin_annotate.c_end.hot
  00000000001bce18 t .annobin_annotate.c_end.hot
  00000000001bc3e2 t .annobin_annotate.c_end.unlikely
  00000000001bc400 t .annobin_annotate.c_end.unlikely
  00000000001bce18 t .annobin_annotate.c.hot
  00000000001bce18 t .annobin_annotate.c.hot
  ...

those symbols have no use for report or annotation and should be skipped.
Moreover they interfere with dwarf unwind test on ppc arch, where they
are mixed with checked symbols and test fails:

  # perf test dwarf -v
  59: Test dwarf unwind                                     :
  --- start ---
  test child forked, pid 8515
  unwind: .annobin_dwarf_unwind.c:ip = 0x10dba40dc (0x2740dc)
  ...
  got: .annobin_dwarf_unwind.c 0x10dba40dc, expecting test__arch_unwind_sample
  unwind: failed with 'no error'

The annobin symbols are defined as NOTYPE/LOCAL/HIDDEN:

  # readelf -s ./perf | grep annobin | head -1
    40: 00000000001bce4f     0 NOTYPE  LOCAL  HIDDEN    13 .annobin_init.c

They can still pass the check for the label symbol. Adding
check for HIDDEN and INTERNAL (as suggested by Nick below)
visibility and filter out such symbols.

> Nick Clifton wrote:
>
>   Just to be awkward, if you are going to ignore STV_HIDDEN
>   symbols then you should probably also ignore STV_INTERNAL ones
>   as well...  Annobin does not generate them, but you never know,
>   one day some other tool might create some.

Link: http://lkml.kernel.org/n/tip-4yuna6qhhg0df3q147cjdyuu@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/symbol-elf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 66a84d5846c8..03cb8c6d620a 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -87,6 +87,11 @@ static inline uint8_t elf_sym__type(const GElf_Sym *sym)
 	return GELF_ST_TYPE(sym->st_info);
 }
 
+static inline uint8_t elf_sym__visibility(const GElf_Sym *sym)
+{
+	return GELF_ST_VISIBILITY(sym->st_other);
+}
+
 #ifndef STT_GNU_IFUNC
 #define STT_GNU_IFUNC 10
 #endif
@@ -111,7 +116,9 @@ static inline int elf_sym__is_label(const GElf_Sym *sym)
 	return elf_sym__type(sym) == STT_NOTYPE &&
 		sym->st_name != 0 &&
 		sym->st_shndx != SHN_UNDEF &&
-		sym->st_shndx != SHN_ABS;
+		sym->st_shndx != SHN_ABS &&
+		elf_sym__visibility(sym) != STV_HIDDEN &&
+		elf_sym__visibility(sym) != STV_INTERNAL;
 }
 
 static bool elf_sym__filter(GElf_Sym *sym)
-- 
2.17.2

