Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BB7C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB472184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cepODubr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbeLXPPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 10:15:23 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:62062 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLXPPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 10:15:23 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id wBOFF40N009889;
        Tue, 25 Dec 2018 00:15:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com wBOFF40N009889
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545664505;
        bh=H3YjI/8O/6u00BHRCrJz6eQAGODFdfB1vFaxWglD9tg=;
        h=From:To:Cc:Subject:Date:From;
        b=cepODubrsY+jmLVSSSEd3f0broWxttirzCRXNsImv5ox5GZ2fn/9qErD4iDNmSd2N
         calcE0G8t9mhpJ0rOQ2FW+ccDksom9mSJgFmjiGTZhRyj5pCYu7/S5SqXwJP2ASths
         0Dg/H9vnDG8uoobstTDC6yb8OC+kfKYISVIfGskdD/TcjAxFIitu+2MZsoZLCJzCpW
         maqRsHFhQ+ekwdqYlOry1M6N0eBDGW14PJRLAChbp4ibWiXtsYgz3xufBansUKMeWw
         YWzryzZJNa9I1DBfgrAhGfODPO50TDP4s4rgCrJe8H1DCSDduiOpHeleDFf0AgIp9F
         dEoY4U+6w9mCA==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] firmware_loader: move CONFIG_FW_LOADER_USER_HELPER switch to Makefile
Date:   Tue, 25 Dec 2018 00:14:57 +0900
Message-Id: <1545664497-26740-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole code of fallback_table.c is surrounded by #ifdef of
CONFIG_FW_LOADER_USER_HELPER.

Move the CONFIG_FW_LOADER_USER_HELPER switch to Makefile so that
it is not compiled at all when this CONFIG is turned off.

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

