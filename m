Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4EFC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B4120868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uXM9iz7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B4120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeK3UZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:25:53 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:53044 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeK3UZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:25:53 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wAU9GEab028692;
        Fri, 30 Nov 2018 18:16:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wAU9GEab028692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543569376;
        bh=kqMXos4G/lPaZHDP8a5rB5HT6m4xOVUCjqkGig4Uqy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uXM9iz7BjVgr3HaB5P4EA7P7ho5Jz9jGuBYhVb9WLFMeaZQB/so6i0IEgqaNQ4t7m
         JKOdMfZKNwuJSjR4q0sO3rWMYjH5OBhcLpdVvYRTOIKILP7aKWGM9jZdWRw4p11JCC
         Yst3bj6W1M3hkui49420hFrc0EPeg+NICpqcxStFBMkeXPNYKc5KdzxejbbTea4nUi
         hYykOHE3ery60ZI5x8a49e9dp0e3S/l+ltOzTBnGLyw0WTrqRQTZGKaWiZU20N2tL6
         YNIZsJvrhoiYc0T6wpAXFvtaXn4Vzbod8Wn6970pJ2KjHu50XIxfxEMzS8SRfF3gj8
         3HFpC4mbXU2kQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] kconfig: rename conf_split_config() to conf_touch_deps()
Date:   Fri, 30 Nov 2018 18:15:49 +0900
Message-Id: <1543569352-4899-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543569352-4899-1-git-send-email-yamada.masahiro@socionext.com>
References: <1543569352-4899-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to commit 2e3646e51b2d ("kconfig: integrate split config
into silentoldconfig"), this function was named after split-include
tool, which used to exist in old versions of Linux.

Setting aside the historical reason, rename it into a more intuitive
name. This function touches timestamp files under include/config/
in order to interact with the fixdep tool.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/confdata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 1e35529..4c76d56 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -906,7 +906,7 @@ static int conf_write_dep(const char *name)
 	return 0;
 }
 
-static int conf_split_config(void)
+static int conf_touch_deps(void)
 {
 	const char *name;
 	char path[PATH_MAX+1];
@@ -1028,7 +1028,7 @@ int conf_write_autoconf(int overwrite)
 
 	conf_write_dep("include/config/auto.conf.cmd");
 
-	if (conf_split_config())
+	if (conf_touch_deps())
 		return 1;
 
 	out = fopen(".tmpconfig", "w");
-- 
2.7.4

