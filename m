Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF54C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646C120811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 12:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="KSfC9+z/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646C120811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbeLKMCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:02:11 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:34040 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeLKMCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 07:02:10 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wBBC1w9X007779;
        Tue, 11 Dec 2018 21:01:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wBBC1w9X007779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544529719;
        bh=kPGBEAmLQmzFrcLYi9ojiKRLB9Wyq9h3VzXN/5eBx6c=;
        h=From:To:Cc:Subject:Date:From;
        b=KSfC9+z/teATZ6gkP2gsQ03YDIC4ZpEeWPat81iWYKDIPTpclKlpK4jAxlaXTpQDu
         KIHZ2KWPcvy0PkMcZfbC3pyC01m7yWPCn8yF3pdpGVzYyRcZdGcvvzVmZjcPplo0+0
         Yj0N7DZPJ2yYv1pjVqmwx4ZLq51/s7SdYIUXcfrVFGohnBuzu7QxVfRFVRznlOToTR
         eIiyge03XgiKWI6p7rZ80tjCfZ/TWdyj1E80hkLcp0DIaZTce9sJamary1/r75Dy1M
         slPg+MlhxnKTPe43fsDpWJk/mtyUr3gz7WsfM07oqNLyLxbHa8KpQKJbtjOhb7+xTE
         e3rmmI5h0B79Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] kbuild: remove redundant quiet_modtag for $(obj-m)
Date:   Tue, 11 Dec 2018 21:01:53 +0900
Message-Id: <1544529716-4917-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All objects in $(obj-m) are included in $(real-obj-m) as well.

It is true composite objects are only contained in $(obj-m),
but [M] is hard-coded in quiet_cmd_link_multi-m.

This line is redundant.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 6a6be9f..5a4fd82 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -110,8 +110,6 @@ $(real-obj-m:.o=.i)  : quiet_modtag := [M]
 $(real-obj-m:.o=.s)  : quiet_modtag := [M]
 $(real-obj-m:.o=.lst): quiet_modtag := [M]
 
-$(obj-m)             : quiet_modtag := [M]
-
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
 cmd_cc_s_c       = $(CC) $(c_flags) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
 
-- 
2.7.4

