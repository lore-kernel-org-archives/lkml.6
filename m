Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67ADECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B592D2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B592D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeJROUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:20:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52407 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeJROUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:20:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9I6KCnX708052
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Oct 2018 23:20:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9I6KBfq708049;
        Wed, 17 Oct 2018 23:20:11 -0700
Date:   Wed, 17 Oct 2018 23:20:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Milian Wolff <tipbot@zytor.com>
Message-ID: <tip-d4046e8e17b9f378cb861982ef71c63911b5dff3@git.kernel.org>
Cc:     hpa@zytor.com, grasland@lal.in2p3.fr, acme@redhat.com,
        yao.jin@linux.intel.com, namhyung@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, jolsa@kernel.org, milian.wolff@kdab.com,
        linux-kernel@vger.kernel.org
Reply-To: acme@redhat.com, yao.jin@linux.intel.com, grasland@lal.in2p3.fr,
          hpa@zytor.com, milian.wolff@kdab.com,
          linux-kernel@vger.kernel.org, jolsa@kernel.org, mingo@kernel.org,
          tglx@linutronix.de, namhyung@kernel.org
In-Reply-To: <20180926135207.30263-3-milian.wolff@kdab.com>
References: <20180926135207.30263-3-milian.wolff@kdab.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf report: Don't crash on invalid inline debug
 information
Git-Commit-ID: d4046e8e17b9f378cb861982ef71c63911b5dff3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d4046e8e17b9f378cb861982ef71c63911b5dff3
Gitweb:     https://git.kernel.org/tip/d4046e8e17b9f378cb861982ef71c63911b5dff3
Author:     Milian Wolff <milian.wolff@kdab.com>
AuthorDate: Wed, 26 Sep 2018 15:52:07 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 16 Oct 2018 14:52:21 -0300

perf report: Don't crash on invalid inline debug information

When the function name for an inline frame is invalid, we must not try
to demangle this symbol, otherwise we crash with:

  #0  0x0000555555895c01 in bfd_demangle ()
  #1  0x0000555555823262 in demangle_sym (dso=0x555555d92b90, elf_name=0x0, kmodule=0) at util/symbol-elf.c:215
  #2  dso__demangle_sym (dso=dso@entry=0x555555d92b90, kmodule=<optimized out>, kmodule@entry=0, elf_name=elf_name@entry=0x0) at util/symbol-elf.c:400
  #3  0x00005555557fef4b in new_inline_sym (funcname=0x0, base_sym=0x555555d92b90, dso=0x555555d92b90) at util/srcline.c:89
  #4  inline_list__append_dso_a2l (dso=dso@entry=0x555555c7bb00, node=node@entry=0x555555e31810, sym=sym@entry=0x555555d92b90) at util/srcline.c:264
  #5  0x00005555557ff27f in addr2line (dso_name=dso_name@entry=0x555555d92430 "/home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da66033d24fce5/elf", addr=addr@entry=2888, file=file@entry=0x0,
      line=line@entry=0x0, dso=dso@entry=0x555555c7bb00, unwind_inlines=unwind_inlines@entry=true, node=0x555555e31810, sym=0x555555d92b90) at util/srcline.c:313
  #6  0x00005555557ffe7c in addr2inlines (sym=0x555555d92b90, dso=0x555555c7bb00, addr=2888, dso_name=0x555555d92430 "/home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da66033d24fce5/elf")
      at util/srcline.c:358

So instead handle the case where we get invalid function names for
inlined frames and use a fallback '??' function name instead.

While this crash was originally reported by Hadrien for rust code, I can
now also reproduce it with trivial C++ code. Indeed, it seems like
libbfd fails to interpret the debug information for the inline frame
symbol name:

  $ addr2line -e /home/milian/.debug/.build-id/f7/186d14bb94f3c6161c010926da66033d24fce5/elf -if b48
  main
  /usr/include/c++/8.2.1/complex:610
  ??
  /usr/include/c++/8.2.1/complex:618
  ??
  /usr/include/c++/8.2.1/complex:675
  ??
  /usr/include/c++/8.2.1/complex:685
  main
  /home/milian/projects/kdab/rnd/hotspot/tests/test-clients/cpp-inlining/main.cpp:39

I've reported this bug upstream and also attached a patch there which
should fix this issue:

https://sourceware.org/bugzilla/show_bug.cgi?id=23715

Reported-by: Hadrien Grasland <grasland@lal.in2p3.fr>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: a64489c56c30 ("perf report: Find the inline stack for a given address")
[ The above 'Fixes:' cset is where originally the problem was
  introduced, i.e.  using a2l->funcname without checking if it is NULL,
  but this current patch fixes the current codebase, i.e. multiple csets
  were applied after a64489c56c30 before the problem was reported by Hadrien ]
Link: http://lkml.kernel.org/r/20180926135207.30263-3-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/srcline.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 09d6746e6ec8..e767c4a9d4d2 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -85,6 +85,9 @@ static struct symbol *new_inline_sym(struct dso *dso,
 	struct symbol *inline_sym;
 	char *demangled = NULL;
 
+	if (!funcname)
+		funcname = "??";
+
 	if (dso) {
 		demangled = dso__demangle_sym(dso, 0, funcname);
 		if (demangled)
