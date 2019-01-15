Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9384C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7228320651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547560440;
	bh=dsJVN4rStJFbwiB/zlz/3IH2uyZl+/W5Rk7M5bNSI2Q=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ObsVpT+5m2dry6aqVQ81wIOQUYLyVJBgUfxI7NFw+Fqk5lMp2sw76Hl/WJY/flqKN
	 XMmXupy1BwjcRlFdt3VKvVaPE77sBpSChuzcUTc0khBPaISeG6jnOS8L71CuyHDcUe
	 cx6Mbxk07a73Ng1/4QfQMkHBPIp9tCdWuN/AIBbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbfAONx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:53:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729204AbfAONx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:53:58 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B144D7F6B0;
        Tue, 15 Jan 2019 13:53:57 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55BDB100194B;
        Tue, 15 Jan 2019 13:53:55 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Nick Clifton <nickc@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC] perf tools: Filter out hidden symbols from labels
Date:   Tue, 15 Jan 2019 14:53:54 +0100
Message-Id: <20190115135354.11572-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 15 Jan 2019 13:53:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
sending this as RFC, because I'm not sure this won't break
something else ;-)

thanks,
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
check for HIDDEN visibility and filter out such symbols.

Link: http://lkml.kernel.org/n/tip-4yuna6qhhg0df3q147cjdyuu@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/symbol-elf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 66a84d5846c8..39ef2bde6d6d 100644
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
@@ -111,7 +116,8 @@ static inline int elf_sym__is_label(const GElf_Sym *sym)
 	return elf_sym__type(sym) == STT_NOTYPE &&
 		sym->st_name != 0 &&
 		sym->st_shndx != SHN_UNDEF &&
-		sym->st_shndx != SHN_ABS;
+		sym->st_shndx != SHN_ABS &&
+		elf_sym__visibility(sym) != STV_HIDDEN;
 }
 
 static bool elf_sym__filter(GElf_Sym *sym)
-- 
2.17.2

