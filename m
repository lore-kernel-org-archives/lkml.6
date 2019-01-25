Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66459C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247EE218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gTfg6Xkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfAYDmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 22:42:04 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:22609 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfAYDmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 22:42:03 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x0P3fkKf001227;
        Fri, 25 Jan 2019 12:41:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0P3fkKf001227
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548387707;
        bh=jv6FjxHY4au3lWFzk4d0+v5HSIXr6FCVVgnbMTMC6aY=;
        h=From:To:Cc:Subject:Date:From;
        b=gTfg6XkzM5OiM4fCi2XMRbZhLZygc4nhjrXnM4eMP+2cKlEqCbpIGPok+uHkOB1rf
         Fn80KnNutwchV476B+1Lsv3iYOafCuThHpHmAY6n32ziuEkPktBOZQYGAqelGB3ZRQ
         pLKZhfDD3Jdjhl8x64KCYwRw3buvZjqH53uj7D6U8ILGV0WyYRIG82CfDAcQxMibq9
         Hb26/wvQ9uPv4BO7LiEEYrMF61DwgKElHmtW97+e0lJcgmY5/EZb+aGyIVbQMrspej
         G9c0mn+61JSfuljkLMJrf//4gDk4XxK6gTVaCWL6qiFl0Krt/NsbcpxVcodqV+qWXf
         Nnj/zHgAgEKCw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] libfdt: prefix header search paths with $(srctree)/
Date:   Fri, 25 Jan 2019 12:41:38 +0900
Message-Id: <1548387699-9222-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the Kbuild core manipulates header search paths in a crazy
way [1].

To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
the search paths in the srctree. Some Makefiles are already written in
that way, but not all. The goal of this work is to make the notation
consistent, and finally get rid of the gross hacks.

Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
("kbuild: do not drop -I without parameter").

[1]: https://patchwork.kernel.org/patch/9632347/

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Makefile b/lib/Makefile
index e1b59da..05973c1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -208,7 +208,7 @@ KCOV_INSTRUMENT_stackdepot.o := n
 libfdt_files = fdt.o fdt_ro.o fdt_wip.o fdt_rw.o fdt_sw.o fdt_strerror.o \
 	       fdt_empty_tree.o
 $(foreach file, $(libfdt_files), \
-	$(eval CFLAGS_$(file) = -I$(src)/../scripts/dtc/libfdt))
+	$(eval CFLAGS_$(file) = -I $(srctree)/scripts/dtc/libfdt))
 lib-$(CONFIG_LIBFDT) += $(libfdt_files)
 
 obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
-- 
2.7.4

