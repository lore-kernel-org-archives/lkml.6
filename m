Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612EDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173B7208BA
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YHd26S2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173B7208BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389501AbeHPKqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:46:13 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:18388 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730404AbeHPKqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:46:13 -0400
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w7G7mcEC026590;
        Thu, 16 Aug 2018 16:48:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w7G7mcEC026590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534405719;
        bh=v/7ovcXkFE6N59xgetdVQoohnsq4qPSHz00vZExCMJk=;
        h=From:To:Cc:Subject:Date:From;
        b=YHd26S2mvXZP+xc9nYtNW+z/KDY/jswTBddvVSDobMLbFRtX98J6b/m7qnlyo2XC9
         F48dXpGG30p/57ha/4oX3fe/7lf9ko1d16tupf9+qvOVD7xgdsXGNAXpdc8IR7QEDP
         7YP+VWlzrKFbueODhU2CJ/xiQDIHPUmisIPfDs+GZPGhvIScWTC4GdOW9h9+3U9l6R
         P34A6uktlkqNyqOi7Y0HnUm5rIN8zx76PKqkx67nbj6Lu+an/v+3vD0z+7eT1lN0eh
         OemTD/cn3+evWex+X7SLHGcrVcX9521KtK8pRZcum8/3sZGSMYp+ATuIGsDxm1WAlu
         qpze2P7KuyJFw==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: suppress "configuration written to .config" for syncconfig
Date:   Thu, 16 Aug 2018 16:48:26 +0900
Message-Id: <1534405706-18467-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The top-level Makefile invokes "make syncconfig" when necessary.
Then, Kconfig displays the following message when .config is updated.

  #
  # configuration written to .config
  #

It is distracting because "make syncconfig" happens during the build
stage, and does nothing important in most cases.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/conf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
index b35cc93..7b2b372 100644
--- a/scripts/kconfig/conf.c
+++ b/scripts/kconfig/conf.c
@@ -508,6 +508,11 @@ int main(int ac, char **av)
 		input_mode = (enum input_mode)opt;
 		switch (opt) {
 		case syncconfig:
+			/*
+			 * syncconfig is invoked during the build stage.
+			 * Suppress distracting "configuration written to ..."
+			 */
+			conf_set_message_callback(NULL);
 			sync_kconfig = 1;
 			break;
 		case defconfig:
-- 
2.7.4

