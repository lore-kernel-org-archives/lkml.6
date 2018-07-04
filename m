Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92702C6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E9D246A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Vec2xobH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E9D246A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932905AbeGDCAN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 22:00:13 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:36259 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932739AbeGDCAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 22:00:12 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w641xbPX009644;
        Wed, 4 Jul 2018 10:59:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w641xbPX009644
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530669578;
        bh=AtDucubhSssKwNPw/AgiLNAZ2+1pCI1oXdbitIWfW9k=;
        h=From:To:Cc:Subject:Date:From;
        b=Vec2xobH7FywVdcpELkBCrgV5qOsMWkm025i3UexX0FmIbMU8v1o+xkqqvv/8JT3A
         dSefzuxDSdzJEnwK1/MyPe9JkQxTYvzHYNovYO8t3FiOBjIqYQ0DWSdtEVoKbiSKYk
         IfnZLg+1pe3z4QAv22KowUHDVj2jL8wf37rIbyGBX5L5m1qAk8Fr+iCsw340XZ26UO
         6+DLpr0ojDtoA2yB/O7IJEPGxO0y+6d7LNm6s3PXmbT2RMrJmo5lXkDgfKfn18sNZB
         0gv8XLZyH9PeTCNRgbEZhkb5gWWk/1dmhEoPFVTXaGd4nuxlgcJ0bLdlSruWGztLcU
         Cp/d3VtYQtzLg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/dtc: consolidate include path options in Makefile
Date:   Wed,  4 Jul 2018 10:59:23 +0900
Message-Id: <1530669563-32637-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is tedious to specify extra compiler options for every file.
HOST_EXTRACFLAGS is useful to add options to all files in a
directory.

-I$(src)/libfdt is needed for all the files in this directory
to include libfdt_env.h etc. from scripts/dtc/libfdt/.

On the other hand, -I$(src) is used to include check-in headers
from generated C files.  Thus, I added it only to dtc-lexer.lex.o
and dtc-parser.tab.o .

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/dtc/Makefile | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 9cac65b..1c943e0 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -9,21 +9,11 @@ dtc-objs	:= dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
 dtc-objs	+= dtc-lexer.lex.o dtc-parser.tab.o
 
 # Source files need to get at the userspace version of libfdt_env.h to compile
+HOST_EXTRACFLAGS := -I$(src)/libfdt
 
-HOSTCFLAGS_DTC := -I$(src) -I$(src)/libfdt
-
-HOSTCFLAGS_checks.o := $(HOSTCFLAGS_DTC)
-HOSTCFLAGS_data.o := $(HOSTCFLAGS_DTC)
-HOSTCFLAGS_dtc.o := $(HOSTCFLAGS_DTC)
-HOSTCFLAGS_flattree.o := $(HOSTCFLAGS_DTC)
-HOSTCFLAGS_fstree.o := $(HOSTCFLAGS_DTC)
-HOSTCFLAGS_livetree.o := $(HOSTCFLAGS_DTC)
-HOSTCFLAGS_srcpos.o := $(HOSTCFLAGS_DTC)
-HOSTCFLAGS_treesource.o := $(HOSTCFLAGS_DTC)
-HOSTCFLAGS_util.o := $(HOSTCFLAGS_DTC)
-
-HOSTCFLAGS_dtc-lexer.lex.o := $(HOSTCFLAGS_DTC)
-HOSTCFLAGS_dtc-parser.tab.o := $(HOSTCFLAGS_DTC)
+# Generated files need one more search path to include headers in source tree
+HOSTCFLAGS_dtc-lexer.lex.o := -I$(src)
+HOSTCFLAGS_dtc-parser.tab.o := -I$(src)
 
 # dependencies on generated files need to be listed explicitly
 $(obj)/dtc-lexer.lex.o: $(obj)/dtc-parser.tab.h
-- 
2.7.4

