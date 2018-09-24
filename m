Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058FBC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DE521486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DE521486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387578AbeIXSad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:30:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57472 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732882AbeIXSac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:30:32 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9D4821018;
        Mon, 24 Sep 2018 12:28:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 034/235] kbuild: add .DELETE_ON_ERROR special target
Date:   Mon, 24 Sep 2018 13:50:20 +0200
Message-Id: <20180924113108.383426053@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 9c2af1c7377a8a6ef86e5cabf80978f3dbbb25c0 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/Kbuild.include |    3 +++
 1 file changed, 3 insertions(+)

--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -400,3 +400,6 @@ endif
 endef
 #
 ###############################################################################
+
+# delete partially updated (i.e. corrupted) files on error
+.DELETE_ON_ERROR:


