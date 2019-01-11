Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE70C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C7920874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="m1CrWt+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbfAKJwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:52:09 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:44615 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730155AbfAKJwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:52:09 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x0B9plH7031412;
        Fri, 11 Jan 2019 18:51:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x0B9plH7031412
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547200308;
        bh=uPlhz8+UarIqj0moNDAT1BJxp5C9Ycepbh7Dp46T1VE=;
        h=From:To:Cc:Subject:Date:From;
        b=m1CrWt+KQBIGIL2AVDSjylS6NDLS5eHFsXFshZmb1OvKAY7OBL+aX8yDHBzIGfwWY
         L0fn+wQYaGfqzG/b8kurmGTBiycShYwFG3ltKMxSeQe//OUkTfmbNxqkwDkAGkGb9T
         V/s41VbyvsFnjmSUNC0U/L8f/HtjvohMwdaHOh8+SMxmU3CdzVh/K9/9T3U/dHlUfC
         U29DQfIxFNjY6w3NF9K1R/VJNH2B+uGiaL9K8woTvsvpFaTgSYKn+3G0XUo6qjzp0B
         cA9kPyws0qjqStfs0m4z0jr7q2jAo4WghmYLjOaI7n+1h0+7AAJSQUJWnD/CexE3Vw
         +YwRCVQHLKwlQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware_loader: move CONFIG_FW_LOADER_USER_HELPER switch to Makefile
Date:   Fri, 11 Jan 2019 18:51:32 +0900
Message-Id: <1547200292-17028-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole code of fallback_table.c is surrounded by #ifdef of
CONFIG_FW_LOADER_USER_HELPER.

Move the CONFIG_FW_LOADER_USER_HELPER switch to Makefile so that
it is not compiled at all when this CONFIG option is disabled.

I also removed the confusing comment, "Module or buit-in [sic]".
CONFIG_FW_LOADER_USER_HELPER is a boolean option.
(If it were a module, CONFIG_FW_LOADER_USER_HELPER_MODULE would
be defined instead.)

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/base/firmware_loader/Makefile         | 2 +-
 drivers/base/firmware_loader/fallback_table.c | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/base/firmware_loader/Makefile b/drivers/base/firmware_loader/Makefile
index a97eeb0..5c7f422 100644
--- a/drivers/base/firmware_loader/Makefile
+++ b/drivers/base/firmware_loader/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for the Linux firmware loader
 
-obj-y			:= fallback_table.o
+obj-$(CONFIG_FW_LOADER_USER_HELPER) += fallback_table.o
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 firmware_class-objs := main.o
 firmware_class-$(CONFIG_FW_LOADER_USER_HELPER) += fallback.o
diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
index 7428659..776dd69 100644
--- a/drivers/base/firmware_loader/fallback_table.c
+++ b/drivers/base/firmware_loader/fallback_table.c
@@ -16,9 +16,6 @@
  * firmware fallback configuration table
  */
 
-/* Module or buit-in */
-#ifdef CONFIG_FW_LOADER_USER_HELPER
-
 static unsigned int zero;
 static unsigned int one = 1;
 
@@ -51,5 +48,3 @@ struct ctl_table firmware_config_table[] = {
 	{ }
 };
 EXPORT_SYMBOL_GPL(firmware_config_table);
-
-#endif
-- 
2.7.4

