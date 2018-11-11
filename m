Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DB5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D9020818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rf7GAQpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D9020818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbeKLJ13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:27:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388167AbeKLITz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:55 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCF26223D0;
        Sun, 11 Nov 2018 22:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975398;
        bh=stqA4lZtUDvNdDoJgj2g+NQSO1l9dJfxUP+Zr2g5SgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rf7GAQpSnJZetp4gNpCQjhiYqBhYOkBQ6X63ip2TEtbkmOd+3vAn3CPtODXDfp65M
         tprWSFy7cINQkYFGuMQt7psgOK4zcOh33453KPA2CHhtZ311N+qFqPCEiflWNVSLaQ
         NdHTaY8+On8LjEV+0aRK7TqJPfaG7tmqRA3cN7LI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hadrien Grasland <grasland@lal.in2p3.fr>,
        Milian Wolff <milian.wolff@kdab.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 057/350] perf report: Dont crash on invalid inline debug information
Date:   Sun, 11 Nov 2018 14:18:41 -0800
Message-Id: <20181111221709.546928968@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/srcline.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -85,6 +85,9 @@ static struct symbol *new_inline_sym(str
 	struct symbol *inline_sym;
 	char *demangled = NULL;
 
+	if (!funcname)
+		funcname = "??";
+
 	if (dso) {
 		demangled = dso__demangle_sym(dso, 0, funcname);
 		if (demangled)


