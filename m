Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E45C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF7C241BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XL8rJ1+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF7C241BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753382AbeGECln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:41:43 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:43891 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753062AbeGEClg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:41:36 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w652duZe028145;
        Thu, 5 Jul 2018 11:40:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w652duZe028145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530758403;
        bh=5iP+WFhN/JF+QJ1sHqvSaieX4HmPr/nz+jZdqsNYU8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XL8rJ1+zSHI2OKUzexfcJNBks8gzC55i7380gz7+FQ+U1PVVjna8ec+i7UGqrf6zN
         EfvYQ61WvOyBSXmokDGkz1sonGZK8g32tl0rVIMW9bVCPVx9ojsoxHxaPMGktC1lFE
         CFmh60XXUfx+oRuEzeeVbEoMO7U6V8yqryqWYbAGmSeIv2lIiQ3maZCqaIPUsBzFzO
         q2p5EKBzLlIdcGDbsblt5h62fJxSce22MdCvKiWoAAecEwuWR+Btdkm/LJvJaDQwLR
         w+qLRhFHM5x79VLC6QKojXHxoEKq/JP/zaDGb14g4CpZ+8y7OoePnVS3MlIUOnyDpR
         B7w4ErBiiUwJA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Dirk Gouders <dirk@gouders.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/12] kbuild: add .DELETE_ON_ERROR special target
Date:   Thu,  5 Jul 2018 11:39:45 +0900
Message-Id: <1530758389-30862-9-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
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

 scripts/Kbuild.include | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index c8156d6..b2d14f1 100644
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

