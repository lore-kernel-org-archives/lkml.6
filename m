Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389D0C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F386621582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1WcfUtUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F386621582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbeKOSfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:35:24 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:50696 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbeKOSfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:35:24 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAF8RHoZ022794;
        Thu, 15 Nov 2018 17:27:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAF8RHoZ022794
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542270440;
        bh=oHJWflb/cZj+gpZw6dJRfP6NxNDi/Q4JEPO1Hmc69ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1WcfUtUG3tWdanxPxKTsV+wD0noBG8LeWj2rsAqOs/MsngujFMc+U8hxxG78pnwTk
         SjWBuyzN7gHnofENvgDpEe2SpLNK1ETDnLDewIwuhx7jiuQjuCzELR+2M1OQ4DJDw0
         AncJs1qWUwsxPr1irmaLtIjdnm72VBKXD1ySNxYM+wUEEBtO3beHuawZ75PnXpBxHr
         iPvaqEhey5gAOeB9osdbcm8bESzs2+oz2zMArMzbDBKbxvAlPJU0LIGNjP+t9KAlF5
         boQKM+Jz9NrXimYmlag4oR2GuXTYEvKdHuhelgkFkKhMqHzzpiTaGroUQGrsnQjfQh
         XxbifY3kcJ+Sw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] kbuild: remove redundant 'set -e' from sub_cmd_record_mcount
Date:   Thu, 15 Nov 2018 17:27:09 +0900
Message-Id: <1542270435-11181-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
References: <1542270435-11181-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is run inside the if_changed_rule, which already sets 'set -e'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a8e7ba9..7af21a8 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -204,7 +204,7 @@ sub_cmd_record_mcount =					\
 recordmcount_source := $(srctree)/scripts/recordmcount.c \
 		    $(srctree)/scripts/recordmcount.h
 else
-sub_cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
+sub_cmd_record_mcount = perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
 	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
 	"$(if $(CONFIG_64BIT),64,32)" \
 	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS)" \
-- 
2.7.4

