Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E3DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E17A2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="untWr3Gp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E17A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeLKLDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:03:36 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:36644 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeLKLBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:01:41 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id wBBB1C5e017210;
        Tue, 11 Dec 2018 20:01:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com wBBB1C5e017210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544526075;
        bh=pSsIoFlZj5d5mg6c+vr71NzXFRGXFCZclWcK8cltYHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=untWr3GpnaXWKHOiLx20lIAx1fr7m45U2/IR1ysuZ4TeHec4j70v35Ja58HIVUM9V
         gGLPewbOoRLGxNp7XV+bJLv8Y0e/wG0MrUdEbsqFjV9ZLJMXv6hEUx1h2rkgnl/fca
         94dmE3Xz21hLrOHIQjzdt/a4goOJcPgwYaS1Ov7/AQ5/byAZV61cPaoKuXpPtDGuFI
         LdgfFDSWTIjliesccDgKjy/NNJZ0E35Nir8VWAw/VeGrxksR9vVnwEQ1Tg36JgmR4p
         vbvqwtpFg3MbAYcCXR/FO2Tjmv3/nw4/FE0o5E5yMzrkQ5pMk0um+C8cJL/tR4hIh3
         ILxNTfTKM6koQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 03/27] kconfig: require T_EOL to reduce visible statement
Date:   Tue, 11 Dec 2018 20:00:46 +0900
Message-Id: <1544526070-16690-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544526070-16690-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All line-oriented statements should be reduced when seeing a T_EOL
token. I guess missing T_EOL for the "visible" statement is just a
mistake. This commit decreases one shift/reduce conflict.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/zconf.y | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/zconf.y
index 22fceb2..c28f1a8 100644
--- a/scripts/kconfig/zconf.y
+++ b/scripts/kconfig/zconf.y
@@ -31,7 +31,7 @@ struct symbol *symbol_hash[SYMBOL_HASHSIZE];
 static struct menu *current_menu, *current_entry;
 
 %}
-%expect 30
+%expect 29
 
 %union
 {
@@ -461,7 +461,7 @@ visibility_list:
 	| visibility_list T_EOL
 ;
 
-visible: T_VISIBLE if_expr
+visible: T_VISIBLE if_expr T_EOL
 {
 	menu_add_visibility($2);
 };
-- 
2.7.4

