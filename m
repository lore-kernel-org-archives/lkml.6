Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B1CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86C620652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="D49FMcwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86C620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeGTIfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:35:00 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:28448 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbeGTIe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:34:58 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w6K7kdj0008048;
        Fri, 20 Jul 2018 16:46:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w6K7kdj0008048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532072804;
        bh=0+xfs+t9qw6M2tt8q3cWVLKoBU4NgX/D4N4D58QqJ4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D49FMcwuuk7iycUF/XCYQiqBAMTZrXLhcgFAIHMgOovnwMGGrUgYR7Y3/AQGT87fj
         Vk4qkmOQ02ds/NGvIqCAVKSr58k4riskgXXbHnUTfADhd8ScXivgrulvE+rtJMTN1l
         7bhUUpvfggXeRoOXgURzwfkYoPS9t9kjAyOEI3QkJc6H7tvZofBuhE3MUIcoWaFG80
         CC2sf0ybBfYelp04VRYUW4rxLTZOEAPYZmHAFBHMCV3cYRUMMbEWh9bL5hLXleiIMw
         t5icg3xDpHCxadlvtpbsdu9U+Xog0yxr4IS/z9pfGfZ37RqAAVoZolXeIJ8XRCIQ78
         w4SZFSj/IV8qg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/11] kbuild: add .DELETE_ON_ERROR special target
Date:   Fri, 20 Jul 2018 16:46:33 +0900
Message-Id: <1532072796-7947-9-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
References: <1532072796-7947-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If Make gets a fatal signal while a shell is executing, it may delete
the target file that the recipe was supposed to update.  This is needed
to make sure that it is remade from scratch when Make is next run; if
Make is interrupted after the recipe has begun to write the target file,
it results in an incomplete file whose time stamp is newer than that
of the prerequisites files.  Make automatically deletes the incomplete
file on interrupt unless the target is marked .PRECIOUS.

The situation is just the same as when the shell fails for some reasons.
Usually when a recipe line fails, if it has changed the target file at
all, the file is corrupted, or at least it is not completely updated.
Yet the file’s time stamp says that it is now up to date, so the next
time Make runs, it will not try to update that file.

However, Make does not cater to delete the incomplete target file in
this case.  We need to add .DELETE_ON_ERROR somewhere in the Makefile
to request it.

scripts/Kbuild.include seems a suitable place to add it because it is
included from almost all sub-makes.

Please note .DELETE_ON_ERROR is not effective for phony targets.

The external module building should never ever touch the kernel tree.
The following recipe fails if include/generated/autoconf.h is missing.
However, include/config/auto.conf is not deleted since it is a phony
target.

 PHONY += include/config/auto.conf

 include/config/auto.conf:
         $(Q)test -e include/generated/autoconf.h -a -e $@ || (          \
         echo >&2;                                                       \
         echo >&2 "  ERROR: Kernel configuration is invalid.";           \
         echo >&2 "         include/generated/autoconf.h or $@ are missing.";\
         echo >&2 "         Run 'make oldconfig && make prepare' on kernel src to fix it."; \
         echo >&2 ;                                                      \
         /bin/false)

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4: None

 scripts/Kbuild.include | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 3d14d0e..7f4b1db 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -400,3 +400,6 @@ endif
 endef
 #
 ###############################################################################
+
+# delete partially updated (i.e. corrupted) files on error
+.DELETE_ON_ERROR:
-- 
2.7.4

