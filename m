Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC097C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9263420838
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x78hTOKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9263420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbeJ3WVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbeJ3WVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:21:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EC7E20870;
        Tue, 30 Oct 2018 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906085;
        bh=BOcKYQjx49p9RMdHgJkTPnY5RNmBTtSIaOqsnPrdEd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x78hTOKg9zX53XpOTFSvYKxdvLDVq7Q1Vtda0doZCL8S9OgSL0BSsQ8dsvb2/qMJJ
         edIH4CLOed4j2kzFmvWCwP+tkt4VBKWUKtuci42dNg+y/isFYssaO8sVWep7sNIrj1
         Nx14V5KiK3GoOcFFBU7TVYvtLuMzexW340iRYqgw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Milian Wolff <milian.wolff@kdab.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 24/33] perf report: Don't crash on invalid inline debug information
Date:   Tue, 30 Oct 2018 09:26:48 -0400
Message-Id: <20181030132657.217970-24-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

[ Upstream commit d4046e8e17b9f378cb861982ef71c63911b5dff3 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
-- 
2.17.1

